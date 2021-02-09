Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16635315B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhBJAm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:42:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233588AbhBIVKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 16:10:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65EA964DAF;
        Tue,  9 Feb 2021 21:09:11 +0000 (UTC)
Date:   Tue, 9 Feb 2021 16:09:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] tracing: More synthetic event error fixes
Message-ID: <20210209160909.28cc8d3b@gandalf.local.home>
In-Reply-To: <cover.1612208610.git.zanussi@kernel.org>
References: <cover.1612208610.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Feb 2021 13:48:10 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi,
> 
> This is v7 of the synthetic event error fix patchset.  This version
> addresses the comments from v6:
> 
>   - moved check_command() from '[PATCH v6 3/6] tracing: Update synth
>     command errors' to '[PATCH v6 2/6] tracing: Rework synthetic event
>     command parsing'.
> 
>   - in __create_synth_event(), moved mutex_lock(&event_mutex) after
>     is_good_name() check and changed related error handling.
> 
>   - simplified check_command() a bit by calling argv_free() sooner as
>     suggested by Steve.
> 
>   - added Steve's comment about check_field_version() into that
>     function and added additional comments to the caller.
> 

After applying these, the following test fails:

 test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc

It appears that:

  echo 'myevent char str[];; int v' > synthetic_events

doesn't error after these changes.

-- Steve
