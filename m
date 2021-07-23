Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE8E3D3C69
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 17:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhGWOrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 10:47:08 -0400
Received: from foss.arm.com ([217.140.110.172]:47428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235501AbhGWOqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:46:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2962112FC;
        Fri, 23 Jul 2021 08:27:07 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B5D43F73D;
        Fri, 23 Jul 2021 08:27:06 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smpboot: remove duplicate inline keyword
In-Reply-To: <20210723091618.1750551-1-arnd@kernel.org>
References: <20210723091618.1750551-1-arnd@kernel.org>
Date:   Fri, 23 Jul 2021 16:27:01 +0100
Message-ID: <8735s5m4oq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 23/07/21 11:16, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> 'static inline void __always_inline' is one more 'inline' than needed,
> and it's in the wrong place as gcc points out when extra warnings
> are enabled:
>
> kernel/smpboot.c:50:1: error: 'inline' is not at beginning of declaration [-Werror=old-style-declaration]
>    50 | static inline void __always_inline idle_init(unsigned int cpu)
>
> Move it to the right place instead.
>
> Fixes: e9ba16e68cce ("smpboot: Mark idle_init() as __always_inlined to work around aggressive compiler un-inlining")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Colin sent a similar fix at:

  http://lore.kernel.org/r/20210715164018.62712-1-colin.king@canonical.com

Now AFAICT the incriminated patch is in tip/core/urgent and
linux-next/master, but not in the current mainline. If so, this could be
fixed up before it gets pulled.
