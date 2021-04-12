Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE45735D2CE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 00:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbhDLWAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 18:00:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:54271 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238235AbhDLWA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:00:27 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13CLsVAn011590;
        Mon, 12 Apr 2021 16:54:31 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 13CLsTMj011588;
        Mon, 12 Apr 2021 16:54:29 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 12 Apr 2021 16:54:28 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] powerpc/bitops: Use immediate operand when possible
Message-ID: <20210412215428.GM26583@gate.crashing.org>
References: <09da6fec57792d6559d1ea64e00be9870b02dab4.1617896018.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09da6fec57792d6559d1ea64e00be9870b02dab4.1617896018.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Apr 08, 2021 at 03:33:44PM +0000, Christophe Leroy wrote:
> For clear bits, on 32 bits 'rlwinm' can be used instead or 'andc' for
> when all bits to be cleared are consecutive.

Also on 64-bits, as long as both the top and bottom bits are in the low
32-bit half (for 32 bit mode, it can wrap as well).

> For the time being only
> handle the single bit case, which we detect by checking whether the
> mask is a power of two.

You could look at rs6000_is_valid_mask in GCC:
  <https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=gcc/config/rs6000/rs6000.c;h=48b8efd732b251c059628096314848305deb0c0b;hb=HEAD#l11148>
used by rs6000_is_valid_and_mask immediately after it.  You probably
want to allow only rlwinm in your case, and please note this checks if
something is a valid mask, not the inverse of a valid mask (as you
want here).

So yes this is pretty involved :-)

Your patch looks good btw.  But please use "n", not "i", as constraint?


Segher
