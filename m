Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9941D453C35
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 23:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhKPW0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 17:26:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231244AbhKPW0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 17:26:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF09461B62;
        Tue, 16 Nov 2021 22:23:33 +0000 (UTC)
Date:   Tue, 16 Nov 2021 17:23:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 4/5] libtraceevent: Add __rel_loc relative location
 attribute support
Message-ID: <20211116172332.655bae77@gandalf.local.home>
In-Reply-To: <163697163637.131454.1385316505107139633.stgit@devnote2>
References: <163697159970.131454.2661507704362599471.stgit@devnote2>
        <163697163637.131454.1385316505107139633.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 19:20:36 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add '__rel_loc' new dynamic data location attribute which encodes
> the data location from the next to the field itself. This is similar
> to the '__data_loc' but the location offset is not from the event
> entry but from the next of the field.
> 
> This patch adds '__rel_loc' decoding support in the libtraceevent.

Note, libtraceevent in the kernel is deprecated.

Care to send a patch against:

  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/

And Cc linux-trace-devel@vger.kernel.org

Thanks!

-- Steve

> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/lib/traceevent/event-parse.c  |   14 ++++++++++++++
>  tools/lib/traceevent/event-parse.h  |    1 +
>  tools/lib/traceevent/parse-filter.c |    5 ++++-
>  3 files changed, 19 insertions(+), 1 deletion(-)

