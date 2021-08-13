Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68873EB4EC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 13:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbhHML7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 07:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239480AbhHML71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 07:59:27 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448BEC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 04:59:00 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GmMXd0tWSz9sWq; Fri, 13 Aug 2021 21:58:57 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, radu.rendec@gmail.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <028d5483b4851b01ea4334d0751e7f260419092b.1625637264.git.christophe.leroy@csgroup.eu>
References: <028d5483b4851b01ea4334d0751e7f260419092b.1625637264.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32: Fix critical and debug interrupts on BOOKE
Message-Id: <162885586697.2317031.18158265809824368370.b4-ty@ellerman.id.au>
Date:   Fri, 13 Aug 2021 21:57:46 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2021 05:55:07 +0000 (UTC), Christophe Leroy wrote:
> 32 bits BOOKE have special interrupts for debug and other
> critical events.
> 
> When handling those interrupts, dedicated registers are saved
> in the stack frame in addition to the standard registers, leading
> to a shift of the pt_regs struct.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/32: Fix critical and debug interrupts on BOOKE
      https://git.kernel.org/powerpc/c/b5cfc9cd7b0426e94ffd9e9ed79d1b00ace7780a

cheers
