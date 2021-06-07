Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A48539E6DF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhFGSwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230316AbhFGSwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:52:44 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9987A61078;
        Mon,  7 Jun 2021 18:50:51 +0000 (UTC)
Date:   Mon, 7 Jun 2021 14:50:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     <catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mingo@redhat.com>, <will@kernel.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] arm64: ftrace: don't dereference a probably invalid
 address
Message-ID: <20210607145049.645b235f@oasis.local.home>
In-Reply-To: <20210607181403.4017-1-mark-pk.tsai@mediatek.com>
References: <20210607105217.772214e5@oasis.local.home>
        <20210607181403.4017-1-mark-pk.tsai@mediatek.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 02:14:03 +0800
Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:

> Should I resend this patch as v2?
> Or you will upstream this fix?

I'll push it. I have some other fixes to add as well.

Thanks!

-- Steve
