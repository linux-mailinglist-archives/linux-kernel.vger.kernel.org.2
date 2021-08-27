Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4ECD3F99DC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245400AbhH0NX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:23:28 -0400
Received: from ozlabs.org ([203.11.71.1]:52055 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245338AbhH0NXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:23:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0kP4mPBz9t5K;
        Fri, 27 Aug 2021 23:22:21 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <b864a92693ca8413ef0b19f0c12065c212899b6e.1625762905.git.christophe.leroy@csgroup.eu>
References: <b864a92693ca8413ef0b19f0c12065c212899b6e.1625762905.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v4 1/4] powerpc/ptdump: Use DEFINE_SHOW_ATTRIBUTE()
Message-Id: <163007016107.52768.13539127295741805273.b4-ty@ellerman.id.au>
Date:   Fri, 27 Aug 2021 23:16:01 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jul 2021 16:49:40 +0000 (UTC), Christophe Leroy wrote:
> Use DEFINE_SHOW_ATTRIBUTE() instead of open coding
> open() and fops.
> 
> 
> 
> 

Applied to powerpc/next.

[1/4] powerpc/ptdump: Use DEFINE_SHOW_ATTRIBUTE()
      https://git.kernel.org/powerpc/c/11f27a7fa4ca27935de74e3eb052bdc430d5f8d8
[2/4] powerpc/ptdump: Remove unused 'page_size' parameter
      https://git.kernel.org/powerpc/c/64b87b0c70e0fd28352895cba3c0a9631e0072dd
[3/4] powerpc/ptdump: Reduce level numbers by 1 in note_page() and add p4d level
      https://git.kernel.org/powerpc/c/cf98d2b6eea6a1b2c43f85680ad58fcc3ea9496b
[4/4] powerpc/ptdump: Convert powerpc to GENERIC_PTDUMP
      https://git.kernel.org/powerpc/c/e084728393a58e7fdafeee2e6b20e0faff09b557

cheers
