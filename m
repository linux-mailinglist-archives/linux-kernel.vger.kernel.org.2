Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBDE34F5D5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhCaBKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbhCaBKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:15 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586ADC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 18:10:15 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97XN0ST7z9sXb; Wed, 31 Mar 2021 12:10:11 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <8038392f38d81f2ad169347efac29146f553b238.1615819955.git.christophe.leroy@csgroup.eu>
References: <8038392f38d81f2ad169347efac29146f553b238.1615819955.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/mm: Remove unneeded #ifdef CONFIG_PPC_MEM_KEYS
Message-Id: <161715297876.226945.6700622335291233560.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:38 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 14:52:51 +0000 (UTC), Christophe Leroy wrote:
> In fault.c, #ifdef CONFIG_PPC_MEM_KEYS is not needed because all
> functions are always defined, and arch_vma_access_permitted()
> always returns true when CONFIG_PPC_MEM_KEYS is not defined so
> access_pkey_error() will return false so bad_access_pkey()
> will never be called.
> 
> Include linux/pkeys.h to get a definition of vma_pkeys() for
> bad_access_pkey().

Applied to powerpc/next.

[1/1] powerpc/mm: Remove unneeded #ifdef CONFIG_PPC_MEM_KEYS
      https://git.kernel.org/powerpc/c/98c26a72751ecb2ed247cdfd6cb2385f37195707

cheers
