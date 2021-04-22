Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD21F3682D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 16:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbhDVO5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 10:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbhDVO5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 10:57:13 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC80EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 07:56:38 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id t17so18080327qkg.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 07:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9cZAWfImI6VLS+4QpAMj/1HbaXFkUQw52F6CC9VLM0Y=;
        b=XOvY2HS1G58unBxLg5ROQPBVXB2i1rtoWGc+bbXT+2vA7bCspRWZdgzAaCCZ0bsoeu
         0sF56VPYV5WfWMwnmZ3Wxy5UtjMzcrDiAqmNu/dR2bYadmmTBLf/iSiXxEjg/GGXuOxB
         mQDhMr9mzdoN6BH9LnOyrOJ8fRZwMpWjD26p+zcqf+J13OviGDOMnBODvZfMg016tALI
         qiyv/x7QuuGB5CZjIlcz701ylLLjRKDmO9O8eprkW2MllSn6Yaui2gI1s2o7s34ux3QI
         jegryPdr6Ar6NzYc3zJu60EBIyHDyIOrzPCcVgX/dgaHH1JrLhbUUe+0XNID6kKlHUJr
         3WYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9cZAWfImI6VLS+4QpAMj/1HbaXFkUQw52F6CC9VLM0Y=;
        b=Q2R2OdD/zwpe3OFK6SuqmSFHbmUpJDhtBpvF5TE8bfu1N5noAFwGSwBcUnjT+spktm
         k490conC/pqCS0XsjS1/5Dj5T9Njeo3jjDqs7P8htmD96FlQckJUziQz2wYoHKzEOt3A
         x9lNRylWq65U13otpb0VuJdGFVvygulNC9FKzGZKNLNIS235suVHK6u5BsUSWMwOC0fd
         73m8bdR5/EQNOp8e+2e7OGQTaLAils0nLNSz/vC+Yrhov5Vbu5wC1g8xxKcaf4scKfOe
         qo0ORcFHojW7o+lwMbAPmlwGp/jLAw1/cibnmtBy05GlOsWeSRfufiTdwUrdbjGnf+zY
         QBoQ==
X-Gm-Message-State: AOAM531U3Jo9qaWlqt0mNp5GEs+jjZN4Shg0+3aplGaR2iSi4wvrL6m5
        2uqPIyFtHsz4Uxyjzww/U/RxPXYbH5Zix4OhYjdM2w==
X-Google-Smtp-Source: ABdhPJxFW03kYV1p+C7svvmXCA8kbvcMHwdxhGDs5AuWcLYnO3Ok1b8fiJ6ENnUdOk4iCG1afoKrJZRnyTQwB3rWzc8=
X-Received: by 2002:a05:620a:52d:: with SMTP id h13mr4127770qkh.472.1619103397954;
 Thu, 22 Apr 2021 07:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <YIE90PSXsMTa2Y8n@mwanda>
In-Reply-To: <YIE90PSXsMTa2Y8n@mwanda>
From:   Patrick Venture <venture@google.com>
Date:   Thu, 22 Apr 2021 07:56:27 -0700
Message-ID: <CAO=notzLH4reOAVu9t=81th+dS52BvBURKveHbg4wDjbdhbH5w@mail.gmail.com>
Subject: Re: [PATCH] soc: aspeed: fix a ternary sign expansion bug
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        Jae Hyun Yoo <jae.hyun.yoo@intel.com>,
        John Wang <wangzhiqiang.bj@bytedance.com>,
        Brad Bishop <bradleyb@fuzziesquirrel.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Lippert <rlippert@google.com>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 2:12 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The intent here was to return negative error codes but it actually
> returns positive values.  The problem is that type promotion with
> ternary operations is quite complicated.
>
> "ret" is an int.  "copied" is a u32.  And the snoop_file_read() function
> returns long.  What happens is that "ret" is cast to u32 and becomes
> positive then it's cast to long and it's still positive.
>
> Fix this by removing the ternary so that "ret" is type promoted directly
> to long.
>
> Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Patrick Venture <venture@google.com>
> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> index 210455efb321..eceeaf8dfbeb 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -94,8 +94,10 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
>                         return -EINTR;
>         }
>         ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
> +       if (ret)
> +               return ret;
>
> -       return ret ? ret : copied;
> +       return copied;
>  }
>
>  static __poll_t snoop_file_poll(struct file *file,
> --
> 2.30.2
>
