Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0883AC1F1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhFREYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhFREYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:24:53 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C90C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:22:45 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m432RXBz9sT6; Fri, 18 Jun 2021 14:22:43 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20210510144925.58195-1-andriy.shevchenko@linux.intel.com>
References: <20210510144925.58195-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] powerpc/prom_init: Move custom isspace() to its own namespace
Message-Id: <162398828919.1363949.14771833320193532617.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:29 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 17:49:25 +0300, Andy Shevchenko wrote:
> If by some reason any of the headers will include ctype.h
> we will have a name collision. Avoid this by moving isspace()
> to the dedicate namespace.
> 
> First appearance of the code is in the commit cf68787b68a2
> ("powerpc/prom_init: Evaluate mem kernel parameter for early allocation").

Applied to powerpc/next.

[1/1] powerpc/prom_init: Move custom isspace() to its own namespace
      https://git.kernel.org/powerpc/c/4cfdd9201cfb85538975f5c8fb83941c3d463ed2

cheers
