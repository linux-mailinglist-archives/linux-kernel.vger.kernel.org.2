Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFE330D8F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhBCLlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbhBCLk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:40:57 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9255DC061786
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 03:40:17 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DW09B4Ly9z9vDw; Wed,  3 Feb 2021 22:40:14 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <62df436454ef06e104cc334a0859a2878d7888d5.1608274548.git.christophe.leroy@csgroup.eu>
References: <62df436454ef06e104cc334a0859a2878d7888d5.1608274548.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/32s: Only build hash code when CONFIG_PPC_BOOK3S_604 is selected
Message-Id: <161235201025.1516112.5330581039307523183.b4-ty@ellerman.id.au>
Date:   Wed,  3 Feb 2021 22:40:14 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Dec 2020 06:56:05 +0000 (UTC), Christophe Leroy wrote:
> It is now possible to only build book3s/32 kernel for
> CPUs without hash table.
> 
> Opt out hash related code when CONFIG_PPC_BOOK3S_604 is not selected.

Applied to powerpc/next.

[1/1] powerpc/32s: Only build hash code when CONFIG_PPC_BOOK3S_604 is selected
      https://git.kernel.org/powerpc/c/259149cf7c3c6195e6199e045ca988c31d081cab

cheers
