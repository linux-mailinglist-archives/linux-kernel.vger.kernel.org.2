Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B8836EBC8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbhD2ODR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbhD2ODP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:03:15 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E60FC06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:02:28 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FWHJ22hV8z9sXM; Fri, 30 Apr 2021 00:02:26 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        chris.packham@alliedtelesis.co.nz,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <0d51620eacf036d683d1a3c41328f69adb601dc0.1618925560.git.christophe.leroy@csgroup.eu>
References: <0d51620eacf036d683d1a3c41328f69adb601dc0.1618925560.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/2] powerpc/64: Fix the definition of the fixmap area
Message-Id: <161970488259.4033873.1485850306530211519.b4-ty@ellerman.id.au>
Date:   Fri, 30 Apr 2021 00:01:22 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 13:32:48 +0000 (UTC), Christophe Leroy wrote:
> At the time being, the fixmap area is defined at the top of
> the address space or just below KASAN.
> 
> This definition is not valid for PPC64.
> 
> For PPC64, use the top of the I/O space.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/64: Fix the definition of the fixmap area
      https://git.kernel.org/powerpc/c/9ccba66d4d2aff9a3909aa77d57ea8b7cc166f3c
[2/2] powerpc/legacy_serial: Use early_ioremap()
      https://git.kernel.org/powerpc/c/0bd3f9e953bd3636e73d296e9bed11a25c09c118

cheers
