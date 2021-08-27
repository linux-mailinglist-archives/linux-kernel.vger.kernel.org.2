Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DE83F9A11
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245250AbhH0N1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:27:34 -0400
Received: from ozlabs.org ([203.11.71.1]:49847 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231964AbhH0N1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:27:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0qQ66mqz9s1l;
        Fri, 27 Aug 2021 23:26:42 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nathan Chancellor <nathan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
In-Reply-To: <20210816185711.21563-1-nathan@kernel.org>
References: <20210816185711.21563-1-nathan@kernel.org>
Subject: Re: [PATCH] powerpc/xive: Do not mark xive_request_ipi() as __init
Message-Id: <163007069928.56462.2139354750294195638.b4-ty@ellerman.id.au>
Date:   Fri, 27 Aug 2021 23:24:59 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2021 11:57:11 -0700, Nathan Chancellor wrote:
> Compiling ppc64le_defconfig with clang-14 shows a modpost warning:
> 
> WARNING: modpost: vmlinux.o(.text+0xa74e0): Section mismatch in
> reference from the function xive_setup_cpu_ipi() to the function
> .init.text:xive_request_ipi()
> The function xive_setup_cpu_ipi() references
> the function __init xive_request_ipi().
> This is often because xive_setup_cpu_ipi lacks a __init
> annotation or the annotation of xive_request_ipi is wrong.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/xive: Do not mark xive_request_ipi() as __init
      https://git.kernel.org/powerpc/c/3f78c90f9eb2e228f44ecc8f4377753f0e11dbab

cheers
