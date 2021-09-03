Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194AE40009A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 15:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbhICNhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 09:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbhICNha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 09:37:30 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0491C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 06:36:28 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y18so6789014ioc.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 06:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=cY1Wm8F5T0llp0eIgP6HBdj9OsPKg/JEwgF9TxdPD2E=;
        b=YSkcrdB2J8wcEwS4D/GKijLOIY4v/Y6E876L+ilaDF9jhRk6W3R1n2W3D5EGMgqqHy
         +64y7KcVzw2HYczJc49rZFwg4DeHuJXgoaAP4qQ7HGFEA8+iHfM8YLAtNzNxoIsqB1Kp
         L9/Ilfl1lJ9X2lYzuhD40jdOUqcY332ESbQMn80Xzs2SMRMiqTJCwSi8//JshyfvwiLQ
         ZS+r3p9iGXjsQlwQLjecDWMPvCb1PFbK34wdlh35FQW79u0HyXV0/iAe1+LWAb9lmt8R
         cdglA+NU5eIiOmfddxiF30HC/M/lR4SVYIVpd20QSpXMli657+fO1uSAYcfxFMCFoI91
         4hWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=cY1Wm8F5T0llp0eIgP6HBdj9OsPKg/JEwgF9TxdPD2E=;
        b=WW+KM31DhoiC1hK9c6rqfSFgw24WF2xpGCJwiFvMZ50Ee/SOEX3Kr0ElSTWO1EYeHk
         BIjzha84pp/sZgidK0Gn5eo/ixXah65gWu8pp4WBK7IQbIId7fD29HLLmYVRx9SsfHbt
         13oSyxuz52whH+PkHlkVqx2+u8cu6cTs+dD5ZwGkHtKHoAFFk/4F5CUUuMfAMKfDZUZ1
         mst8RMleAeW4H3NRZ8A1il1/wtCnrvY3l/OOQZc49zWccFIMebJQ7bX5eNwFl2DX19H5
         zv7j421K+RciDdrzT54j8xfCyrywi7lIdkXCOIFCVvVssmljh1zhK+kk+AHijZHCRwMh
         ARiA==
X-Gm-Message-State: AOAM530XGTRIuLFL8lNFjwt2Nvw27zYCiCF3UQo+rK+CFCgnMILec+/T
        V2k0Flc9wCEkoo5pZ4HsX8nGMQ==
X-Google-Smtp-Source: ABdhPJx8KK4etGbv340Im6joRNBXx7V/zunh3pbLqwumjfD8oNuOiopsL9VpcYsE1S9AO5ol0F/VcA==
X-Received: by 2002:a05:6602:2e13:: with SMTP id o19mr3172212iow.9.1630676188168;
        Fri, 03 Sep 2021 06:36:28 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p7sm2591042iln.70.2021.09.03.06.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 06:36:27 -0700 (PDT)
To:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, inux-pm@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: Bug: d0e936adbd22 crashes at boot
Message-ID: <942f4041-e4e7-1b08-3301-008ab37ff5b8@kernel.dk>
Date:   Fri, 3 Sep 2021 07:36:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Booting Linus's tree causes a crash on my laptop, an x1 gen9. This was a bit
difficult to pin down as it crashes before the display is up, but I managed
to narrow it down to:

commit d0e936adbd2250cb03f2e840c6651d18edc22ace
Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date:   Thu Aug 19 19:40:06 2021 -0700

    cpufreq: intel_pstate: Process HWP Guaranteed change notification

which crashes with a NULL pointer deref in notify_hwp_interrupt() ->
queue_delayed_work_on().

Reverting this change makes the laptop boot fine again.

-- 
Jens Axboe

