Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715A73639E0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbhDSEEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:04:45 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60489 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhDSEEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:04:39 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVJ3l0Wz9vDw; Mon, 19 Apr 2021 14:04:08 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        jniethe5@gmail.com, Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <0c3d5cb8a4dfdf6ca1b8aeb385c01470d6628d55.1617283827.git.christophe.leroy@csgroup.eu>
References: <0c3d5cb8a4dfdf6ca1b8aeb385c01470d6628d55.1617283827.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/3] powerpc/modules: Load modules closer to kernel text
Message-Id: <161880478975.1398509.1364784415611338894.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 13:59:49 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2021 13:30:41 +0000 (UTC), Christophe Leroy wrote:
> On book3s/32, when STRICT_KERNEL_RWX is selected, modules are
> allocated on the segment just before kernel text, ie on the
> 0xb0000000-0xbfffffff when PAGE_OFFSET is 0xc0000000.
> 
> On the 8xx, TASK_SIZE is 0x80000000. The space between TASK_SIZE and
> PAGE_OFFSET is not used and could be used for modules.
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/modules: Load modules closer to kernel text
      https://git.kernel.org/powerpc/c/2ec13df167040cd153c25c4d96d0ffc573ac4c40
[2/3] powerpc/8xx: Define a MODULE area below kernel text
      https://git.kernel.org/powerpc/c/9132a2e82adc6e5a1c7c7385df3bfb25576bdd80
[3/3] powerpc/32s: Define a MODULE area below kernel text all the time
      https://git.kernel.org/powerpc/c/80edc68e0479bafdc4869ec3351e42316b824596

cheers
