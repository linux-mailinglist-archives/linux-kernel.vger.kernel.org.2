Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F7140AC49
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhINLT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbhINLTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:19:23 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCA4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 04:18:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z94so13085663ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 04:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/sbK6Gyku0pI2crTRLJKEIo3nSfX3xy0COK8b8AjyvI=;
        b=HvCxjYx5jExAgYRvyFHZWAdtux8k0u8JyFtCMZNYuDqN3XWjtOvL4HnBVa7jZqenR5
         UrIJ7gVErGlkNzG4FLSyzoVpIsMcFTboQD9Ina7NaqnEjkG/IP6So6vi6cnSXcUJzBek
         EHe2lazYXYTNugfB6Ti+w8SWtUMummWgQbLKs0EYu4kJz5r78LpSGVjUx9StcVR3WOpU
         qdCraJrIdndx0hFenerjMWEq40UW1P8UyaC2f9v4RT61WabGhepThWlsWNZCKV3MEPQm
         G2XMBTeBtpXoXi/UaaSuLSpXwtj4hjGsEZlMrr4IWxhnVA0pX5aItJYwkJrYyPIh5Beb
         njSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/sbK6Gyku0pI2crTRLJKEIo3nSfX3xy0COK8b8AjyvI=;
        b=c5DeY5qzRPNHOC53mXahKM8NWZg7EzfXID+mh3Elu69n1ebDMpVMPhXmdUQmHUttf4
         BVbujlJZFwSHNJu+Y9KRX9CQMxiSoUTsU798OlW1borsCuLXFSVnOsOuOpUsoCXX5PnK
         Rd+6ieHvgvo2g7Z4cbnktUrNQhN+0htmObZ+hr/gR87h5iOOmmyIjxVEOkzN7mHeCEe0
         rc2hdzxBEo9/8FoFKGJ9o+c+LboKk3JsaSt2sU8CU+101JPkxR05jxxCrXulm8F0np+s
         X+BLa8tIcavtJGVRh474Pw0di06IFCZJmkt7endp2lAB9+gE086+AcvMALa7NrvELJeK
         LIjg==
X-Gm-Message-State: AOAM532BnlWKBn2dsai1UDh2Ei3t2Sq1S6n03ZCaLBYgaVPkPOKJz7wD
        qS7szj0cPWzesZqIAsIwL40=
X-Google-Smtp-Source: ABdhPJyGQLy3IoGt2RfEiNs8iExv2YYlSQEOTccADlEhuYNZT5i6aV/k/uGT/ked8e2B+i3J6rlIUA==
X-Received: by 2002:a05:6402:493:: with SMTP id k19mr19144049edv.386.1631618284842;
        Tue, 14 Sep 2021 04:18:04 -0700 (PDT)
Received: from localhost.localdomain (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id la17sm4683629ejb.80.2021.09.14.04.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 04:18:04 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v4 15/18] staging: r8188eu: hal: Clean up usbctrl_vendorreq()
Date:   Tue, 14 Sep 2021 13:18:01 +0200
Message-ID: <2067006.DYBlakG51R@localhost.localdomain>
In-Reply-To: <20210914092405.GB2088@kadam>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com> <20210913181002.16651-16-fmdefrancesco@gmail.com> <20210914092405.GB2088@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 14, 2021 11:24:05 AM CEST Dan Carpenter wrote:
> On Mon, Sep 13, 2021 at 08:09:59PM +0200, Fabio M. De Francesco wrote:
> > Clean up usbctrl_vendorreq () in usb_ops_linux.c because some
> > of its code will be reused in this series. This cleanup is in
> > preparation for shortening the call chains of rtw_read{8,16,32}()
> > and rtw_write{8,16,32,N}(). More insights about the reasons why at
> > https://lore.kernel.org/lkml/5319192.FrU0QrjFp7@localhost.localdomain/
> > 
> 
> This commit message is quite bad.
> 
> This patch has nothing to do with reusing the code or shortening call
> chains.

It has to do, in a certain sense. Let me explain please...

Some days ago, David Laight made the review of "Shorten calls chain of 
rtw_write8/16/32/n()" version 3. 

In that patch he noticed some lines of usb_read() that I had created with the 
help of reusing some lines of the code of usbctrl_vendorreq() that is deleted 
in the same patch. 

He thought that they were clean-ups and renames and so he suggested to make 
those "clean-ups" in a separate patch.

However they were _not_ renames or other clean-ups, because usb_read() was 
not touched in that patch and, above all, it was a new function. 

I am sure that when I write new functions I can use whatever name of 
variables I like, even if people may think I'm renaming the variables that 
were in a old function that now is deleted. Am I not permitted?

However, because I also think that readability of the diffs matters, I 
decided to do some clean-up of the code I'm about to reuse in the new 
functions. It improves readability of the above-mentioned patch that is also 
the 18/18 of this series.

That is the reason why I'm cleaning up a function that is going to be deleted 
in the last patch of the series.

> Don't use a link like that in the commit message especially when it's a
> link to an email you wrote.  If it's someone else's email you can say,
> something like "As <name> points out in <his/her> email <url>.  Blah
> blah blah."  That way you give credit to the other person but all the
> information is in the commit message.

I agree with you. I'll redo the commit message for in order to summarize in 
few lines why I'm doing clean-ups of functions that must be deleted in 18/18.
The same for 16/18. I think that a short explanation like the one that I gave 
you above should suffice (much shorter, obviously).

I hope that I've been clear now. Please let me know if you have more 
suggestions about this patch and the next (16/18).

Regards,

Fabio


