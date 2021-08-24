Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59113F5D95
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 14:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbhHXMBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 08:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbhHXMBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 08:01:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A344C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 05:01:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lc21so11432564ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HqW+LVNalGaEHB9VYLp4uCdC1n0gnyFeiL2DickMWrY=;
        b=KvYPLuqgBhqBGmJh7qw5geo7ieerX2Zqs0CIMrBuETggPk70943RkGOnHD0qAWkqju
         qRBLJHxKUepQDj8Tdd+wk3wsRX4Th+Cmu6xCSQlflCrEF5MqZnxpdfSe11i0AZPMQkUe
         q00tkGdxcojJ55zbISEbQXIOGP50p0DZDLrVT171NKXvhnJu6iUQb2jdUPtpWEXFl4E+
         ukBjyM1yUlRzzg1OJXzTVn7mSGYaHXylDyQvAgRowAMv3bZys2taRrSoZw2fCkkzgwHA
         5euFncByvR/KW8QiBXSjXn9W+FQ1x4V7/0GKPnWkGWrelRb+Eldir1cBkP16koBiWFAO
         XrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqW+LVNalGaEHB9VYLp4uCdC1n0gnyFeiL2DickMWrY=;
        b=JWXij3E5Js3IjUZU9hm725y41eBym+XCslOPb2fnEWGgX2H/Kna/DmucBlRJ5oFa70
         IDvrtB14U7NfgSW6uQVWXSgiN0C5BUHP8sntn/LpCogxtUvYv0kTpF5X/Huz8kz0fguz
         I3CIHhqTZXgS1qGN2V/PdlZ9c9zaqvN4Y5vMOxPZAEFSDGQyQ7qvR8FPDdf951x7K03w
         WoYVhjH3erAMC4nNDSiA5CKj78j1gk1appRq2zBUsFs/pDxtMzC4VyYbsemPORiAF8vG
         UhoIMyqhZLVMtb67c5Ec+MiB1A540Eg/PI9O4oMrXflLqTBywE8fPkklRxTLfv5XE2vT
         Gfug==
X-Gm-Message-State: AOAM531UKxrIgg1Y+h9uY/nYPCwG+nXfC/KstBoe+3OFginccZE+wOnj
        PUSZh2N5cLK1+2IC3H6MyBM=
X-Google-Smtp-Source: ABdhPJy1OGOqUiRok3HWsjnllrBDpZhXdq8mtN2VVs5qBbLZwnxhvXe1by0EbIUBupRRwMdVh35NIw==
X-Received: by 2002:a17:906:1289:: with SMTP id k9mr39791879ejb.2.1629806464207;
        Tue, 24 Aug 2021 05:01:04 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id v13sm9103037ejh.62.2021.08.24.05.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 05:01:03 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH 1/2] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
Date:   Tue, 24 Aug 2021 14:01:02 +0200
Message-ID: <6601006.JhxPbakEoc@localhost.localdomain>
In-Reply-To: <d5ac7cd8-dc81-732d-b583-628cd2a273cb@gmail.com>
References: <20210823223751.25104-1-fmdefrancesco@gmail.com> <3198276.4iybWabFxt@localhost.localdomain> <d5ac7cd8-dc81-732d-b583-628cd2a273cb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24, 2021 1:07:46 PM CEST Pavel Skripkin wrote:
> 
> Btw, not related to your patch, but I start think, that this check:
> 
> 
> 	if (!pIo_buf) {
> 		DBG_88E("[%s] pIo_buf == NULL\n", __func__);
> 		status = -ENOMEM;
> 		goto release_mutex;
> 	}
> 
> Should be wrapped as
> 
> 	if (WARN_ON(unlikely(!pIo_buf)) {
> 		...
> 	}
> 
> Since usb_vendor_req_buf is initialized in ->probe() and I can't see 
> possible calltrace, which can cause zeroing this pointer.

I see that usb_vendor_req_buf is initialized in rtw_init_intf_priv(). It depends on a 
kzalloc() success on allocating memory. Obviously it could fail to allocate. If it fails,
rtw_init_intf_priv() returns _FAIL to its caller(s) (whichever they are - I didn't go too 
deep in understanding the possible calls chains).

What does really matter is that dvobjpriv->usb_vendor_req_buf _could_ _indeed_ _be_
in an _un-initialized_ _status_ when it is assigned to pIo_buf.  

> Something _completely_ wrong is going on if usb_vendor_req_buf is NULL, 
> and we should complain loud about it. What do you think?

That "if (!pIo_buf)" in usbctrl_vendorreq() manages a possible but remote (I guess)
un-initialization by releasing a mutex and returning -ENOMEM.

I think that technically speaking it would suffice if callers read and manage properly 
the -ENOMEM returned by usbctrl_vendorreq(). 

Said that, I have no sufficient experience to say if exiting and returning -ENOMEM would
suffice to not make happen "_something _completely_ wrong_" or if a WARN_ON is required.
I'm sorry for not being able to go beyond the confirmation that indeed dvobjpriv->usb_vendor_req
could be un-initialized.

Regards,

Fabio

> With regards,
> Pavel Skripkin
> 




