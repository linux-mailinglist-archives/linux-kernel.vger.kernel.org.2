Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63AD4119AA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243502AbhITQVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242597AbhITQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:21:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E2CC0613E9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:17:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h17so63553029edj.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=meii394rMMf2+VExFEXSq/fznMv+auld/8Avcma/sHI=;
        b=cmGMkAr6TS7S/CzOvMjyO/b7QjbdCwatc5lDFr3/G86GkPxwPJ6NllRsN+oyv0GHQJ
         5eaoOLoqQhkIxtUbj1UNboHefrAHkAfvgljZx/9MTgKVe3BrJRyv2xzxgiP0UG3nYhFD
         dJTuyqnXyfat5I1k8IxMhfZ0kFNjGHSntReoEOo42M6Nt7LHa65Hwpj62RyBOujy5x3o
         qsn/TDrF6A2BDPVoEO3o7xQ8442/F/qMVfn6ioKSSJtLPgVAIm+NioJOdEsWHq21907N
         tkgg2uBCgsRZ/ic41BHh1HbV/uyLWswp5fNcq1vTBTYhPBWgZ6R6ENy85EVFcCXZ7ony
         QyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=meii394rMMf2+VExFEXSq/fznMv+auld/8Avcma/sHI=;
        b=3nrAIQAmvaQ0DtBFap/58IEd/pgGUsjBwrblYaPuiCmmAdGpwllIrpy3UBXD2Pet5S
         QD+eR/WGvXIq3MB7HEDsOcZScX21W8qZsKy3hNICb5YaBxLyN5uP2nMCD/eucuB71LBb
         80V3MWDjR6lFosBBaH7cNDYQeApIrTqc+BX0F1lMzNxnR4e8jXRlMRoIiyVvewheKhy7
         vQuiEOtyUddmPvq4vVbv/T/aCGwptV5NS/bNiY+u5OjxL8rGa1+roK/yWRV38b8cCeTh
         TbAtDvn47AMowg9D8HWWU7v/bnDHdWq3hmu1FAa///7LHO6hwDansYUYlTR9hMFdjOPn
         sMag==
X-Gm-Message-State: AOAM533ITnO80YMQFwfZzQXTmWrxFRFWdZhRHWTXLFN/kPGNsYibqlg2
        5E1OsmLdr8iDIqwY2y21Icc=
X-Google-Smtp-Source: ABdhPJyZMdLpVQZjzOTFIYwbbFIlvQXRcpF6cZiTl/MqSRY0DHPtpDGSFKP3jq0VoUy8mshxvKvKww==
X-Received: by 2002:a50:bf4a:: with SMTP id g10mr11848420edk.11.1632154659434;
        Mon, 20 Sep 2021 09:17:39 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id di4sm7301437edb.34.2021.09.20.09.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 09:17:38 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v8 15/19] staging: r8188eu: change the type of a variable in rtw_read16()
Date:   Mon, 20 Sep 2021 18:17:36 +0200
Message-ID: <3187315.KoBY3qX4Pt@localhost.localdomain>
In-Reply-To: <20210920131036.GR2088@kadam>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com> <48009934.f5uHuSIIb1@localhost.localdomain> <20210920131036.GR2088@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 20, 2021 3:10:36 PM CEST Dan Carpenter wrote:
> On Mon, Sep 20, 2021 at 03:03:44PM +0200, Fabio M. De Francesco wrote:
> > On Monday, September 20, 2021 1:56:47 PM CEST Dan Carpenter wrote:
> > > On Mon, Sep 20, 2021 at 01:53:52AM +0200, Fabio M. De Francesco wrote:
> > > > Change the type of "data" from __le32 to __le16.
> > > > 
> > > 
> > > You should note in the commit message that:
> > > 
> > > The last two bytes of "data" are not initialized so the 
le32_to_cpu(data)
> > > technically reads uninitialized data.  This can likely be detected by
> > > the KASan checker as reading uninitialized data.  But because the bytes
> > > are discarded in the end so this will not affect runtime.
> > > 
> > > regards,
> > > dan carpenter
> > > 
> > 
> > Dear Dan,
> > 
> > Thanks for your suggestion about this specific topic. 
> > 
> > We thought that, since "data" is in bitwise AND with 0xffff before being 
> > passed to the callee, it was enough to have reviewers know why we're 
doing 
> > that change of type with no further explanations. Actually it seems to be 
not 
> > enough to motivate that change.
> > 
> > We will surely use the note you provided. 
> > 
> > However, since I'm not used to blindly follow suggestions (even if I 
trust 
> > your words with no doubts at all) without complete understanding of what 
I'm 
> > doing, I will need to understand what KASan is before copy-paste your 
note.
> 
> Google is your friend!

Yes, it is :)

I think you were referring to the KernelMemorySanitizer (KMSan), a detector 
of uses of uninitialized memory (but it seems to not be upstream):
https://github.com/google/kmsan

Instead you wrote about the The Kernel Address Sanitizer (KASan) that seems 
to be a dynamic memory error detector designed to find out-of-bound and use-
after-free bugs (this is upstream):
https://www.kernel.org/doc/html/v5.0/dev-tools/kasan.html

Can you please confirm?

Back to the code... uninitialised data is not a problem in the old code, it's 
just bad design. The new code cannot affect runtime, it's just better design. 

There's no change in runtime behaviour because of different protection nets:
Aside from the bitwise AND that truncate that variable two the size of two 
bytes and set the higher bytes to 0, memcpy() inside usbctrl_vendorreq(), the 
new usb_read() and usb_write uses memcpy() with count = size (and size is 
checked also in rtw_writeN()). 

I can't see any bugs. Just bad design, that we fix and possible sanitizer's 
warning, that disappear with our fixes. Am I right?

Thanks,

Fabio


> 
> Either way reading uninitialized data is generally bad.  The trickier
> thing is showing that your changes don't affect runtime.  For both of
> these le32 to le16 changes.
> 
> regards,
> dan carpenter
> 
> 




