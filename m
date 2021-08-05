Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C743E1916
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhHEQID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231472AbhHEQIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:08:00 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B374610CD;
        Thu,  5 Aug 2021 16:07:45 +0000 (UTC)
Date:   Thu, 5 Aug 2021 12:07:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jpoimboe@redhat.com, jbaron@akamai.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, ltykernel@gmail.com
Subject: Re: [PATCH] static_call: Update comment
Message-ID: <20210805120743.0fb8832d@oasis.local.home>
In-Reply-To: <YQwIorQBHEq+s73b@hirez.programming.kicks-ass.net>
References: <YQwIorQBHEq+s73b@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021 17:49:54 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Update the comment with the new features.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

