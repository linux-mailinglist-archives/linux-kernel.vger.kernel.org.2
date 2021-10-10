Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DD94283E8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 23:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhJJVvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 17:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231343AbhJJVvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 17:51:38 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD83F60F46;
        Sun, 10 Oct 2021 21:49:38 +0000 (UTC)
Date:   Sun, 10 Oct 2021 17:49:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     mingo@redhat.com, akpm@linux-foundation.org, vbabka@suse.cz,
        axelrasmussen@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] mm: mmap_lock: use DECLARE_EVENT_CLASS and
 DEFINE_EVENT_FN
Message-ID: <20211010174937.600a44b2@rorschach.local.home>
In-Reply-To: <20211009071243.70286-1-ligang.bdlg@bytedance.com>
References: <20211009071243.70286-1-ligang.bdlg@bytedance.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Oct 2021 15:12:43 +0800
Gang Li <ligang.bdlg@bytedance.com> wrote:

> By using DECLARE_EVENT_CLASS and TRACE_EVENT_FN, we can save a lot
> of space from duplicate code.

Thanks for doing this. Looking at the events, they can certainly be
merged into one.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> 
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
