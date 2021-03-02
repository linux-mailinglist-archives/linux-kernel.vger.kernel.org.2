Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A4632A6A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578854AbhCBP1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:27:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383974AbhCBM7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:59:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E76B61494;
        Tue,  2 Mar 2021 12:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614689943;
        bh=rD8t6WOfsd8DzSjihfIj/2ve47wp6Xsu2pLKj/pQMOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XEH/41EBMntlD3kje4wW7jDLlpKlVaRtHooGqLHQ+TisMrAzma1UMaZrthGJL321B
         /7B+JeR4bDmYTQ/pXTOr9M6a4ZKFhv8GiRrPeLeoPKvDM/9TcWThgoi1e23nUX6by/
         AqmMjaOfl49xQ0vs/yqIm+MWZ5Gv1UKU9Ec6oD7o45bcwwMsZ6gA91C8AA7vm2bXtp
         mBKuYcsYxMRCBGPwxed5Q5391LS2Rlruw9TT1S8U1NLAAcWj9Z0c8eQgcQSHBsVRxf
         fML+VSD3PvxeUexY8mT+Hk4IoA8vXYVMZ1dEM0alL7joQKVmhZadub83KFgKOHtZcj
         6IlDQrqZ9F4Hw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D7D8040CD9; Tue,  2 Mar 2021 09:59:00 -0300 (-03)
Date:   Tue, 2 Mar 2021 09:59:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/2] perf daemon: Fix control fifo permissions
Message-ID: <YD42lFE2ijc6e3PX@kernel.org>
References: <20210301122510.64402-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301122510.64402-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 01, 2021 at 01:25:09PM +0100, Jiri Olsa escreveu:
> Add proper mode for mkfifo calls to get read and
> write permissions for user. We can't use O_RDWR
> in here, changing to standard permission value.

Thanks, applied both patches to perf/urgent.

- Arnaldo

 
> Fixes: 6a6d1804a190 ("perf daemon: Set control fifo for session")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-daemon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 617feaf020f6..8f0ed2e59280 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -373,12 +373,12 @@ static int daemon_session__run(struct daemon_session *session,
>  	dup2(fd, 2);
>  	close(fd);
>  
> -	if (mkfifo(SESSION_CONTROL, O_RDWR) && errno != EEXIST) {
> +	if (mkfifo(SESSION_CONTROL, 0600) && errno != EEXIST) {
>  		perror("failed: create control fifo");
>  		return -1;
>  	}
>  
> -	if (mkfifo(SESSION_ACK, O_RDWR) && errno != EEXIST) {
> +	if (mkfifo(SESSION_ACK, 0600) && errno != EEXIST) {
>  		perror("failed: create ack fifo");
>  		return -1;
>  	}
> -- 
> 2.29.2
> 

-- 

- Arnaldo
