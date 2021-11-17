Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933E24549AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhKQPSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:18:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233244AbhKQPRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:17:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF7561465;
        Wed, 17 Nov 2021 15:14:49 +0000 (UTC)
Date:   Wed, 17 Nov 2021 10:14:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 4/5] libtraceevent: Add __rel_loc relative location
 attribute support
Message-ID: <20211117101447.39a394d4@gandalf.local.home>
In-Reply-To: <20211117233317.841b81fa8b709455b7df9da6@kernel.org>
References: <163697159970.131454.2661507704362599471.stgit@devnote2>
        <163697163637.131454.1385316505107139633.stgit@devnote2>
        <20211116172332.655bae77@gandalf.local.home>
        <20211117233317.841b81fa8b709455b7df9da6@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 23:33:17 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > Care to send a patch against:
> > 
> >   https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/
> > 
> > And Cc linux-trace-devel@vger.kernel.org  
> 
> Should I cc to LKML too?

Only if you want to, but it is not necessary. Patches to linux-trace-devel
end up at:

   https://patchwork.kernel.org/project/linux-trace-devel/list/

-- Steve
