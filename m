Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AFE429BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 05:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhJLDIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 23:08:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231742AbhJLDIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 23:08:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFB8560E05;
        Tue, 12 Oct 2021 03:06:34 +0000 (UTC)
Date:   Mon, 11 Oct 2021 23:06:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     davidcomponentone@gmail.com
Cc:     Viktor.Rosendahl@bmw.de, colin.king@canonical.com,
        vulab@iscas.ac.cn, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] Fix application of sizeof to pointer
Message-ID: <20211011230633.262b54a5@oasis.local.home>
In-Reply-To: <20211012025424.180781-1-davidcomponentone@gmail.com>
References: <20211012025424.180781-1-davidcomponentone@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 10:54:24 +0800
davidcomponentone@gmail.com wrote:

> From: David Yang <davidcomponentone@gmail.com>
> 
> The coccinelle check report:
> "./tools/tracing/latency/latency-collector.c:1541:10-16:
> ERROR: application of sizeof to pointer"
> Using the "strlen" to fix it.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: David Yang <davidcomponentone@gmail.com>
> ---
>  tools/tracing/latency/latency-collector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
> index 3a2e6bb781a8..b131007e6c70 100644
> --- a/tools/tracing/latency/latency-collector.c
> +++ b/tools/tracing/latency/latency-collector.c
> @@ -1538,7 +1538,7 @@ static void tracing_loop(void)
>  				mutex_lock(&print_mtx);
>  				check_signals();
>  				write_or_die(fd_stdout, queue_full_warning,
> -					     sizeof(queue_full_warning));
> +					     strlen(queue_full_warning) + 1);

Really, the +1, although would match if queue_full_warning was an
array, but in this use case, there's no reason to pass the nul
character to the write.

-- Steve


>  				mutex_unlock(&print_mtx);
>  			}
>  			modified--;

