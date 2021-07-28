Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1493D90DC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbhG1OnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236837AbhG1OnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:43:13 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 497C26069E;
        Wed, 28 Jul 2021 14:43:11 +0000 (UTC)
Date:   Wed, 28 Jul 2021 10:43:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        linux-trace-devel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] MAINTAINERS: add TRACE EVENT LIBRARY section
Message-ID: <20210728104304.24805770@oasis.local.home>
In-Reply-To: <20210728065748.19989-1-lukas.bulwahn@gmail.com>
References: <20210728065748.19989-1-lukas.bulwahn@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 08:57:48 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> The git history shows that the files under ./tools/lib/traceevent/ are
> being developed and maintained by Tzetomir Stoyanov and Steven Rostedt
> and are discussed on linux-trace-devel list.
> 
> Add a suitable section in MAINTAINERS for patches to reach them.
> 
> This was identified with a small script that finds all files only
> belonging to "THE REST" according to the current MAINTAINERS file, and I
> acted upon its output.

Hmm, this is now an obsolete library, as future work is being developed at:

  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/

We probably want people to start using that instead, and eventually
remove the tools/lib/traceveent/ directory entirely.

-- Steve



> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> applies cleanly on next-20210726
> 
> RFC patch (from early 2020) here: https://lore.kernel.org/lkml/20200201161931.29665-1-lukas.bulwahn@gmail.com/
> 
> also copied Steven's Acked-by from the RFC patch.
> 
> Arnaldo, please pick this quick patch.
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2eb730101689..5a1863b93a9a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18828,6 +18828,13 @@ Q:	https://patchwork.kernel.org/project/linux-integrity/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
>  F:	drivers/char/tpm/
>  
> +TRACE EVENT LIBRARY
> +M:	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
> +M:	Steven Rostedt <rostedt@goodmis.org>
> +L:	linux-trace-devel@vger.kernel.org
> +S:	Maintained
> +F:	tools/lib/traceevent/
> +
>  TRACING
>  M:	Steven Rostedt <rostedt@goodmis.org>
>  M:	Ingo Molnar <mingo@redhat.com>

