Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C93E3167AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhBJNPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhBJNO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:14:56 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1614EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 05:14:15 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u14so2513439wri.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 05:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yd/N+I5kkzyOJpCnRN7vd7lwOUGF6B7BATQPc1K2fYQ=;
        b=Ku2flnqwc5D6z3d9GmRgcHXuXbDphKiJCNyjgnzoxVdwxDs/52BrDyb7OcLZWnkYAz
         UR5IZLaVzdRpurLn7fxlbf1b3mo/RM5L29GsZ6tgTpsyMRaO55uRbNi615w5EEGuzuiH
         EftzrNQu9uZtxv0u8BEWObc6EWl1rD8xoM1xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=yd/N+I5kkzyOJpCnRN7vd7lwOUGF6B7BATQPc1K2fYQ=;
        b=X2dFYDWFKU+Y964zWsuAvFW/9mePlC/Cn9TX44+Cmjg+UYNpBaZ5eCPChOt4qg5SWZ
         5zwbxGKbF1Bt584r3xFZcLYUEqd2i86kFdgfQ2AKYGBm+LFJoV56l2dcHpSX1TfUtp+F
         p0fEEiXpwtlvgnDHhlIvWPnwoI1KbjmQt4avIDtInsWLpMM0EL1se9DXUyv42ZVl4NNp
         ciIWbp07XzEZ+YZtQYAp7uM2mCj41M+OYbVQPsqK05eFnmK3p5GkPyCvGh24bhhHvq9U
         iOmEPdYohhrnSWWghpsF03f2nQ1Nq2jhwDN9RHSOBUbU1gvVeeg1Ha8pSDn1nJwePMvp
         YXGw==
X-Gm-Message-State: AOAM531ZpMHtSF+PqBv2G+ylJd1luRhQ8KT6NX5jtno5W8az7vFfTcOf
        D+l5v42OnQHAddacj4TsTRNLrw==
X-Google-Smtp-Source: ABdhPJzaMMmb4JfbfYiORqaQNccdJmyShOrVZsJEkutd675pXDThmmVuBjfO9+5KkU1bjFmrTMFG0A==
X-Received: by 2002:a05:6000:1374:: with SMTP id q20mr3489704wrz.44.1612962853806;
        Wed, 10 Feb 2021 05:14:13 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id r1sm2894759wrl.95.2021.02.10.05.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 05:14:13 -0800 (PST)
Date:   Wed, 10 Feb 2021 14:14:11 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Likun Gao <Likun.Gao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH 0/3] drm/ttm: constify static vm_operations_structs
Message-ID: <YCPcIwxso67M3VqR@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Likun Gao <Likun.Gao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org
References: <20210209234817.55112-1-rikard.falkeborn@gmail.com>
 <e819cb08-98b6-c87d-4d95-338e06f88a48@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e819cb08-98b6-c87d-4d95-338e06f88a48@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 08:45:56AM +0100, Christian König wrote:
> Reviewed-by: Christian König <christian.koenig@amd.com> for the series.

Smash it into -misc?
-Daniel

> 
> Am 10.02.21 um 00:48 schrieb Rikard Falkeborn:
> > Constify a few static vm_operations_struct that are never modified. Their
> > only usage is to assign their address to the vm_ops field in the
> > vm_area_struct, which is a pointer to const vm_operations_struct. Make them
> > const to allow the compiler to put them in read-only memory.
> > 
> > With this series applied, all static struct vm_operations_struct in the
> > kernel tree are const.
> > 
> > Rikard Falkeborn (3):
> >    drm/amdgpu/ttm: constify static vm_operations_struct
> >    drm/radeon/ttm: constify static vm_operations_struct
> >    drm/nouveau/ttm: constify static vm_operations_struct
> > 
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
> >   drivers/gpu/drm/nouveau/nouveau_ttm.c   | 2 +-
> >   drivers/gpu/drm/radeon/radeon_ttm.c     | 2 +-
> >   3 files changed, 3 insertions(+), 3 deletions(-)
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
