Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA723AC1F2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhFREY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhFREYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:24:55 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B39C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:22:46 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m4502l3z9sXN; Fri, 18 Jun 2021 14:22:44 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1fff2054e5dfc00329804dbd3f2a91667c9a8aff.1623438544.git.christophe.leroy@csgroup.eu>
References: <1fff2054e5dfc00329804dbd3f2a91667c9a8aff.1623438544.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc/64: drop redundant defination of spin_until_cond
Message-Id: <162398829870.1363949.16738170586766727812.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:38 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 19:10:57 +0000 (UTC), Christophe Leroy wrote:
> linux/processor.h has exactly same defination for spin_until_cond.
> Drop the redundant defination in asm/processor.h

Applied to powerpc/next.

[1/2] powerpc/64: drop redundant defination of spin_until_cond
      https://git.kernel.org/powerpc/c/db8f7066dc498acf9074ed3c11a7a24f318d8d4f
[2/2] powerpc/watchdog: include linux/processor.h for spin_until_cond
      https://git.kernel.org/powerpc/c/2400c13c437debc99d3399a7100d4e8c3fe20a08

cheers
