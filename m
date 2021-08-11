Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA673E904E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbhHKMQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbhHKMQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:16:19 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CE8C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:15:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 203-20020a1c00d40000b02902e6a4e244e4so1806484wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nn/UPEtSSOq2aO+2n1rQfQxHGvQ/Gb9SyS5gCui4WYA=;
        b=lF2YYKb4jTBJYsM584kgmaeezgvjtLBvwh+Z3r4O92Wx+UZnokkPIXv6Ft0VrpO+gU
         FBRISDB4mkfr+rFk8xebcIzXIstiEBECHdjhTCNS24t5rFHWrDNsM7OBbj87DK7T+Bn5
         zIgj+wRY19cycQ/1pbeiUeOZIC/JJZZoBeJezaM129dN6fniuGJ06bPRQbp20SxblaTl
         gui4Hm9hYkrawNye97fNW3Ucn8FC5AsaavmiPnnrUMvLZe1FKfAm3l4nkg9C8+V0ISva
         xNXH8qd3iXMQCesPGF1Y6mIliyOC0eKV4qtnt9FB3vQa3XCg5SBZpP506QlZRe0rsRtl
         xgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nn/UPEtSSOq2aO+2n1rQfQxHGvQ/Gb9SyS5gCui4WYA=;
        b=CRMRFcy6PpG+4KOSWxEc9XVkbF+XPrBJ5eIQNJhOATROX0Xpfw14pHJvmXuCqw2ebD
         uUQYesP78KIOXiTjlUA9Peu1yhIQzpiP14Zqsuvu50Z80X+6VgOwRwj1oaGI5oo1OLf+
         sd6QhrYpsl5eljCDDZEY2tFhc2fWULzz4STfcSbrvZZ867XlZmPBtxosZYJihjL2P3TU
         pQX9ouE5TC7+BkOZvjBnG6MXvyNzRlXzAj5/rOECukG0xX4aeUZeDUY+U/HNJ3TaQV88
         UFEyM4iMzN4AhNaVOp1hq/0gm/CYTK7oc22+PhiPYBlaH+qYTy58lYZIHp18BhRP2cBG
         5oiA==
X-Gm-Message-State: AOAM530LwOhwWN5SRUBRfR1GalKpXHQQoN9fGiNoKTbOiPPoycMwEDJY
        cTFOJJ3mc3Yi4DO+TawTSFdEcA==
X-Google-Smtp-Source: ABdhPJwbiZZJ3tq7YeVxFlt6/xFEZZ5E4igk1i+pordJ0dTrDJZklBO9SHmM1R+GAj1h1e5BOMZ9jQ==
X-Received: by 2002:a7b:c958:: with SMTP id i24mr8339082wml.42.1628684153630;
        Wed, 11 Aug 2021 05:15:53 -0700 (PDT)
Received: from localhost ([82.44.17.50])
        by smtp.gmail.com with ESMTPSA id h9sm5558968wrv.84.2021.08.11.05.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 05:15:52 -0700 (PDT)
Date:   Wed, 11 Aug 2021 13:15:52 +0100
From:   Jamie Iles <jamie@nuviainc.com>
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com
Subject: Re: [PATCH v1 02/20] x86/resctrl: Merge mon_capable and mon_enabled
Message-ID: <YRO/ePm75ekuO+6j@hazel>
References: <20210729223610.29373-1-james.morse@arm.com>
 <20210729223610.29373-3-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729223610.29373-3-james.morse@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, Jul 29, 2021 at 10:35:52PM +0000, James Morse wrote:
> mon_enabled and mon_capable are always set as a pair by
> rdt_get_mon_l3_config().
> 
> There is no point having two values.
> 
> Merge them together.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h | 4 ----
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 1 -
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++----
>  include/linux/resctrl.h                | 4 ++--
>  4 files changed, 6 insertions(+), 11 deletions(-)
> 
...
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index ada0a02093a6..d715df9de37f 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -130,7 +130,7 @@ struct resctrl_schema;
>  /**
>   * struct rdt_resource - attributes of a resctrl resource
>   * @rid:		The index of the resource
> - * @mon_enabled:	Is monitoring enabled for this feature
> + * @cdp_enabled		Is CDP enabled for this resource
>   * @alloc_capable:	Is allocation available on this machine
>   * @mon_capable:	Is monitor feature available on this machine
>   * @num_rmid:		Number of RMIDs available
> @@ -149,7 +149,7 @@ struct resctrl_schema;
>   */
>  struct rdt_resource {
>  	int			rid;
> -	bool			mon_enabled;
> +	bool			cdp_enabled;

Nothing is setting cdp_enabled in this patch, is this intended to be 
here?

Thanks,

Jamie
