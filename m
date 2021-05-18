Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA229387655
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348417AbhERKWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241390AbhERKWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:22:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF1CC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:20:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a4so9617233wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=70ytm4W0WP5qG41Y6kcb7UDXaJDfERJqeAyjJPyIpfw=;
        b=Uv+GAHDgcZbUm2zGwTW9XJE77SnSSgIbjr+0yXlS/BSOwyDCahG2BrBG+B9fx6xgUR
         2d251BjxqiRP4QngXmg+RT9+RE4bpEIUWUHajM6o5N++rP60IeKJlN16BAjIbHOKFfqY
         yYZ29frKkzKR/9/FqWAlqWUrvck9BOXa7/H3Myboh3FX01spR2lEAqXTVTGvZPueICFS
         8Y4V6d3EpeYXGaalsYUrZy28VFc3WlTbjvO0BtzGsS52CYmtGulBczIP4qzktdRHssoI
         JLbGdka9F+jonY6DG3pkKZ/V9CGDrECIYPd0xg06JlH+TpoLBTE2oYkuS5rR02qyztEe
         ldzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=70ytm4W0WP5qG41Y6kcb7UDXaJDfERJqeAyjJPyIpfw=;
        b=H6CViPf//tCAtsOVJLQA1eYe6ho0uF6y8/m4u1Y3/2Ix+V6FcZqJo0Gy2bNC8GUz+8
         Tsu64Po0iThswQQxYe1IsKZL/7tQfc4lOKyCrdj+6JPyPVQfRTeHKEmRfQGoHNarIRN7
         OgsbBvCT1JarHJCN6K6HMahcShWau4qlDuHCnkNcv7nBp2AOog3m4oCbTHeZy1xpcuGc
         mXcbHW+Br7Ja1+ey8tRpn0PjtDEJWOpDARextoBb6Hw2pFCGNPN1NHMEnAX2weRMSnP6
         9qQBv9FHsoIBSdNtgm3XmQ6Q+L39adImBDRGoTKmfvaE9OLRjw/Olav9ePAuSnxtO7uJ
         pykQ==
X-Gm-Message-State: AOAM531nLKtAwrGmaeOKyFrb73z3IvdpBodXVCS55jlrNLv1bX8ohkU4
        OZY0i+TXEAtnpNqTNSp6NKZsjJkac8x+PQ==
X-Google-Smtp-Source: ABdhPJwGsDXSNDfperQKGi8GavxUP9aJ6KvyV2Q3pXV8ILLSRN0HEh7dHMbiP7y3oBxMbndkBSYZlQ==
X-Received: by 2002:a5d:47ae:: with SMTP id 14mr5879747wrb.190.1621333245170;
        Tue, 18 May 2021 03:20:45 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id o8sm2569124wrx.4.2021.05.18.03.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 03:20:44 -0700 (PDT)
Date:   Tue, 18 May 2021 10:20:38 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
Message-ID: <YKOU9onXUxVLPGaB@google.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-14-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518094725.7701-14-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 May 2021 at 10:47:17 (+0100), Will Deacon wrote:
> On asymmetric systems where the affinity of a task is restricted to
> contain only the CPUs capable of running it, admission to the deadline
> scheduler is likely to fail because the span of the sched domain
> contains incompatible CPUs. Although this is arguably the right thing to
> do, it is inconsistent with the case where the affinity of a task is
> restricted after already having been admitted to the deadline scheduler.
> 
> For example, on an arm64 system where not all CPUs support 32-bit
> applications, a 64-bit deadline task can exec() a 32-bit image and have
> its affinity forcefully restricted.

So I guess the alternative would be to fail exec-ing into 32bit from a
64bit DL task, and then drop this patch?

The nice thing about your approach is that existing applications won't
really notice a difference (execve would still 'work'), but on the cons
side it breaks admission control, which is sad.

I don't expect this weird execve-to-32bit pattern from DL to be that
common in practice (at the very least not in Android), so maybe we could
start with the stricter version (fail the execve), and wait to see if
folks complain? Making things stricter later will be harder.

Thoughts?

Thanks,
Quentin
