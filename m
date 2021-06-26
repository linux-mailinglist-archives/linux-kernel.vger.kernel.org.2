Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCD33B4E1C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 12:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhFZKlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 06:41:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54041 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229938AbhFZKlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 06:41:15 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GBr2N4R2rz9svs; Sat, 26 Jun 2021 20:38:52 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        wangkefeng.wang@huawei.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <9fa9ba6807c17f93f35a582c199c646c4a8bfd9c.1622800638.git.christophe.leroy@csgroup.eu>
References: <9fa9ba6807c17f93f35a582c199c646c4a8bfd9c.1622800638.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Remove klimit
Message-Id: <162470384534.3589875.7856522821307710306.b4-ty@ellerman.id.au>
Date:   Sat, 26 Jun 2021 20:37:25 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 09:57:36 +0000 (UTC), Christophe Leroy wrote:
> klimit is a global variable initialised at build time with the
> value of _end.
> 
> This variable is never modified, so _end symbol can be used directly.
> 
> Remove klimit.

Applied to powerpc/next.

[1/1] powerpc: Remove klimit
      https://git.kernel.org/powerpc/c/56afad885228902d090558a0b1cf75e9809e831d

cheers
