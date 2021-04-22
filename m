Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27936368427
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbhDVPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:47:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237928AbhDVPrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:47:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5ADE61208;
        Thu, 22 Apr 2021 15:46:30 +0000 (UTC)
Date:   Thu, 22 Apr 2021 11:46:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ed Tsai <ed.tsai@mediatek.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] sched: remove the redundant 'success' in the sched
 tracepoint
Message-ID: <20210422114629.2b1ea3ad@gandalf.local.home>
In-Reply-To: <20210422122226.9415-1-ed.tsai@mediatek.com>
References: <20210422122226.9415-1-ed.tsai@mediatek.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2021 20:22:26 +0800
Ed Tsai <ed.tsai@mediatek.com> wrote:

> 'success' is left here for a long time and also it is meaningless
> for the upper user. Just remove it.

Have you tested all userspace code that might use this?

This is the "poster boy" example of why Peter Zijlstra hates trace events ;-)

I know I've updated trace-cmd to check to see if this field exits before
depending on it, but there may be some other tools that may not. Perhaps
nothing will break.

I'm all for this change, but be ware, it might be reverted if there's some
tool out that that expects it to exist. This is why it hasn't been removed.

-- Steve
