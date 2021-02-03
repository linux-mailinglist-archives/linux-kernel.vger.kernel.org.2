Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C971F30D8EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhBCLk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:40:59 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:51237 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234298AbhBCLks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:40:48 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DW08y6TrGz9sX5; Wed,  3 Feb 2021 22:40:02 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, Qian Cai <cai@lca.pw>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        paulus@samba.org, aik@ozlabs.ru, paulmck@kernel.org
In-Reply-To: <20200510051559.1959-1-cai@lca.pw>
References: <20200510051559.1959-1-cai@lca.pw>
Subject: Re: [PATCH] powerpc/mm/book3s64/iommu: fix some RCU-list locks
Message-Id: <161235200882.1516112.5579154052220245435.b4-ty@ellerman.id.au>
Date:   Wed,  3 Feb 2021 22:40:02 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 May 2020 01:15:59 -0400, Qian Cai wrote:
> It is safe to traverse mm->context.iommu_group_mem_list with either
> mem_list_mutex or the RCU read lock held. Silence a few RCU-list false
> positive warnings and fix a few missing RCU read locks.
> 
>  arch/powerpc/mm/book3s64/iommu_api.c:330 RCU-list traversed in non-reader section!!
> 
>  other info that might help us debug this:
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/mm/book3s64/iommu: fix some RCU-list locks
      https://git.kernel.org/powerpc/c/b5952f8125ae512420d5fc569adce591bea73bf5

cheers
