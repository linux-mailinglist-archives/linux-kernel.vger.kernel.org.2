Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9031E3056AF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbhA0JTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbhA0JQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:16:24 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C3FC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 01:15:44 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id s15so688359plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 01:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rHTuJRyQa6IkZrOcDXTmo6V/IoSpFtVtzeo39+057VI=;
        b=dmnt1BJLmLK2Vo/16KBvlnaM7idcAawcelXBUw5dhxKYqSDfSBrDnn27AZSVB7VDAX
         BHgnauR75tqa3K9s60YI5HYGLOdzB2Eleb/F2jRKrUTwQCUG2KWiya/xnrK7sigchZIG
         GisJli3Bf2a6aKU8NU4B5Jmgl5Ur/kLovqH0RDq6X7wgaLFqH/ulnljDcuKsRV+qCObg
         oReMdsMO3US8RZuOgvNzDWu9FD86j4dODKCWNTwB5ADFm6sWurjavt5ZS8X6mLFN3zAN
         UXRxfa71YeEZhCFdT6MmD2IBl6r6C8OgBL0m9L1kNCLuhtJMuGklH52bYTX5HkZFyUUl
         cUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rHTuJRyQa6IkZrOcDXTmo6V/IoSpFtVtzeo39+057VI=;
        b=fsqXsCueLGUCoFfF6ftCW8pU3br0FfliPdUIyh+1mTKY5QFVszEzmW7cZFBmgN8emj
         PsWWtzyJg3dSCPneKmM/4Q3syFH4WT6wmalE/bRNOa/YwNG9kdvFmvRtxBIP3K7RKBcp
         D/sQbqyiMCtsyIzSFS6PbAGIxW58gqBhqW7xkVXAp/a4FVtFJj8tWlnRMXc/Pyob8uhU
         kYsHV14IfP4k1a/lNxNbn4P3WsaIp/ndhxiEmlyEWAsuFZMKRnKEjAT1urhPu3QPsEyC
         SJN5YM9b7bCyAB3thE4leTP1YjuQXsx1CajI5AqF+MUbn/HXjHAuTzKFuN9xr0EKDdoP
         j6RA==
X-Gm-Message-State: AOAM532XrILMed4U3mmIQB5RGUJJdkSEk1jtUerXg851KO1/nIDqd/7e
        grp7wXlLTEI2jIWBhSG5+CLpfQ==
X-Google-Smtp-Source: ABdhPJxVeb44ivUo66HnFGdBrk/qrgUBS0F2cVMI0Yypoc35AI8bYl8wJKGjX0U4VTNtJgyrRVHY7A==
X-Received: by 2002:a17:903:31ca:b029:e0:ee2:c076 with SMTP id v10-20020a17090331cab02900e00ee2c076mr9189669ple.58.1611738943733;
        Wed, 27 Jan 2021 01:15:43 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id o13sm1619126pfg.124.2021.01.27.01.15.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 01:15:42 -0800 (PST)
Date:   Wed, 27 Jan 2021 14:45:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, amitk@kernel.org, rui.zhang@intel.com,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Subject: Re: [RFC][PATCH 0/3] New thermal interface allowing IPA to get max
 power
Message-ID: <20210127091540.xesvwoeavyaf37jn@vireshk-i7>
References: <20210126104001.20361-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126104001.20361-1-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-01-21, 10:39, Lukasz Luba wrote:
> As it's a RFC, it still misses the cpufreq sysfs implementation, but would
> be addressed if all agree.

Not commenting on the whole stuff but if you ever need something for cpufreq, it
is already there. Look for these.

store_one(scaling_min_freq, min);
store_one(scaling_max_freq, max);

Hopefully they will work just fine.

-- 
viresh
