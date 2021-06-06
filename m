Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC2339CEE3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFFMOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFFMN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:13:58 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2D6C061767
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:12:08 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Fyb3B0qBZz9sWH; Sun,  6 Jun 2021 22:12:05 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <2541e4e415505b27db8ccbb8977035c20e408ef4.1620405461.git.christophe.leroy@csgroup.eu>
References: <2541e4e415505b27db8ccbb8977035c20e408ef4.1620405461.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/8xx: Update mpc885_ads_defconfig to improve CI
Message-Id: <162298131541.2353459.4370077652152199678.b4-ty@ellerman.id.au>
Date:   Sun, 06 Jun 2021 22:08:35 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2021 16:37:53 +0000 (UTC), Christophe Leroy wrote:
> mpc885_ads_defconfig is used by several CI robots.
> 
> A few functionnalities are specific to 8xx and are not covered
> by other default configuration, so improve build test coverage
> by adding them to mpc885_ads_defconfig.
> 
> 8xx is the only platform supporting 16k page size in addition
> to 4k page size. Considering that 4k page size is widely tested
> by other configurations, lets make 16k pages the selection for
> 8xx, as it has demonstrated in the past to be a weakness.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/8xx: Update mpc885_ads_defconfig to improve CI
      https://git.kernel.org/powerpc/c/9a1762a4a4ff3cc096c605212165f59481e84503

cheers
