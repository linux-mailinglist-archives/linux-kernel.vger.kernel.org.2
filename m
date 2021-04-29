Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F42636EBC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbhD2ODM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:03:12 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58845 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233602AbhD2ODL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:03:11 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FWHHz5CVmz9t1C; Fri, 30 Apr 2021 00:02:23 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <c68163065163f303f5af1e4bbdd9f1ce69f0543e.1619260465.git.christophe.leroy@csgroup.eu>
References: <c68163065163f303f5af1e4bbdd9f1ce69f0543e.1619260465.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/kasan: Fix shadow start address with modules
Message-Id: <161970488639.4033873.400053528462440778.b4-ty@ellerman.id.au>
Date:   Fri, 30 Apr 2021 00:01:26 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Apr 2021 10:34:43 +0000 (UTC), Christophe Leroy wrote:
> Modules are now located before kernel, KASAN area has to
> be extended accordingly.

Applied to powerpc/next.

[1/1] powerpc/kasan: Fix shadow start address with modules
      https://git.kernel.org/powerpc/c/30c400886bad4ac1801516683b71d7714bc2b1b1

cheers
