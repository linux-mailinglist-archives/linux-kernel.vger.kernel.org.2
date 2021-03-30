Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A387034E31E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhC3I0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhC3I0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:26:21 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C0CC061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:26:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id o10so22473634lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5LXW22aAYf3JYOoV/0hwKSIkX/UUO5en8X4dxPYEY1s=;
        b=iG6pvzjEA6wDWWCWnLT8Efy/wQ32LJkia3Lk1+U1yiyhAnbhZRTYmym7otsYhJESfT
         H7XwX7WRfCay+07hDhsf/2IcGqryelfxvlfwttR7Nkl0xVQNbgU7X4YPHQh2R/7l4BdR
         IVL+UNP4I7tLhSDrhBsBtydThLXJpZFg5yqirZwHAuwUeEsi58rwFHkk8Qz6fzQ66U5w
         zFb4dNneA6aO9YbhMnD2xIDhzHYfJ5jvdxKcUOMe4yYpUHPQywDVPQWLAQIVpqu/qGen
         3rVz6chwidic5D1HH5BNkzYgbxOXqt3p42uUu6e75S4Qwt4K5aSsiXbhTL4QlD/xebYJ
         nVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5LXW22aAYf3JYOoV/0hwKSIkX/UUO5en8X4dxPYEY1s=;
        b=sHEBpKP9QI2BrJPoCXhXfiDUl2dKUjDQyYaxW4hUWfeMp7C5MS7WrNVyUR4f3GqiUP
         nCG5lvxTY+uYl3PB4JnTO+jXcT+dhSnbIfja0DLZIkZOf3ZHqGuwolBbQsfvlOg/0M/C
         h/gviqdqPV1JlkyTL3+HxWHvQszj7ynuA3P6FQq86k7gGIq7Bi+i9GNEUS/hqILGu4Th
         W+XBmmJuwjnqYJ7cR2c078n50SOkJ5G7jRkYTfyVrP54kKU3Z+YyvubCVC8l6O3xwkPa
         aSUY8YWBNYuvVkrbMyA7jcbGPgooSeoS1hfkaEf5A48foZEe931SmQJq8k624WhUBL+2
         crEw==
X-Gm-Message-State: AOAM530RvWv7q2rqWnD+TLzw+WPIGu8vjMIZjrfE6Os5A+KcYJX+ovn9
        OfxImRsyKgg99jexkXdHOc1ZlA==
X-Google-Smtp-Source: ABdhPJyvCb7GcoPdJyZMc6cj+kOhTE3OZTR/Xj/QD11sDEmPGnbI8iYIhL9yn34zhS17FaTFLJRjWQ==
X-Received: by 2002:a19:e44:: with SMTP id 65mr19430477lfo.344.1617092779756;
        Tue, 30 Mar 2021 01:26:19 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id w12sm2723334ljm.50.2021.03.30.01.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 01:26:19 -0700 (PDT)
Date:   Tue, 30 Mar 2021 10:26:17 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tee: optee: fix build error caused by recent optee
 tracepoints feature
Message-ID: <20210330082617.GA971075@jade>
References: <20210325120601.71584253@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210325120601.71584253@xhacker.debian>
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

I've picked up this.

Thanks,
Jens
