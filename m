Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EF8333893
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhCJJT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhCJJS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:18:56 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D902EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:18:55 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h98so22391888wrh.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tHj+yYn6t3BXOSgJFUIAj9kMAlyAXQomz7nQZa+bccQ=;
        b=u2BiIUlH+qwM/lTJ43p1ZgvILF9WghC1M6Fl+zwrN/Zow5Z65hnLrqm96UwdFcyqhN
         QpWppAOsUjDRuQLlHLxNFqFoljTyNqYJPMPJiO6XuOF0nYL70a2L+7plRIS5yUYAf3ye
         Sydmkt/CxJ/ZBE2+JnWBUm6KhsRI9b9LtDglfq3lAqbj4PmCo4jYU6yrZn5AbZNIVLMF
         LFYMoQIJjKbsG3wf4kN6I9hiKgbFLSbKmB3SWt215rfBMqdMMGlCcBi2m1AUYypU2RnU
         WYR6BF90/YTxUIY18w6hvkFcgvzRFzC25RGXr+A3K62IqGTPCfeTb4k4y0Z/raFGwfnR
         lgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tHj+yYn6t3BXOSgJFUIAj9kMAlyAXQomz7nQZa+bccQ=;
        b=DfdG2awEXWY5uM48b+Sytw6Bl5lSEuy7fCPumx+raoE6GkzhpIahgbZ+sv8iTpgx+0
         oxGubphE4wv4i1F4UYskII2fvGm7ZHGTPDlTgBXJ9PuGFUcCbBTRwFUWO0OVZfw70Fto
         28M6ZkuiOpUxjPe+KOagsG474EnAEcJ7Ji5q0f02laamwffMQLTpSEVkDUA4FhaBx5WP
         R5Vd/CqUMcuGq3J+fDRwHMagQrN7fQrj5lhPpK3xYFBQRjAcuXIjLQYgHbvHZk3C+cxD
         NBvJcOyS2GHveGqzEORL8zXQb4R8asW/8FuCaPGwdabjcGUJJ6gEZEf8Cp9fgLIBlZGe
         pHrQ==
X-Gm-Message-State: AOAM53124WiWIFSJ289A51b+uUQ/jX9I+DW62dVQfuTSoWBS5nLbeXEQ
        u09R7sk1xNSF+La/SLiGQTcA5g==
X-Google-Smtp-Source: ABdhPJyv67zCHDeVWMXuyG4SVDskcbkBX2VC2KDjpDYjCGgiZYkPqJRxTLGHq16gxEHE89ObNjJ9hg==
X-Received: by 2002:adf:a2cf:: with SMTP id t15mr2549043wra.250.1615367934657;
        Wed, 10 Mar 2021 01:18:54 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id y8sm7924430wmi.46.2021.03.10.01.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 01:18:54 -0800 (PST)
Date:   Wed, 10 Mar 2021 09:18:52 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v3 3/4] mfd: intel-m10-bmc: Add access table
 configuration to the regmap
Message-ID: <20210310091852.GL4931@dell>
References: <1614578385-26955-1-git-send-email-yilun.xu@intel.com>
 <1614578385-26955-4-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1614578385-26955-4-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2021, Xu Yilun wrote:

> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> This patch adds access tables to the MAX 10 BMC regmap. This prevents
> the host from accessing the unwanted I/O space. It also filters out the
> invalid outputs when reading the regmap debugfs interface.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v2: Use the new macro M10BMC_LEGACY_BUILD_VER
> v3: No change, rebased to 5.12-rc1
> ---
>  drivers/mfd/intel-m10-bmc.c       | 13 +++++++++++++
>  include/linux/mfd/intel-m10-bmc.h |  5 ++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
