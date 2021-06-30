Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4AE3B82BD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbhF3NRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 09:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbhF3NRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:17:51 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E73C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 06:15:20 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GFMK10pm6z9sVm; Wed, 30 Jun 2021 23:15:16 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <42f4bd12b476942e4d5dc81c0e839d8871b20b1c.1624863319.git.christophe.leroy@csgroup.eu>
References: <42f4bd12b476942e4d5dc81c0e839d8871b20b1c.1624863319.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Fix setup_{kuap/kuep}() on SMP
Message-Id: <162505885576.174506.2852417119553122234.b4-ty@ellerman.id.au>
Date:   Wed, 30 Jun 2021 23:14:15 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 06:56:11 +0000 (UTC), Christophe Leroy wrote:
> On SMP, setup_kup() is also called from start_secondary().
> 
> start_secondary() is not an __init function.
> 
> Remove the __init marker from setup_kuep() and and setup_kuap().

Applied to powerpc/next.

[1/1] powerpc/32s: Fix setup_{kuap/kuep}() on SMP
      https://git.kernel.org/powerpc/c/c89e632658e793fbbdcbfbe80a6c13bbf7203e9b

cheers
