Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F377043CC77
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238930AbhJ0OmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhJ0OmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:42:16 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C33C079783
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:39:48 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id r6so3746354oiw.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZOVIW59kKpmA3YI6MyWfAQdWikp/1S+bV4WvwADltGI=;
        b=l3VHqW+goh9EHaX+7Vr/K8TAijIkOX8IUNP6+2QSVp9LQtv1as36aPVcm/F4HjQzC/
         LC+2Ruoy4oEUhC2ITk9J+MX8teOSjapO+KJH1NSabDmTTKPqFkhVfb5J9jPDCw8L0JER
         79INMm8w6WMacJjG0aK90648YYdIkXCdMjAZFObUvrhgMAqBEdGQgCg3J+DrbhlgTmaA
         YF6Vj4xML4fl0gBvveJ/6H7ETblC4ehdkPErvU967yh4nq/c08JPTZSTI/2+wXlppTdK
         enPzilSXE/M99mVYnlq1mWrEAsV3rIE2hKTbMk9uwfaQh9nrSquS8VmfIhkqu7p769qZ
         RPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=ZOVIW59kKpmA3YI6MyWfAQdWikp/1S+bV4WvwADltGI=;
        b=z2oXsriQu+gv5hvEgltlTq8PXaOXV7tWiaOYM0XCJRQK7tYSN30WiPWNXW/CUYCd/t
         XKyxHACKqrI7ywHlN6DV5UZLINTbWOrqt2dT8MaM0TTS7njuPoIp3dtA3t+KmIQWvTiz
         mKQgCaxIhZaD1TzSUp6D7QqEGuPkddxGKpP3fH12aLt5dUGxcyTh8LVGe/0GoQP0kJzb
         oYCW3SRzUean/3fFTFRbtmybr+z6YiM6lA9PJhl3bAVQLhY8BOeWPgYSmIfSjxEsDk4W
         ksjC79A45SB8BLsh6mXiJUvn9g776j48gJcWQCpcwNjiEyVRprS5xRYvh+kxAx01TQqx
         LZ/Q==
X-Gm-Message-State: AOAM531M03WJOSIWjztpbL3cuO5Ziuknv7O9AO5fvEiXoRcEt98Zm7UU
        4mW6z6qwDbbxFz6A5ONxyR8=
X-Google-Smtp-Source: ABdhPJyHthbhSHJfSRNPj/xZEqesLzv1SFbQ3NKuegTuxoKp/W3Nsj1ndnpoWIrBM4Ob9PJzOL+XWQ==
X-Received: by 2002:a05:6808:490:: with SMTP id z16mr4119312oid.54.1635345587781;
        Wed, 27 Oct 2021 07:39:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y123sm41791oie.0.2021.10.27.07.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:39:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 27 Oct 2021 07:39:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thelford Williams <tdwilliamsiv@gmail.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix out of bounds write
Message-ID: <20211027143945.GA1947580@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 04:04:13PM -0400, Thelford Williams wrote:
> Size can be any value and is user controlled resulting in overwriting the
> 40 byte array wr_buf with an arbitrary length of data from buf.
> 
> Signed-off-by: Thelford Williams <tdwilliamsiv@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

The fix works, but unless I am missing something it is incomplete.
parse_write_buffer_into_params() is called several times, and the
size parameter is always wrong. This patch only fixes one of several
instances of the problem.

Guenter

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 814f67d86a3c..9b3ad56607bb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -264,7 +264,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
>  	if (!wr_buf)
>  		return -ENOSPC;
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  					   (long *)param, buf,
>  					   max_param_num,
>  					   &param_nums)) {
> -- 
> 2.33.0
