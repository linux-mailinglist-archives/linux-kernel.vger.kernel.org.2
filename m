Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7054592F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 17:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbhKVQ2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 11:28:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231307AbhKVQ23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 11:28:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 735F6608FB;
        Mon, 22 Nov 2021 16:25:22 +0000 (UTC)
Date:   Mon, 22 Nov 2021 11:25:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 4/5] libtraceevent: Add __rel_loc relative location
 attribute support
Message-ID: <20211122112520.5de93c47@gandalf.local.home>
In-Reply-To: <20211122140538.a981ac0bdaa1b375f9545433@kernel.org>
References: <163697159970.131454.2661507704362599471.stgit@devnote2>
        <163697163637.131454.1385316505107139633.stgit@devnote2>
        <20211116172332.655bae77@gandalf.local.home>
        <20211122140538.a981ac0bdaa1b375f9545433@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 14:05:38 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> So it seems that the in-kernel libtraceevent source and header are
> still in use.

I believe it's still used if it's not found in the system.

I'll include this patch to the code as well.

Thanks!

-- Steve
