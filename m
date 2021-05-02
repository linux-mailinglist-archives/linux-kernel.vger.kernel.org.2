Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA75370A6F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 08:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhEBGLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 02:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhEBGLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 02:11:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1B2A613E1;
        Sun,  2 May 2021 06:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619935820;
        bh=BTrWrUBqG+mxHfOsVdFTMvDIXUeDLs1p3+Ufop2ppXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezGaOvsGeITq6bba4wJZYV1PcH8Tc94fnHifAm4hKMn6O6CEQoWU81e/GukjxywC7
         nrA1qUP7FP+ufXIGYfLVM7sNPo4yjjBxEmL+TTzXJl/BnJqcmtVRsN4Jj1+9HJHS0H
         /qes1O9QuRVFfiisa/5LmmLJEFy8wbH4auFepLr8=
Date:   Sun, 2 May 2021 08:10:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thais Camacho <thaiscamachoo@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: greybus: tools: loopback_test: fixed coding
 style issues
Message-ID: <YI5CSvPnz1mL9+Az@kroah.com>
References: <20210501193043.12153-1-thaiscamachoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210501193043.12153-1-thaiscamachoo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2021 at 04:30:42PM -0300, Thais Camacho wrote:
> Fixed warnings found by checkpatch.pl script
> 
> Signed-off-by: Thais Camacho <thaiscamachoo@gmail.com>
> ---
>  drivers/staging/greybus/tools/loopback_test.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
> index 867bf289df2e..553883b2bfa3 100644
> --- a/drivers/staging/greybus/tools/loopback_test.c
> +++ b/drivers/staging/greybus/tools/loopback_test.c
> @@ -239,7 +239,6 @@ static void show_loopback_devices(struct loopback_test *t)
>  
>  	for (i = 0; i < t->device_count; i++)
>  		printf("device[%d] = %s\n", i, t->devices[i].name);
> -
>  }
>  
>  int open_sysfs(const char *sys_pfx, const char *node, int flags)
> @@ -274,7 +273,6 @@ float read_sysfs_float_fd(int fd, const char *sys_pfx, const char *node)
>  	char buf[SYSFS_MAX_INT];
>  
>  	if (read(fd, buf, sizeof(buf)) < 0) {
> -
>  		fprintf(stderr, "unable to read from %s%s %s\n", sys_pfx, node,
>  			strerror(errno));
>  		close(fd);
> @@ -367,7 +365,6 @@ static int get_results(struct loopback_test *t)
>  			r->apbridge_unipro_latency_max - r->apbridge_unipro_latency_min;
>  		r->gbphy_firmware_latency_jitter =
>  			r->gbphy_firmware_latency_max - r->gbphy_firmware_latency_min;
> -
>  	}
>  
>  	/*calculate the aggregate results of all enabled devices */
> @@ -407,7 +404,6 @@ static int get_results(struct loopback_test *t)
>  			r->apbridge_unipro_latency_max - r->apbridge_unipro_latency_min;
>  		r->gbphy_firmware_latency_jitter =
>  			r->gbphy_firmware_latency_max - r->gbphy_firmware_latency_min;
> -
>  	}
>  
>  	return 0;
> @@ -536,7 +532,6 @@ static int log_results(struct loopback_test *t)
>  			fprintf(stderr, "unable to open %s for appendation\n", file_name);
>  			abort();
>  		}
> -
>  	}
>  	for (i = 0; i < t->device_count; i++) {
>  		if (!device_enabled(t, i))
> @@ -550,10 +545,8 @@ static int log_results(struct loopback_test *t)
>  			if (ret == -1)
>  				fprintf(stderr, "unable to write %d bytes to csv.\n", len);
>  		}
> -
>  	}
>  
> -
>  	if (t->aggregate_output) {
>  		len = format_output(t, &t->aggregate_results, "aggregate",
>  				    data, sizeof(data), &tm);
> @@ -675,11 +668,13 @@ static int open_poll_files(struct loopback_test *t)
>  static int close_poll_files(struct loopback_test *t)
>  {
>  	int i;
> +
>  	for (i = 0; i < t->poll_count; i++)
>  		close(t->fds[i].fd);
>  
>  	return 0;
>  }
> +
>  static int is_complete(struct loopback_test *t)
>  {
>  	int iteration_count;
> @@ -740,7 +735,6 @@ static int wait_for_complete(struct loopback_test *t)
>  		ts = &t->poll_timeout;
>  
>  	while (1) {
> -
>  		ret = ppoll(t->fds, t->poll_count, ts, &mask_old);
>  		if (ret <= 0) {
>  			stop_tests(t);
> @@ -780,7 +774,6 @@ static void prepare_devices(struct loopback_test *t)
>  		if (t->stop_all || device_enabled(t, i))
>  			write_sysfs_val(t->devices[i].sysfs_entry, "type", 0);
>  
> -
>  	for (i = 0; i < t->device_count; i++) {
>  		if (!device_enabled(t, i))
>  			continue;
> @@ -823,13 +816,12 @@ static int start(struct loopback_test *t)
>  	return 0;
>  }
>  
> -
>  void loopback_run(struct loopback_test *t)
>  {
>  	int i;
>  	int ret;
>  
> -	for (i = 0; dict[i].name != NULL; i++) {
> +	for (i = 0; dict[i].name; i++) {
>  		if (strstr(dict[i].name, t->test_name))
>  			t->test_id = dict[i].type;
>  	}
> @@ -852,7 +844,6 @@ void loopback_run(struct loopback_test *t)
>  	if (ret)
>  		goto err;
>  
> -
>  	get_results(t);
>  
>  	log_results(t);
> @@ -861,7 +852,6 @@ void loopback_run(struct loopback_test *t)
>  
>  err:
>  	printf("Error running test\n");
> -	return;
>  }
>  
>  static int sanity_check(struct loopback_test *t)
> @@ -881,10 +871,8 @@ static int sanity_check(struct loopback_test *t)
>  			fprintf(stderr, "Bad device mask %x\n", (1 << i));
>  			return -1;
>  		}
> -
>  	}
>  
> -
>  	return 0;
>  }
>  
> -- 
> 2.20.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
