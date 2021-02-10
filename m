Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C45531676B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhBJNDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbhBJM6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:58:18 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C29C061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:57:31 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DbKY26GsFz9sW3; Wed, 10 Feb 2021 23:57:26 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     npiggin@gmail.com, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <ad782af87a222efc79cfb06079b0fd23d4224eaf.1612515180.git.christophe.leroy@csgroup.eu>
References: <ad782af87a222efc79cfb06079b0fd23d4224eaf.1612515180.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/8xx: Fix software emulation interrupt
Message-Id: <161296172333.3178259.7272491290910741468.b4-ty@ellerman.id.au>
Date:   Wed, 10 Feb 2021 23:57:26 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021 08:56:13 +0000 (UTC), Christophe Leroy wrote:
> For unimplemented instructions or unimplemented SPRs, the 8xx triggers
> a "Software Emulation Exception" (0x1000). That interrupt doesn't set
> reason bits in SRR1 as the "Program Check Exception" does.
> 
> Go through emulation_assist_interrupt() to set REASON_ILLEGAL.

Applied to powerpc/next.

[1/1] powerpc/8xx: Fix software emulation interrupt
      https://git.kernel.org/powerpc/c/903178d0ce6bb30ef80a3604ab9ee2b57869fbc9

cheers
