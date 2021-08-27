Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F4C3F99D8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245354AbhH0NXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:23:22 -0400
Received: from ozlabs.org ([203.11.71.1]:46927 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245403AbhH0NWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:22:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0k33Dwyz9sWq;
        Fri, 27 Aug 2021 23:22:03 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <c04cce578b97a76a9e69a096698b1d89f721768a.1629276437.git.christophe.leroy@csgroup.eu>
References: <c04cce578b97a76a9e69a096698b1d89f721768a.1629276437.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32: Remove unneccessary calculations in load_up_{fpu/altivec}
Message-Id: <163007013987.52768.9451271906730834709.b4-ty@ellerman.id.au>
Date:   Fri, 27 Aug 2021 23:15:39 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021 08:47:28 +0000 (UTC), Christophe Leroy wrote:
> No need to re-read SPRN_THREAD, we can calculate thread address
> from current (r2).
> 
> And remove a reload of value 1 into r4 as r4 is already 1.
> 
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32: Remove unneccessary calculations in load_up_{fpu/altivec}
      https://git.kernel.org/powerpc/c/51ed00e71f0130e0f3534b8e7d78facd16829426

cheers
