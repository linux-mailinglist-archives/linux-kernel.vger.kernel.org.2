Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2E237993A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 23:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhEJVhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 17:37:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:57318 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230165AbhEJVhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 17:37:43 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 14ALElMY017988;
        Mon, 10 May 2021 16:14:47 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 14ALEiiv017985;
        Mon, 10 May 2021 16:14:44 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 10 May 2021 16:14:44 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, pmenzel@molgen.mpg.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/legacy_serial: Fix UBSAN: array-index-out-of-bounds
Message-ID: <20210510211444.GE10366@gate.crashing.org>
References: <d5e3c8e66bad3725d7d48d0e45c4b7eb7c02631d.1620455671.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5e3c8e66bad3725d7d48d0e45c4b7eb7c02631d.1620455671.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 06:36:21AM +0000, Christophe Leroy wrote:
> UBSAN complains when a pointer is calculated with invalid
> 'legacy_serial_console' index, allthough the index is verified
> before dereferencing the pointer.

Addressing like this is UB already.

You could just move this:

> -	if (legacy_serial_console < 0)
> -		return 0;

to before

> -	struct legacy_serial_info *info = &legacy_serial_infos[legacy_serial_console];
> -	struct plat_serial8250_port *port = &legacy_serial_ports[legacy_serial_console];

and no other change is necessary.


Segher
