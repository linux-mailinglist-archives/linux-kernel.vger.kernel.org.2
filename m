Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1A639B566
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhFDI77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhFDI75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:59:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F82C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 01:57:56 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p13-20020a05600c358db029019f44afc845so5155825wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 01:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/0XS+taR8uO0Puxfl2+DmxsoWoL/hO28ux66/TfeXRE=;
        b=WfJOqL6TtKt8J4Be3wgOm4JHJ8FOJwSwNKlkmW/uNwzuaZ/SyU+xkNLZD5idPTHDB8
         TvyBoiOtv7ZEwPlikHdvUA46RQCybUiS27Cth69Dz0oxwSB45rhkkwf9nYHUJVwue+0A
         iwnZKX4V54W2Sw8Fz6RP/n/idZWnjG3fobAMtTQaJIQSKG/sanGE8KpnFzoDpbicJ0qU
         1aGEdAoZpGiBpFlD+goILCI7RhOHiBgjfyKTsDjkDuJOMGLZpnwDGmqjEVSE33SiKDX5
         q4bS0Ag4SzLVxMFIJGr2VB2Vogv/PrBZIKcyssJud6xsHVYQB0nrRD6bKzHr0fUSCKHl
         6IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/0XS+taR8uO0Puxfl2+DmxsoWoL/hO28ux66/TfeXRE=;
        b=A8UpjYHtd9losR0HeRMb6YV/fyS9cSdfxAgdfs+hMJ+2SjTNHXMuayJdq/n9nuQtQN
         Tbh3XIKcljZvjTkK4XxIFFjRdTpBE5RAKo5NAoGYvBSlo3PLe1+oThK1lZArZf/0Z4+T
         s5nEVc4dG1wm4vtlbPPVP4ClYscLYDk64xsjP1Hy0XcKnvIX64iD1oMxF/TWrR5DDyrn
         Nfcefo0CeZjvwOfMzlgOKX3U8hCVoeLbJ7W2idTu3n4Xqu5tS1UGUxO7Jph9q9GdnS2z
         NxM/H5rM+epzLoGSpR1aqIbGyMsTXqLJ/8LxLJCrCA8OPc3IewFyVLxD+k90Lo+Wi55+
         NbJA==
X-Gm-Message-State: AOAM530cbrR8CVN7GMlcLjp/hRjIig1LRroDV8vNFTPfBsCpYaqTflhy
        dT0QKg0OrdEozOggF7wlvtfW0w==
X-Google-Smtp-Source: ABdhPJxSerMJo/NyEAwIjmxLZAscEMfLRp3dsxK1fpB61fIULrq5CngQm+FyXIn4sq6jKtWiJ2gD8A==
X-Received: by 2002:a05:600c:4f0f:: with SMTP id l15mr2515531wmq.143.1622797075254;
        Fri, 04 Jun 2021 01:57:55 -0700 (PDT)
Received: from dell ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id x11sm6033904wru.87.2021.06.04.01.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 01:57:54 -0700 (PDT)
Date:   Fri, 4 Jun 2021 09:57:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [RESEND 10/26] drm/msm/disp/dpu1/dpu_hw_interrupts: Demote a
 bunch of kernel-doc abuses
Message-ID: <20210604085752.GI2435141@dell>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
 <20210602143300.2330146-11-lee.jones@linaro.org>
 <85bd6c24-0e4e-6f18-ccf0-6acf62d0f0ff@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85bd6c24-0e4e-6f18-ccf0-6acf62d0f0ff@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Jun 2021, Dmitry Baryshkov wrote:

> On 02/06/2021 17:32, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:17: warning: expecting prototype for Register offsets in MDSS register file for the interrupt registers(). Prototype was for MDP_SSPP_TOP0_OFF() instead
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:35: warning: expecting prototype for WB interrupt status bit definitions(). Prototype was for DPU_INTR_WB_0_DONE() instead
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:42: warning: expecting prototype for WDOG timer interrupt status bit definitions(). Prototype was for DPU_INTR_WD_TIMER_0_DONE() instead
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:51: warning: expecting prototype for Pingpong interrupt status bit definitions(). Prototype was for DPU_INTR_PING_PONG_0_DONE() instead
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:71: warning: expecting prototype for Interface interrupt status bit definitions(). Prototype was for DPU_INTR_INTF_0_UNDERRUN() instead
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:85: warning: expecting prototype for Pingpong Secondary interrupt status bit definitions(). Prototype was for DPU_INTR_PING_PONG_S0_AUTOREFRESH_DONE() instead
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:94: warning: expecting prototype for Pingpong TEAR detection interrupt status bit definitions(). Prototype was for DPU_INTR_PING_PONG_0_TEAR_DETECTED() instead
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:102: warning: expecting prototype for Pingpong TE detection interrupt status bit definitions(). Prototype was for DPU_INTR_PING_PONG_0_TE_DETECTED() instead
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:110: warning: expecting prototype for Ctl start interrupt status bit definitions(). Prototype was for DPU_INTR_CTL_0_START() instead
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:119: warning: expecting prototype for Concurrent WB overflow interrupt status bit definitions(). Prototype was for DPU_INTR_CWB_2_OVERFLOW() instead
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:125: warning: expecting prototype for Histogram VIG done interrupt status bit definitions(). Prototype was for DPU_INTR_HIST_VIG_0_DONE() instead
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:133: warning: expecting prototype for Histogram VIG reset Sequence done interrupt status bit definitions(). Prototype was for DPU_INTR_HIST_VIG_0_RSTSEQ_DONE() instead
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:141: warning: expecting prototype for Histogram DSPP done interrupt status bit definitions(). Prototype was for DPU_INTR_HIST_DSPP_0_DONE() instead
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:149: warning: expecting prototype for Histogram DSPP reset Sequence done interrupt status bit definitions(). Prototype was for DPU_INTR_HIST_DSPP_0_RSTSEQ_DONE() instead
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:157: warning: expecting prototype for INTF interrupt status bit definitions(). Prototype was for DPU_INTR_VIDEO_INTO_STATIC() instead
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c:170: warning: expecting prototype for AD4 interrupt status bit definitions(). Prototype was for DPU_INTR_BACKLIGHT_UPDATED() instead
> 
> Most of these defines are gone in msm/msm-next. Could you please rebase and
> repost just this patch? Other patches apply clearly.

Sure.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
