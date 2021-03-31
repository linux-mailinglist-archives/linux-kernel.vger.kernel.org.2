Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD20634F5EE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhCaBLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbhCaBKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:38 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D2EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 18:10:38 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97Xr3S33z9t0G; Wed, 31 Mar 2021 12:10:31 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20210302200829.2680663-1-nathan@kernel.org>
References: <20210302200829.2680663-1-nathan@kernel.org>
Subject: Re: [PATCH] powerpc/prom: Mark identical_pvr_fixup as __init
Message-Id: <161715296566.226945.1083928509084280457.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:25 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021 13:08:29 -0700, Nathan Chancellor wrote:
> If identical_pvr_fixup() is not inlined, there are two modpost warnings:
> 
> WARNING: modpost: vmlinux.o(.text+0x54e8): Section mismatch in reference
> from the function identical_pvr_fixup() to the function
> .init.text:of_get_flat_dt_prop()
> The function identical_pvr_fixup() references
> the function __init of_get_flat_dt_prop().
> This is often because identical_pvr_fixup lacks a __init
> annotation or the annotation of of_get_flat_dt_prop is wrong.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/prom: Mark identical_pvr_fixup as __init
      https://git.kernel.org/powerpc/c/1ef1dd9c7ed27b080445e1576e8a05957e0e4dfc

cheers
