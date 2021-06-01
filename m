Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2E33947CC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 22:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhE1UKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhE1UKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:10:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D63D613B5;
        Fri, 28 May 2021 20:08:59 +0000 (UTC)
Date:   Fri, 28 May 2021 16:08:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ring-buffer: Fix fall-through warning for Clang
Message-ID: <20210528160858.287e33ac@gandalf.local.home>
In-Reply-To: <20210528195942.GA39174@embeddedor>
References: <20210528195942.GA39174@embeddedor>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021 14:59:42 -0500
"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> In preparation to enable -Wimplicit-fallthrough for Clang, fix
> a fall-through warning by replacing a /* fall through */ comment
> with the new pseudo-keyword macro fallthrough;
> 
> Notice that Clang doesn't recognize /* fall through */ comments as
> implicit fall-through markings, so in order to globally enable
> -Wimplicit-fallthrough for Clang, these comments need to be
> replaced with fallthrough; in the whole codebase.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> JFYI: We had thousands of these sorts of warnings and now we are down
>       to just 25 in linux-next. This is one of those last remaining
>       warnings.

And I have it fixed locally already.

  https://lore.kernel.org/lkml/20210511140246.18868-1-jj251510319013@gmail.com/

I've just been on vacation and haven't pushed it to next yet. It's still in
the "to be tested" queue.

-- Steve

> 
>  kernel/trace/ring_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 2c0ee6484990..d1463eac11a3 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3391,7 +3391,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
>  		case RINGBUF_TYPE_PADDING:
>  			if (event->time_delta == 1)
>  				break;
> -			/* fall through */
> +			fallthrough;
>  		case RINGBUF_TYPE_DATA:
>  			ts += event->time_delta;
>  			break;

