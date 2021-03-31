Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF5E34F5DB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhCaBKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:49 -0400
Received: from ozlabs.org ([203.11.71.1]:51867 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233109AbhCaBKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:22 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97XY0c3hz9sf9; Wed, 31 Mar 2021 12:10:20 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     npiggin@gmail.com, He Ying <heying24@huawei.com>, clg@kaod.org,
        dja@axtens.net, rppt@kernel.org, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, benh@kernel.crashing.org,
        aneesh.kumar@linux.ibm.com, paulus@samba.org,
        akpm@linux-foundation.org, ardb@kernel.org
Cc:     johnny.chenyi@huawei.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210316041148.29694-1-heying24@huawei.com>
References: <20210316041148.29694-1-heying24@huawei.com>
Subject: Re: [PATCH] powerpc: arch/powerpc/kernel/setup_64.c - cleanup warnings
Message-Id: <161715298036.226945.370266141807077592.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:40 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 00:11:48 -0400, He Ying wrote:
> warning: symbol 'rfi_flush' was not declared.
> warning: symbol 'entry_flush' was not declared.
> warning: symbol 'uaccess_flush' was not declared.
> We found warnings above in arch/powerpc/kernel/setup_64.c by using
> sparse tool.
> 
> Define 'entry_flush' and 'uaccess_flush' as static because they are not
> referenced outside the file. Include asm/security_features.h in which
> 'rfi_flush' is declared.

Applied to powerpc/next.

[1/1] powerpc: arch/powerpc/kernel/setup_64.c - cleanup warnings
      https://git.kernel.org/powerpc/c/d2313da4ff56bd631a3afe7a17992ed5bd0e04a6

cheers
