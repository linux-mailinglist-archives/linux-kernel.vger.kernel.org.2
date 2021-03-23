Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054053463F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhCWP5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbhCWP5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:57:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0F3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:57:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h10so24000414edt.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZmVnw9e3zs9ujDSWUHwpSdZW2U3P6WcGwuzKoSOiP/c=;
        b=VXjlBx8Mz+v5Q26sEsoUwSqdY42SHNSc070iy6+C/2+8WhgNpN/eIMG6opEj2Q5R7f
         jx8Si+0Knav0nP8i1VRLSHQzWkFL8tNq9calbJclyI9eK6XlzVD99tFGbN6HLyl41uV7
         FWOXnzjNY3TL36TuW1kDoGMKK86rGfGuLiC4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZmVnw9e3zs9ujDSWUHwpSdZW2U3P6WcGwuzKoSOiP/c=;
        b=mQjfe1vvD5QxrwYzTuBLF/9iilUvBuhEL4pmw1kFVKJrG09TFjPPrTRseD2tOu12FZ
         ksVHnze1hpSOeAKoKPevJD67FdphLP6V7tpcJRaEMK8+4IE24bZWlFxIgy8aRDmJbF+K
         O5+bKkkgiPAHBXwOFGA7YMlmXdLYSIwbRVOEa2Dey4a/jBRzvGQExWSxKHtCSd8kVr5J
         WjQFQ60BwXd8FTN0eH7G+ZjrWIQR4URLWEdFq6W5I+G8UvCuYYhsCGgT+xhyBhbwZxvE
         s/yeanjZuKlIy03K6XPY5/OCYNQfLAx9rViOFrTRkiTrT/NT/XiCm4ueJkhmt5KnnqQy
         1BsQ==
X-Gm-Message-State: AOAM533ohu0hAvWG6J4cWcVQ31Cr8Z/HKQo6NV89LOoHikp83WjZaIzf
        ykJwOXa9ovncYq8B35zcH2qq9pKzMVPp6A==
X-Google-Smtp-Source: ABdhPJxJh4y5zbto9JNYyNG+99RMRhIVRkumjFcGhX+XdnF5W+FCTKAbJCF0L12eKaQjojQgMYg6kg==
X-Received: by 2002:a05:6402:1393:: with SMTP id b19mr5178086edv.333.1616515058513;
        Tue, 23 Mar 2021 08:57:38 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id la15sm11307906ejb.46.2021.03.23.08.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 08:57:38 -0700 (PDT)
Subject: Re: [PATCH] amdgpu: fix gcc -Wrestrict warning
To:     Arnd Bergmann <arnd@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huang Rui <ray.huang@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210323130430.2250052-1-arnd@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f8cd5d0b-0c50-a2e9-a5a1-a2358419dd44@rasmusvillemoes.dk>
Date:   Tue, 23 Mar 2021 16:57:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210323130430.2250052-1-arnd@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2021 14.04, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc warns about an sprintf() that uses the same buffer as source
> and destination, which is undefined behavior in C99:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c: In function 'amdgpu_securedisplay_debugfs_write':
> drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c:141:6: error: 'sprintf' argument 3 overlaps destination object 'i2c_output' [-Werror=restrict]
>   141 |      sprintf(i2c_output, "%s 0x%X", i2c_output,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   142 |       securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
>       |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c:97:7: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
>    97 |  char i2c_output[256];
>       |       ^~~~~~~~~~
> 
> Rewrite it to remember the current offset into the buffer instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> index 834440ab9ff7..69d7f6bff5d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> @@ -136,9 +136,10 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>  		ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
>  		if (!ret) {
>  			if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS) {
> +				int pos = 0;
>  				memset(i2c_output,  0, sizeof(i2c_output));
>  				for (i = 0; i < TA_SECUREDISPLAY_I2C_BUFFER_SIZE; i++)
> -					sprintf(i2c_output, "%s 0x%X", i2c_output,
> +					pos += sprintf(i2c_output + pos, " 0x%X",
>  						securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
>  				dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is :%s\n", i2c_output);

Eh, why not get rid of the 256 byte stack allocation and just replace
all of this by

  dev_info(adev->dev, ""SECUREDISPLAY: I2C buffer out put is: %*ph\n",
TA_SECUREDISPLAY_I2C_BUFFER_SIZE,
securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf);

That's much less code (both in #LOC and .text), and avoids adding yet
another place that will be audited over and over for "hm, yeah, that
sprintf() is actually not gonna overflow".

Yeah, it'll lose the 0x prefixes for each byte and use lowercase hex chars.

Rasmus
