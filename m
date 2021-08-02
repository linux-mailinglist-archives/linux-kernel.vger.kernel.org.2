Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8213DDDC3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 18:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhHBQe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 12:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhHBQe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 12:34:29 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E85D61029;
        Mon,  2 Aug 2021 16:34:19 +0000 (UTC)
Date:   Mon, 2 Aug 2021 12:34:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [RFC PATCH 0/3] tracing/boot: Add histogram syntax support in
 boot-time tracing
Message-ID: <20210802123417.54b263ec@oasis.local.home>
In-Reply-To: <162791821009.552329.4358174280895732459.stgit@devnote2>
References: <162791821009.552329.4358174280895732459.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Aug 2021 00:30:10 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is a series of patches for boot-time tracing to add histogram
> syntax extension and fixes a build issue.

Cool, I'll try to look at this, this week.

Thanks Masami!

-- Steve


> 
> Currently, the boot-time tracing only supports per-event actions
> for setting trigger actions. This is enough for short actions
> like 'traceon', 'traceoff', 'snapshot' etc. However, it is not good
> for the 'hist' trigger action because it is usually too long to write
> it in a single string especially if it has an 'onmatch' action.
>
