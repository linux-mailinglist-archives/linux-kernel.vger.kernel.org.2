Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA6C32A026
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575397AbhCBD4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:56:01 -0500
Received: from gate.crashing.org ([63.228.1.57]:59311 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343967AbhCAWih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:38:37 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 121MVAHn003883;
        Mon, 1 Mar 2021 16:31:10 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 121MV9DG003882;
        Mon, 1 Mar 2021 16:31:09 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 1 Mar 2021 16:31:09 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Daniel Axtens <dja@axtens.net>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/15] powerpc/uaccess: Remove __get_user_allowed() and unsafe_op_wrap()
Message-ID: <20210301223108.GE29191@gate.crashing.org>
References: <cover.1614275314.git.christophe.leroy@csgroup.eu> <e0538c71167bd90224a8727fea9ed5b75612e2d7.1614275314.git.christophe.leroy@csgroup.eu> <87im6ao7ld.fsf@dja-thinkpad.axtens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im6ao7ld.fsf@dja-thinkpad.axtens.net>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 09:02:54AM +1100, Daniel Axtens wrote:
> Checkpatch does have one check that is relevant:
> 
> CHECK: Macro argument reuse 'p' - possible side-effects?
> #36: FILE: arch/powerpc/include/asm/uaccess.h:482:
> +#define unsafe_get_user(x, p, e) do {					\
> +	if (unlikely(__get_user_nocheck((x), (p), sizeof(*(p)), false)))\
> +		goto e;							\
> +} while (0)

sizeof (of something other than a VLA) does not evaluate its operand.
The checkpatch warning is incorrect (well, it does say "possible" --
it just didn't find a possible problem here).

You can write
  bla = sizeof *p++;
and p is *not* incremented.


Segher
