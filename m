Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7C23AC1FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhFREZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:25:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60569 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231182AbhFREZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:25:00 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m4C2XgRz9srX; Fri, 18 Jun 2021 14:22:50 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <d37f61afca55b5b33787b643890e061ae1c18f5f.1620396045.git.christophe.leroy@csgroup.eu>
References: <d37f61afca55b5b33787b643890e061ae1c18f5f.1620396045.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/perf: Simplify Makefile
Message-Id: <162398828936.1363949.1084024487791778042.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:29 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2021 14:01:09 +0000 (UTC), Christophe Leroy wrote:
> arch/powerpc/Kbuild decend into arch/powerpc/perf/ only when
> CONFIG_PERF_EVENTS is selected, so there is not need to take
> CONFIG_PERF_EVENTS into account in arch/powerpc/perf/Makefile.

Applied to powerpc/next.

[1/1] powerpc/perf: Simplify Makefile
      https://git.kernel.org/powerpc/c/87f19ea10100892637d4eee9069fad4ed61cb6a5

cheers
