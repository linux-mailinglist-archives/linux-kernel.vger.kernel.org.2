Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E9236B55F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhDZPDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:03:35 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:18541 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhDZPDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:03:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619449362; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=P+Q0gjVqnItHpKvn5/Y4qD5GvFZxA4F2pNTLT3bjqjw=;
 b=VHHymdp5m74rEKnavRlLBEWOcV39HXJ3pInHHu4LuRwt8LOVaSSZ9JQBNSTXpvV/RpfvlyL2
 A+P+fmup6PgYD0Z+Q+uld9xP1oj+0jyophuH2+BNe/uqeb9zGg00bep8JKosKkydKCxbtyk/
 N+0FkDajzVltGcWySWTx0xTmRn0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6086d5d8215b831afbc6f146 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Apr 2021 15:01:44
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A1479C43460; Mon, 26 Apr 2021 15:01:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8CED0C433F1;
        Mon, 26 Apr 2021 15:01:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 26 Apr 2021 20:31:41 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Rob Clark <robdclark@gmail.com>
Cc:     Sharat Masetty <smasetty@codeaurora.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>
Subject: Re: a6xx_gpu.c:undefined reference to `llcc_slice_deactivate'
In-Reply-To: <202104261123.Dqr4uccM-lkp@intel.com>
References: <202104261123.Dqr4uccM-lkp@intel.com>
Message-ID: <a7fd62d1c8eb4f829708ab4c99c05f6a@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-26 09:13, kernel test robot wrote:
> tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> master
> head:   9f4ad9e425a1d3b6a34617b8ea226d56a119a717
> commit: 474dadb8b0d557661cb3d1727f1ff2f82bac6b4c drm/msm/a6xx: Add
> support for using system cache(LLC)
> date:   5 months ago
> config: arm64-randconfig-m031-20210426 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         #
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=474dadb8b0d557661cb3d1727f1ff2f82bac6b4c
>         git remote add linus
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 474dadb8b0d557661cb3d1727f1ff2f82bac6b4c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross
> W=1 ARCH=arm64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    aarch64-linux-ld: Unexpected GOT/PLT entries detected!
>    aarch64-linux-ld: Unexpected run-time procedure linkages detected!
>    aarch64-linux-ld: drivers/gpu/drm/msm/adreno/a6xx_gpu.o: in
> function `a6xx_pm_suspend':
>>> a6xx_gpu.c:(.text+0x92c): undefined reference to 
>>> `llcc_slice_deactivate'
>>> aarch64-linux-ld: a6xx_gpu.c:(.text+0x94c): undefined reference to 
>>> `llcc_slice_deactivate'
>    aarch64-linux-ld: drivers/gpu/drm/msm/adreno/a6xx_gpu.o: in
> function `a6xx_pm_resume':
>>> a6xx_gpu.c:(.text+0xb9c): undefined reference to 
>>> `llcc_slice_activate'
>>> aarch64-linux-ld: a6xx_gpu.c:(.text+0xbc0): undefined reference to 
>>> `llcc_slice_activate'
>>> aarch64-linux-ld: a6xx_gpu.c:(.text+0xc00): undefined reference to 
>>> `llcc_get_slice_id'
>    aarch64-linux-ld: a6xx_gpu.c:(.text+0xc8c): undefined reference to
> `llcc_get_slice_id'
>    aarch64-linux-ld: a6xx_gpu.c:(.text+0xccc): undefined reference to
> `llcc_slice_activate'
>    aarch64-linux-ld: drivers/gpu/drm/msm/adreno/a6xx_gpu.o: in
> function `a6xx_destroy':
>>> a6xx_gpu.c:(.text+0x5e54): undefined reference to `llcc_slice_putd'
>>> aarch64-linux-ld: a6xx_gpu.c:(.text+0x5e74): undefined reference to 
>>> `llcc_slice_putd'
>    aarch64-linux-ld: drivers/gpu/drm/msm/adreno/a6xx_gpu.o: in
> function `a6xx_gpu_init':
>>> a6xx_gpu.c:(.text+0x60d0): undefined reference to `llcc_slice_getd'
>>> aarch64-linux-ld: a6xx_gpu.c:(.text+0x60f4): undefined reference to 
>>> `llcc_slice_getd'
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Arnd's patch [1] should fix the issue.

[1] 
https://lore.kernel.org/lkml/20210103140407.3917405-1-arnd@kernel.org/

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
