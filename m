Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EC439CEE5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhFFMOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:14:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46833 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhFFMN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:13:59 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Fyb3F1W5dz9sXM; Sun,  6 Jun 2021 22:12:09 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <594fa3cc0df11e21644fd6a584851ae4f164b2bf.1620367249.git.christophe.leroy@csgroup.eu>
References: <594fa3cc0df11e21644fd6a584851ae4f164b2bf.1620367249.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/mmu: Remove leftover CONFIG_E200
Message-Id: <162298131664.2353459.10281899511487269108.b4-ty@ellerman.id.au>
Date:   Sun, 06 Jun 2021 22:08:36 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2021 06:00:58 +0000 (UTC), Christophe Leroy wrote:
> Commit 39c8bf2b3cc1 ("powerpc: Retire e200 core (mpc555x processor)")
> removed CONFIG_E200.
> Commit f9158d58a4e1 ("powerpc/mm: Add mask of always present MMU
> features") was merged in the same cycle and added a new use of
> CONFIG_E200.
> 
> Remove that use.

Applied to powerpc/next.

[1/1] powerpc/mmu: Remove leftover CONFIG_E200
      https://git.kernel.org/powerpc/c/0441729e16379649ea0f393a5be68a19ba384d94

cheers
