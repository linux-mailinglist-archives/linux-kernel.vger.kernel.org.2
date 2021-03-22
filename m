Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7F93446F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhCVOT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCVOT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:19:28 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B0EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:19:26 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id g8so8698931qvx.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QYPaK4eZuqY538ZO9STyQwPazRVmaZseW38pdKvXyOA=;
        b=0KkOSF++n2pYIA/LC3rHcyiX9uFPtTQUgOjlG8xt4w6Wx+UbWIQgbiI7WrISxv2Zm9
         bqABzjEQ6BS8xhIbRLFZLWV8naUFFXeX1IrSq7k6GjSFDoa3t6x9T6Jsw10ijrAys4lH
         0HSz36XyHZ6nRtximp4rhyaYg+ogWFUzVuUgJUu23XStQH0Z1igoGyO8ljg2GdOck82k
         4qSJJpR/8zUb/au34CZZiydjQTIHedeLi7UIdgaOOglsoMG+OqOFCfR9PXn6AMFJCYvv
         YRFXcGhXgvjAnTfM/mGVPy5aJtFk24XsDjKdepztg/xuc5zrFSRKf5zqK/fTTb2+A22/
         hJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QYPaK4eZuqY538ZO9STyQwPazRVmaZseW38pdKvXyOA=;
        b=qhRrwdVhE/x2Lmn6AIIzUXKp5COTa88MB8++2h5Qr1IgHSX8EKrzrcqpfJHLR5UwdP
         in1Vxojl+r+ETMv0NKGeCprsPySainyTH9isAn5u0Jdui47Ie05B6xsSyUw8aoQh816a
         aYel1lV7YgN/BX+tevP9XeFRHDgQdTspZajf+hkN5pxU4Ky8LZPfMCdNwSfSb5PiOwVE
         L7jKuPnL/7kVDcvWjUb4NT/rLPjRgmRV60uW+y8+0zz5/Dc68lw35AXDZ6xVlY8evZ2F
         F0zrGhHqT9+ptIzPY/xXlgBhcD5465YXPQlXQrEoZE3b7qAe75CZmn+ts1g28Ga8TeT7
         AK6Q==
X-Gm-Message-State: AOAM533ejdhdcBF/+kVuQmSeHfmoG+iCs0yM6hY5uIZ3zNfL/wemK4by
        MqX+MtVHqJhyYz3U9Ry8f+rgOw==
X-Google-Smtp-Source: ABdhPJxxPOysLR4/4ZJTggMgfIk1uKorvE+zFQVVOnYjumtWBnXTUgG8WCeHqCPShY0t3uby9DTtPQ==
X-Received: by 2002:ad4:55ef:: with SMTP id bu15mr21373854qvb.46.1616422765771;
        Mon, 22 Mar 2021 07:19:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:b54e])
        by smtp.gmail.com with ESMTPSA id l4sm9070555qte.64.2021.03.22.07.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:19:25 -0700 (PDT)
Date:   Mon, 22 Mar 2021 10:19:22 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: reduce calls to sched_clock() in psi
Message-ID: <YFinajvlw+FSEsYk@cmpxchg.org>
References: <20210321205156.4186483-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210321205156.4186483-1-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 01:51:56PM -0700, Shakeel Butt wrote:
> We noticed that the cost of psi increases with the increase in the
> levels of the cgroups. Particularly the cost of cpu_clock() sticks out
> as the kernel calls it multiple times as it traverses up the cgroup
> tree. This patch reduces the calls to cpu_clock().
> 
> Performed perf bench on Intel Broadwell with 3 levels of cgroup.
> 
> Before the patch:
> 
> $ perf bench sched all
>  # Running sched/messaging benchmark...
>  # 20 sender and receiver processes per group
>  # 10 groups == 400 processes run
> 
>      Total time: 0.747 [sec]
> 
>  # Running sched/pipe benchmark...
>  # Executed 1000000 pipe operations between two processes
> 
>      Total time: 3.516 [sec]
> 
>        3.516689 usecs/op
>          284358 ops/sec
> 
> After the patch:
> 
> $ perf bench sched all
>  # Running sched/messaging benchmark...
>  # 20 sender and receiver processes per group
>  # 10 groups == 400 processes run
> 
>      Total time: 0.640 [sec]
> 
>  # Running sched/pipe benchmark...
>  # Executed 1000000 pipe operations between two processes
> 
>      Total time: 3.329 [sec]
> 
>        3.329820 usecs/op
>          300316 ops/sec
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
