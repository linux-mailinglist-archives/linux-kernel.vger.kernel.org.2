Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936D135F13A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348848AbhDNKF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhDNKFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:05:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80749C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 03:05:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 18so22994234edx.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 03:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GVh307TByYmYoNzLAF6596sbOa45mSgCV5D/X4yX508=;
        b=kRv98L8xJPnkCwfDV/m+Gne5gNAPGjmBs7UWw5q4POogq0Z2Y8rGBGXfPUqUB1nKqq
         ULMzcZvMKnpRudRkAujqVbwDZvzQ8CmCGLRR0rOPl+z0yF65KAG7A83EE52ZIY+BWwM8
         9YPgyABoKBIUf3Mefnj7Rw6OGKSZR0Buare6DJ7jGwSznoNLe60BL4d52oXQCcemsxPN
         h5hJtyI4hTNgdbWq5dIdZ9sMwaGrvTcRwbiaoiBlAQggQW14M6VVx39l8FnFjq9NoI3C
         Jr0+wA4QJgAcA0yBsv02pZR/OP6eXw+o4ZOaaxlnbv6MDmLRHm2fEzJZh2XtjC9nu8X8
         hjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GVh307TByYmYoNzLAF6596sbOa45mSgCV5D/X4yX508=;
        b=J5d6KFnqKAXfk/MHw0juBIZH6u81ATOO3WFz5jahjOeuDCv3qQ1Zn8q8RAEub+BAFH
         eddWjtovr1nGAQiL07w17+5NN482OWnlGdlo0fVS2NHoFm/s8eS+59TfqiGLAC+yvyA8
         mCN0ysRUfoxCWV/aCTnwpGfvF7F7eySV8yqr0kZ3vRwuZkDb/rV4z2DQwL7r14cBEzE6
         yikNBnLPMP71Aakc0l2gNnrUEN1cWJHiqsd5wUWEMUMiu9SvC2lfFFTwIi/RhtH1xJlI
         pbDse4zrp6+VbmwXLv7u3ch73MYjgr2c6rirA/9Cev5XVWyHF/oDDtjhJw8RzR85+8iy
         EPtQ==
X-Gm-Message-State: AOAM532h17H6tO8FCzVNktBYpc7Pp2+0/5/cc72KE12k7TEocf27tpju
        N7XePW26H7fDPRJvpsVRxtZuBw==
X-Google-Smtp-Source: ABdhPJwqK8oiXg0xutMuNK4j6I69rvn/k96EWnLpL8VbK3QGFBwP0I7B9b6O0lVzKXVvxd4HA0sbhw==
X-Received: by 2002:a05:6402:128a:: with SMTP id w10mr39701798edv.277.1618394728272;
        Wed, 14 Apr 2021 03:05:28 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id mm8sm3068019ejb.28.2021.04.14.03.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 03:05:27 -0700 (PDT)
Date:   Wed, 14 Apr 2021 11:05:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v9 1/1] mfd: intel-m10-bmc: support for MAX10 BMC Secure
 Updates
Message-ID: <20210414100525.GM4869@dell>
References: <20210412195329.241357-1-russell.h.weight@intel.com>
 <20210412195329.241357-2-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210412195329.241357-2-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2021, Russ Weight wrote:

> Add macros and definitions required by the MAX10 BMC
> Secure Update driver.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> v9:
>   - Rebased on next-20210412
> v8:
>   - Previously patch 1/6 in "Intel MAX10 BMC Secure Update Driver"
>   - Rebased on next-20210121
> v7:
>   - No change
> v6:
>   - No change
> v5:
>   - Renamed USER_FLASH_COUNT to STAGING_FLASH_COUNT
> v4:
>   - No change
> v3:
>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
>     Update driver"
>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>     underlying functions will be called directly.
> v2:
>   - These functions and macros were previously distributed among
>     the patches that needed them. They are now grouped together
>     in a single patch containing changes to the Intel MAX10 BMC
>     driver.
>   - Added DRBL_ prefix to some definitions
>   - Some address definitions were moved here from the .c files that
>     use them.
> ---
>  include/linux/mfd/intel-m10-bmc.h | 85 +++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
