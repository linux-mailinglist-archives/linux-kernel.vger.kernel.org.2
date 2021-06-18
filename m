Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C233AC1FC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhFREZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:25:17 -0400
Received: from ozlabs.org ([203.11.71.1]:34195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231345AbhFREY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:24:59 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m4925tZz9sCD; Fri, 18 Jun 2021 14:22:49 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <8479a862e165a57a855292d47e24c259a578f5a0.1622711627.git.christophe.leroy@csgroup.eu>
References: <8479a862e165a57a855292d47e24c259a578f5a0.1622711627.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/kuap: Force inlining of all first level KUAP helpers.
Message-Id: <162398829627.1363949.10534995724959196164.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:36 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 09:13:54 +0000 (UTC), Christophe Leroy wrote:
> All KUAP helpers defined in asm/kup.h are single line functions
> that should be inlined. But on book3s/32 build, we get many
> instances of <prevent_write_to_user.constprop.0>.
> 
> Force inlining of those helpers.

Applied to powerpc/next.

[1/1] powerpc/kuap: Force inlining of all first level KUAP helpers.
      https://git.kernel.org/powerpc/c/240efd717c415e69511780044f44416bdf161523

cheers
