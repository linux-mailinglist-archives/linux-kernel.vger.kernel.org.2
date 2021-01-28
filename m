Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010CA30810C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhA1WVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:21:43 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:56795 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhA1WVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:21:42 -0500
Subject: Re: [RFC PATCH v2] sched/topology: fix the issue groups don't span
 domain->span for NUMA diameter > 2
To:     Barry Song <song.bao.hua@hisilicon.com>,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        mgorman@suse.de, mingo@kernel.org, peterz@infradead.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Cc:     linux-kernel@vger.kernel.org, linuxarm@openeuler.org,
        xuwei5@huawei.com, liguozhu@hisilicon.com, tiantao6@hisilicon.com,
        jonathan.cameron@huawei.com, wanghuiqiang@huawei.com
References: <20210127115510.496-1-song.bao.hua@hisilicon.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <02ab09db-19ea-e6c6-ef3e-97120e915249@linux.ee>
Date:   Fri, 29 Jan 2021 00:20:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127115510.496-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Tested by the below topology:
> qemu-system-aarch64  -M virt -nographic \

Also works on the initial 8-node Sun Fire X4600-M2. No strange messages in dmesg and no problems on kernel build with make -j64.

Tested-by: Meelis Roos <mroos@linux.ee>
