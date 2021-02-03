Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D28130D8F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhBCLlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbhBCLk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:40:57 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925F3C061788
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 03:40:17 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DW0992mCjz9t56; Wed,  3 Feb 2021 22:40:11 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <b0607f1113d1558e73476bb06db0ee16d31a6e5b.1608716197.git.christophe.leroy@csgroup.eu>
References: <e4471bf81089252470efb3eed735d71a5b32adbd.1608716197.git.christophe.leroy@csgroup.eu> <b0607f1113d1558e73476bb06db0ee16d31a6e5b.1608716197.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/xmon: Enable breakpoints on 8xx
Message-Id: <161235201042.1516112.18227660998011390380.b4-ty@ellerman.id.au>
Date:   Wed,  3 Feb 2021 22:40:09 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Dec 2020 09:38:48 +0000 (UTC), Christophe Leroy wrote:
> Since commit 4ad8622dc548 ("powerpc/8xx: Implement hw_breakpoint"),
> 8xx has breakpoints so there is no reason to opt breakpoint logic
> out of xmon for the 8xx.

Applied to powerpc/next.

[1/1] powerpc/xmon: Enable breakpoints on 8xx
      https://git.kernel.org/powerpc/c/30662217885d7341161924acf1665924d7d37d64

cheers
