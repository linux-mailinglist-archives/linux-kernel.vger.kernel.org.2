Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED03F39B532
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhFDIwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhFDIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:52:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753EEC061761
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 01:50:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j14so8483211wrq.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 01:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/D69yTYy/RC+3+Gp37xgtg3/qvq6X7jOP7lOc/gB+gE=;
        b=mBMUWtpmp7a0Br0LRC+gmr2FtS4tA3BNbD4wY4neoXz2LN9c7RyrwVnwEavCesKsyN
         yEjyvITF6krunV+NlMhtSTOfM7lsXZa2C5xD9xjU5O68OPyIQt6QW459HAzH03Quh40Z
         UDb8lF8f7nYnvrRNlQvEY+0AM21HOpA857eNZz/5WqjYO10WUhRBYe9wfV7ZxlYTnfKt
         wgpTtNZu/19Y9zxwFhpHXM1uvJ/DhWnozYiw+7c2ChyIrH2VFtW/9ygpxoiIYi+lR68m
         4/LnT4e2tUNRBmaIaONaQD9Ahbf2j+TJcvujuNvKsXXjo/PriTUU8A0b9YlBc3aeJJ5U
         D+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/D69yTYy/RC+3+Gp37xgtg3/qvq6X7jOP7lOc/gB+gE=;
        b=qLs5VyjkpYgmdQIqs2rywvnU42ECzUd/EasGRXbW52CCW7njuLq4pElraaI521YcX1
         fDw8SH7B8ZfvQ6e4awLdZq9jlzWCol7dcOnBThZhh8RcrcciYf14/legLtCpPFVGh4pe
         DR7jzIsFYKDCbQAAovxPCGw9+LNcvBvASPVpGkZDcuTRlZE6aNF0QOJTBlRL/401VC2V
         qfQe3MODZ4+zv9Z7R4FW+fUkqOMr7EJZVx1CSk48budbcLtrosJ6WiUSTumkF/jIO39x
         Wb2Koh654GASKTxvtr1KDPix0B8wgBmCt7+hDdYr1MtcN1Eppv4/QMisyUOuNVBbsqBG
         0Zjg==
X-Gm-Message-State: AOAM531eZ0qTnGLEIOaBUjq+FNIrioBfLEd8fJMVEp1A5yacX21Waprb
        5TLQ2Qa4vuuLYVCl3vggQ7kWBg==
X-Google-Smtp-Source: ABdhPJxxP114GNC4/2C7yXDIyMBIZZtQbzMtTtT4lWMDBF34za4ZMA3kHxXv9f3ZpMzYRVfe870NBw==
X-Received: by 2002:adf:e5c1:: with SMTP id a1mr2723662wrn.16.1622796601063;
        Fri, 04 Jun 2021 01:50:01 -0700 (PDT)
Received: from dell ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id p6sm6085885wrf.51.2021.06.04.01.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 01:50:00 -0700 (PDT)
Date:   Fri, 4 Jun 2021 09:49:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Anders Berg <anders.berg@lsi.com>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 05/16] i2c: busses: i2c-axxia: Fix formatting issue in
 struct and demote unworthy kernel-doc headers
Message-ID: <20210604084958.GH2435141@dell>
References: <20210520190105.3772683-1-lee.jones@linaro.org>
 <20210520190105.3772683-6-lee.jones@linaro.org>
 <YLk7P3+vcR1hNpBO@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YLk7P3+vcR1hNpBO@kunai>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Jun 2021, Wolfram Sang wrote:

> 
> > -/**
> > - * axxia_i2c_dev - I2C device context
> > +/*
> > + * struct axxia_i2c_dev - I2C device context
> >   * @base: pointer to register struct
> >   * @msg: pointer to current message
> >   * @msg_r: pointer to current read message (sequence transfer)
> 
> Shouldn't we keep the kernel-doc header here?

There are a couple of missing descriptions still, but a) since a
concerted effort seems to have been made with this and b) the
remaining descriptions look fairly generic/trivial, I'd be prepared to
re-work this patch.

Will fix.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
