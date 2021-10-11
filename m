Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E4942855F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 05:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhJKDBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 23:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230273AbhJKDBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 23:01:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93D666054F;
        Mon, 11 Oct 2021 02:59:38 +0000 (UTC)
Date:   Sun, 10 Oct 2021 22:59:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     mingo@redhat.com, akpm@linux-foundation.org, vbabka@suse.cz,
        axelrasmussen@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: mmap_lock: remove "\n" in TP_printk and use
 DECLARE_EVENT_CLASS
Message-ID: <20211010225936.2f97d165@oasis.local.home>
In-Reply-To: <20211011021124.86248-1-ligang.bdlg@bytedance.com>
References: <20211011021124.86248-1-ligang.bdlg@bytedance.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 10:11:24 +0800
Gang Li <ligang.bdlg@bytedance.com> wrote:

> Ftrace core will add "\n" automatically on print. "\n" in TP_printk
> will create blank line, so remove it.
> 
> By using DECLARE_EVENT_CLASS and TRACE_EVENT_FN, we can save a lot
> of space from duplicate code.

Why did you send this? It should be two patches, not one. The rule is,
every commit does one thing. Now you made this patch do two.

Andrew already pulled in the other two patches. I don't think this one
is appropriate, and should be discarded.

-- Steve


> 
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
