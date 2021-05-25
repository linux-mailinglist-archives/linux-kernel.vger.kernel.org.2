Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143063901B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhEYNJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbhEYNJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:09:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31B3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 06:08:16 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p24so45987561ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 06:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=J3i7sySuF9vAMwjRduq9o4pZBENGbTDxWuaAXXo5lxM=;
        b=CUcTIB0jGV2498eTndtJ4dsxx9tU25S/huYWnqhhT16rMypCIkW2OSS2dEjs/ScD2/
         z6Oy6LTaUwdiQWKocdpHw/s4akCqzh3aFWaPuPl6h3FUY9uPGaFaDbs19ONFxN2lFxmk
         tiUlt5+GP9TsqYQrWQGwSV/5rZ/PXdNuRFves=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=J3i7sySuF9vAMwjRduq9o4pZBENGbTDxWuaAXXo5lxM=;
        b=X+/wieyr2UpbPKZ4gDVFTuMPRBhwU3Gu4I9P7/XSoAEwLJeCBWWFOBf9lLkkG0yZea
         oSSLQGpwgAuNysmHOLut0D8cBHR+CBpLz2GQqKZDRIlHp737HmI06JKrWNa8YNobIVo9
         1d+FOr5StaRqeOZ76fGwYl8VnUp0XMWNvuo/fnzAjstpbHz93f0oc33q6553fyDIhyhU
         QfOiKOEzqV8k3ORnJhx7jICPmQHKP5ZbVByGFX1tkjWA50hcoEBjRn3oXqAZBMUolm5l
         UyP8PSPGQVVLE7ga6LbH7SIzANwoVwo/ugmVNP9v4pHnaDvMTs2R948es3lm1RQqGYJ7
         bHLg==
X-Gm-Message-State: AOAM53336cxk/60CKaOKVwpgd5aGJ23wuepVIwZOH31wylyXIEk2IkvJ
        T4vviTeqES97UZSFA47i4pV/Ag==
X-Google-Smtp-Source: ABdhPJxXJHDlcz+lHAfC3eMn2DkJLakk8UYTxiXf4gRAsmQw7xJyIhqyJL0QLeuwZ9Zpjh38P9PnUA==
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr28105603ejj.16.1621948095527;
        Tue, 25 May 2021 06:08:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u21sm9007517ejg.50.2021.05.25.06.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 06:08:14 -0700 (PDT)
Date:   Tue, 25 May 2021 15:08:13 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/fb-helper: improve DRM fbdev emulation device names
Message-ID: <YKz2vbxYXSKQE1Ng@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
References: <20210521131910.3000689-1-javierm@redhat.com>
 <YKfS2GDCXPJ/q8gT@phenom.ffwll.local>
 <3a6f9235-5375-b2cb-2d63-a47c5f9752bb@suse.de>
 <bfd6fa47-497a-64bc-c2fc-a081bd41d5ec@redhat.com>
 <fc6540fa-1945-a15d-239d-e87bb4d3fa9e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc6540fa-1945-a15d-239d-e87bb4d3fa9e@suse.de>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 08:53:56PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 21.05.21 um 19:18 schrieb Javier Martinez Canillas:
> > On 5/21/21 6:53 PM, Thomas Zimmermann wrote:
> > 
> > [snip]
> > 
> > > > 
> > > > So what with all the drivers which do _not_ have drm in their name? Also
> > > > I'm never sure how much these are uapi or not ...
> > > 
> > 
> > That someone could threat as an uapi is a fair point indeed.
> > > Why do we need a suffix anyway?
> > > 
> > 
> > Yes, I thought the same and was torn about posting a patch to just remove
> > the suffix. I don't think users care that much if is a fb device from a
> > fbdev driver or a DRM driver using the fbdev emulation.
> 
> Yup. I don't see how anything in userspace would depend on the exact name;
> especially since fbdev emulation only provides basic features. (I'd welcome
> a counter examples that proves me wrong.)
> 
> IMHO we can risk it to remove the suffix entirely. But that needs an ack
> from Daniel or Dave.

If you guys with your distro hats on all think it doesn't matter, then
yeah I'm all for dropping the somewhat silly -drm or drmfb suffixes. I
think that was just way back so it's easier to know you've loaded the
right driver, back when there was both drm and native fbdev drivers
around. But now I think for new hw there's only drm, so should be all
fine.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
