Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154C9368ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241336AbhDWI3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhDWI3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:29:30 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88F8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 01:28:52 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id t14-20020a05600c198eb029012eeb3edfaeso733260wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 01:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=h5v4zIXPv6WHWTKJvFYWSELVGuItjZYfaJrXobHmfuo=;
        b=LLTmm9mVlUi6clUD7JUsKWh0K7EL9Qw1q+pdK4ZgZuITlf3H+/lF//Fd0MDVRsaqTW
         /oIEliN++BGSRU87nOuOB2UvKwiAAbsHuQy6Zynb7CvSh5n2sNrZTWMKmO0kKOavskOS
         aBl2Rl8MoS3ZpdXFYhkzVmL5jCn1HXJVQeeElRhahx5oerQBev0+84SKaIvKSgFEKVYi
         NvrdvcLb0CTLSceov4ymzZfGhdkqLHjBDesJyKYl60PycziYY7wMyvWFFS1ncEkiVuQl
         DwFZ8G1IJ2GiCiBgxAeAbN2dk1H6malE9XSGm002jWeT1FwQ7cgnUwofPJDv3NAZ6oOM
         giyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=h5v4zIXPv6WHWTKJvFYWSELVGuItjZYfaJrXobHmfuo=;
        b=E9cWzSxM3jxu9rgdZ5rwNZc2/v52jB3o0bJA/mhO4TkV2kWvHDQB8jtHz+yCRPAeU4
         Onqo5zov9QcNomxabdUzMEQHURGTiA2xaCIBC95Umos3UJjUr5owqyrRP9J6Pr93T0IG
         /D6RllH8CzN57HM8OvjYnSsgvsGLidwQkkfQtZFhtRiPsmHoPbL6nZRLad5MZRqCvg8F
         nMf5TKxlWtAB9optz/0MsV7O4lQDPq82etuEHfkVbPiewtWGfQfyw3ezoHLuFrsaIczg
         /NCp1zGSJCDB6GPIL062CyPATA2sNHgb/BW/xV6uWZHWKbodinCK6w4KCtLa0TZ8KLN9
         Ei5A==
X-Gm-Message-State: AOAM530kfeUBLdrROWrGvx8gDeg+yxx1Ke2NZuX5clQRnQFoYxZK4z9b
        W4r6Xpf3lnhm60laK6UR/5Y9TQ==
X-Google-Smtp-Source: ABdhPJxWpAEBcc/UIoHyOrRT4kaqZXgVnkDlB7IPILt72r+qVIyQSieMIAQdqs2mehCKPaIeN0ZGvQ==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr4203194wmi.160.1619166531614;
        Fri, 23 Apr 2021 01:28:51 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 2sm9611435wmi.19.2021.04.23.01.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 01:28:51 -0700 (PDT)
Date:   Fri, 23 Apr 2021 09:28:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 31/40] drm/amd/amdgpu/amdgpu_gart: Correct a couple of
 function names in the docs
Message-ID: <20210423082849.GD6446@dell>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
 <20210416143725.2769053-32-lee.jones@linaro.org>
 <2029fbcf-8d2b-7a85-edd2-481a571ae43d@amd.com>
 <CADnq5_N5_poFcOpQzV+Ae22rwD0PG3kq0O3q10gmbb7=fNpEyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_N5_poFcOpQzV+Ae22rwD0PG3kq0O3q10gmbb7=fNpEyA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021, Alex Deucher wrote:

> Applied.  thanks!

Lovely.  Thanks for these Alex.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
