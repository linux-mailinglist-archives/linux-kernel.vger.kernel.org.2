Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1613AA0B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhFPQEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232231AbhFPQEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:04:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17CC561159;
        Wed, 16 Jun 2021 16:02:29 +0000 (UTC)
Date:   Wed, 16 Jun 2021 12:02:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     <peterz@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mhelsley@vmware.com>, <samitolvanen@google.com>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH v4] recordmcount: Correct st_shndx handling
Message-ID: <20210616120227.6fc005c3@gandalf.local.home>
In-Reply-To: <20210616154126.2794-1-mark-pk.tsai@mediatek.com>
References: <20210616154126.2794-1-mark-pk.tsai@mediatek.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 23:41:26 +0800
Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> One should only use st_shndx when >SHN_UNDEF and <SHN_LORESERVE. When
> SHN_XINDEX, then use .symtab_shndx. Otherwise use 0.
> 
> This handles the case: st_shndx >= SHN_LORESERVE && st_shndx != SHN_XINDEX.
> 
> Reported-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> [handle endianness of sym->st_shndx]
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---

Thanks, I pulled this in and started the testing.

-- Steve
