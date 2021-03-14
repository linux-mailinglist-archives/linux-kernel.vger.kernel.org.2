Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AAA33A346
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 07:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbhCNGLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 01:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhCNGLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 01:11:09 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BA4C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 22:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=O1NVT4BorWBMlPYXPUtlWYkkcJnlYL57fd0zPOIUr6Q=; b=Jo5KWcz3VWDYRn00J0fujN8kju
        NWvc0QtCy6XBong79Sd0gG0nKdAb0DNvJcve86fS9Emqgp4O2Id2hF1hBumQx/fTo0zukdYCdumYa
        JapnAoCETunP0rBrbHTaSGeDg09GpeUzYQkhQOX7zGA0v0Nv8S33AsLzk2qZYMoiDcahhCGestj4w
        7oMbAfpCOi2hfA/hnLz+WQG7Lqv4jkkJjoRQDeTdRziE6tS0DVSBdjYHpGO6+dIniyObXcO3Xd0jh
        e8q4q0QhodxS1a76C4AVcSL1eQ38X2j0Ae4izgAaduDjm/Flwvrst6noPgNRHWnPMCx52rO1Dfgje
        C7TbhKzA==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLJxu-001B59-8l; Sun, 14 Mar 2021 06:11:02 +0000
Subject: Re: [PATCH] kernel: trace: A typo fix in the file trace_event_perf.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
References: <20210314050656.9402-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <15e0174c-4d8b-03b3-8f92-34acc9bf115a@infradead.org>
Date:   Sat, 13 Mar 2021 22:10:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210314050656.9402-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/21 9:06 PM, Bhaskar Chowdhury wrote:
> 
> s/suprises/surprises/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  kernel/trace/trace_event_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index a71181655958..d1eac45b79d2 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -16,7 +16,7 @@ static char __percpu *perf_trace_buf[PERF_NR_CONTEXTS];
> 
>  /*
>   * Force it to be aligned to unsigned long to avoid misaligned accesses
> - * suprises
> + * surprises
>   */
>  typedef typeof(unsigned long [PERF_MAX_TRACE_SIZE / sizeof(unsigned long)])
>  	perf_trace_t;
> --


-- 
~Randy

