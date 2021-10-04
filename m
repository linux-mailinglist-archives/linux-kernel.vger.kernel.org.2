Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D8942128D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhJDPWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:22:33 -0400
Received: from foss.arm.com ([217.140.110.172]:50242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234893AbhJDPWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:22:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D22FD6E;
        Mon,  4 Oct 2021 08:20:42 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ACCA3F70D;
        Mon,  4 Oct 2021 08:20:41 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Yicong Yang <yangyicong@hisilicon.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, 21cnbao@gmail.com
Cc:     linux-kernel@vger.kernel.org, song.bao.hua@hisilicon.com,
        prime.zeng@huawei.com, yangyicong@hisilicon.com
Subject: Re: [RESEND PATCH] sched/topology: Remove unused numa_distance in cpu_attach_domain()
In-Reply-To: <20210915063158.80639-1-yangyicong@hisilicon.com>
References: <20210915063158.80639-1-yangyicong@hisilicon.com>
Date:   Mon, 04 Oct 2021 16:20:39 +0100
Message-ID: <87y278lsu0.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/21 14:31, Yicong Yang wrote:
> numa_distance in cpu_attach_domain() is introduced in
> commit b5b217346de8 ("sched/topology: Warn when NUMA diameter > 2")
> to warn user when NUMA diameter > 2 as we'll misrepresent
> the scheduler topology structures at that time. This is
> fixed by Barry in commit 585b6d2723dc ("sched/topology: fix the issue
> groups don't span domain->span for NUMA diameter > 2") and
> numa_distance is unused now. So remove it.
>

Ah, 585b6d2723dc didn't contain a proper revert of b5b217346de8, leaving
those hunks behind.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
