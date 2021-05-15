Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B295F381B7E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 00:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhEOWrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 18:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhEOWq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 18:46:59 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97133C061573
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 15:45:45 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FjL8Q2VYGz9sXN; Sun, 16 May 2021 08:45:42 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cadc0a328bc8e6c5bf133193e7547d5c10ae7895.1620465920.git.christophe.leroy@csgroup.eu>
References: <cadc0a328bc8e6c5bf133193e7547d5c10ae7895.1620465920.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/signal: Fix possible build failure with unsafe_copy_fpr_{to/from}_user
Message-Id: <162111863409.1890426.10647570427178264099.b4-ty@ellerman.id.au>
Date:   Sun, 16 May 2021 08:43:54 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2021 09:25:44 +0000 (UTC), Christophe Leroy wrote:
> When neither CONFIG_VSX nor CONFIG_PPC_FPU_REGS are selected,
> unsafe_copy_fpr_to_user() and unsafe_copy_fpr_from_user() are
> doing nothing.
> 
> Then, unless the 'label' operand is used elsewhere, GCC complains
> about it being defined but not used.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/signal: Fix possible build failure with unsafe_copy_fpr_{to/from}_user
      https://git.kernel.org/powerpc/c/bc581dbab26edf0b6acc98c76943b4a0c7d672a2

cheers
