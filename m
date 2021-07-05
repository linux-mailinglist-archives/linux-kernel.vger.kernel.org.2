Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECC33BBBB7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 12:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhGELA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhGELAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:00:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8198C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 03:58:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h1-20020a17090a3d01b0290172d33bb8bcso2096909pjc.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TS5725BMQ0gKTaaRgTF2dpCMOSOYoKyPmGmSv9N+v5s=;
        b=q6FxVJ0dJy7lazmhe+1rZ3CgvAlLA66cQFTv6qVfww3zQ5mf6UpwZmgA+l6UvMWqyK
         hNU+O5GKNzofInBtJOneWyrcSRVm+KBB5me0/udCDLq89GtSOBcf8pOFMLuXsl+edomV
         0w9YZzfiksxizixHFErivxdXVwLRW4FU9IdsMXwfU0+osN1H+EEQu0NzDFi8oyp9DehN
         3hWz38gIByHT06yo3Iwzxbgb5xz5NT+tjsqxhrg+lNipnmDtfXH6DJli3sLaXQAihmVT
         jFnaOToyKIdLh10DsOn6lvwwY9geYgFVTCTniqrP9G/8RMSOMjN1fP3QyqQhSAy4YasU
         ssQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TS5725BMQ0gKTaaRgTF2dpCMOSOYoKyPmGmSv9N+v5s=;
        b=CiFs4LBiCgDtEsbq/WUOaK3qN+l1gnBUl/3vjkYcgkdojLpyuUBKh38TiKT/a8JCqF
         tBS/r7zzsp14Gq2O4ycRVRNhDMff+ZlsUMoEecu973RNROA06Mbup4qrCw56q0w3yBx5
         cIpPrr35oVRsul56k9hnJEoH0oZwq9r/lbUusto60mva7tiCkswQVM/YMapC6y9V50CQ
         CuNJ5FfxjcHH35xTWZFSBesOR5INO08WDvRdsIE4G4hyoeACta6kEUI6T/rWsghsWNL7
         R0uaITRNeHyFrC8iqxebVf+CNCNTPdBlDfuHbeyZwk4kYSUs842OE+SlBRbMF+hOO7NK
         tO4w==
X-Gm-Message-State: AOAM5336z7AK4Zuk6rQDvMlJQdgflYTMoVd1mNT+CzYA2rmhLk90Opnn
        hZy21XH8txtHhKrC8uYVQTU=
X-Google-Smtp-Source: ABdhPJwo4miumHlV9SzFxEreIAG6c8AlmvbD4WrmSza2hsZ++IT8CQauoy2cJDMiVS489a13jj0S2A==
X-Received: by 2002:a17:90a:d598:: with SMTP id v24mr14189644pju.185.1625482697293;
        Mon, 05 Jul 2021 03:58:17 -0700 (PDT)
Received: from ojas ([122.177.226.131])
        by smtp.gmail.com with ESMTPSA id c2sm21335050pjc.40.2021.07.05.03.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 03:58:17 -0700 (PDT)
Date:   Mon, 5 Jul 2021 16:28:04 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, nsaenz@kernel.org, lkp@intel.com,
        kbuild-all@lists.01.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, arnd@arndb.de, phil@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] staging: vchiq: Move vchiq char driver to its own
 file
Message-ID: <20210705105804.GA41070@ojas>
References: <3b7178086322f774772d95141764ed99d0698139.1625401927.git.ojaswin98@gmail.com>
 <202107051622.6i1l1vdL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107051622.6i1l1vdL-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,

On Mon, Jul 05, 2021 at 12:56:09PM +0300, Dan Carpenter wrote:
> Hi Ojaswin,
> 
> url:    https://github.com/0day-ci/linux/commits/Ojaswin-Mujoo/vchiq-Patch-to-separate-platform-and-cdev-code/20210705-000124
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 77ad1f0e99bd00af024e650b862cfda3137af660
> config: i386-randconfig-m021-20210705 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c:1235 vchiq_release() warn: argument 3 to %lx specifier is cast from pointer
> 
> vim +1235 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> 
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1227  static int vchiq_release(struct inode *inode, struct file *file)
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1228  {
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1229  	struct vchiq_instance *instance = file->private_data;
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1230  	struct vchiq_state *state = vchiq_get_state();
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1231  	struct vchiq_service *service;
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1232  	int ret = 0;
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1233  	int i;
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1234  
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04 @1235  	vchiq_log_info(vchiq_arm_log_level, "%s: instance=%lx", __func__,
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1236  		       (unsigned long)instance);
> 
> This should eventually be converted to %p so it doesn't defeat KASLR.
> (Not that we really care on raspberry pi, I think?)
Yes, that does seem right, however, this patchset only moves the code from
vchiq_arm.c to vchiq_dev.c and I've not really touched any of the
existing code itself (Except moving it to a new file which is why it shows up
in the patch). 

Hence, I'm not sure if this fix is in scope of this patchset. (I also
have a similar warning by kernel test robot here [1] which and I'm not
sure if I need to act upon). Maybe we can look at this in a separate
patch?

[1] https://lkml.org/lkml/2021/7/4/138
> 
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1237  
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1238  	if (!state) {
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1239  		ret = -EPERM;
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1240  		goto out;
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1241  	}
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1242  
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1243  	/* Ensure videocore is awake to allow termination. */
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1244  	vchiq_use_internal(instance->state, NULL, USE_TYPE_VCHIQ);
> 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1245  
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

Thank you for looking into this,
Ojaswin
