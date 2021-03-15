Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0519333B49B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhCONbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:31:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45989 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231153AbhCONbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:31:17 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Dzckr4XwZz9sWQ; Tue, 16 Mar 2021 00:31:16 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <b231dfa040ce4cc37f702f5c3a595fdeabfe0462.1615378209.git.christophe.leroy@csgroup.eu>
References: <b231dfa040ce4cc37f702f5c3a595fdeabfe0462.1615378209.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Force inlining of cpu_has_feature() to avoid build failure
Message-Id: <161581505531.387233.15261946391055557763.b4-ty@ellerman.id.au>
Date:   Tue, 16 Mar 2021 00:31:16 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 12:10:34 +0000 (UTC), Christophe Leroy wrote:
> The code relies on constant folding of cpu_has_feature() based
> on possible and always true values as defined per
> CPU_FTRS_ALWAYS and CPU_FTRS_POSSIBLE.
> 
> Build failure is encountered with for instance
> book3e_all_defconfig on kisskb in the AMDGPU driver which uses
> cpu_has_feature(CPU_FTR_VSX_COMP) to decide whether calling
> kernel_enable_vsx() or not.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: Force inlining of cpu_has_feature() to avoid build failure
      https://git.kernel.org/powerpc/c/eed5fae00593ab9d261a0c1ffc1bdb786a87a55a

cheers
