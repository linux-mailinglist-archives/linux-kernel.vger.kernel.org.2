Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D915348823
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 05:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhCYE5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 00:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhCYE5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 00:57:12 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CB8C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 21:57:12 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so815249oto.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 21:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dlwPOOwmmcidTtkFkAPDlxAXxvHXtRIaJ2faAmek/jE=;
        b=M7e9Q8LgGiE1M3dYbym8nZn8H0NRHGXJlZ/SLOQHULocj36S/hWnfhDdwhpNnbW1dH
         SSnrF1csWnqAP/65bjXEl8YybEZ7fKgsZyTtbQ6WmnomuQn93pXqz0QkvudICAkV4UfN
         kJFYnskpQ+sGzmvgZkost6LKwuZOnLSEX1/rDsa5hDZpaLTIXS6R3QbAz4iW+q6YnnSN
         UwAmUwGSIuPuvEIMoWFfz4kuEqgaS8ACOvbkD4y5BIycsAfNyoH7D0YLFl8NvtMf8u0W
         UShi7+kYcbqLoQcI2teHq+s70xCIzZRKekTApgt21D4RbxXUm+jLMlKoDbLqOLvYxeuz
         PWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=dlwPOOwmmcidTtkFkAPDlxAXxvHXtRIaJ2faAmek/jE=;
        b=Bsm89O6OeqJ6XYiH8myWxnrbVEVRBgG6o2yZqEhrZ2cmEI9b/1eLIEr2YqpkN1x+VR
         un7X+5RxRBpbZ5pK4OUE+TKQmkCdxefgh6YyRUs53xaOSGF+Ql4navlVrIyEHExGeyTj
         12H3d94bgDKjOkaN+NpFrm9FEXOB7C8pgx/4zFFb4ihelaIu2x2g/1jDW1wOrug7i4NB
         BMBC/T/EoAFUjKP4B7PU05eB9qKwk/nmCS7qDJwY1xQR2kWHKIeQLe3o5hYHtmMeq+xr
         wGUod9guXHJOktKxI5Sp6m0VcgfJt/ALa24ZItbmbUJLEj65Ymq1f56+zXrhcBBwc+xG
         OyLg==
X-Gm-Message-State: AOAM532IgGnqDkxKXYbKcEx/23ilyTBDiGvx19kZNKb9TECgqJenZydT
        a8rE9mcJQvrH1stz6Dy01p0=
X-Google-Smtp-Source: ABdhPJzuTnQvWvCdqDZVKv/Y7tolUbhsvaf0QYlTGepEl91Q0muphg8Jc/4c25ZPjyqNk1BAl2hJHw==
X-Received: by 2002:a05:6830:17d0:: with SMTP id p16mr5878584ota.127.1616648231364;
        Wed, 24 Mar 2021 21:57:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r2sm1081918otk.55.2021.03.24.21.57.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Mar 2021 21:57:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 24 Mar 2021 21:57:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tee: optee: fix build error caused by recent optee
 tracepoints feature
Message-ID: <20210325045709.GA115263@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 12:06:01PM +0800, Jisheng Zhang wrote:
> If build kernel without "O=dir", below error will be seen:
> 
> In file included from drivers/tee/optee/optee_trace.h:67,
>                  from drivers/tee/optee/call.c:18:
> ./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: No such file or directory
>    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>       |                                          ^
> compilation terminated.
> 
> Fix it by adding below line to Makefile:
> CFLAGS_call.o := -I$(src)
> 
> Tested with and without "O=dir", both can build successfully.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/tee/optee/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> index 56263ae3b1d7..3aa33ea9e6a6 100644
> --- a/drivers/tee/optee/Makefile
> +++ b/drivers/tee/optee/Makefile
> @@ -6,3 +6,6 @@ optee-objs += rpc.o
>  optee-objs += supp.o
>  optee-objs += shm_pool.o
>  optee-objs += device.o
> +
> +# for tracing framework to find optee_trace.h
> +CFLAGS_call.o := -I$(src)
> -- 
> 2.31.0
> 
