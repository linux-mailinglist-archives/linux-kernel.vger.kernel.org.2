Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D344345284
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 23:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCVWph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 18:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhCVWpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:45:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3C4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=JsR7VWSm0T9gUi7PShJLjaTO/6YuAo/dscGaXeBiyKw=; b=wYjxPQZC1U9KOj9wXWjZupKzaL
        ybPrsoKILXI/tFnt3yMV0oWY4DgJZJlJPvguenZv+EIqhD+r3DlPKypAsCXF2sMd59nNg9/Ncz7Fm
        kvbKxQ3UbAvSt/KeeM/4luZUebyCg6Y837WIfw8ym5ygP9Hs8Kmt/b3/5BkVlqGkisi3mgQPSpzjA
        sFOiYOdvWqyMbXbXfRARc/I/tF3yFrmFmv+Oj5i/6hr5JundoAbfAIgsTal0KUb1cz7rNizqgtaqC
        i3GfMwSpo9DM7SwkBRY7zStw+MIMnc3nrDr8Gf9OJpLHNR6KfW4F2w2jAt2E7ZqAt0JhNODtAJvjw
        Ihhb2v9Q==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOTI7-009BWk-4p; Mon, 22 Mar 2021 22:45:01 +0000
Subject: Re: [PATCH] drm/amd: Fix a typo in two different sentences
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, evan.quan@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210322210612.1786322-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9696cd2a-bac2-15ba-c8e4-434df7b5cee0@infradead.org>
Date:   Mon, 22 Mar 2021 15:44:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322210612.1786322-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 2:06 PM, Bhaskar Chowdhury wrote:
> 
> s/defintion/definition/ .....two different places.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/gpu/drm/amd/include/atombios.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
> index c1d7b1d0b952..47eb84598b96 100644
> --- a/drivers/gpu/drm/amd/include/atombios.h
> +++ b/drivers/gpu/drm/amd/include/atombios.h
> @@ -1987,9 +1987,9 @@ typedef struct _PIXEL_CLOCK_PARAMETERS_V6
>  #define PIXEL_CLOCK_V6_MISC_HDMI_BPP_MASK           0x0c
>  #define PIXEL_CLOCK_V6_MISC_HDMI_24BPP              0x00
>  #define PIXEL_CLOCK_V6_MISC_HDMI_36BPP              0x04
> -#define PIXEL_CLOCK_V6_MISC_HDMI_36BPP_V6           0x08    //for V6, the correct defintion for 36bpp should be 2 for 36bpp(2:1)
> +#define PIXEL_CLOCK_V6_MISC_HDMI_36BPP_V6           0x08    //for V6, the correct definition for 36bpp should be 2 for 36bpp(2:1)
>  #define PIXEL_CLOCK_V6_MISC_HDMI_30BPP              0x08
> -#define PIXEL_CLOCK_V6_MISC_HDMI_30BPP_V6           0x04    //for V6, the correct defintion for 30bpp should be 1 for 36bpp(5:4)
> +#define PIXEL_CLOCK_V6_MISC_HDMI_30BPP_V6           0x04    //for V6, the correct definition for 30bpp should be 1 for 36bpp(5:4)
>  #define PIXEL_CLOCK_V6_MISC_HDMI_48BPP              0x0c
>  #define PIXEL_CLOCK_V6_MISC_REF_DIV_SRC             0x10
>  #define PIXEL_CLOCK_V6_MISC_GEN_DPREFCLK            0x40
> --


-- 
~Randy

