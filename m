Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BC0364529
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 15:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240354AbhDSNlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 09:41:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:54322 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241926AbhDSNhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:37:06 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13JDWABR028210;
        Mon, 19 Apr 2021 08:32:10 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 13JDW9tI028209;
        Mon, 19 Apr 2021 08:32:09 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 19 Apr 2021 08:32:09 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 2/2] powerpc: add ALTIVEC support to lib/ when PPC_FPU not set
Message-ID: <20210419133209.GR26583@gate.crashing.org>
References: <20210418201726.32130-1-rdunlap@infradead.org> <20210418201726.32130-2-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418201726.32130-2-rdunlap@infradead.org>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sun, Apr 18, 2021 at 01:17:26PM -0700, Randy Dunlap wrote:
> Add ldstfp.o to the Makefile for CONFIG_ALTIVEC and add
> externs for get_vr() and put_vr() in lib/sstep.c to fix the
> build errors.

>  obj-$(CONFIG_PPC_FPU)	+= ldstfp.o
> +obj-$(CONFIG_ALTIVEC)	+= ldstfp.o

It is probably a good idea to split ldstfp.S into two, one for each of
the two configuration options?


Segher
