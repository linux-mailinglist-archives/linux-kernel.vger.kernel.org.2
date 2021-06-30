Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3513B82BE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhF3NRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 09:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbhF3NRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:17:51 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1D1C061766
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 06:15:21 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GFMK24Y0Xz9sVp; Wed, 30 Jun 2021 23:15:18 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <8ee05934288994a65743a987acb1558f12c0c8c1.1624969450.git.christophe.leroy@csgroup.eu>
References: <8ee05934288994a65743a987acb1558f12c0c8c1.1624969450.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/4xx: Fix setup_kuep() on SMP
Message-Id: <162505885820.174506.3727018626821602076.b4-ty@ellerman.id.au>
Date:   Wed, 30 Jun 2021 23:14:18 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2021 12:24:21 +0000 (UTC), Christophe Leroy wrote:
> On SMP, setup_kuep() is also called from start_secondary() since
> commit 86f46f343272 ("powerpc/32s: Initialise KUAP and KUEP in C").
> 
> start_secondary() is not an __init function.
> 
> Remove the __init marker from setup_kuep() and bail out when
> not caller on the first CPU as the work is already done.

Applied to powerpc/next.

[1/1] powerpc/4xx: Fix setup_kuep() on SMP
      https://git.kernel.org/powerpc/c/fc4999864bca323f1b844fefe1b402632443c076

cheers
