Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24122354AF7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 04:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243451AbhDFCja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 22:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243433AbhDFCj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 22:39:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DCAF6128B;
        Tue,  6 Apr 2021 02:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617676761;
        bh=L4PfP8buDB33UfXmw4tX5ALYPYBeDUt2Tu5w7JmPnvs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D0tF+xWUeMfv4pAW2V0LFNUNqsek+Smyl/L1Y6D0lLskxx164M2H3YWzJuNdfDBai
         zlUz8MQw+4JFuv+RFadabuadWWeGBqh97bp2nkWF3SgrxtuP0TzTs5OpzRhHnyy/3d
         nKySkL99Y5uDpBVrczpQ1K719THS7UtZnjsgmAGA=
Date:   Mon, 5 Apr 2021 19:39:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH-next 2/5] lib/test_vmalloc.c: add a new 'nr_threads'
 parameter
Message-Id: <20210405193920.46d3792200ad05f4a7c66829@linux-foundation.org>
In-Reply-To: <20210403123143.GA38147@pc638.lan>
References: <20210402202237.20334-1-urezki@gmail.com>
        <20210402202237.20334-2-urezki@gmail.com>
        <20210402145934.719192be298eadbeecb321d2@linux-foundation.org>
        <20210403123143.GA38147@pc638.lan>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Apr 2021 14:31:43 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:

> > 
> > We may need to replaced that kcalloc() with kmvalloc() though...
> >
> Yep. If we limit to USHRT_MAX, the maximum amount of memory for
> internal data would be ~12MB. Something like below:
> 
> diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> index d337985e4c5e..a5103e3461bf 100644
> --- a/lib/test_vmalloc.c
> +++ b/lib/test_vmalloc.c
> @@ -24,7 +24,7 @@
>         MODULE_PARM_DESC(name, msg)                             \
> 
>  __param(int, nr_threads, 0,
> -       "Number of workers to perform tests(min: 1 max: 1024)");
> +       "Number of workers to perform tests(min: 1 max: 65536)");
> 
>  __param(bool, sequential_test_order, false,
>         "Use sequential stress tests order");
> @@ -469,13 +469,13 @@ init_test_configurtion(void)
>  {
>         /*
>          * A maximum number of workers is defined as hard-coded
> -        * value and set to 1024. We add such gap just in case
> +        * value and set to 65536. We add such gap just in case
>          * and for potential heavy stressing.
>          */
> -       nr_threads = clamp(nr_threads, 1, 1024);
> +       nr_threads = clamp(nr_threads, 1, 65536);
> 
>         /* Allocate the space for test instances. */
> -       tdriver = kcalloc(nr_threads, sizeof(*tdriver), GFP_KERNEL);
> +       tdriver = kvcalloc(nr_threads, sizeof(*tdriver), GFP_KERNEL);
>         if (tdriver == NULL)
>                 return -1;
> 
> @@ -555,7 +555,7 @@ static void do_concurrent_test(void)
>                         i, t->stop - t->start);
>         }
> 
> -       kfree(tdriver);
> +       kvfree(tdriver);
>  }
> 
>  static int vmalloc_test_init(void)
> 
> Does it sound reasonable for you?

I think so.  It's a test thing so let's give testers more flexibility,
remembering that they don't need as much protection from their own
mistakes.

