Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC9D35AE4C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbhDJO3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:29:50 -0400
Received: from ozlabs.org ([203.11.71.1]:55747 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234708AbhDJO3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:29:47 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FHcp35tBMz9sWX; Sun, 11 Apr 2021 00:29:31 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <828348da7868eda953ce023994404dfc49603b64.1616514473.git.christophe.leroy@csgroup.eu>
References: <828348da7868eda953ce023994404dfc49603b64.1616514473.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Switch to relative jump labels
Message-Id: <161806493513.1467223.12842890533757437748.b4-ty@ellerman.id.au>
Date:   Sun, 11 Apr 2021 00:28:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 15:47:59 +0000 (UTC), Christophe Leroy wrote:
> Convert powerpc to relative jump labels.
> 
> Before the patch, pseries_defconfig vmlinux.o has:
> 9074 __jump_table  0003f2a0  0000000000000000  0000000000000000  01321fa8  2**0
> 
> With the patch, the same config gets:
> 9074 __jump_table  0002a0e0  0000000000000000  0000000000000000  01321fb4  2**0
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Switch to relative jump labels
      https://git.kernel.org/powerpc/c/b0b3b2c78ec075cec4721986a95abbbac8c3da4f

cheers
