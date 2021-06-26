Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B39A3B4E19
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 12:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhFZKlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 06:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhFZKlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 06:41:13 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56292C061574
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 03:38:51 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GBr2K3Dtbz9sjD; Sat, 26 Jun 2021 20:38:49 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <49f4fb051a3e1cb69f7305d5b6768aec14727c32.1624619582.git.christophe.leroy@csgroup.eu>
References: <49f4fb051a3e1cb69f7305d5b6768aec14727c32.1624619582.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc/ptrace: Move set_return_regs_changed() before regs_set_return_{msr/ip}
Message-Id: <162470384781.3589875.1784352665925391904.b4-ty@ellerman.id.au>
Date:   Sat, 26 Jun 2021 20:37:27 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 11:13:16 +0000 (UTC), Christophe Leroy wrote:
> regs_set_return_msr() and regs_set_return_ip() have a copy
> of the code of set_return_regs_changed().
> 
> Move up set_return_regs_changed() so it can be reused by
> regs_set_return_{msr/ip}

Applied to powerpc/next.

[1/2] powerpc/ptrace: Move set_return_regs_changed() before regs_set_return_{msr/ip}
      https://git.kernel.org/powerpc/c/5f0f95f1e1b64fe55679059837dafb3439b57012
[2/2] powerpc/ptrace: Refactor regs_set_return_{msr/ip}
      https://git.kernel.org/powerpc/c/cae4644673ec5f54c77deab67a57c41395a1539f

cheers
