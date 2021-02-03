Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EBF30D8E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhBCLk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:40:57 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:46515 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234303AbhBCLks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:40:48 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DW0903CHVz9tkZ; Wed,  3 Feb 2021 22:40:03 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, Qian Cai <cai@lca.pw>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        paulus@samba.org, aik@ozlabs.ru, paulmck@kernel.org
In-Reply-To: <20200510051347.1906-1-cai@lca.pw>
References: <20200510051347.1906-1-cai@lca.pw>
Subject: Re: [PATCH] powerpc/powernv/pci: fix a RCU-list lock
Message-Id: <161235200863.1516112.12206707948646314806.b4-ty@ellerman.id.au>
Date:   Wed,  3 Feb 2021 22:40:03 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 May 2020 01:13:47 -0400, Qian Cai wrote:
> It is unsafe to traverse tbl->it_group_list without the RCU read lock.
> 
>  WARNING: suspicious RCU usage
>  5.7.0-rc4-next-20200508 #1 Not tainted
>  -----------------------------
>  arch/powerpc/platforms/powernv/pci-ioda-tce.c:355 RCU-list traversed in non-reader section!!
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/powernv/pci: fix a RCU-list lock
      https://git.kernel.org/powerpc/c/c9790fb5df461c91d3fff1d864c1acb8baf5ad5c

cheers
