Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A134580BA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 22:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhKTV6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 16:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhKTV6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 16:58:35 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99496C061574;
        Sat, 20 Nov 2021 13:55:31 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso22569412otr.2;
        Sat, 20 Nov 2021 13:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OamL+NK3bn6CPgVJDXFtsN2Dw3KMbVn2a7j+lAf9hMI=;
        b=RnEz5ZvBVBUESy/vLXB/mtG+MHSbHN9hoFa0rw2ZUkhrX6fzM/vof4NlQ/Wn2zgs6y
         VxTxIbz0l2HOO0w/Uf188W10tAEgeYUeACcicqLnOJylfyQNj6cKtRWnEU+RR54tGWI+
         g+RJgNLkpTfZbKImPBryxmk0RfOeLVBusPVsmkP8N2GsI9949U/zyVlAn+gzCvhPLodO
         uOftGeJLosSQDS/BnfSK783OhTPuYk3tcJuCjdwGq2TCm1hug1zGU8CwD/nF5LL7G9SK
         BupFYG6Ph9fPnAAhkdYVHTyWSAFqlQkX/o7euQGwo9FxMeugIvhhquphtPni/ePxOPFX
         vTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OamL+NK3bn6CPgVJDXFtsN2Dw3KMbVn2a7j+lAf9hMI=;
        b=Es8TxogzoiGkT3TK7WU4MEYnFjEbyXItZmmvJzhQjFHbZtYDPluH5HxGDmwfgLrd9i
         Re9HuLjHzjJ9KmH3xyWObBSlXGwrnPX0q84auCU/+5ltBJ86ATOnwZuIAot4YlSL8/Xq
         YidcGdim/J7KgAyZKw9gF8vXyR1cWz2BWX8vfGlOuWtTrATKX02mJDf1DXS89gWE4IWJ
         wDEfqx8Lhdm4WwayJCYnQjq0htYuoki16xAJx8Ji+zHO6F0c3G3aaW65JxejuglC/5Yg
         vXs3Rrk/Amggf8gzNa5ePtJa52vcTU3nWxAv9Mi6U+35FTG1udfsSKlkeUBJ9O30qG3k
         YiGQ==
X-Gm-Message-State: AOAM532rFMq4TdSrMqinNx67ystssV+YfYAk98qFibAfJCN/ui+hPI1H
        nWXAon+9TUhPlZE6Xd05SdB7X0kEiUo=
X-Google-Smtp-Source: ABdhPJyXyCNdXMqmS+7ND8NA8ZKE1Ye3VzTngroaGBjBIxDz4jwAoEi6XsBhxMGlRQPaI8fiGrVmUg==
X-Received: by 2002:a9d:5604:: with SMTP id e4mr14482954oti.249.1637445331069;
        Sat, 20 Nov 2021 13:55:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w29sm791857ooe.25.2021.11.20.13.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 13:55:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 20 Nov 2021 13:55:29 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Mosberger-Tang <davidm@egauge.net>
Cc:     Navin Sankar Velliangiri <navin@linumiz.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (sht4x) Fix EREMOTEIO errors
Message-ID: <20211120215529.GB1291159@roeck-us.net>
References: <20211120204053.2299501-1-davidm@egauge.net>
 <20211120212849.2300854-1-davidm@egauge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120212849.2300854-1-davidm@egauge.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 09:28:53PM +0000, David Mosberger-Tang wrote:
> Repeat of previous patch but split into separate emails so the
> device-tree bits can be sent to the proper group of maintainers, as
> per Guenter's suggestion.
> 

Another rule: Never send a follow-up patch series as reply to a
previous one; otherwise it might get lost.

Also, if you send a single patch, there is not need for an
introduction patch like this one.

Thanks,
Guenter
