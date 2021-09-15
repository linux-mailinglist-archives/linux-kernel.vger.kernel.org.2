Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE01540C2E2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhIOJkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbhIOJkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:40:52 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1A4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:39:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id j6so2192027pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=9DwEurpv8pV9WAKblxk8PQ6MlsJLKqkLsk2uIwjdOs8=;
        b=CHYtUWpojKuDZDp8++kUB6sBOmGkVp2FVI419Trr5GXtgFzVzUVDD+wZ339WENrz8n
         LzaoQW5ksPbkLJC57SCoeeombrDIjB05zvwUeYFBhf86tHsq+kpPxZjubz3XaRw++fAl
         OYw/wlU/FwEWtvGkrcHgyFb4U98CqPZNAPRZkbgScMMtXZQlg/cgcXREcnWskkH98n8i
         bdOBFAwLupdlx4R+W5KqPTAH4bOdCKCQoJhvScfHvKs1JkO7sfHpJfdSZii+yLoHz2j9
         ++COGMH++Ee04AmkKCF+dov94QQVsYm4Cw4ofpRlliJ/IKPSeJcj15g680EclieKGCgq
         U8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=9DwEurpv8pV9WAKblxk8PQ6MlsJLKqkLsk2uIwjdOs8=;
        b=4vDooHRQepnRFglR5T9gcfTHdSz5M/df2qfCC2h4zR2wUXaRH9zgjhUaxo9mV2FHE4
         2vE1+szkzJ8Qi2arws4RHwmAV/G832P2WPI/UjqYbOg2gdxjseJyqul/dh5ZYfge6/1N
         DUOHxTUsT759+lI5r2dRLeSLxpLCa1tLguyyOTZgF4YeZNyabfla1gNRhAGap5Rl1a1a
         ULjx4jWWoW41t/CngVg4KWo58DH39uhlGNPIjPG4Sapiwraz2OatUSddUtJrqHEyeBmM
         hBrxS4XGUtroYRqEEgbgw4X78Ytx0YV0Y5pBSJpEu8CL3K7iAPpjp1I8ZeaiZ1RsHGhY
         EKag==
X-Gm-Message-State: AOAM531j4VEosXkuY/9LbRIgObReNI+AK2AlBDkVVyFaLJg5L6rJkgC2
        Edzn7dIbSGTbMKcvwbfP7JrrOA28Sdc=
X-Google-Smtp-Source: ABdhPJz79Ykf/6lng9i3x2nmL9Wuw9ciMpAMALdLeYK2rnjmpUMc21B1gNwkYS30l6z927RkIZSdhw==
X-Received: by 2002:a62:e902:0:b0:414:aaf2:2b4 with SMTP id j2-20020a62e902000000b00414aaf202b4mr9587556pfh.10.1631698771533;
        Wed, 15 Sep 2021 02:39:31 -0700 (PDT)
Received: from [166.111.139.129] ([166.111.139.129])
        by smtp.gmail.com with ESMTPSA id w5sm14342387pgp.79.2021.09.15.02.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 02:39:31 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] gpu: drm: amd: amdgpu: possible ABBA deadlock in
 amdgpu_set_power_dpm_force_performance_level() and
 amdgpu_debugfs_process_reg_op()
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, Felix.Kuehling@amd.com, ray.huang@amd.com,
        lee.jones@linaro.org
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2dc31435-ba62-b6a4-76dc-cfe9747f4cfb@gmail.com>
Date:   Wed, 15 Sep 2021 17:39:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My static analysis tool reports a possible ABBA deadlock in the amdgpu 
driver in Linux 5.10:

amdgpu_debugfs_process_reg_op()
   mutex_lock(&adev->grbm_idx_mutex); --> Line 250 (Lock A)
   mutex_lock(&adev->pm.mutex); --> Line 259 (Lock B)

amdgpu_set_power_dpm_force_performance_level()
   mutex_lock(&adev->pm.mutex); --> Line 381 (Lock B)
     pp_dpm_force_performance_level() --> function pointer via 
"amdgpu_dpm_force_performance_level()"
       pp_dpm_en_umd_pstate()
         amdgpu_device_ip_set_clockgating_state()
           gfx_v7_0_set_clockgating_state() --> function pointer via 
"funcs->set_clockgating_state()"
             gfx_v7_0_enable_mgcg()
               mutex_lock(&adev->grbm_idx_mutex); --> Line 3646 (Lock A)
               mutex_lock(&adev->grbm_idx_mutex); --> Line 3697 (Lock A)

When amdgpu_debugfs_process_reg_op() and 
amdgpu_set_power_dpm_force_performance_level() are concurrently 
executed, the deadlock can occur.

I am not quite sure whether this possible deadlock is real and how to 
fix it if it is real.
Any feedback would be appreciated, thanks :)

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai
