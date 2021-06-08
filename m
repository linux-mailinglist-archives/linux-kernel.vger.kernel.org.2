Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FB639F169
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhFHIyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFHIyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:54:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78DDE6124B;
        Tue,  8 Jun 2021 08:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623142370;
        bh=ffcy4ITRe2eWn3D6+rBqkBtJ9q7jBgASKT2AeYL6tlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AxBTUuuqJFLd+tUj+ExsdO3Tk7AOsBqAzJOl93L45BIJhTCmBl/emih/hJfbF6MhX
         CLrDZ7U0W0JsVyIdy5X76QcoH0ViKA7WYOOALgv707aGn0yQZmVojVAffK/hI16SbJ
         dCIFpJs2fa+g3lAPPuIWSYepi2zwkYL/G3syjefyyOAyZj/nVLn2IZbU3lkJvhq1cO
         lpd0WFCUzg+iKH68CEV9cQA4H5UYJwtAFzSCcbIp5O9k7t8Lbn4LFrqK8rCnk+2cq8
         CuS+LyOr8znLPaiximWsp0d3RsQY2d+pEAy8/Ix7MmaB/G0/FUAf26qF1v2eCcM9J1
         CWfSkl5SmdV6A==
Date:   Tue, 8 Jun 2021 09:52:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 8/9] drivers/perf: Simpilfy EVENT ATTR macro in
 arm_dsu_pmu.c
Message-ID: <20210608085245.GA8791@willie-the-truck>
References: <1623123201-45634-1-git-send-email-liuqi115@huawei.com>
 <1623123201-45634-9-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623123201-45634-9-git-send-email-liuqi115@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 11:33:20AM +0800, Qi Liu wrote:
> Use common macro PMU_EVENT_ATTR_ID to simplify DSU_EVENT_ATTR.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>  drivers/perf/arm_dsu_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> index 196faea..bed8376 100644
> --- a/drivers/perf/arm_dsu_pmu.c
> +++ b/drivers/perf/arm_dsu_pmu.c
> @@ -82,7 +82,7 @@
>  	})[0].attr.attr)
>  
>  #define DSU_EVENT_ATTR(_name, _config)		\
> -	DSU_EXT_ATTR(_name, dsu_pmu_sysfs_event_show, (unsigned long)_config)
> +	PMU_EVENT_ATTR_ID(_name, dsu_pmu_sysfs_event_show, _config)
>  
>  #define DSU_FORMAT_ATTR(_name, _config)		\
>  	DSU_EXT_ATTR(_name, dsu_pmu_sysfs_format_show, (char *)_config)

I'm not convinced this is any simpler. We still have two users of the
DSU_EXT_ATTR macro and the net effect is no change in line count.

Will
