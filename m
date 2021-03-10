Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B25333895
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhCJJUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhCJJTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:19:50 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C99C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:19:49 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b18so22438183wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PVNedkkKpVAOBXR/t2ZWvouM0Cb8Zr2NJii8w5ZgcAU=;
        b=UzmDnBAls30cfQT5WfUg1iPN9L3ygNyjCvIWPVld0GcncMGPWUStycG81yJei7yxei
         1Iv4sgzXPZgI3ha7Jm1pTiTm/S7CCJg2VAG6dT8FEAr6QWmI/UKCYefKWVm3zQjd7qqa
         bC/PyPhxwOPUg/7pSG4juhmopB0ACDxgW74h1jHAEqDD8EO5dlth3aLAq/m+Rkyjpc3P
         KvdJMNNX1Mid9wJJntwKUt9Src+3+cnwGuPZA8yr+cZl2W5YzzH7dPxViz0FOrPG6VEg
         KEmj/r8TRJsEmB+5LISDoPjFlD9HrOHDTKXkgZyZwbY67EO+UaCy11XjEYVUBrcs8YtW
         tBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PVNedkkKpVAOBXR/t2ZWvouM0Cb8Zr2NJii8w5ZgcAU=;
        b=sNPKCzsmXYX/n24GNHW6ueE6s/3LQUCy3rqNEslC4H8tUaXGatZz9ohk2RAzrv3Qtf
         6fg7Zi9nUiiMSKzYZreTkiC/RPirGkf3SjuV52sP5YsgMaPfehKLnyUsLcRN01TqLGyP
         ZdeyhxEliyRF7fBSLox1HTjBAN+smJE+znwZS1RKFjCyQKwetDTCfETHn4K/ZjlwXBxo
         /t2D/ly5I5RmojbZfw+0hteTf82UdQ80Rq4cracBKrh9a73RwxfNzQW/eULqETkBhwB6
         gwPKmWTcSzT47/FbPy8I3qoXnjgDfTk84kNJE2xlwjxxj0rC0UprGeCh/if3feDuIMqF
         QSPQ==
X-Gm-Message-State: AOAM531PxXpTj3pEfHtfGtHiADDOzz0bQ75B2Xg/0ErdRlo/ZQCvqP7X
        bEvyQm7Jz0zsB7KeDb4XMx/fsA==
X-Google-Smtp-Source: ABdhPJwnTSFH8BtGwZ4GUIiCoCXMFPk2GaVWRtNv48CNMh9SrRGH3ogUtG7IrKoFBMfhnrIeryClxA==
X-Received: by 2002:a5d:4708:: with SMTP id y8mr2555075wrq.382.1615367988336;
        Wed, 10 Mar 2021 01:19:48 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id o14sm26829893wri.48.2021.03.10.01.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 01:19:47 -0800 (PST)
Date:   Wed, 10 Mar 2021 09:19:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v3 4/4] MAINTAINERS: Add entry for Intel MAX 10 mfd driver
Message-ID: <20210310091946.GM4931@dell>
References: <1614578385-26955-1-git-send-email-yilun.xu@intel.com>
 <1614578385-26955-5-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1614578385-26955-5-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2021, Xu Yilun wrote:

> This patch adds maintainer info for Intel MAX 10 mfd driver.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v3: Add Tom Rix as the reviewer.
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
