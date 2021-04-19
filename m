Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA04363C93
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbhDSHdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbhDSHdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:33:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BEBC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:32:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k26so16430550wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Z8WpgIEyaNMIp2AG6J2yr0VQBL2GI1senNVwuLAl8l8=;
        b=ZQF7H/uM2rO49L9wpM9XllzZjitTbpXKWInesIXamkm9FCLyEWSAYYGY2w/0MNb5PE
         b5ESG/rXCvlhhb16xngbxkcyDZWxYpDi0tcoYEB5o7e/3L6g7OF6btvzN76aYAq/G10+
         0Eb4urisyR5zKISw5hHtHOGRZwGqbCNY8x4OO2ypbXcabXs4R8szDfjkJoIYydk9zfSU
         7/UxJwoN5KJ2rtk39R/PNfqepLj+Rj++PW3MyphjCJiFeWuI5b165CUFETQnewWKoGJd
         I69WZPf35biNVDZ6nR6XPRXUQUfBGrarporKZkSh34O/KX51oG0bm8XH9m3byyfDY+Ss
         vcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z8WpgIEyaNMIp2AG6J2yr0VQBL2GI1senNVwuLAl8l8=;
        b=QPIgCqy0VXXXC6Z1ffSjsaNarVruaCqHSMKRZH1HryFPIiyGYGxd1dpj4B5hBiKWRD
         P3XASaeE4GmbieQN7/OjGXr38/bNKk+0QNZaaaPj6noZuA17kHzrgjpbRAI9WaDjNenv
         hCW6xdEoxLDPnPoo7dPhUuJ5Fmc+JmOJb48oA2b14ubClvAKdyTIx2/lTTYNW/o92mSZ
         TPfl7opfyKGD9lAEaFO8w0URib6xaEzUeujfkjov8SBOhw54r8dEA9w7jr3MOCUVaB1M
         N1mnu36UpEIyadnpt1sCeUxDOFZlMwJi/41od1KXy1jSCmo14rPOycs0LCcTrT2geeMz
         jUuQ==
X-Gm-Message-State: AOAM533hGnXRnC9QZCcAeNCMU4VYBUIqthZUXfGvmAkqqAKKbqc9C37v
        tNIkoHDdW6z1CFvw5fbt2xsuEQ==
X-Google-Smtp-Source: ABdhPJx+cxP7LQa/qUpwTpH/IMyqh38VCbja+SonDd0qBBMbuOTUmqlP3W58Zo1ouVBaSuPseC56Ew==
X-Received: by 2002:adf:97d6:: with SMTP id t22mr12827899wrb.123.1618817555052;
        Mon, 19 Apr 2021 00:32:35 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 186sm18640349wme.10.2021.04.19.00.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:32:34 -0700 (PDT)
Date:   Mon, 19 Apr 2021 08:32:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 22/40] drm/ttm/ttm_tt: Demote non-conformant kernel-doc
 header
Message-ID: <20210419073232.GE4869@dell>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
 <20210416143725.2769053-23-lee.jones@linaro.org>
 <2a85bf3c-d40e-6608-98f3-cd399f4df912@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a85bf3c-d40e-6608-98f3-cd399f4df912@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2021, Christian König wrote:

> 
> 
> Am 16.04.21 um 16:37 schrieb Lee Jones:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >   drivers/gpu/drm/ttm/ttm_tt.c:398: warning: Function parameter or member 'num_pages' not described in 'ttm_tt_mgr_init'
> >   drivers/gpu/drm/ttm/ttm_tt.c:398: warning: Function parameter or member 'num_dma32_pages' not described in 'ttm_tt_mgr_init'
> > 
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> For that one I would rather prefer to just document the two parameters.

No problem.  Will fix.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
