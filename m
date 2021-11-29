Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCDD460DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 04:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbhK2D46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 22:56:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59534 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhK2Dy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 22:54:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8554B80D33
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 03:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AA5C004E1;
        Mon, 29 Nov 2021 03:51:37 +0000 (UTC)
Date:   Sun, 28 Nov 2021 22:51:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     peterz@infradead.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] scripts: ftrace - move the sort-processing in
 ftrace_init to compile time
Message-ID: <20211128225133.65e7c8de@oasis.local.home>
In-Reply-To: <eb65291b-edc3-6968-46a9-fc7e5ac48adb@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
        <20211123105404.22166-1-yinan@linux.alibaba.com>
        <20211123105404.22166-2-yinan@linux.alibaba.com>
        <eb65291b-edc3-6968-46a9-fc7e5ac48adb@linux.alibaba.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 10:13:23 +0800
Yinan Liu <yinan@linux.alibaba.com> wrote:

> Is there anything wrong with this patch? Or are you too busy
> to review? Let me make sure that it has not been forgotten.

FYI, last week had a major US holiday, and things get a bit busy,
before hand.

I haven't had time to look at it, but will try to this week or next.

Cheers,

-- Steve
