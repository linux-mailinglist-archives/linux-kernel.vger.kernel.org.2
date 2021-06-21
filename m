Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2273AEB3E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 16:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFUOa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 10:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFUOa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:30:56 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4154C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:28:40 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e22so8127412pgv.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HRj6jgpuI+cB6PDpqLiq6EiwF1c8kXiEkJQw6hQEm+I=;
        b=mTZ7WQlwbzQk4gLECW7X3QARCyfrBR8joUnqTeTEIY7DXMFL1wvwZeLRm/dXLg3dAq
         elpj5NsV88/ynmX9WeRqZZVIBlJbhMbehCVsrE2uxm7vyaBQdzK+qo2MSYM+DKUOZKNB
         2sW9Ucnr21Nk76Tc6UFhLVds9CasDcCUoJzHoPusKuRFQYYtHqlym6SJ5CblH9oMjnDC
         cuAHoIes0Ixjj3l6F7E4bqu4vpoGYvX2Fwk77s4IdHuiHUDp11Uyr9eF4wwAoEWRtxcA
         y45vECWxVDe9uIfyCWnK0gL7+HMNrFt7tfO2k/u5hMAyYSa9vP6kugG4fhSA2J7aK67+
         sGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HRj6jgpuI+cB6PDpqLiq6EiwF1c8kXiEkJQw6hQEm+I=;
        b=I0/va5mXD0BV8l+QBrM1E2Z39tCM3qtUf8TG6Ede8TA/SbZmItB1cgMvzyvf9i8Zz4
         bw1keAUtGQH3qF8HWTNpt2u6lRDEbD56GlEbCpSMVgXeNmZ+haOG7OokzKSrkKgOvMdD
         awr85TnFS55+Rvbh2jBiy453xEQV3RlI9jdRGto6WXArUGsE//1h43XxDN828WZd6g71
         avlJZzkvL7KLtDvah/LdBml8KUNnPF17ObquYzsObYM/n4EiCBzYqILomAUdyaT6RuLG
         0ODctuw3V5b8luY1WXC6os580hInrsOEyAjxQnBVwvIvcTAJ7IjWVbYWKbkzpeZHGiou
         pjQg==
X-Gm-Message-State: AOAM532a744x4Cc5asgNHyw66DogVrqvGkgvgqs84COFPfqTUX9eJaAb
        8VshtJY5leLgVmj414ZCQ7w=
X-Google-Smtp-Source: ABdhPJwrYStRiFqhX6UmCBwPaRoE54hZpFRYBM7yG2YneCzaqUMuTlan+FvxcavMJjLliSPU+NtGPQ==
X-Received: by 2002:a63:c1e:: with SMTP id b30mr24435102pgl.118.1624285720505;
        Mon, 21 Jun 2021 07:28:40 -0700 (PDT)
Received: from ojas ([122.177.154.120])
        by smtp.gmail.com with ESMTPSA id 10sm13203713pfh.174.2021.06.21.07.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 07:28:40 -0700 (PDT)
Date:   Mon, 21 Jun 2021 19:58:33 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, arnd@arndb.de, phil@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] staging: vchiq: Move vchiq char driver to its own
 file
Message-ID: <20210621142833.GB186979@ojas>
References: <cover.1624185152.git.ojaswin98@gmail.com>
 <8cd9b5899f82eaf2efdc9caa8d07f719a592a94d.1624185152.git.ojaswin98@gmail.com>
 <20210621095631.GF1901@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621095631.GF1901@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 12:56:31PM +0300, Dan Carpenter wrote:
> On Sun, Jun 20, 2021 at 06:26:34PM +0530, Ojaswin Mujoo wrote:
> > +/* read a user pointer value from an array pointers in user space */
> > +static inline int vchiq_get_user_ptr(void __user **buf, void __user *ubuf, int index)
> > +{
> > +	int ret;
> > +
> > +	if (in_compat_syscall()) {
> > +		compat_uptr_t ptr32;
> > +
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> When I'm reviewing these sorts of patches then what I'm trying to verify
> is that you are not a UMN "researcher" trying to change the code without
> anyone noticing.  In the orignal code, there was no blank line here
> 
> > +		compat_uptr_t __user *uptr = ubuf;
> 
> but there was a blank line here.
> 
> > +		ret = get_user(ptr32, uptr + index);
> > +		*buf = compat_ptr(ptr32);
> > +	} else {
> 
> These sorts of minor white space changes make it hard to verify the code
> in an automated way.
> 
Ohh I see, I get the point. I'm not sure how this creeped in here.
Especially with this patch, the git diff looks very ugly and confusing
to me. I'm not sure if that is because I unknownigly introduced some
whitespace changes or if thats normal when shifting a lof of code
around. Anyways, I'll fix this in the next revision.

PS: I was unable to get mainline kernel working on my Pi and instead
submitted this patch which is built against the raspberry downstream
kernel. I now know this definitely not the right thing to do and am
trying to recreate this patchset with mainline. Hopefully I'll be able
to iron out all such anomalies in the next revision
> > +		uintptr_t ptr, __user *uptr = ubuf;
> > +
> > +		ret = get_user(ptr, uptr + index);
> > +		*buf = (void __user *)ptr;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> 
> regards,
> dan carpenter
> 

Thank you for the help!
Ojaswin
