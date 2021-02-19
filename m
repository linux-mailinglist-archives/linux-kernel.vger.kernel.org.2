Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF5631F456
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 05:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhBSEKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 23:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBSEKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 23:10:19 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9739EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 20:09:39 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a9so2638328plh.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 20:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7j5bErGlNj5pVMV/nhWCKY7Bp8LVCkRskglc+ZUjBPo=;
        b=jtebhbomWJK58ir5dU9SSD2X6DwX3IGlckOY1lDeJytDUI4SnuXDE+jdcNK24OXefN
         41DRTlj8ndHlYVVH25VEpcKmJc21W6Zklu7CGfeLBlrwQbbjIqfhY3lu6fDvdW99ikbE
         R3ql8rY2/zhaoC8pv1uxGKT3+mRXeTL0hMqbdUPYMCknVJVIW40W1fcd9bdBWk6DohpX
         aOKFPgztaUeSawqxPRnSfZ3ZukO72S0+zbx2hT5Ne7SPrFubPRecfyH99KP6ycWuh689
         8GkakE84k7zniMJGEF3j7CyrxMjEhKhMykoWp0CoBZoz/c8FmagpXhDNUQq2/LqwDW9d
         zFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7j5bErGlNj5pVMV/nhWCKY7Bp8LVCkRskglc+ZUjBPo=;
        b=r7T9B5hbyKUNLtW8iOcdqErmg0fF5UfCcjthq7RN2lE5O5nncwdR1VVOqeMKSQAyqQ
         5N26j7cA4vbCw5HUbTg5XDZQh/QMXVO7cGMk8EgC+TAyJ4mFJAB5PMu67sWTR4Omgh4C
         ch826O915R4gZJfTe6QgsJi0uK+Oo07/4TYzPoHHKTqRGqzabknuGb1ktAilAebcMM4X
         g8P4dAKhNP9Fx1ms5iU6R4K5d7/4YV57PVNSwN/8AVDQ6lm1ThuK8KyM1NY3mu0nPjfW
         qQ095wjW8edsQ0HyFz//Vp3uqyt+d6UyCH4UszoGtUp3puYu6ti227dWFDAMBE+Z6ow2
         X3pw==
X-Gm-Message-State: AOAM533RuG9lpL58Z4chq4fgZ1iPTc5lIS+llZrqd/ziauyc52rmUjhg
        cqG2AExXLCPQOeG3YsjWUjQlNA==
X-Google-Smtp-Source: ABdhPJwvCkVj9RBn4Yvn6txt+lInD+Tk7rrioMJDimq64GEw0RKjwx9/h8PWiD8LTjxqv8pFtBhA9w==
X-Received: by 2002:a17:90a:b796:: with SMTP id m22mr5391205pjr.23.1613707779062;
        Thu, 18 Feb 2021 20:09:39 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id i15sm7405415pgh.47.2021.02.18.20.09.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 20:09:38 -0800 (PST)
Date:   Fri, 19 Feb 2021 09:39:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] cpufreq: schedutil: Don't consider freq reduction to
 busy CPU if need_freq_update is set
Message-ID: <20210219040933.2o5hhbjb6emf3xl4@vireshk-i7>
References: <20210218082514.1437-1-zbestahu@gmail.com>
 <20210218102029.syj6vkltlbtoxsig@vireshk-i7>
 <20210219113804.00004a7e.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219113804.00004a7e.zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-21, 11:38, Yue Hu wrote:
> There's a possibility: we will use the previous freq to update if next_f
> is reduced for busy CPU if need_freq_update is set in
> sugov_update_next_freq().

Right.

> This possibility would happen now? And this
> update is what we want if it happens?

This is exactly what we want here, don't reduce speed for busy CPU, but we also
need to make sure we are in the policy's valid range which cpufreq core will
take care of.

> This is related to another possible patch ready to send.

I am not sure what's there to send now.

-- 
viresh
