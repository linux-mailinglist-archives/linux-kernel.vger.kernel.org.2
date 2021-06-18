Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1BC3AC1F4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhFREZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:25:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60569 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhFREY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:24:56 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m4658KXz9sf9; Fri, 18 Jun 2021 14:22:46 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <d01028f8166b98584eec536b52f14c5e3f98ff6b.1623172922.git.christophe.leroy@csgroup.eu>
References: <d01028f8166b98584eec536b52f14c5e3f98ff6b.1623172922.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32: Remove __main()
Message-Id: <162398829715.1363949.9107567005809269254.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 17:22:51 +0000 (UTC), Christophe Leroy wrote:
> Comment says that __main() is there to make GCC happy.
> 
> It's been there since the implementation of ppc arch in Linux 1.3.45.
> 
> ppc32 is the only architecture having that. Even ppc64 doesn't have it.
> 
> Seems like GCC is still happy without it.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32: Remove __main()
      https://git.kernel.org/powerpc/c/4696cfdb1380238dca2bda6199428d7e50c4ea38

cheers
