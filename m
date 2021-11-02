Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C25F442CD3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhKBLlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:11 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:58447 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhKBLlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:41:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fb1Zn4z4xcJ;
        Tue,  2 Nov 2021 22:38:27 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <971b69739ff4746252e711a9845210465c023a9e.1635425947.git.christophe.leroy@csgroup.eu>
References: <971b69739ff4746252e711a9845210465c023a9e.1635425947.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Don't provide __kernel_map_pages() without ARCH_SUPPORTS_DEBUG_PAGEALLOC
Message-Id: <163584792877.1845480.15860244911222952564.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:12:08 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 14:59:15 +0200, Christophe Leroy wrote:
> When ARCH_SUPPORTS_DEBUG_PAGEALLOC is not selected, the user can
> still select CONFIG_DEBUG_PAGEALLOC in which case __kernel_map_pages()
> is provided by mm/page_poison.c
> 
> So only define __kernel_map_pages() when both
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC and CONFIG_DEBUG_PAGEALLOC
> are defined.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Don't provide __kernel_map_pages() without ARCH_SUPPORTS_DEBUG_PAGEALLOC
      https://git.kernel.org/powerpc/c/f8c0e36b48e32b14bb83332d24e0646acd31d9e9

cheers
