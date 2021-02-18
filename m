Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA25231E970
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 13:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhBRL6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhBRKVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:21:40 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F60BC061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 02:20:32 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o38so857754pgm.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 02:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T9WX6VlwZtLaGwFF0UQOAG35a7SM97lWHqMByPI/JqA=;
        b=HNWEVDsII3pnEkohAwuC3i8K9psDVm9dUK8DdsIZfK7gvJLN0vd4qvPUy5G5mQNfFW
         QKjrxDfn+iUIJ5DCrXuZStdnpe6fnbvyZitI3NcKPO0qKIcemldpw+/Qx/TtJnWx7D82
         7zfm4/pj5dRW91f8ivNua8JG+pqwNfN3xocsC+4aIGT2KE5j64dk77jp/qtDarq6QNwn
         SzdrZTwF94Q3lA94S7Kc5OORpuDnRw+WSyOQ2VPeKnUknV9wj5FIbEAfk397Qu4BS2Nm
         0OvECnvZcOPbzW/JSJq7gHj+CV4IUhYPe6IbitFiYiw4tHlBUKvzcRymi41h28KnQ+zU
         dTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T9WX6VlwZtLaGwFF0UQOAG35a7SM97lWHqMByPI/JqA=;
        b=kTgjNzDbMWbVVWR+c2WoAwJPaN4Kl89Bzqlth63I8Izqz7TdpVFTDICjBdXWgmpAbv
         Fe9P52lQKZx1ooretbDBRw4hYB73OAX/3XE0NZrjfM6Grhbpj7FWfgVIiG32bNyB7PWl
         U3OIGm7IqQ5wK5nVlhjqDv/ztkEKH7gW+7f5bJQffxV+6i215iqqfhl3jVe4tmoRKMw/
         qa3Xgpjpndl5oGEpnBxqtntB6jrZHuihJw6nP4Y+O7YCPvamICGlKQ/yaH1XiYEl4dOZ
         x89mIuXbwVuXvuOcPbiQhz+emuMp6DOKDguyxE0NR7O0IIvdQ1Pop6Pdw63abzQm/VrW
         NpAQ==
X-Gm-Message-State: AOAM533F6xfEffkBdNQHgFdSd2UQoV/7tK2mwXKAIppZIi8dm1yAJfwt
        wQ4eSOvUYpFaBseyudjhikhCEw==
X-Google-Smtp-Source: ABdhPJyzfDcJWntJ6tauL6gmyPB3bbiIWj1LgFFxtCXdJIc7ibDmTCIrFz1xIDw8klf92W+c7F6peA==
X-Received: by 2002:a62:cd48:0:b029:1ec:deac:28cd with SMTP id o69-20020a62cd480000b02901ecdeac28cdmr3741796pfg.75.1613643632108;
        Thu, 18 Feb 2021 02:20:32 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id q25sm5492254pff.112.2021.02.18.02.20.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 02:20:31 -0800 (PST)
Date:   Thu, 18 Feb 2021 15:50:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] cpufreq: schedutil: Don't consider freq reduction to
 busy CPU if need_freq_update is set
Message-ID: <20210218102029.syj6vkltlbtoxsig@vireshk-i7>
References: <20210218082514.1437-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218082514.1437-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-02-21, 16:25, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> For busy CPU case, we do not need to avoid freq reduction if limits
> change since commit 600f5badb78c ("cpufreq: schedutil: Don't skip
> freq update when limits change").
> 
> Later, commit 23a881852f3e ("cpufreq: schedutil: Don't skip freq
> update if need_freq_update is set") discarded the need_freq_update
> check for special case of busy CPU because we won't abort a frequency
> update anymore if need_freq_update is set.
> 
> That is nonlogical since we will not reduce the freq for busy CPU
> if the computed next_f is really reduced when limits change.

Schedutil governor will probably ask for a higher frequency than
allowed, but cpufreq core will clamp the request between policy
min/max before updating the frequency here.

We added the check in 600f5badb78c here earlier as there were chances
that we will abort the operation without reaching to cpufreq core,
which won't happen now.

-- 
viresh
