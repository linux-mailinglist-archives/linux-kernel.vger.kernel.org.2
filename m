Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364413AC1F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhFREY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhFREY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:24:56 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E884AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:22:47 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m4541Wvz9sXb; Fri, 18 Jun 2021 14:22:45 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <5838caffa269e0957c5a50cc85477876220298b0.1623063174.git.christophe.leroy@csgroup.eu>
References: <5838caffa269e0957c5a50cc85477876220298b0.1623063174.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/3] powerpc: Define empty_zero_page[] in C
Message-Id: <162398829697.1363949.8863181598389195121.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:36 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2021 10:56:04 +0000 (UTC), Christophe Leroy wrote:
> At the time being, empty_zero_page[] is defined in each
> platform head.S.
> 
> Define it in mm/mem.c instead, and put it in BSS section instead
> of the DATA section. Commit 5227cfa71f9e ("arm64: mm: place
> empty_zero_page in bss") explains why it is interesting to have
> it in BSS.

Applied to powerpc/next.

[1/3] powerpc: Define empty_zero_page[] in C
      https://git.kernel.org/powerpc/c/45b30fafe528601f1a4449c9d68d8ebe7bbc39ad
[2/3] powerpc: Define swapper_pg_dir[] in C
      https://git.kernel.org/powerpc/c/e72421a085a8dc81c71b0daeb89612279c2c621c
[3/3] powerpc/32s: Rename PTE_SIZE to PTE_T_SIZE
      https://git.kernel.org/powerpc/c/91e9ee7e949bff08cc3845a4811185e826b6e2f1

cheers
