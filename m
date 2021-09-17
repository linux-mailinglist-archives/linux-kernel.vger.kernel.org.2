Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E5140F849
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbhIQMuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbhIQMuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:50:19 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C79C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 05:48:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q26so14988262wrc.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 05:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=7oU/zrR0lyaLCX/xbrz4I5jPxXrxTONpS1EupeiEBYU=;
        b=e8/iUGwb6f0jMLzsQZnw37NoIcbAVpXGdLudRJ2aUZOOZr7GuR0vRR4j6afb3vDdJB
         XJWMRXjmtRvQvAricoKKGZwrCEjgiS6TABw7XntuutkzWOtWm/Ic/cHXvDH0zOxJRL7N
         bGCuq2SuiQLkzWudNPIV3ASsNpk2MY/4P8ipE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=7oU/zrR0lyaLCX/xbrz4I5jPxXrxTONpS1EupeiEBYU=;
        b=GyPhj01S2cOBqrtF/r6232ISPttvp6LL/njNwbiS7nyCNzQwEGdhDOzdCM+bs3Qjy5
         tCK4HRNN5v/qMnQKfhTBjYKRpC5okxDv5XTqlik/HDBoH1gceWpHO33mebhccqme286h
         Ms2H+7lprDbAtYKLbXg+apR6feqkS1NbOxYSbgcQlm42aM2SxsFjTUh+2PVqNW/lKk9T
         imi2hOaeULfiKlIKgU/LNALQ3KD8JXhF/E9djNiz37ChPY2jfCjS1x0ms2K43beQLAOT
         HzeSZX/OTFc6NWfNkNePqu4/ASYFonCH94OrQgspcGpzVjbzKzpLBHGReQpMwbm7/d0M
         YD5w==
X-Gm-Message-State: AOAM530jrJ7Fyho+EkbEwOVKLgklBzPNALEnLXT8sGINJVuBBhjtLgqT
        rSyJx7K2cemIZrsVmC45mbzPAQ==
X-Google-Smtp-Source: ABdhPJzmZO9DPHwWpq5bcm/uB+ld41fkcqMQ3vhyJ+BbFkla9FMUstw4PpsHkn7V6/6NabpIAn+JIg==
X-Received: by 2002:a5d:608e:: with SMTP id w14mr12008142wrt.18.1631882935719;
        Fri, 17 Sep 2021 05:48:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i1sm6355034wrb.93.2021.09.17.05.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 05:48:55 -0700 (PDT)
Date:   Fri, 17 Sep 2021 14:48:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch, marcan@marcan.st,
        maz@kernel.org, akpm@linux-foundation.org, npiggin@gmail.com,
        thunder.leizhen@huawei.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] drm/vboxvideo: Use managed interfaces for
 framebuffer write combining
Message-ID: <YUSOtX0kKA57xA1T@phenom.ffwll.local>
Mail-Followup-To: Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
        airlied@linux.ie, marcan@marcan.st, maz@kernel.org,
        akpm@linux-foundation.org, npiggin@gmail.com,
        thunder.leizhen@huawei.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210916181601.9146-1-tzimmermann@suse.de>
 <20210916181601.9146-6-tzimmermann@suse.de>
 <353180c3-4184-4723-a8ae-a633931beec4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <353180c3-4184-4723-a8ae-a633931beec4@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 09:28:53PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 9/16/21 8:16 PM, Thomas Zimmermann wrote:
> > Replace arch_phys_wc_add() with the rsp managed function. Allows for
> > removing the cleanup code for memory management
> > 
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Maybe review entire series and then ask Thomas to unblock some of your
stuff?
-Daniel

> 
> Regards,
> 
> Hans
> 
> 
> > ---
> >  drivers/gpu/drm/vboxvideo/vbox_drv.c |  5 +----
> >  drivers/gpu/drm/vboxvideo/vbox_drv.h |  1 -
> >  drivers/gpu/drm/vboxvideo/vbox_ttm.c | 17 ++++++++---------
> >  3 files changed, 9 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.c b/drivers/gpu/drm/vboxvideo/vbox_drv.c
> > index 2b81cb259d23..a6c81af37345 100644
> > --- a/drivers/gpu/drm/vboxvideo/vbox_drv.c
> > +++ b/drivers/gpu/drm/vboxvideo/vbox_drv.c
> > @@ -69,7 +69,7 @@ static int vbox_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  
> >  	ret = vbox_mode_init(vbox);
> >  	if (ret)
> > -		goto err_mm_fini;
> > +		goto err_hw_fini;
> >  
> >  	ret = vbox_irq_init(vbox);
> >  	if (ret)
> > @@ -87,8 +87,6 @@ static int vbox_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  	vbox_irq_fini(vbox);
> >  err_mode_fini:
> >  	vbox_mode_fini(vbox);
> > -err_mm_fini:
> > -	vbox_mm_fini(vbox);
> >  err_hw_fini:
> >  	vbox_hw_fini(vbox);
> >  	return ret;
> > @@ -101,7 +99,6 @@ static void vbox_pci_remove(struct pci_dev *pdev)
> >  	drm_dev_unregister(&vbox->ddev);
> >  	vbox_irq_fini(vbox);
> >  	vbox_mode_fini(vbox);
> > -	vbox_mm_fini(vbox);
> >  	vbox_hw_fini(vbox);
> >  }
> >  
> > diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.h b/drivers/gpu/drm/vboxvideo/vbox_drv.h
> > index 4903b91d7fe4..e77bd6512eb1 100644
> > --- a/drivers/gpu/drm/vboxvideo/vbox_drv.h
> > +++ b/drivers/gpu/drm/vboxvideo/vbox_drv.h
> > @@ -139,7 +139,6 @@ void vbox_mode_fini(struct vbox_private *vbox);
> >  void vbox_report_caps(struct vbox_private *vbox);
> >  
> >  int vbox_mm_init(struct vbox_private *vbox);
> > -void vbox_mm_fini(struct vbox_private *vbox);
> >  
> >  /* vbox_irq.c */
> >  int vbox_irq_init(struct vbox_private *vbox);
> > diff --git a/drivers/gpu/drm/vboxvideo/vbox_ttm.c b/drivers/gpu/drm/vboxvideo/vbox_ttm.c
> > index fd8a53a4d8d6..dc24c2172fd4 100644
> > --- a/drivers/gpu/drm/vboxvideo/vbox_ttm.c
> > +++ b/drivers/gpu/drm/vboxvideo/vbox_ttm.c
> > @@ -13,22 +13,21 @@
> >  int vbox_mm_init(struct vbox_private *vbox)
> >  {
> >  	int ret;
> > +	resource_size_t base, size;
> >  	struct drm_device *dev = &vbox->ddev;
> >  	struct pci_dev *pdev = to_pci_dev(dev->dev);
> >  
> > -	ret = drmm_vram_helper_init(dev, pci_resource_start(pdev, 0),
> > -				       vbox->available_vram_size);
> > +	base = pci_resource_start(pdev, 0);
> > +	size = pci_resource_len(pdev, 0);
> > +
> > +	/* Don't fail on errors, but performance might be reduced. */
> > +	devm_arch_phys_wc_add(&pdev->dev, base, size);
> > +
> > +	ret = drmm_vram_helper_init(dev, base, vbox->available_vram_size);
> >  	if (ret) {
> >  		DRM_ERROR("Error initializing VRAM MM; %d\n", ret);
> >  		return ret;
> >  	}
> >  
> > -	vbox->fb_mtrr = arch_phys_wc_add(pci_resource_start(pdev, 0),
> > -					 pci_resource_len(pdev, 0));
> >  	return 0;
> >  }
> > -
> > -void vbox_mm_fini(struct vbox_private *vbox)
> > -{
> > -	arch_phys_wc_del(vbox->fb_mtrr);
> > -}
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
