Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA6E34F5ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbhCaBLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:11:04 -0400
Received: from ozlabs.org ([203.11.71.1]:52835 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233184AbhCaBKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:33 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97Xm1ZNmz9sjD; Wed, 31 Mar 2021 12:10:31 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20210302195013.2626335-1-nathan@kernel.org>
References: <20210302195013.2626335-1-nathan@kernel.org>
Subject: Re: [PATCH] powerpc/fadump: Mark fadump_calculate_reserve_size as __init
Message-Id: <161715296549.226945.14575193524004441168.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:25 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021 12:50:14 -0700, Nathan Chancellor wrote:
> If fadump_calculate_reserve_size() is not inlined, there is a modpost
> warning:
> 
> WARNING: modpost: vmlinux.o(.text+0x5196c): Section mismatch in
> reference from the function fadump_calculate_reserve_size() to the
> function .init.text:parse_crashkernel()
> The function fadump_calculate_reserve_size() references
> the function __init parse_crashkernel().
> This is often because fadump_calculate_reserve_size lacks a __init
> annotation or the annotation of parse_crashkernel is wrong.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/fadump: Mark fadump_calculate_reserve_size as __init
      https://git.kernel.org/powerpc/c/fbced1546eaaab57a32e56c974ea8acf10c6abd8

cheers
