Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D563EDA0D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbhHPPke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236778AbhHPPkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:40:11 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB97C61038;
        Mon, 16 Aug 2021 15:39:39 +0000 (UTC)
Date:   Mon, 16 Aug 2021 11:39:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v4 07/10] tools/bootconfig: Support per-group/all event
 enabling option
Message-ID: <20210816113938.10822bb2@oasis.local.home>
In-Reply-To: <20210814123132.29181525b4debbf3bc5447bb@kernel.org>
References: <162856122550.203126.17607127017097781682.stgit@devnote2>
        <162856127850.203126.16694505101982548237.stgit@devnote2>
        <20210814123132.29181525b4debbf3bc5447bb@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Aug 2021 12:31:32 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Tue, 10 Aug 2021 11:07:58 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>  
> 
> Oops, I missed the changelog for this patch.
> 
> -----
> Add group or all event enabling syntax support to bconf2ftrace.sh.
> User can pass a bootconfig file which includes
> 
> ftrace[.instance.INSTANCE].event.enable
> 
>     and
> 
> ftrace[.instance.INSTANCE].event.GROUP.enable
> 
> correctly.
> -----
> 
> Steve, should I update the patch and resend the series?
> 

No need. I updated it.

Thanks!

-- Steve
