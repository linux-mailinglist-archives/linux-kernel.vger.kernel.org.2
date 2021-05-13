Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E483037F892
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbhEMNVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233961AbhEMNUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:20:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A083C61433;
        Thu, 13 May 2021 13:19:36 +0000 (UTC)
Date:   Thu, 13 May 2021 09:19:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, dianders@chromium.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kdb: Get rid of redundant kdb_register_flags()
Message-ID: <20210513091935.5747c12e@gandalf.local.home>
In-Reply-To: <20210513112842.707103-2-sumit.garg@linaro.org>
References: <20210513112842.707103-1-sumit.garg@linaro.org>
        <20210513112842.707103-2-sumit.garg@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 16:58:41 +0530
Sumit Garg <sumit.garg@linaro.org> wrote:

> Commit e4f291b3f7bb ("kdb: Simplify kdb commands registration")
> allowed registration of pre-allocated kdb commands with pointer to
> struct kdbtab_t. Lets switch other users as well to register pre-
> allocated kdb commands via:
> - Changing prototype for kdb_register() to pass a pointer to struct
>   kdbtab_t instead.
> - Embed kdbtab_t structure in defcmd_set rather than individual params.
>   So while at it rename struct defcmd_set to struct kdb_macro_t as that
>   sounds more appropriate given its purpose.
> 
> With these changes kdb_register_flags() becomes redundant and hence
> removed. Also, since we have switched all users to register
> pre-allocated commands, "is_dynamic" flag in struct kdbtab_t becomes
> redundant and hence removed as well.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  include/linux/kdb.h            |  27 +++--
>  kernel/debug/kdb/kdb_main.c    | 206 +++++++++++----------------------
>  kernel/debug/kdb/kdb_private.h |  13 ---
>  kernel/trace/trace_kdb.c       |  12 +-

For the tracing directory.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  samples/kdb/kdb_hello.c        |  20 ++--
>  5 files changed, 104 insertions(+), 174 deletions(-)

