Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC3039CEC4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhFFMN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:13:56 -0400
Received: from ozlabs.org ([203.11.71.1]:50707 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhFFMNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:13:53 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Fyb366722z9sW8; Sun,  6 Jun 2021 22:12:02 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <13f7532f21df3196e8c78b4f82a9c8d5487aca35.1620292185.git.christophe.leroy@csgroup.eu>
References: <13f7532f21df3196e8c78b4f82a9c8d5487aca35.1620292185.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Remove m8260_gorom()
Message-Id: <162298131443.2353459.17230531273790320173.b4-ty@ellerman.id.au>
Date:   Sun, 06 Jun 2021 22:08:34 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 09:10:01 +0000 (UTC), Christophe Leroy wrote:
> Last user of m8260_gorom() was removed by
> Commit 917f0af9e5a9 ("powerpc: Remove arch/ppc and include/asm-ppc")
> removed last user of m8260_gorom().
> 
> In fact m8260_gorom() was ported to arch/powerpc/ but the
> platform using it died with arch/ppc/
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32s: Remove m8260_gorom()
      https://git.kernel.org/powerpc/c/3a5988b884a33cb3e4ab427b08a020ce32f3b3ba

cheers
