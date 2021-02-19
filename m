Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CA831F69E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhBSJgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhBSJgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:36:36 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAE5C061756
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 01:35:55 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t11so3541863pgu.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 01:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QRKFIKxvbdbgCQa2DA6d6kpnINF/wfZXSyngxZL2TfY=;
        b=Mgr2pHz/EvZx6HL00ywnP4w6yT0x608sM+pL75U9Jqpocblnh4wtbuukp64ESKMDge
         hFuIrwQmHyNJjHlhghy97vi8XgerxOAIoHZTYuIo6B2gqNPO0sRhPbJdpke5kHVJAZM4
         Mhh+bp3ijePc0Auom0Tbxl/rX5KP0GwrR03L2QstBEmFfzzKDxb/mU+peorLcox3ZZDI
         jFXS6QCapnEtablb7d3qxRdGA1eT5N5hIpi3Pn4Tayv/lbdrxRF+DXiOmkBl2fdMbPmk
         AHjQ/EPL+ac33I3dgRz6i9fhqHLjRnLtmuzCDc5bTC8VKEquCYf0SucO13RkoKZtjK2q
         Pqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QRKFIKxvbdbgCQa2DA6d6kpnINF/wfZXSyngxZL2TfY=;
        b=Y/fHKQrOXfe2+KbcqpupxbO0KXVjfBX4wgbPAGG1rRodv/b7t9VS8jxsRiLZYxDB4Q
         q7lA23mYRWSADQhZusNCLUJ1q4Y8xLy7q/7nYBxTYqEb1xRJXDhWZmLk+ysNIPGqTObv
         TSe87vMQkITyc/xVFH38I94fZTy54KeBwZjaxx/KqfL1bWNj08lMZGqxoHSFjlWNhLAN
         TQxHdoknst8vXzJ5diea7kSJnHG40h8WRI3BeM2aiE/MExNcv2jzwBcVzDuo5j+owkqC
         qys+zKx7ECMugxMJKHshP5elJPb8b2+y6mzoCkDSYXTHYY7XUGamMzy1o59ZBRDjRa/t
         peew==
X-Gm-Message-State: AOAM530M9nLfqpE2SF1knh3PBTmbwbU5XAOBZT1GQFH73TQd5SqQ4uii
        7edxqk48WORqLfldFRd5ewP8oA==
X-Google-Smtp-Source: ABdhPJxH8EDCsT9i3y2shU2v98/N0RwmxdQLsKId0aeiaSaeH0V0EmwRcboLK9RCLiV6Ofpa5fMDEA==
X-Received: by 2002:a63:c44d:: with SMTP id m13mr7839608pgg.64.1613727355194;
        Fri, 19 Feb 2021 01:35:55 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id f2sm10095069pfk.63.2021.02.19.01.35.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2021 01:35:53 -0800 (PST)
Date:   Fri, 19 Feb 2021 15:05:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] cpufreq: schedutil: Don't consider freq reduction to
 busy CPU if need_freq_update is set
Message-ID: <20210219093551.bykqhjk6xvs4kszi@vireshk-i7>
References: <20210218082514.1437-1-zbestahu@gmail.com>
 <20210218102029.syj6vkltlbtoxsig@vireshk-i7>
 <20210219113804.00004a7e.zbestahu@gmail.com>
 <20210219040933.2o5hhbjb6emf3xl4@vireshk-i7>
 <20210219144140.00004de9.zbestahu@gmail.com>
 <20210219074249.2hcwcnakihor343h@vireshk-i7>
 <20210219162026.00002e2b.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219162026.00002e2b.zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-21, 16:20, Yue Hu wrote:
> However, we will skip the update if need_freq_update is not set.

Not really, we will update freq periodically nevertheless, around
every 10ms or something..

> And do the update if need_freq_update is set.

Yeah, that breaks the periodic cycle to attend to some urgent request.

> Note that there are unnecessary fast switch check and spin lock/unlock
> operations in freq skip path.

Maybe, I am not sure. We are all up for optimizations if there are
any.

> If we consider unnecessary behaviors above, then we should return right
> away rather than continue to execute following code.

As I said earlier, we may end up updating the frequency even if
need_freq_update is unset.

-- 
viresh
