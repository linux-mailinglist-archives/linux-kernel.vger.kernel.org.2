Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE1346618
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhCWRPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhCWRPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:15:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53675C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:15:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o16so21602074wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jkD/89hzNsqmkTz0cgn45+3G97+hdN9w0MYvdcADVJY=;
        b=h8rraCmPEqparAn5HJ+4/mzapBhqLvKpCahb5I3lLD89c+5vSx0qm5c/WvW7Hkg0QW
         vLuQyjlK6th2ka7h1zdWq2tmQMvAueieDzg2NMMFh/wTs+KFqeDjfk8lMmtIsSDInfkj
         hgumkG5eOb9/9AvlNf9fzgg5pyrhWZAfJFjsgYr7T/qefxwDnXtc/szmhIhYx8BvhfHa
         5Ab99TVj4UW5nyy0ZNc0XDiExScRPMt0UBdDfxHlVqOGJRB6auO/+tvXmAP6dPMWr+wN
         J9ybc4PVrTZFO2L6EUnKoiv15Dx12limTVkfQqobEnnMtgbSy9vwB9+4RA9s9Cjouc2r
         +FNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jkD/89hzNsqmkTz0cgn45+3G97+hdN9w0MYvdcADVJY=;
        b=f9oTGoy4VmVoeVWFC+3LDcz2Qj8+N3sWRr6wfkUwKZy9ugzuPcCzo3OqcpX27rGHQL
         jp+BwdZP3+15fq15GCIfGTUxhEtdzjB53ObaiaRTlvFO6I9rqhJTTXfR3Ama4u0CwLNK
         ArayyEFUOD70A3fRKYtUDcGQeOG0DcjXY3xfBEbOLJWR8A+1WDL+tmQ/94ZU9M/kbXLN
         AUUYPFbmBLvMciSCRDrQ+ZBbrRLI8Yap6UFqn9uo7RrACI0V60DVZHToccArQQBwfMni
         0+3acr1Fwt8PoPtDCf6Rf4vU51vzzYUXaxWf5DsUAV9ODTEoFJVj+UB5k5PBhvNb0ZYY
         Zdcw==
X-Gm-Message-State: AOAM530P4LMU1lfOCUhvbpXL3tvoAf9pXkboougOmwJ+6awjGjwR8YU8
        P45Psm2FxJRhWdo/0xfMMPgVOQ==
X-Google-Smtp-Source: ABdhPJzWk/7mbyRrWGJqZM8T40XSMeZ7AZ+LrfMOt0Jd/pLxU2JubXbpvZ4enfFd1MIJMNCEbK4leQ==
X-Received: by 2002:adf:e68e:: with SMTP id r14mr4985288wrm.273.1616519744011;
        Tue, 23 Mar 2021 10:15:44 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g15sm2957207wmq.31.2021.03.23.10.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 10:15:43 -0700 (PDT)
Date:   Tue, 23 Mar 2021 17:15:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/amd/display/dc/calcs/dce_calcs: Fix allocation
 size for dceip and vbios
Message-ID: <20210323171541.GX2916463@dell>
References: <20210323141541.348376-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323141541.348376-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the allocations for dceip and vbios are based on the size of
> the pointer rather than the size of the data structures, causing heap
> issues. Fix this by using the correct allocation sizes.
> 
> Addresses-Coverity: ("Wrong size of argument")
> Fixes: a2a855772210 ("drm/amd/display/dc/calcs/dce_calcs: Remove some large variables from the stack")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Fixed already mate.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
