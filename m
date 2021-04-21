Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973BA366C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242554AbhDUNPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242026AbhDUNJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:44 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7BBC061344
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:09:11 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FQLVC5vg7z9vDw; Wed, 21 Apr 2021 23:09:06 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <69f9968f4b592fefda55227f0f7430ea612cc950.1611299687.git.christophe.leroy@csgroup.eu>
References: <69f9968f4b592fefda55227f0f7430ea612cc950.1611299687.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32: Use r2 in wrtspr() instead of r0
Message-Id: <161901050347.1961279.12121626398624044029.b4-ty@ellerman.id.au>
Date:   Wed, 21 Apr 2021 23:08:23 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 07:15:03 +0000 (UTC), Christophe Leroy wrote:
> wrtspr() is a function to write an arbitrary value in a special
> register. It is used on 8xx to write to SPRN_NRI, SPRN_EID and
> SPRN_EIE. Writing any value to one of those will play with MSR EE
> and MSR RI regardless of that value.
> 
> r0 is used many places in the generated code and using r0 for
> that creates an unnecessary dependency of this instruction with
> preceding ones using r0 in a few places in vmlinux.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32: Use r2 in wrtspr() instead of r0
      https://git.kernel.org/powerpc/c/867e762480f4ad4106b16299a373fa23eccf5b4b

cheers
