Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F3B44985B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 16:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240899AbhKHPfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 10:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240888AbhKHPfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 10:35:21 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0760C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 07:32:36 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u1so27575681wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 07:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3qH9TdJtbE5s6fGLUpqoEcNvViWRlxUM56TldO1HeKs=;
        b=IDU4UF9pM/kEqYhhBQbBBKHZ3Ho9d/OPwdilkGK0aRqkEmeTorOipZkdyVKic8fdM7
         DCXvdsPJ8cxqG6fRWzipKWMlcqBFjBeO9E6qGurECf9jZ6rnDfih1gtNW1zoCHZaRCao
         5wueSQYH9Z/hIkWExTUjipen9leMYvj6H07Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=3qH9TdJtbE5s6fGLUpqoEcNvViWRlxUM56TldO1HeKs=;
        b=eDPm8Y81+QuZF04ROXX9VxipKxpPncoreziI63bh1X7AistZpoTimrVsLhhCGG4S+x
         +7nR7Ctk/O21CfxFO0VBcoqsHvSWXt+MYuwbBPKI7VrmVK6kFBIiO0vI7AnXnlcPvzdd
         uCR+e1nPURTGbW3kYH9x6n5Cxct7qqwcOzFdB8LDg81UIBp77fO8DvxTuEko8wRpRmVI
         tth6vKXDvgawyAR5jyvjHmhkh/4SD5FBkCZefkClhIIW7HLoyclN0BuTq2Yogcht0snx
         G+9L8AFkLZrtyLtwuJz9rkkKYXnhIVU/FYo3yj+ZRkkbE690ErE2J13+fgRDSaJP8iy5
         Xa9w==
X-Gm-Message-State: AOAM531SrJ1L1EcXbCktpy1TL+N3WQcSKBorBCxvRa7l26DpNW4kwi2U
        O7ZAngs+b+FN8I1MvgqMr5hrPQ==
X-Google-Smtp-Source: ABdhPJxUhPtLxhdxtIRqnFCsOzKZQNDCoG7g8D/0H28sp3ZvEiXYQsgDC6xoBnfafE67l2I3bI/FdA==
X-Received: by 2002:a5d:64ed:: with SMTP id g13mr50670wri.222.1636385555360;
        Mon, 08 Nov 2021 07:32:35 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b197sm16154272wmb.24.2021.11.08.07.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 07:32:34 -0800 (PST)
Date:   Mon, 8 Nov 2021 16:32:33 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v3 5/6] Documentation/admin-guide: Document nomodeset
 kernel parameter
Message-ID: <YYlDETv8pVM+0SJo@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20211108121544.776590-1-javierm@redhat.com>
 <20211108121544.776590-6-javierm@redhat.com>
 <0f152d33-6362-b04b-6661-1d5cd7f32015@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f152d33-6362-b04b-6661-1d5cd7f32015@suse.de>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 01:48:24PM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 08.11.21 um 13:15 schrieb Javier Martinez Canillas:
> > The nomodeset kernel command line parameter is not documented. Its name
> > is quite vague and is not intuitive what's the behaviour when it is set.
> > 
> > Document in kernel-parameters.txt what actually happens when nomodeset
> > is used. That way, users could know if they want to enable this option.
> > 
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > ---
> > 
> > (no changes since v1)
> > 
> >   Documentation/admin-guide/kernel-parameters.txt | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git Documentation/admin-guide/kernel-parameters.txt Documentation/admin-guide/kernel-parameters.txt
> > index 91ba391f9b32..ed9859fd0734 100644
> > --- Documentation/admin-guide/kernel-parameters.txt
> > +++ Documentation/admin-guide/kernel-parameters.txt
> > @@ -3521,6 +3521,10 @@
> >   			shutdown the other cpus.  Instead use the REBOOT_VECTOR
> >   			irq.
> > +	nomodeset	Disable kernel modesetting. DRM drivers will not be
> > +			loaded when this kernel boot parameter is used. The
> > +			simpledrm driver is the only DRM driver that loads.
> > +
> 
> That's misleading and to the general admin it might not be clear what
> simpledrm is about. Rather say something like
> 
>  Disable kernel modesetting. DRM drivers will not perform
>  display-mode changes or accelerated rendering. Only the
>  system framebuffer will be available for use. Requires the
>  firmware or boot loader to setup the display. Useful as
>  fallback, or for testing and debugging.

Yeah I think that's much clearer. With that wording:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 
> Best regards
> Thomas
> 
> >   	nomodule	Disable module load
> >   	nopat		[X86] Disable PAT (page attribute table extension of
> > 
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Ivo Totev




-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
