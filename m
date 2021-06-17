Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667B43AAF33
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 10:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhFQJAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:00:48 -0400
Received: from foss.arm.com ([217.140.110.172]:50444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhFQJAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:00:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 304F91042;
        Thu, 17 Jun 2021 01:58:40 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B86EF3F694;
        Thu, 17 Jun 2021 01:58:38 -0700 (PDT)
Date:   Thu, 17 Jun 2021 09:58:36 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Tejun Heo <tj@kernel.org>, Quentin Perret <qperret@google.com>,
        Wei Wang <wvw@google.com>, Yun Hsiang <hsiang023167@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/uclamp: Fix uclamp_tg_restrict()
Message-ID: <20210617085836.lpfeuvzcbsqkgtmi@e107158-lin.cambridge.arm.com>
References: <20210611122246.3475897-1-qais.yousef@arm.com>
 <CAB8ipk8bCYdb5d28sVrFfJSKpGB4EW+Fv0sekj7PGamKM_pngw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk8bCYdb5d28sVrFfJSKpGB4EW+Fv0sekj7PGamKM_pngw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xuewen

On 06/16/21 11:06, Xuewen Yan wrote:
> Hi Qais
> 
> Sorry for the late reply.
> 
> I tested the patch on the "UNISOC T610" platform, and it looks fine.
> 
> According to the two cases:
> case1:
> without patch:
> set task's clamp_min=614(60%), clamp_max=819(80%), the result as:
> [  215.780435]c6  uclamp_test :
> pid=138,req_min=614,req_max=819,eff_min=614,eff_max=819
> 
> after set tg's cpu.uclamp.max = 50%，the result:
> [  420.580443]c6  uclamp_test :
> pid=138,req_min=614,req_max=819,eff_min=614,eff_max=512
> 
> with patch:
> set task's clamp_min=614(60%), clamp_max=819(80%), the result as:
> [  333.533878]c7  uclamp_test :
> pid=138,req_min=614,req_max=819,eff_min=614,eff_max=819
> 
> after set tg's cpu.uclamp.max = 50%，the result:
> [  430.813789]c6  uclamp_test :
> pid=138,req_min=614,req_max=819,eff_min=512,eff_max=512
> 
> case2:
> without patch:
> set task's clamp_min=614(60%), clamp_max=819(80%), the result as:
> [  169.700544]c0  uclamp_test :
> pid=137,req_min=0,req_max=209,eff_min=0,eff_max=209
> 
> after set tg's cpu.uclamp.min = 30%, tg's cpu.uclamp.max = 50%，the result:
> [  246.500634]c7  uclamp_test :
> pid=137,req_min=0,req_max=209,eff_min=307,eff_max=209
> 
> with patch:
> set task's clamp_min=0(0%), clamp_max=209(20%), the result as:
> [  169.700544]c0  uclamp_test :
> pid=137,req_min=0,req_max=209,eff_min=0,eff_max=209
> 
> after set tg's cpu.uclamp.min = 30%, tg's cpu.uclamp.max = 50%，the result:
> [  179.933868]c6  uclamp_test :
> pid=137,req_min=0,req_max=209,eff_min=307,eff_max=307

Thanks a lot for trying it out.

Cheers

--
Qais Yousef
