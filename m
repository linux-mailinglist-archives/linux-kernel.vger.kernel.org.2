Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E104E3F2612
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 06:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhHTEk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 00:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhHTEkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 00:40:55 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B69AC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 21:40:18 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id r17-20020a0568302371b0290504f3f418fbso11480067oth.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 21:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=U95kMWvbpVh0veAC4zTebnZuRjnR8xBCS9KpNNAr5tQ=;
        b=dqAK0BMresy6mFI9l72sf0WtDdMOWE1j9PoghCJJOPyrZNMMNtK4cpkOiKqaaArutj
         3AGlTD+n+pw1tWLl5weBT87zEBv0TXCiFnF9YeJ1g7cMW0vmhgWi05Ce8wgljnPLuSNM
         hbiU0xgtg7HHd49ijUDcE1hw/dG6PnTDO8CDKj6mpKFZ6G3J+x8/We/aNPS10+4+JNQ5
         jBGetZp5yl8wxbzzvYe2ay6jcGBKUVeijM4kI/Wjv6Cbho0ntrwzgNGB3pTFMe+0pXun
         sV58DWbQKtvDw/rUkdS6tt7mCgeBJvGa87mjBLLNMlrll4vgAbJKsDm3ynFakmpWPyAt
         xakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=U95kMWvbpVh0veAC4zTebnZuRjnR8xBCS9KpNNAr5tQ=;
        b=Enm9UyutdKEqops7dTHBYp/mQ7Y/XCvwHZH6hU5WbMBv2iy6uBvxCPcm/mn9X76JTT
         xHOih5ZsMZ7QkfRoWCRIqo40P/FkD/cFIBDVpN4NwSheTuSB/WgYfTO/oZHlxWhyLekH
         qKFJsqXsAfuivHURGIE0VhoU4IjEdFK/ULfpkQjDeUZv/2uEIh9xy8EyS1FqAkuQ7RnK
         XbxS5V431I7ahRU0FlI/LmPcT2lpjVNy/edg2gqYTLcsoD/hzE1Q0dl9CHE34KC65555
         lQedTqHuQ2dxjp0h7EbYLIQBnchz4f9GWlqkT6Cl6WaQS/cH2uNbAZ4sFCLJ0eXl9c+H
         UxNw==
X-Gm-Message-State: AOAM531M0HQWJwON/f/Dj1CadpM+jD57zMd6NYf0xz+rqqBY6God/8t7
        TX6dPx+1DVtDLztkhUSAcR8=
X-Google-Smtp-Source: ABdhPJwupivAk1N9MgrVRfeLIuGpMWP5Kyf0EI8ijczY41hBE7aYMyQPoMFzZEL0p9tHGfnhDxkH8Q==
X-Received: by 2002:a05:6830:b8b:: with SMTP id a11mr15162078otv.179.1629434417359;
        Thu, 19 Aug 2021 21:40:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t30sm1023166oiw.42.2021.08.19.21.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 21:40:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 19 Aug 2021 21:40:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v2] locking/ww_mutex: Initialize waiter.ww_ctx properly
Message-ID: <20210820044015.GA2751666@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 09:30:30PM +0200, Sebastian Andrzej Siewior wrote:
> The gathering of the debug code for the ww-mutex initialized moved the
> POISON initialiation into one spot and only set waiter.ww_ctx if the
> ww_ctx was non-NULL thus keeping the POISON value in ww-mutex case.
> 
> For ww-mutex without a context it is expected to set the context to
> NULL, the poison value was intended only for the regular mutex.
> 
> Always initialized waiter.ww_ctx to ww_ctx in the ww-mutex case.
> 
> Fixes: c0afb0ffc06e6 ("locking/ww_mutex: Gather mutex_waiter initialization")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v1…v2: Use PeterZ' approach.
> 
>  kernel/locking/mutex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 05b68931622d1..2c70213934cd4 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -614,7 +614,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  
>  	debug_mutex_lock_common(lock, &waiter);
>  	waiter.task = current;
> -	if (ww_ctx)
> +	if (use_ww_ctx)
>  		waiter.ww_ctx = ww_ctx;
>  
>  	lock_contended(&lock->dep_map, ip);
> -- 
> 2.33.0
> 
