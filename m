Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0623EB4EA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 13:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239927AbhHML73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 07:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239493AbhHML71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 07:59:27 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A12C0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 04:59:00 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GmMXd5VTHz9sX5; Fri, 13 Aug 2021 21:58:57 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Finn Thain <fthain@linux-m68k.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, userm57@yahoo.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <731694e0885271f6ee9ffc179eb4bcee78313682.1628003562.git.christophe.leroy@csgroup.eu>
References: <731694e0885271f6ee9ffc179eb4bcee78313682.1628003562.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Fix napping restore in data storage interrupt (DSI)
Message-Id: <162885586674.2317031.2615926550981438565.b4-ty@ellerman.id.au>
Date:   Fri, 13 Aug 2021 21:57:46 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021 15:14:27 +0000 (UTC), Christophe Leroy wrote:
> When a DSI (Data Storage Interrupt) is taken while in NAP mode,
> r11 doesn't survive the call to power_save_ppc32_restore().
> 
> So use r1 instead of r11 as they both contain the virtual stack
> pointer at that point.

Applied to powerpc/fixes.

[1/1] powerpc/32s: Fix napping restore in data storage interrupt (DSI)
      https://git.kernel.org/powerpc/c/62376365048878f770d8b7d11b89b8b3e18018f1

cheers
