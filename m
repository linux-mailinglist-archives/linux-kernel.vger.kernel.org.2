Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D535B34F5CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhCaBK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:29 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55789 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232515AbhCaBKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:10 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97XK1yZ5z9sWk; Wed, 31 Mar 2021 12:10:09 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, rashmicy@gmail.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <9881c68fbca004f9ea18fc9473f630e11ccd6417.1615806071.git.christophe.leroy@csgroup.eu>
References: <9881c68fbca004f9ea18fc9473f630e11ccd6417.1615806071.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/asm-offsets: GPR14 is not needed either
Message-Id: <161715297765.226945.4352182922403291412.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:37 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 11:01:26 +0000 (UTC), Christophe Leroy wrote:
> Commit aac6a91fea93 ("powerpc/asm: Remove unused symbols in
> asm-offsets.c") removed GPR15 to GPR31 but kept GPR14,
> probably because it pops up in a couple of comments when doing
> a grep.
> 
> However, it was never used either, so remove it as well.

Applied to powerpc/next.

[1/1] powerpc/asm-offsets: GPR14 is not needed either
      https://git.kernel.org/powerpc/c/6eeca7a11379e9dd05493bbdba57515b36a2e3cf

cheers
