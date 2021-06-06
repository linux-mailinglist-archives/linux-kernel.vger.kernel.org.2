Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD8639CEEC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhFFMO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:14:57 -0400
Received: from ozlabs.org ([203.11.71.1]:36435 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230287AbhFFMOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:14:08 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Fyb3P2YbVz9t0p; Sun,  6 Jun 2021 22:12:16 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, Oliver O'Halloran <oohall@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Joe Perches <joe@perches.com>,
        Paul Mackerras <paulus@samba.org>
In-Reply-To: <20210518204044.2390064-1-ndesaulniers@google.com>
References: <87cztok1r5.fsf@mpe.ellerman.id.au> <20210518204044.2390064-1-ndesaulniers@google.com>
Subject: Re: [PATCH v2] powerpc/powernv/pci: fix header guard
Message-Id: <162298132083.2353459.1100923917875069463.b4-ty@ellerman.id.au>
Date:   Sun, 06 Jun 2021 22:08:40 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 13:40:41 -0700, Nick Desaulniers wrote:
> While looking at -Wundef warnings, the #if CONFIG_EEH stood out as a
> possible candidate to convert to #ifdef CONFIG_EEH.
> 
> It seems that based on Kconfig dependencies it's not possible to build
> this file without CONFIG_EEH enabled, but based on upstream discussion,
> it's not clear yet that CONFIG_EEH should be enabled by default.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/powernv/pci: fix header guard
      https://git.kernel.org/powerpc/c/73e6e4e01134c9ee97433ad1f470c71b0748b08f

cheers
