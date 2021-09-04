Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7024009EF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 07:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhIDF7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 01:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhIDF7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 01:59:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBFEC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 22:58:49 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id e16so1172123pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 22:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f/n2nxuDHHhZ11WJWH1zIlD9cd3WmDx7yPKho8Os6hw=;
        b=LjUuzuQVdKjipEN2HiXMhHaHtudEzYHRvcJnqfs0vWkUitj1LMLoQZcKIkvBzB+Xed
         1qzvhzGnXJkO8S/5XUgq4B4Te2lxgP2Qtf27F57OSHz24RxZCu13mNa17cAtaIXstmss
         dYeVSWpFb/JRD9w4Y4JruCSnCkoKFprbuD08uoR/SApfFCxPK4EkCa7tVWxG37oiOcLz
         zOVvD9koX4x20oUdHL/HU+Pw/XtGQtUA2B/91birEDb+baLWB0XvOuEsRsNVvnQzrH5D
         x/91lbI03+KU6mfsivAF0k4iiQBwiYhAbnFN41z8AgBZqS4Q9mIowPMdC7XZD9VTyY+D
         QwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f/n2nxuDHHhZ11WJWH1zIlD9cd3WmDx7yPKho8Os6hw=;
        b=AUc7bk5Qu7VBEqPW+sKBUpM7qpiu45PxjdycH8CaqxZsjTta+FswYSa2iFCCRHBNVU
         iGqN0Z9qPuzhSkjN8ggkhsZm/xlRH6znj114+8tu6WVEHDIVvXSobpR2c7ZQM7V4KJC0
         xFbuAlhHZh5vGsnkgI56x8Tuj2vZSttONBUKGQMopAhBUWoRjudtqh3EQdGT00NAEp1C
         Ku2EhYj20j6yB5w+6REMKeGHWT5yEwH67cgJbtuX0RNtn4WW7OXoQvWGZbgKevrfxnIw
         cFCCABmKwpnw7XJTOAG3bHwEaInV56ubfSDwOn4YmDtzhaMWPMypCtuOqVB2MQOVboXp
         TJZg==
X-Gm-Message-State: AOAM532MxCcF/HdOKWy5je4D0uSAdINEqx5Jx8tKky3mtL/AwOP/jxHN
        syvpM1eSfzNHIKuRwmyuvTI=
X-Google-Smtp-Source: ABdhPJy9L0JX9a9KbH7pkZ2BFzJGUNJlWX2uQNcel6crBH60SUmj0Aw0+gOqLX/1uAsXm7g3jN42dw==
X-Received: by 2002:aa7:90c8:0:b029:32c:935f:de5f with SMTP id k8-20020aa790c80000b029032c935fde5fmr2207340pfk.79.1630735129318;
        Fri, 03 Sep 2021 22:58:49 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id b20sm1057325pfl.9.2021.09.03.22.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 22:58:48 -0700 (PDT)
Date:   Sat, 4 Sep 2021 11:28:43 +0530
From:   SAURAV GIREPUNJE <saurav.girepunje@gmail.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH v4] staging: r8188eu: core: remove null check before vfree
Message-ID: <YTMLE9tIYCv6uNeE@user>
References: <YSu9GQa1A3s6FYQx@user>
 <bf3547a3-bca0-cb81-b086-0d7a9bfe6e7c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf3547a3-bca0-cb81-b086-0d7a9bfe6e7c@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Aug 2021 14:09, Michael Straube wrote:
> On 8/29/21 19:00, Saurav Girepunje wrote:
> > Remove NULL check. NULL check before freeing function is not needed.
> > Correct the indentation.
> >
> > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > ---
> >
>
> Acked-by: Michael Straube <straube.linux@gmail.com>
>
> Thanks,
> Michael


Thanks for Review Michael


Saurav
