Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2F43383A5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 03:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhCLCfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 21:35:47 -0500
Received: from gate.crashing.org ([63.228.1.57]:41065 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhCLCfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 21:35:21 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 12C2TfrX028000;
        Thu, 11 Mar 2021 20:29:41 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 12C2Te1w027999;
        Thu, 11 Mar 2021 20:29:40 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 11 Mar 2021 20:29:40 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/vdso32: Add missing _restgpr_31_x to fix build failure
Message-ID: <20210312022940.GO29191@gate.crashing.org>
References: <a7aa198a88bcd33c6e35e99f70f86c7b7f2f9440.1615270757.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7aa198a88bcd33c6e35e99f70f86c7b7f2f9440.1615270757.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Mar 09, 2021 at 06:19:30AM +0000, Christophe Leroy wrote:
> With some defconfig including CONFIG_CC_OPTIMIZE_FOR_SIZE,
> (for instance mvme5100_defconfig and ps3_defconfig), gcc 5
> generates a call to _restgpr_31_x.

> I don't know if there is a way to tell GCC not to emit that call, because at the end we get more instructions than needed.

The function is required by the ABI, you need to have it.

You get *fewer* insns statically, and that is what -Os is about: reduce
the size of the binaries.

(The only reason you get such problems is because Linux does not have
all of libgcc.  You can have that *and* have some symbols cause link
errors, it isn't rocket science).


Segher
