Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188293B54A7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 20:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhF0S11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 14:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231359AbhF0S10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 14:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624818302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HGYAo7mGCSBM8kbRddWOTZlrEzJRYjIqLkPhMmgOzZ8=;
        b=SNTbe+etJn5AvcS1ttZNKLcB7OENmvcg7srvpp0cn5hgoKUUfpuL2fE0+YduW5deOoyfJc
        DwUP3JQNQyHIh0+aDD3drwzOFYoUM/3NHhW/6Xh1jvnGdC4KXe2eiqUesL8Z07Ig64cpBD
        tIAeNxsmdW0hxzZ1aqw+xHY3TkalWgQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-P2rsYz-zPyCqXCc6Nvqjfg-1; Sun, 27 Jun 2021 14:24:59 -0400
X-MC-Unique: P2rsYz-zPyCqXCc6Nvqjfg-1
Received: by mail-lj1-f197.google.com with SMTP id i17-20020a2e86510000b0290176c643f27fso2910492ljj.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 11:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HGYAo7mGCSBM8kbRddWOTZlrEzJRYjIqLkPhMmgOzZ8=;
        b=JqdtHfyi/fM8YUnWBcOKxI0jQ+oe73GoHR8yjLvVRBU5JmoSYnJI91lDvHi75X3S6u
         Slx8iZmqrlDHuMoE38MY6HuCO7ommqVknEFDcpJzyLkcVvsmF+IK2/F/vMEbClalhSEk
         BvbTCXismDIGuDz0QIkdxfc8HsYm4eH5eeZ/WKe1N4vKLpQ8apsBZCW649jKJPB6rqgp
         gBovXG3Gb8nkWjj94cQ7bMGC2cJVZqh2H546p6wMflMGReHY+Q/9JC6pDkXBlDargn4V
         IhnsQup3UHNR0TxXvw7nTDYFYNFw5DaweXL4RPFnJGbMA0KNpIXNzWImARDJ68+cbmLB
         CjNw==
X-Gm-Message-State: AOAM531Jc4yECqq0Bisj+4k5Mo9SWhv7vbKlZ1JHNuhAdTfYqxHRCUBs
        4Y0yQc1Vchyb+8DC2anppGZFOcnXZ7NC9SJgHhhkL2w883jVjlhwZeRTM/xUtpqZEl8rcbChkkL
        umRJa1dkalIIrpReZFsnn0KPIr3iyqH8kzh0Nm3Jy
X-Received: by 2002:a2e:9e95:: with SMTP id f21mr16400300ljk.137.1624818298088;
        Sun, 27 Jun 2021 11:24:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKzZt8JyDg++2kt/4dDCHatqBvHPZK8S5XqkKnwaHWtFhzeeJSq00dxoISrJxQjRu9yHDJChrj/LvtejwzLog=
X-Received: by 2002:a2e:9e95:: with SMTP id f21mr16400285ljk.137.1624818297856;
 Sun, 27 Jun 2021 11:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <162474059066.395.17544610641097100087.tip-bot2@tip-bot2>
In-Reply-To: <162474059066.395.17544610641097100087.tip-bot2@tip-bot2>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Sun, 27 Jun 2021 14:24:46 -0400
Message-ID: <CAFki+Lmu5ARgqYFxtFho+sUke9eg9=ZMTQbA1JVoJQqGeYRd5g@mail.gmail.com>
Subject: Re: [tip: timers/core] time/kunit: Add missing MODULE_LICENSE()
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 4:51 PM tip-bot2 for Thomas Gleixner
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the timers/core branch of tip:
>
> Commit-ID:     34c7342ac1b4e496315fb615d2a1309df8400403
> Gitweb:        https://git.kernel.org/tip/34c7342ac1b4e496315fb615d2a1309df8400403
> Author:        Thomas Gleixner <tglx@linutronix.de>
> AuthorDate:    Sat, 26 Jun 2021 22:44:11 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Sat, 26 Jun 2021 22:47:32 +02:00
>
> time/kunit: Add missing MODULE_LICENSE()
>
> Reported-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/time_test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
> index 341ebfa..a064a7c 100644
> --- a/kernel/time/time_test.c
> +++ b/kernel/time/time_test.c
> @@ -96,3 +96,4 @@ static struct kunit_suite time_test_suite = {
>  };
>
>  kunit_test_suite(time_test_suite);
> +MODULE_LICENSE(GPL);
>

This should be:
MODULE_LICENSE("GPL");
isn't it?

We will get a compilation error otherwise.


--
Thanks
Nitesh

