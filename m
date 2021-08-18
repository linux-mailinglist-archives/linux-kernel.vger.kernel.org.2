Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF0F3F0521
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbhHRNqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:46:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47733 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237312AbhHRNqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:46:38 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GqTgt12HPz9t1C; Wed, 18 Aug 2021 23:46:01 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     paulus@samba.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
        Laurent Dufour <ldufour@linux.ibm.com>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Nathan Lynch <nathanl@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210517090606.56930-1-ldufour@linux.ibm.com>
References: <20210517090606.56930-1-ldufour@linux.ibm.com>
Subject: Re: [PATCH v5] pseries/drmem: update LMBs after LPM
Message-Id: <162929391930.3619265.14579706708870831597.b4-ty@ellerman.id.au>
Date:   Wed, 18 Aug 2021 23:38:39 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 11:06:06 +0200, Laurent Dufour wrote:
> After a LPM, the device tree node ibm,dynamic-reconfiguration-memory may be
> updated by the hypervisor in the case the NUMA topology of the LPAR's
> memory is updated.
> 
> This is handled by the kernel, but the memory's node is not updated because
> there is no way to move a memory block between nodes from the Linux kernel
> point of view.
> 
> [...]

Applied to powerpc/next.

[1/1] pseries/drmem: update LMBs after LPM
      https://git.kernel.org/powerpc/c/d144f4d5a8a804133d20ff311d7be70bcdbfaac2

cheers
