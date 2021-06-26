Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160C73B4E17
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 12:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhFZKlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 06:41:17 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44925 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229929AbhFZKlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 06:41:14 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GBr2M1QRgz9ssD; Sat, 26 Jun 2021 20:38:51 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <52531029563c1fc823b790058e799d0ca71b028c.1624631463.git.christophe.leroy@csgroup.eu>
References: <52531029563c1fc823b790058e799d0ca71b028c.1624631463.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/interrupt: Also use exit_must_hard_disable() on PPC32
Message-Id: <162470384844.3589875.8852110377002600805.b4-ty@ellerman.id.au>
Date:   Sat, 26 Jun 2021 20:37:28 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 14:31:46 +0000 (UTC), Christophe Leroy wrote:
> Reduce #ifdefs a bit by making exit_must_hard_disable() return
> true on PPC32.

Applied to powerpc/next.

[1/1] powerpc/interrupt: Also use exit_must_hard_disable() on PPC32
      https://git.kernel.org/powerpc/c/767e6e7130b288d856e4f2be365554dc6147a80a

cheers
