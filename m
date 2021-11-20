Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DDD457C09
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 07:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbhKTG44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 01:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbhKTG4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 01:56:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DD8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 22:53:52 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1moKFu-0003Ns-N7; Sat, 20 Nov 2021 07:53:46 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH] Fixup: perf bench: Fix two memory leaks detected with
 ASan
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>, jolsa@redhat.com
Cc:     acme@kernel.org, irogers@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        songliubraving@fb.com
References: <YZev7KClb/ud43Lc@krava>
 <20211120040854.95169-1-sohaib.amhmd@gmail.com>
Message-ID: <0c4189c4-3788-0fef-fce0-3527ec90b4b1@pengutronix.de>
Date:   Sat, 20 Nov 2021 07:53:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211120040854.95169-1-sohaib.amhmd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sohaib,

On 20.11.21 05:08, Sohaib Mohamed wrote:
> Fixes: 92723ea0f11d ("perf bench: Fix two memory leaks detected with
> ASan")

Fixes and other tags are usually at the end, but before the S-o-b's,
Tested-by's and such.

> This patch fixes the previous patch which frees the ctx before
> the thread finishes the work. This break -t option.
>
> This patch stores all overwritten pointers in a global vars then free
> them at the end of the program.

Clean up is complicated a bit, because the worker may either be forked
off (so each main and worker has its own allocation) or threaded (with
same allocation for both).

I wouldn't bother to fix small leaks in a short running application to be
honest, but still some review below:

> 
> Tests:
> $ perf bench sched messaging -g 1 -l 100 -t
> $ perf bench sched messaging -g 1 -l 100
> $ perf bench sched all
> 
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
> ---
>  tools/perf/bench/sched-messaging.c | 39 +++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
> index 488f6e6ba1a5..f60dc9c36f4e 100644
> --- a/tools/perf/bench/sched-messaging.c
> +++ b/tools/perf/bench/sched-messaging.c
> @@ -30,11 +30,15 @@
>  #include <linux/time64.h>
> 
>  #define DATASIZE 100
> +#define GROUPS_NUM 10
> +#define FD_NUM 20
> 
>  static bool use_pipes = false;
>  static unsigned int nr_loops = 100;
>  static bool thread_mode = false;
> -static unsigned int num_groups = 10;
> +static unsigned int num_groups = GROUPS_NUM;

Why is this a variable? Looks like it's never changed

> +static unsigned int num_fds = FD_NUM;

Same here

> +static unsigned int total_counter; /* num_groups * num_fds */
> 
>  struct sender_context {
>  	unsigned int num_fds;
> @@ -50,6 +54,9 @@ struct receiver_context {
>  	int wakefd;
>  };
> 
> +struct receiver_context *ctx_arr[FD_NUM*GROUPS_NUM];
> +struct sender_context *snd_ctx_arr[FD_NUM*GROUPS_NUM];
> +
>  static void fdpair(int fds[2])
>  {
>  	if (use_pipes) {
> @@ -190,29 +197,30 @@ static void reap_worker(pthread_t id)
> 
>  /* One group of senders and receivers */
>  static unsigned int group(pthread_t *pth,
> -		unsigned int num_fds,
> +		unsigned int num_fd,

Especially fixes should be as short as possible. Renaming this variable
could've been avoided.

>  		int ready_out,
>  		int wakefd)
>  {
>  	unsigned int i;
>  	struct sender_context *snd_ctx = malloc(sizeof(struct sender_context)
> -			+ num_fds * sizeof(int));
> +			+ num_fd * sizeof(int));
> 
>  	if (!snd_ctx)
>  		err(EXIT_FAILURE, "malloc()");
> 
> -	for (i = 0; i < num_fds; i++) {
> +	for (i = 0; i < num_fd; i++) {
>  		int fds[2];
>  		struct receiver_context *ctx = malloc(sizeof(*ctx));
> 
>  		if (!ctx)
>  			err(EXIT_FAILURE, "malloc()");
> 
> +		total_counter++;
> 
>  		/* Create the pipe between client and server */
>  		fdpair(fds);
> 
> -		ctx->num_packets = num_fds * nr_loops;
> +		ctx->num_packets = num_fd * nr_loops;
>  		ctx->in_fds[0] = fds[0];
>  		ctx->in_fds[1] = fds[1];
>  		ctx->ready_out = ready_out;
> @@ -223,24 +231,28 @@ static unsigned int group(pthread_t *pth,
>  		snd_ctx->out_fds[i] = fds[1];
>  		if (!thread_mode)
>  			close(fds[0]);
> +
> +		ctx_arr[total_counter] = ctx;

You could've done the total_counter++ here, which makes the relation easier
to follow.

>  	}
> 
>  	/* Now we have all the fds, fork the senders */
> -	for (i = 0; i < num_fds; i++) {
> +	for (i = 0; i < num_fd; i++) {
>  		snd_ctx->ready_out = ready_out;
>  		snd_ctx->wakefd = wakefd;
> -		snd_ctx->num_fds = num_fds;
> +		snd_ctx->num_fds = num_fd;
> 
> -		pth[num_fds+i] = create_worker(snd_ctx, (void *)sender);
> +		pth[num_fd+i] = create_worker(snd_ctx, (void *)sender);
>  	}
> 
>  	/* Close the fds we have left */
>  	if (!thread_mode)
> -		for (i = 0; i < num_fds; i++)
> +		for (i = 0; i < num_fd; i++)
>  			close(snd_ctx->out_fds[i]);
> 
> +	snd_ctx_arr[total_counter] = snd_ctx;

You are storing at snd_ctx_arr[num_fd] each time, so you will leak
all context, except for the last one.

> +
>  	/* Return number of children to reap */
> -	return num_fds * 2;
> +	return num_fd * 2;
>  }
> 
>  static const struct option options[] = {
> @@ -262,7 +274,6 @@ int bench_sched_messaging(int argc, const char **argv)
>  {
>  	unsigned int i, total_children;
>  	struct timeval start, stop, diff;
> -	unsigned int num_fds = 20;
>  	int readyfds[2], wakefds[2];
>  	char dummy;
>  	pthread_t *pth_tab;
> @@ -287,6 +298,7 @@ int bench_sched_messaging(int argc, const char **argv)
>  		if (read(readyfds[0], &dummy, 1) != 1)
>  			err(EXIT_FAILURE, "Reading for readyfds");
> 
> +

Unneeded space.

>  	gettimeofday(&start, NULL);
> 
>  	/* Kick them off */
> @@ -323,6 +335,11 @@ int bench_sched_messaging(int argc, const char **argv)
>  		break;
>  	}
> 
> +	/* Free malloc's */

Unneeded comment.

> +	for (i = 0; i < FD_NUM * GROUPS_NUM; i++) {
> +		free(ctx_arr[i]);
> +		free(snd_ctx_arr[i]);
> +	}

At least in the threaded case, file descriptors are leaked and there's more
memory associated with them than with the context structs you are freeing here.

If you are serious about fixing leaks, I think both should be fixed together, 
so I am in favor of just reverting the other patch for now.

Cheers,
Ahmad

>  	free(pth_tab);
> 
>  	return 0;
> --
> 2.25.1
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
