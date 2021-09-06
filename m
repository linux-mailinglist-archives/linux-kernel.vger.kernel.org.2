Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16AA4016C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 09:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbhIFHI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 03:08:56 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:33360 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbhIFHIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 03:08:54 -0400
Received: from madeliefje.horms.nl (tulip.horms.nl [83.161.246.101])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 478CF25B849;
        Mon,  6 Sep 2021 17:07:49 +1000 (AEST)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
        id 9832241AB; Mon,  6 Sep 2021 09:07:47 +0200 (CEST)
Date:   Mon, 6 Sep 2021 09:07:47 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>, Jay Lan <jlan@sgi.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] ia64: Make reserve_elfcorehdr() static
Message-ID: <20210906070747.GD19281@vergenet.net>
References: <cover.1629884459.git.geert+renesas@glider.be>
 <fe236cd73b64abc4abd03dd808cb015c907f4c8c.1629884459.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe236cd73b64abc4abd03dd808cb015c907f4c8c.1629884459.git.geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 01:48:28PM +0200, Geert Uytterhoeven wrote:
> There never was a reason for reserve_elfcorehdr() to be global.
> Make the function static, and move it before its sole caller.
> 
> Fixes: cee87af2a5f75713 ("[IA64] kexec: Use EFI_LOADER_DATA for ELF core header")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms@verge.net.au>

> ---
> This fixes a conflict triggered by
> https://lore.kernel.org/r/c7e46e50aaf87ef49bdaa61358d25b122f32b7df.1628670468.git.geert+renesas@glider.be/
> and fixed by
> https://lore.kernel.org/r/f6eabbbce0fba6da3da0264c1e1cf23c01173999.1629884393.git.geert+renesas@glider.be
>  arch/ia64/include/asm/meminit.h |  1 -
>  arch/ia64/kernel/setup.c        | 51 ++++++++++++++++-----------------
>  2 files changed, 25 insertions(+), 27 deletions(-)

...
