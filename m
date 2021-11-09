Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051DB44A433
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 02:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbhKIBve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 20:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhKIBvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 20:51:32 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62122C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 17:48:47 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id n8so17998622plf.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 17:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nmjVrpmF2KKGvFEgq/XE5mXulYLRvLz+Yf/tqScYzE8=;
        b=mMeY/rHFIKR0L+1vwdeY62NRpsgzSEud8m2/8toS4e+MsciWJKJ0zPQynYCetxOn09
         eacjvT+rgE7luYUPqaWrlp0U7xAzoRcsHu0bwK9Qzz6FndsEShsKNwfbmD6OpqvuyudT
         FfNIt366DefmcSzIy4qHe6u4zjIaLoiOMjfkkR/8m3Urtm2zddZsvYmyJX59J8h0LdB0
         iqUmc8Cy85crXDAEIEnW6h5YMviL1kCsWzhxAzszuskq8PvFJJa1AUJiaqPFiBshWJ4n
         GZYaT9jkxpJY+6OTJvICK/v7Af8UW4xguyqNeQPYwWxAfwuD40JLxL3MSiHLIMMS4Rkq
         oVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nmjVrpmF2KKGvFEgq/XE5mXulYLRvLz+Yf/tqScYzE8=;
        b=GXbxr8coStmyRpjBV+l1r6wxMmMfGjeMPHJcL9wPL5ZKNjk632IjozhDo2x3DNN0O1
         TIaWYdZbtklMuqu59Ee8J326Ea4QE/AewTfK1bsaVGMa99aLCStE816PduIrAXDOryR0
         XgRlUhD3Sh/sFHvtLn1Sq0FZbAuawsxbF0DyaxZNXcoh8/pIL7etujr4h9YeYIa6ljI7
         KK4AGyEh+V3xGBAgyUnlzIAnggYoGZETEPclmLibisD39COEyn2g73BmCCBqps5c0jxW
         xgKWayJeQGf+ArYMiIOCJHNxSmd5nLMoe4lP4iKcLireMCOsQYMLBFXQybbcXf0ltACc
         GuNA==
X-Gm-Message-State: AOAM533mdBmwG2mfcqa882eeDFdESbM0JSFiwEBLCHWm5ONXs9viK4ST
        uhwAysz5tgTNuJeK4HW3tpEg8A==
X-Google-Smtp-Source: ABdhPJwFsNS7oDpQpm8FccCWtvXaUWFfGCkAXKxTipaSdTti1p9fA26jFYpEHR9K/caKCjyGT6Towg==
X-Received: by 2002:a17:90a:c58d:: with SMTP id l13mr3024556pjt.189.1636422526914;
        Mon, 08 Nov 2021 17:48:46 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id k1sm9135177pfu.31.2021.11.08.17.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 17:48:46 -0800 (PST)
Date:   Tue, 9 Nov 2021 09:48:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Question: SMMUv3 PMU event aliasing
Message-ID: <20211109014843.GD1388819@leoy-ThinkPad-X240s>
References: <20211108121941.GC1267967@leoy-ThinkPad-X240s>
 <8b24f36b-6459-c13c-bf19-b9f588eb6b8e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b24f36b-6459-c13c-bf19-b9f588eb6b8e@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Mon, Nov 08, 2021 at 12:41:33PM +0000, John Garry wrote:

[...]

> > Could you share current status (or plan) for upstreaming SMMUv3 PMU
> > event alias?  Or if there have any block issue to prevent merging the
> > changes in the mainline kernel?
> 
> This feature should be supported in the SMMUv3 PMU kernel driver and perf
> tool.
> 
> However it relies on the SMMU PMU identifier sysfs file to work. This relies
> on SMMU_PMCG_IIDR being set, which is introduced latest spec, which not much
> HW will support yet - see commit 2c255223362e. In theory we don't need that
> for the fixed, non-IMPDEF events, but I did not complicate perf tool with
> that mixed support.
> 
> That's the reason for which I paused smmuv3-pmcg.json upstream in [3]. I
> will revive that for new gen HW when concrete IMPDEF events known and
> shared.

Thanks for info.  When send out the new patch, you are welcome to Cc
to me, I am glad to give a test on D06 board (its IIDR is zero, so
I need to tweak a bit in driver for IIDR :)).

Thanks,
Leo
