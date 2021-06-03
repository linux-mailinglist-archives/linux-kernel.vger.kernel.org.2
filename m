Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FF7399FC8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFCLb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFCLb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:31:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B37C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 04:30:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gb17so8688924ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 04:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=JQPG6yu+Jm/v1G300jVvmHhYJLJT/kgFqNxsmCD/SVU=;
        b=UuqGhLwhKPL2UZnJsZIyrY79pLOgLOqaHSPoNPoeWc4N8hx4767TnTwEsF3LZNtla/
         TPZGQVe+8BS7Rw28Rr950sI7gD11EViAabcSK9u58VHuMCAx2R8h+yL+P3NSDkYdJwy8
         LXhaBkjbtGs8KE5u0+ntseLSRBv+usQy6/MIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=JQPG6yu+Jm/v1G300jVvmHhYJLJT/kgFqNxsmCD/SVU=;
        b=hxVoiL8zMxk1sxUU/yN9de4+Y8Y08ERLbw/AopdvazAeN40M69FP6jTn2OnuFIhbFz
         Cad1fb2ULms8/OclhOhGQFPr11A4dHMrUPPi4wJMDA2XEQ263WmixaHeG6FkBTPJQ5Dv
         /12ryYgWhaftupyw2lS01EQ6F2saZzFPmGLD99hdyD/vi4GQ7RImvHLTzaZAWpiFbRAF
         lD5M5Ats+nO1C+gB0PxlE91CRuRVK0bDymmkWGPUco8l5IpwqT1cbM5B8CHQbwpfVWve
         jozMZnyZtwhmewtiehidJbweH3/e9nd4KyQzoexd/skP0wnFaXTD0cwp+djkahnFgcwV
         EhdQ==
X-Gm-Message-State: AOAM530Z0VwsnjPiV6eyv1hGN/FgXcvjb86vmNOgTm9czpCWAQCNx+FX
        oAuSCWTVop9EDsa1ucAk8E0yPw==
X-Google-Smtp-Source: ABdhPJwMUYfrOxIGftaR7UridML3dSa22TrXpD7HPzzADNMlpuQKbmkVQuxyFkP0lSzr1wU3d3ESbQ==
X-Received: by 2002:a17:907:72d2:: with SMTP id du18mr38469724ejc.438.1622719811673;
        Thu, 03 Jun 2021 04:30:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c14sm1402302ejm.4.2021.06.03.04.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 04:30:10 -0700 (PDT)
Date:   Thu, 3 Jun 2021 13:30:08 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND 17/26] drm/xlnx/zynqmp_disp: Fix incorrectly named enum
 'zynqmp_disp_layer_id'
Message-ID: <YLi9QI76rFWva6ID@phenom.ffwll.local>
Mail-Followup-To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Hyun Kwon <hyun.kwon@xilinx.com>, David Airlie <airlied@linux.ie>,
        Michal Simek <michal.simek@xilinx.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
References: <20210602143300.2330146-1-lee.jones@linaro.org>
 <20210602143300.2330146-18-lee.jones@linaro.org>
 <YLev02lSORBOlqw+@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLev02lSORBOlqw+@pendragon.ideasonboard.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 07:20:35PM +0300, Laurent Pinchart wrote:
> Hi Lee,
> 
> Thank you for the patch.
> 
> On Wed, Jun 02, 2021 at 03:32:51PM +0100, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/gpu/drm/xlnx/zynqmp_disp.c:101: warning: expecting prototype for enum zynqmp_disp_id. Prototype was for enum zynqmp_disp_layer_id instead
> > 
> > Cc: Hyun Kwon <hyun.kwon@xilinx.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Michal Simek <michal.simek@xilinx.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I'm assuming you'll merge these two for xlnx somehow?
-Daniel

> 
> > ---
> >  drivers/gpu/drm/xlnx/zynqmp_disp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > index 109d627968ac0..ca1161ec9e16f 100644
> > --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > @@ -91,7 +91,7 @@ struct zynqmp_disp_format {
> >  };
> >  
> >  /**
> > - * enum zynqmp_disp_id - Layer identifier
> > + * enum zynqmp_disp_layer_id - Layer identifier
> >   * @ZYNQMP_DISP_LAYER_VID: Video layer
> >   * @ZYNQMP_DISP_LAYER_GFX: Graphics layer
> >   */
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
