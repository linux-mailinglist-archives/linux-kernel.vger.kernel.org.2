Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377AE39CEC9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFFMOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhFFMN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:13:58 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4E2C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:12:08 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Fyb386Pz9z9sWF; Sun,  6 Jun 2021 22:12:04 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <603725297466959419628ef7964aaf3417fb647d.1620363691.git.christophe.leroy@csgroup.eu>
References: <603725297466959419628ef7964aaf3417fb647d.1620363691.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/603: Avoid a pile of NOPs when not using SW LRU in TLB exceptions
Message-Id: <162298131614.2353459.7661512092871640787.b4-ty@ellerman.id.au>
Date:   Sun, 06 Jun 2021 22:08:36 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2021 05:02:02 +0000 (UTC), Christophe Leroy wrote:
> The SW LRU is in an MMU feature section. When not used, that's a
> dozen of NOPs to fetch for nothing.
> 
> Define an ALT section that does the few remaining operations.
> 
> That also avoids a double read on SRR1 in the SW LRU case.

Applied to powerpc/next.

[1/1] powerpc/603: Avoid a pile of NOPs when not using SW LRU in TLB exceptions
      https://git.kernel.org/powerpc/c/70d6ebf82bd0cfddaebb54e861fc15e9945a5fc6

cheers
