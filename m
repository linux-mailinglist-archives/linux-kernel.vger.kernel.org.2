Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33497361071
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhDOQwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:52:30 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:39689 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbhDOQw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:52:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618505524; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=nJyjkib2XarwJFFtDBFcrwVkSOSShC50uwK+PqeAZI0=; b=Fjfc0wuBG8IfyNg5qC/JZcMXyIMuPVDOGymwGyMKO1jf96ytQcDrvJBwdb0mKk1yww/eJzi4
 W5xItpwcJfWUGVkAPis075oc1Z8mjiuHrU5jSznVYwl9sSueQvPpOU3ca9Fh7SZzIO0BtZIw
 2EKQsw3Y/cNv11VV0D6VB6nQbQ0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60786f33e0e9c9a6b63c61d2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 15 Apr 2021 16:52:03
 GMT
Sender: akhilpo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1A07FC433CA; Thu, 15 Apr 2021 16:52:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.105] (unknown [117.210.185.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7BED4C433C6;
        Thu, 15 Apr 2021 16:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BED4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akhilpo@codeaurora.org
Subject: Re: [kbuild] drivers/gpu/drm/msm/adreno/a3xx_gpu.c:600
 a3xx_gpu_init() error: passing non negative 1 to ERR_PTR
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>
References: <20210409093738.GH6048@kadam>
From:   Akhil P Oommen <akhilpo@codeaurora.org>
Message-ID: <d3cd5c0b-f30e-6130-582d-7b68d8320507@codeaurora.org>
Date:   Thu, 15 Apr 2021 22:21:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210409093738.GH6048@kadam>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/2021 3:07 PM, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> head:   2d743660786ec51f5c1fefd5782bbdee7b227db0
> commit: 5785dd7a8ef0de8049f40a1a109de6a1bf17b479 drm/msm: Fix duplicate gpu node in icc summary
> config: arm64-randconfig-m031-20210407 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/gpu/drm/msm/adreno/a3xx_gpu.c:600 a3xx_gpu_init() error: passing non negative 1 to ERR_PTR
> drivers/gpu/drm/msm/adreno/a4xx_gpu.c:727 a4xx_gpu_init() error: passing non negative 1 to ERR_PTR
> 
> vim +600 drivers/gpu/drm/msm/adreno/a3xx_gpu.c
> 
> 7198e6b03155f6 Rob Clark      2013-07-19  515  struct msm_gpu *a3xx_gpu_init(struct drm_device *dev)
> 7198e6b03155f6 Rob Clark      2013-07-19  516  {
> 7198e6b03155f6 Rob Clark      2013-07-19  517  	struct a3xx_gpu *a3xx_gpu = NULL;
> 55459968176f13 Rob Clark      2013-12-05  518  	struct adreno_gpu *adreno_gpu;
> 7198e6b03155f6 Rob Clark      2013-07-19  519  	struct msm_gpu *gpu;
> 060530f1ea6740 Rob Clark      2014-03-03  520  	struct msm_drm_private *priv = dev->dev_private;
> 060530f1ea6740 Rob Clark      2014-03-03  521  	struct platform_device *pdev = priv->gpu_pdev;
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  522  	struct icc_path *ocmem_icc_path;
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  523  	struct icc_path *icc_path;
> 7198e6b03155f6 Rob Clark      2013-07-19  524  	int ret;
> 7198e6b03155f6 Rob Clark      2013-07-19  525
> 7198e6b03155f6 Rob Clark      2013-07-19  526  	if (!pdev) {
> 6a41da17e87dee Mamta Shukla   2018-10-20  527  		DRM_DEV_ERROR(dev->dev, "no a3xx device\n");
> 7198e6b03155f6 Rob Clark      2013-07-19  528  		ret = -ENXIO;
> 7198e6b03155f6 Rob Clark      2013-07-19  529  		goto fail;
> 7198e6b03155f6 Rob Clark      2013-07-19  530  	}
> 7198e6b03155f6 Rob Clark      2013-07-19  531
> 7198e6b03155f6 Rob Clark      2013-07-19  532  	a3xx_gpu = kzalloc(sizeof(*a3xx_gpu), GFP_KERNEL);
> 7198e6b03155f6 Rob Clark      2013-07-19  533  	if (!a3xx_gpu) {
> 7198e6b03155f6 Rob Clark      2013-07-19  534  		ret = -ENOMEM;
> 7198e6b03155f6 Rob Clark      2013-07-19  535  		goto fail;
> 7198e6b03155f6 Rob Clark      2013-07-19  536  	}
> 7198e6b03155f6 Rob Clark      2013-07-19  537
> 55459968176f13 Rob Clark      2013-12-05  538  	adreno_gpu = &a3xx_gpu->base;
> 55459968176f13 Rob Clark      2013-12-05  539  	gpu = &adreno_gpu->base;
> 7198e6b03155f6 Rob Clark      2013-07-19  540
> 70c70f091b1ffd Rob Clark      2014-05-30  541  	gpu->perfcntrs = perfcntrs;
> 70c70f091b1ffd Rob Clark      2014-05-30  542  	gpu->num_perfcntrs = ARRAY_SIZE(perfcntrs);
> 70c70f091b1ffd Rob Clark      2014-05-30  543
> 3bcefb0497f9fc Rob Clark      2014-09-05  544  	adreno_gpu->registers = a3xx_registers;
> 3bcefb0497f9fc Rob Clark      2014-09-05  545
> f97decac5f4c2d Jordan Crouse  2017-10-20  546  	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 1);
> 7198e6b03155f6 Rob Clark      2013-07-19  547  	if (ret)
> 7198e6b03155f6 Rob Clark      2013-07-19  548  		goto fail;
> 7198e6b03155f6 Rob Clark      2013-07-19  549
> 55459968176f13 Rob Clark      2013-12-05  550  	/* if needed, allocate gmem: */
> 55459968176f13 Rob Clark      2013-12-05  551  	if (adreno_is_a330(adreno_gpu)) {
> 26c0b26dcd005d Brian Masney   2019-08-23  552  		ret = adreno_gpu_ocmem_init(&adreno_gpu->base.pdev->dev,
> 26c0b26dcd005d Brian Masney   2019-08-23  553  					    adreno_gpu, &a3xx_gpu->ocmem);
> 26c0b26dcd005d Brian Masney   2019-08-23  554  		if (ret)
> 26c0b26dcd005d Brian Masney   2019-08-23  555  			goto fail;
> 55459968176f13 Rob Clark      2013-12-05  556  	}
> 55459968176f13 Rob Clark      2013-12-05  557
> 667ce33e57d0de Rob Clark      2016-09-28  558  	if (!gpu->aspace) {
> 871d812aa43e63 Rob Clark      2013-11-16  559  		/* TODO we think it is possible to configure the GPU to
> 871d812aa43e63 Rob Clark      2013-11-16  560  		 * restrict access to VRAM carveout.  But the required
> 871d812aa43e63 Rob Clark      2013-11-16  561  		 * registers are unknown.  For now just bail out and
> 871d812aa43e63 Rob Clark      2013-11-16  562  		 * limp along with just modesetting.  If it turns out
> 871d812aa43e63 Rob Clark      2013-11-16  563  		 * to not be possible to restrict access, then we must
> 871d812aa43e63 Rob Clark      2013-11-16  564  		 * implement a cmdstream validator.
> 871d812aa43e63 Rob Clark      2013-11-16  565  		 */
> 6a41da17e87dee Mamta Shukla   2018-10-20  566  		DRM_DEV_ERROR(dev->dev, "No memory protection without IOMMU\n");
> 871d812aa43e63 Rob Clark      2013-11-16  567  		ret = -ENXIO;
> 871d812aa43e63 Rob Clark      2013-11-16  568  		goto fail;
> 871d812aa43e63 Rob Clark      2013-11-16  569  	}
> 871d812aa43e63 Rob Clark      2013-11-16  570
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  571  	icc_path = devm_of_icc_get(&pdev->dev, "gfx-mem");
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  572  	ret = IS_ERR(icc_path);
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  573  	if (ret)
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  574  		goto fail;
> 
> IS_ERR() returns/true false so this will lead to an Oops in the caller.
> 
> 	icc_path = devm_of_icc_get(&pdev->dev, "gfx-mem");
> 	if (IS_ERR(icc_path)) {
> 		ret = PTR_ERR(icc_path);
> 		goto fail;
> 	}
Agree.

> 
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  575
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  576  	ocmem_icc_path = devm_of_icc_get(&pdev->dev, "ocmem");
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  577  	ret = IS_ERR(ocmem_icc_path);
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  578  	if (ret) {
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  579  		/* allow -ENODATA, ocmem icc is optional */
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  580  		if (ret != -ENODATA)
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  581  			goto fail;
> 
> Same.  ret is true/false so it can't be equal to -ENODATA, plus the
> caller will Oops.
> 
> Btw, this patch removed the assignments:
> 
> 		gpu->icc_path = of_icc_get(dev, "gfx-mem");
> 		gpu->ocmem_icc_path = of_icc_get(dev, "ocmem");
> 
> So I think "gpu->icc_path" and "gpu->ocmem_icc_path" are always
> NULL/unused and they should be removed.
> 
Agree. Will share a fix.
Thanks, Dan.

-Akhil.

> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  582  		ocmem_icc_path = NULL;
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  583  	}
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  584
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  585
> d163ba0b65f2e4 Brian Masney   2019-11-21  586  	/*
> d163ba0b65f2e4 Brian Masney   2019-11-21  587  	 * Set the ICC path to maximum speed for now by multiplying the fastest
> d163ba0b65f2e4 Brian Masney   2019-11-21  588  	 * frequency by the bus width (8). We'll want to scale this later on to
> d163ba0b65f2e4 Brian Masney   2019-11-21  589  	 * improve battery life.
> d163ba0b65f2e4 Brian Masney   2019-11-21  590  	 */
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  591  	icc_set_bw(icc_path, 0, Bps_to_icc(gpu->fast_rate) * 8);
> 5785dd7a8ef0de Akhil P Oommen 2020-10-28  592  	icc_set_bw(ocmem_icc_path, 0, Bps_to_icc(gpu->fast_rate) * 8);
> d163ba0b65f2e4 Brian Masney   2019-11-21  593
> 871d812aa43e63 Rob Clark      2013-11-16  594  	return gpu;
> 7198e6b03155f6 Rob Clark      2013-07-19  595
> 7198e6b03155f6 Rob Clark      2013-07-19  596  fail:
> 7198e6b03155f6 Rob Clark      2013-07-19  597  	if (a3xx_gpu)
> 7198e6b03155f6 Rob Clark      2013-07-19  598  		a3xx_destroy(&a3xx_gpu->base.base);
> 7198e6b03155f6 Rob Clark      2013-07-19  599
> 7198e6b03155f6 Rob Clark      2013-07-19 @600  	return ERR_PTR(ret);
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
> _______________________________________________
> kbuild mailing list -- kbuild@lists.01.org
> To unsubscribe send an email to kbuild-leave@lists.01.org
> 

