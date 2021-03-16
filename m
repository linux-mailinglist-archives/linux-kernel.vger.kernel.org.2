Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693E233D0C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhCPJ15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbhCPJ1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:27:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2220C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 02:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EB3tWeNP5/eIP99bI0XboXyQSgMvd48ru6ffd1gUxF4=; b=qS+VjI1PDJx//qRaJypPaHwrbL
        0cxkemuyFwoJMKPg5a+KHuhlPJ80DF42832YkPsjPDV+9Ph6BPTok8/pJPDaq7K/BetszKxvn+qP8
        rHfGnkKlvlwo/YTvaDsOiO+dZzEQwrjRFbDWEfdyvRb2UmPIuuqwL+rK/kS6cw/txMWnK3zU18CFh
        srCYawglXAtea2GMDOAwaGc2TisnmMYlDhVyYwfC7475rdSvbmpd/GoDxEOBIerWW6A6kl2WsSrM3
        aHhkMCrykZIE70qiKP3Dv+ANxehjTYRuMQB2/a1WW6kKNGxpyzbqIYx4Mcu+l89UP9/K1qtK24Oxg
        l4EsIaoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM5ys-000Gvz-UH; Tue, 16 Mar 2021 09:27:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C69E301124;
        Tue, 16 Mar 2021 10:27:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF81620435CFB; Tue, 16 Mar 2021 10:27:03 +0100 (CET)
Date:   Tue, 16 Mar 2021 10:27:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        odin@uged.al, odin@ugedal.com, pauld@redhead.com, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com, tj@kernel.org,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com
Subject: Re: [PATCH v4 1/4] sched/fair: Introduce primitives for CFS
 bandwidth burst
Message-ID: <YFB558607TWGeX63@hirez.programming.kicks-ass.net>
References: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
 <20210316044931.39733-2-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316044931.39733-2-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 12:49:28PM +0800, Huaixin Chang wrote:
> In this patch, we introduce the notion of CFS bandwidth burst. Unused

Documentation/process/submitting-patches.rst:instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
