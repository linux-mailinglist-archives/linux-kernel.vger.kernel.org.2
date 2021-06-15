Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3172F3A843F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhFOPog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231274AbhFOPog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:44:36 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1D766145C;
        Tue, 15 Jun 2021 15:42:30 +0000 (UTC)
Date:   Tue, 15 Jun 2021 11:42:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Matt Helsley <mhelsley@vmware.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2] recordmcount: Correct st_shndx handling
Message-ID: <20210615114229.3b1f2c5f@oasis.local.home>
In-Reply-To: <20210615064720.21950-1-mark-pk.tsai@mediatek.com>
References: <20210615064720.21950-1-mark-pk.tsai@mediatek.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 14:47:20 +0800
Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:

> One should only use st_shndx when >SHN_UNDEF and <SHN_LORESERVE. When
> SHN_XINDEX, then use .symtab_shndx. Otherwise use 0.
> 
> This handles the case: st_shndx >= SHN_LORESERVE && st_shndx != SHN_XINDEX.
> 
> Reported-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>

Please explain the two signed-off-by's above. If you are just tweaking
Peter's original patch, please add at the start:

From: Peter Zijlstra (Intel) <peterz@infradead.org>

And then just above your signed off by, add what you changed:

Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
[ Changed something ]
Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>

But state what you changed.

Thanks!

-- Steve
