Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBAE39FF85
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhFHSdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:33:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:34119 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234235AbhFHScd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:32:33 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 158IP33w028182;
        Tue, 8 Jun 2021 13:25:03 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 158IP2I6028181;
        Tue, 8 Jun 2021 13:25:02 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 8 Jun 2021 13:25:02 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: Remove __main()
Message-ID: <20210608182502.GZ18427@gate.crashing.org>
References: <d01028f8166b98584eec536b52f14c5e3f98ff6b.1623172922.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d01028f8166b98584eec536b52f14c5e3f98ff6b.1623172922.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 05:22:51PM +0000, Christophe Leroy wrote:
> Comment says that __main() is there to make GCC happy.
> 
> It's been there since the implementation of ppc arch in Linux 1.3.45.
> 
> ppc32 is the only architecture having that. Even ppc64 doesn't have it.
> 
> Seems like GCC is still happy without it.
> 
> Drop it for good.

If you used G++ to build the kernel there could be a call to __main
inserted under some circumstances.   It is used in functions called
"main" if there is no other way to do initialisations (this should not
happen if you use -ffreestanding, and there should not be a function
called "main" anyway, but who knows).

Either way, yup, this is ancient history :-)


Segher
