Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544223FC054
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 03:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239214AbhHaBFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 21:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhHaBFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 21:05:48 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD82FC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 18:04:53 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id x4so15181682pgh.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 18:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N9oXdiyKyh+64MjmkQedbrZJBmQwnxKayFwZGo+V8Ik=;
        b=gW+g6sw7G9SRkIO4ftZiqwMcqR/F0nK+204T/aIFFwdYI3RrUEN4x0Ur8tQ5+GTkdt
         rvJhRPluk1SvZjJR+tj3T5ryphD7yNZ7pcIKH3U8Yc+6ASXwNTK+oOFPLH7baNTfWdZb
         oLJPd+q8jWZOCdjWjHShIMMYXULqfITsb4pRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N9oXdiyKyh+64MjmkQedbrZJBmQwnxKayFwZGo+V8Ik=;
        b=L5wVQmhvsYtUb0deDkHiHvhUfK5d1MCkRCS84W8FS0ToPY7PYK9KVhALaF3iXfeVDy
         lCQf99tzpMrmtd+Zw7ZFgF90OPqCGXzh26GanAGvMQCUChGHyStV6dlrPA0oO1bI3Dmr
         Fl1Fe3/SyIo0QFlITDrbGZX8HnpUTLMT44TTwtZQnGqSw2mhInKmFTNRx3tnl7oq2NvN
         Npd0//SV8/Hok7WrrtMB4+h1Nkz8QKp+1b+vO5tQu2hV9WhhrStWkFzo2GPsMtcmArl1
         6RxrTVvzeWbOlHRRD2bKAYPRKjMCd/QckhZqmGVOQvDNDmXdlhvC75M6eMu/V5R4VKdP
         tR2A==
X-Gm-Message-State: AOAM532vK3lhUCsVMUda8I0HXtbloOKQz23Qp1jrCCQ4ZrSbPBrvcww7
        ++TDilKjL6df6Y+kFjR9g9Ux1Q==
X-Google-Smtp-Source: ABdhPJzUWbLXbubjr4NxIULBQ208sO9zxi9JNX6oqkH+q/g3cpjbL9Vpcxi4PxuB3pMXHr9AFd/deQ==
X-Received: by 2002:aa7:8888:0:b0:3ff:1d90:1864 with SMTP id z8-20020aa78888000000b003ff1d901864mr8718183pfe.54.1630371893448;
        Mon, 30 Aug 2021 18:04:53 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:6d52:87b8:b55b:8800])
        by smtp.gmail.com with ESMTPSA id o2sm18511425pgu.76.2021.08.30.18.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 18:04:53 -0700 (PDT)
Date:   Tue, 31 Aug 2021 10:04:48 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 05/10] printk: call boot_delay_msec() in
 printk_delay()
Message-ID: <YS2AMIQGPDR0Ve57@google.com>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
 <20210803131301.5588-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803131301.5588-6-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/08/03 15:18), John Ogness wrote:
> boot_delay_msec() is always called immediately before printk_delay()
> so just call it from within printk_delay().

[..]

Interesting. Apparently boot_delay_msec() does not do anything
if suppress_message_printing(level). I wonder if we want a similar
thing for printk_delay() as well. Otherwise we have some imbalance in
behaviour.

IOW,

> @@ -1222,10 +1222,8 @@ static void boot_delay_msec(int level)
>        unsigned long long k;
>        unsigned long timeout;
> 
>-       if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
>-               || suppress_message_printing(level)) {
>+       if (boot_delay == 0 || system_state >= SYSTEM_RUNNING)
>                return;
>-       }
> 
>        k = (unsigned long long)loops_per_msec * boot_delay;

[..]

> +static inline void printk_delay(int level)
>  {

+	if (suppress_message_printing(level))
+		return;

> +	boot_delay_msec(level);
> +
>  	if (unlikely(printk_delay_msec)) {
>  		int m = printk_delay_msec;
>  
