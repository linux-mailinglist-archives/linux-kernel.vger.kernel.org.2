Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8A433737D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhCKNKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbhCKNKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:10:20 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A5AC061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 05:10:20 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so12761799wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 05:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+hhpCW4NXZ2+Io3IMxIPYt+lYnp9sm+v1Ci9SUk4a3o=;
        b=JNpInhzYi/QnLCeOhXJx5y7ODz0WDyvNCzDUaEHpOk3MmBIeniVihqSRcfAx5GJ7px
         Jr+zQJ+o5Qlg1Vhf6G4z1e+jH7desHi3Dbn82MxKmS1Nq+qSx+mmW4AVXBigDJ/G0YuZ
         pGbslCB6D3BwYRFru3GF5x9gCIm9fC2/1MXxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=+hhpCW4NXZ2+Io3IMxIPYt+lYnp9sm+v1Ci9SUk4a3o=;
        b=uSw9u6m4vEFRbU+FtUUZahOksS7KlWCyIgDor55VD5owgFxxhacSC9uTd7eIsOGJ+6
         rWIKyrZGmhp4xgvVBAklYu9ByG+CGOpojBpudlbPk+2To/sLcVA5pGiGIdxPydGHZ7yO
         1vyQYOTm9ndL9Z3pXTUogtjoazn5x65iMo3AWcTakMECD6UucWbUmQnCh8iac50Bbkt1
         MxreHrPo3IkIv7k+cabEf5JDtCVdMRVyMXXVX4aUO9lbhs7tX7ORfgNrTP33barSUBNy
         v7YgRsQYIGQziwAtr9VM+ra16cw1Mg7wGIbJqIKdRpmFncZsroPmC2W4BoEU5M5eRcWw
         xbbQ==
X-Gm-Message-State: AOAM533qbLGeTvxAbeeL6PJ0+DKc9wLQG0ttXlgkD152iZvV752+QU2Q
        oJGOCv5HCF2IEl7pJKaUFrGtbg==
X-Google-Smtp-Source: ABdhPJy51Lb+MAwQ+byf24AEh2DP5jP8rj5VHu5rcUu4pEdw0ULIAaT7cZjaXYbs9Ol1mcprLfnklA==
X-Received: by 2002:a1c:7e45:: with SMTP id z66mr8189532wmc.126.1615468218741;
        Thu, 11 Mar 2021 05:10:18 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g5sm3782504wrq.30.2021.03.11.05.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 05:10:18 -0800 (PST)
Date:   Thu, 11 Mar 2021 14:10:16 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marek =?utf-8?B?T2zFocOhaw==?= <marek.olsak@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/radeon: fix copy of uninitialized variable back to
 userspace
Message-ID: <YEoWuBOCf8nr5tZn@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Marek =?utf-8?B?T2zFocOhaw==?= <marek.olsak@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210303002759.28752-1-colin.king@canonical.com>
 <490409f2-9fcb-d402-a6ae-b45c80bae3d2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <490409f2-9fcb-d402-a6ae-b45c80bae3d2@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 08:42:31AM +0100, Christian König wrote:
> Am 03.03.21 um 01:27 schrieb Colin King:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently the ioctl command RADEON_INFO_SI_BACKEND_ENABLED_MASK can
> > copy back uninitialised data in value_tmp that pointer *value points
> > to. This can occur when rdev->family is less than CHIP_BONAIRE and
> > less than CHIP_TAHITI.  Fix this by adding in a missing -EINVAL
> > so that no invalid value is copied back to userspace.
> > 
> > Addresses-Coverity: ("Uninitialized scalar variable)
> > Cc: stable@vger.kernel.org # 3.13+
> > Fixes: 439a1cfffe2c ("drm/radeon: expose render backend mask to the userspace")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> Let's hope that this doesn't break UAPI.

If it does I think the only difference would be errno userspace sees
(aside from the stack garbage, which we could also emulate). Switching to
return 0; is easy. So no worries this would be a problem :-)
-Daniel

> 
> Christian.
> 
> > ---
> >   drivers/gpu/drm/radeon/radeon_kms.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
> > index 2479d6ab7a36..58876bb4ef2a 100644
> > --- a/drivers/gpu/drm/radeon/radeon_kms.c
> > +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> > @@ -518,6 +518,7 @@ int radeon_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
> >   			*value = rdev->config.si.backend_enable_mask;
> >   		} else {
> >   			DRM_DEBUG_KMS("BACKEND_ENABLED_MASK is si+ only!\n");
> > +			return -EINVAL;
> >   		}
> >   		break;
> >   	case RADEON_INFO_MAX_SCLK:
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
