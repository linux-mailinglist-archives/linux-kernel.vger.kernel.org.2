Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB50442B91
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 11:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhKBK0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 06:26:18 -0400
Received: from elvis.franken.de ([193.175.24.41]:55788 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhKBK0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 06:26:16 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mhqx9-0003gx-02; Tue, 02 Nov 2021 11:23:39 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id C61D7C291E; Tue,  2 Nov 2021 11:21:37 +0100 (CET)
Date:   Tue, 2 Nov 2021 11:21:37 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: cm: Convert to bitfield API to fix out-of-bounds
 access
Message-ID: <20211102102137.GB7512@alpha.franken.de>
References: <0471c545117c5fa05bd9c73005cda9b74608a61e.1635501373.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0471c545117c5fa05bd9c73005cda9b74608a61e.1635501373.git.geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 11:58:16AM +0200, Geert Uytterhoeven wrote:
> mips_cm_error_report() extracts the cause and other cause from the error
> register using shifts.  This works fine for the former, as it is stored
> in the top bits, and the shift will thus remove all non-related bits.
> However, the latter is stored in the bottom bits, hence thus needs masking
> to get rid of non-related bits.  Without such masking, using it as an
> index into the cm2_causes[] array will lead to an out-of-bounds access,
> probably causing a crash.
> 
> Fix this by using FIELD_GET() instead.  Bite the bullet and convert all
> MIPS CM handling to the bitfield API, to improve readability and safety.
> 
> Fixes: 3885c2b463f6a236 ("MIPS: CM: Add support for reporting CM cache errors")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only, but assembler output before/after compared.
> ---
>  arch/mips/include/asm/mips-cm.h | 12 ++++++------
>  arch/mips/kernel/mips-cm.c      | 21 ++++++++++-----------
>  2 files changed, 16 insertions(+), 17 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
