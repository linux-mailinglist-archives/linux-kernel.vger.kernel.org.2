Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B22E363A12
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbhDSEHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:07:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51415 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237460AbhDSEFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:05:24 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVz10WGz9vHf; Mon, 19 Apr 2021 14:04:42 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Yu Kuai <yukuai3@huawei.com>, mpe@ellerman.id.au
Cc:     zhangxiaoxu5@huawei.com, yi.zhang@huawei.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210407125903.4139663-1-yukuai3@huawei.com>
References: <20210407125903.4139663-1-yukuai3@huawei.com>
Subject: Re: [PATCH] powerpc/smp: Make some symbols static
Message-Id: <161880479136.1398509.6657730746176929719.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 13:59:51 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 20:59:03 +0800, Yu Kuai wrote:
> The sparse tool complains as follows:
> 
> arch/powerpc/kernel/smp.c:86:1: warning:
>  symbol '__pcpu_scope_cpu_coregroup_map' was not declared. Should it be static?
> arch/powerpc/kernel/smp.c:125:1: warning:
>  symbol '__pcpu_scope_thread_group_l1_cache_map' was not declared. Should it be static?
> arch/powerpc/kernel/smp.c:132:1: warning:
>  symbol '__pcpu_scope_thread_group_l2_cache_map' was not declared. Should it be static?
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/smp: Make some symbols static
      https://git.kernel.org/powerpc/c/078277acbd7c3fdb25c01a3cd5b4a1a875a1ab2f

cheers
