Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C07C39CEE7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhFFMOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhFFMOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:14:01 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C223EC061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:12:11 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Fyb3F74gCz9sXb; Sun,  6 Jun 2021 22:12:09 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <d536bbc46094f66b24d3017343be25164f232933.1620307840.git.christophe.leroy@csgroup.eu>
References: <d536bbc46094f66b24d3017343be25164f232933.1620307840.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Only pad struct pt_regs when needed
Message-Id: <162298131711.2353459.17978709783123896091.b4-ty@ellerman.id.au>
Date:   Sun, 06 Jun 2021 22:08:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 13:30:51 +0000 (UTC), Christophe Leroy wrote:
> If neither KUAP nor PPC64 is selected, there is nothing in the second
> union of struct pt_regs, so the alignment padding is waste of memory.

Applied to powerpc/next.

[1/1] powerpc: Only pad struct pt_regs when needed
      https://git.kernel.org/powerpc/c/b09049c516af90d4b6643b5d0d2549cd01539086

cheers
