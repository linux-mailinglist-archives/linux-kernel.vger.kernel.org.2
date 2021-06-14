Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF5B3A6B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbhFNQXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233044AbhFNQXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:23:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CA64613D0;
        Mon, 14 Jun 2021 16:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623687673;
        bh=cRIYdUmqM08o9AcSwmE0jOf990hB3Rb6ZtDqmtlY5AA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IfFII17KCvYNObVx26XraIumREsHtBht3mBm7UQyrYauo70CNGnMkpqjOGfCd61Dd
         ybpuYNE5P5nMMtIS4srXcSM/g/nC09ycnX0L+v7077sx+iVvlAQcQPbsVCaEJIbZKE
         n5kbAhaANneAEtAJsZ1PfyUoA3MuvbttT8fBntjIp1bXy/m26ayUXML7e2Hz6R93iz
         LdkbqQ49scutBqkfKPeG+hpfbE11LJaJ/jnfo3wPBUyFmyK2gj/gnJDRZgRrhgS7Sl
         9kP+sNvifMlaKUykezjg78kJFiEorizfWq98ug1oFvkrIASfVuW+f2msNHDmz72zRa
         fRV038j4wyjOQ==
Subject: Re: [PATCH] x86: fix get_wchan() not support the ORC unwinder
To:     Qi Zheng <zhengqi.arch@bytedance.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        peterz@infradead.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20210611124642.72910-1-zhengqi.arch@bytedance.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <06292162-5a44-6f91-140d-e1211c006ad0@kernel.org>
Date:   Mon, 14 Jun 2021 09:21:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210611124642.72910-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/21 5:46 AM, Qi Zheng wrote:
> Currently, the kernel CONFIG_UNWINDER_ORC option is enabled by
> default on x86, but the implementation of get_wchan() is still
> based on the frame pointer unwinder, so the /proc/<pid>/wchan
> always return 0 regardless of whether the task <pid> is running.
> 
> We reimplement the get_wchan() by calling stack_trace_save_tsk(),
> which is adapted to the ORC and frame pointer unwinders.

How much slower does this make ps?

--Andy
