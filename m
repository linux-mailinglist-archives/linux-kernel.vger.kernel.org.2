Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95583558E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346261AbhDFQKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:10:46 -0400
Received: from foss.arm.com ([217.140.110.172]:45364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233506AbhDFQKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:10:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2FCA1063;
        Tue,  6 Apr 2021 09:10:35 -0700 (PDT)
Received: from e107158-lin (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BCC33F792;
        Tue,  6 Apr 2021 09:10:34 -0700 (PDT)
Date:   Tue, 6 Apr 2021 17:10:32 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mpe@ellerman.id.au,
        aneesh.kumar@linux.ibm.com, ethp@qq.com, npiggin@gmail.com,
        joe.jin@oracle.com
Subject: Re: [PATCH RFC 1/1] kernel/cpu: to track which CPUHP callback is
 failed
Message-ID: <20210406161032.iwmlfszrfcpjss5e@e107158-lin>
References: <20210310070837.17674-1-dongli.zhang@oracle.com>
 <40a7be6b-0603-a2ab-afaa-339e88a03210@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40a7be6b-0603-a2ab-afaa-339e88a03210@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/21 14:22, Dongli Zhang wrote:
> May I have if there is any feedback on this? To pr_err_once() here helps narrow
> down what is the root cause of cpu online failure.
> 
> 
> The issue fixed by d7eb79c6290c ("KVM: kvmclock: Fix vCPUs > 64 can't be
> online/hotpluged") is able to demonstrate how this pr_err_once() helps.
> 
> Due to VM kernel issue, at most 64 VCPUs can online if host clocksource is
> switched to hpet.
> 
> # echo hpet > /sys/devices/system/clocksource/clocksource0/current_clocksource
> 
> 
> By default, we have no idea why only 64 out of 100 VCPUs are online in VM. We
> need to customize kernel to debug why some CPUs are not able to online.
> 
> 
> We will have below and know the root cause is with kvmclock, if we add the
> pr_err_once().

Isn't pr_debug() more appropriate here? Don't you want one on the
cpuhp_down_callbacks() too?

I *think* it's common now to have CONFIG_DYNAMIC_DEBUG enabled so one can
enable that line when they need to

	https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html

I can see the appeal of pr_err_once() but I think this can fail for legitimate
reasons and is not necessarily strictly always an error?

Thanks

--
Qais Yousef
