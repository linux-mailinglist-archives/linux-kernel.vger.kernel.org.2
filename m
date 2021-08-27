Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5C23F9A10
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245215AbhH0N1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbhH0N1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:27:31 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF90C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 06:26:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0qM6Gz8z9sRf;
        Fri, 27 Aug 2021 23:26:39 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        fthain@linux-m68k.org, userm57@yahoo.com,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <4856f5574906e2aec0522be17bf3848a22b2cd0b.1629269345.git.christophe.leroy@csgroup.eu>
References: <4856f5574906e2aec0522be17bf3848a22b2cd0b.1629269345.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/32s: Fix random crashes by adding isync() after locking/unlocking KUEP
Message-Id: <163007070021.56462.16976826768640062743.b4-ty@ellerman.id.au>
Date:   Fri, 27 Aug 2021 23:25:00 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021 06:49:29 +0000 (UTC), Christophe Leroy wrote:
> Commit b5efec00b671 ("powerpc/32s: Move KUEP locking/unlocking in C")
> removed the 'isync' instruction after adding/removing NX bit in user
> segments. The reasoning behind this change was that when setting the
> NX bit we don't mind it taking effect with delay as the kernel never
> executes text from userspace, and when clearing the NX bit this is
> to return to userspace and then the 'rfi' should synchronise the
> context.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/32s: Fix random crashes by adding isync() after locking/unlocking KUEP
      https://git.kernel.org/powerpc/c/ef486bf448a057a6e2d50e40ae879f7add6585da

cheers
