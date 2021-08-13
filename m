Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FE43EB6E5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240582AbhHMOnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:43:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233567AbhHMOni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:43:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA96760C41;
        Fri, 13 Aug 2021 14:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628865791;
        bh=WFhOXngG1jTidCMkgnBGevWfnMbHMBV1tkcVssMelAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JCdQnBlFworm0odw/VFe0rVtElOhEI06BUtG/WnKnXU3EOVhNJjjevavM8+nCWHOB
         eOE9RD2X2G3UjI7X1IHHJHZmSYg0Fiq2eq86MM11joa6tfZFA9t0HeFaaatAhEb/Rq
         O2E93rVwvQ3vK4qnv28fH7aw6dO6Y2ljMo8DTjXPoAtgDVnCs14JGyoBPNOU/cAh3c
         tbC79/21C99tneJ7gq4GnywZieMneNG87+1WjGMu1Qub35U1eDl/ZV2e3p/Cqo5EL3
         jEc/AUvNpMySyQPtdTtXgqh25RzAevHI/my+WDaopun9FptJUG1i26Q0i/LVjP7I/E
         76VSJTBBDEkAg==
Date:   Fri, 13 Aug 2021 15:43:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        wangle6@huawei.com, xiaoqian9@huawei.com, shaolexi@huawei.com
Subject: Re: [PATCH] semaphore: Add might_sleep() to down_*() family
Message-ID: <20210813144305.GB8451@willie-the-truck>
References: <20210809021215.19991-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809021215.19991-1-nixiaoming@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 10:12:15AM +0800, Xiaoming Ni wrote:
> Semaphore is sleeping lock. Add might_sleep() to down*() family
> (with exception of down_trylock()) to detect atomic context sleep.
> 
> Previously discussed with Peter Zijlstra, see link:
>  https://lore.kernel.org/lkml/20210806082320.GD22037@worktop.programming.kicks-ass.net

You can use a Link: tag here.

> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> ---
>  kernel/locking/semaphore.c | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
