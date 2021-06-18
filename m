Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE453AC20A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhFRE0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:26:00 -0400
Received: from ozlabs.org ([203.11.71.1]:57285 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231735AbhFREZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:25:08 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m4L6vvhz9t0G; Fri, 18 Jun 2021 14:22:58 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <3dca510ce555335261a47c4799167da698f569c0.1622782111.git.christophe.leroy@csgroup.eu>
References: <3dca510ce555335261a47c4799167da698f569c0.1622782111.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/8xx: Allow disabling KUAP at boot time
Message-Id: <162398828661.1363949.12162317705793450374.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:26 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 04:49:25 +0000 (UTC), Christophe Leroy wrote:
> PPC64 uses MMU features to enable/disable KUAP at boot time.
> But feature fixups are applied way too early on PPC32.
> 
> But since commit c16728835eec ("powerpc/32: Manage KUAP in C"),
> all KUAP is in C so it is now possible to use static branches.

Applied to powerpc/next.

[1/1] powerpc/8xx: Allow disabling KUAP at boot time
      https://git.kernel.org/powerpc/c/f6025a140ba8dcabdfb8a1e27ddaf44821700dce

cheers
