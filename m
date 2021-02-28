Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361D1326FE1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 02:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhB1BMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 20:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhB1BMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 20:12:51 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E8DC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 17:12:11 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p5so7399253plo.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 17:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=itLFdH4ncCm/888kATjxIyM0909kWZHGB8jl1hY9Edc=;
        b=iVVYwS4Og5IGaF5hLgMnZmClbdNh3TXWwdTE5pZGSgYrRvHZBpGpHRSVdfTKbLyToG
         Ou24uq7uLQm3eNEPk97vAFqR4WN3XEG++BUbAb78yQhgslcu/Pikcw9TuZSu61K6W6rT
         rD6a/TUJDdCUkQl4/X5p8GEw6RJ8IcxN9aTcpp6LFBOh1/tLWOSiyEhdVdZVU/pYd36Q
         oAWbri7U782DeiwtueCPPb87OuxcKzIeED+22hoWki0vEPQtsiTVzG+8QJCOWLtTIiKX
         x7cvZMruXnTFeTplbwQs46bKVgQTa0k1puJQefEK9t3O6bfH3X7viZEMzCwjTjDWavN9
         +oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=itLFdH4ncCm/888kATjxIyM0909kWZHGB8jl1hY9Edc=;
        b=jQ5J1A8wmsWs/m3dgo1cHSV0YVMDkClSl3ymWuzLad+esJbTcpdqvH/kB9/Ih4YzER
         mSe4pfuruY09DL3U5w1YGEMtxk2HrvbejU6UARPZ5m/8aciackSddqirBzPPnMaz53NY
         h1+lqAdE45sfVop28gPR5tVjXpaTJJijpibVM7AJSmCaJkMp3Eptda+hg6PFtMv1YuuG
         ea5/vxXZ97zYGm5E89q+ArNvVWZ7Nwt/0xsxEJPsAfSHkfCq9pZISravVcYY7SKwGy8W
         KIEpV2+OXWBB/MjDmHHlzgQbtIKkVx5+NgVxThUcPU/Yfqv75djb3B4X09+dUnK8WCXl
         zsGg==
X-Gm-Message-State: AOAM530jMfSm3G3lfigJ6sKAVOXhLbq6Ec2JGEknXHsunxdfFjI32uwz
        BxHXoXZ594z/+oeqg5c/ya9xoQ==
X-Google-Smtp-Source: ABdhPJwTsVKtLqFMkuuWiM0Xzpiyynoh3PaHpm4Ic8Q8YctftCu/ItoYektiOwQHhAjYC1L0TKJ+1A==
X-Received: by 2002:a17:90b:3892:: with SMTP id mu18mr10314134pjb.143.1614474729343;
        Sat, 27 Feb 2021 17:12:09 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id n15sm12187621pgl.31.2021.02.27.17.12.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Feb 2021 17:12:08 -0800 (PST)
Date:   Sun, 28 Feb 2021 09:12:03 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: drivers/cpufreq/qcom-cpufreq-hw.c:377 qcom_cpufreq_hw_cpu_init()
 error: we previously assumed 'data' could be null (see line 327)
Message-ID: <20210228011202.GD24428@dragon>
References: <20210227092620.GD2087@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210227092620.GD2087@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 12:26:20PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8b83369ddcb3fb9cab5c1088987ce477565bb630
> commit: 67fc209b527d023db4d087c68e44e9790aa089ef cpufreq: qcom-hw: drop devm_xxx() calls from init/exit hooks
> config: arm64-randconfig-m031-20210226 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/cpufreq/qcom-cpufreq-hw.c:377 qcom_cpufreq_hw_cpu_init() error: we previously assumed 'data' could be null (see line 327)
> drivers/cpufreq/qcom-cpufreq-hw.c:377 qcom_cpufreq_hw_cpu_init() error: dereferencing freed memory 'data'

Thanks for the report!  I will send a fix for it right away.

Shawn
