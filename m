Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB26E31A0E6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhBLOsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:48:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhBLOr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:47:57 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F24DB64E15;
        Fri, 12 Feb 2021 14:47:15 +0000 (UTC)
Date:   Fri, 12 Feb 2021 09:47:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] tracefs: Add FS_GENERATED_CONTENT to filesystem
 flags
Message-ID: <20210212094714.043446b4@gandalf.local.home>
In-Reply-To: <20210212124354.5.Ibc4b187415025a544425f206264db4fd94a555a7@changeid>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
        <20210212124354.5.Ibc4b187415025a544425f206264db4fd94a555a7@changeid>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Feb 2021 12:44:04 +0800
Nicolas Boichat <drinkcat@chromium.org> wrote:

> tracefs content is generated at runtime.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
> 
>  fs/tracefs/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 4b83cbded559..89980312c7a3 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -308,6 +308,7 @@ static struct file_system_type trace_fs_type = {
>  	.name =		"tracefs",
>  	.mount =	trace_mount,
>  	.kill_sb =	kill_litter_super,
> +	.fs_flags =	FS_GENERATED_CONTENT,
>  };
>  MODULE_ALIAS_FS("tracefs");
>  

