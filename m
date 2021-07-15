Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCD53CA50A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 20:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbhGOSOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 14:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbhGOSOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 14:14:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB5CC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:11:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id v20so10751623eji.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xFNcy37c+BnJmbGuVLgBOx81eX2e2c/KJb9k8Y2Otp4=;
        b=KM/X5+2FdDaB+GeERQSAkF2pO4RsG3QXA+s39Eut0Wy4eYIF8KVO+vM4tDdpJm5mZ2
         sL6jpjuL92+pP6d7x8aUW/1RsWoZrVr/tDzuttsoiBsdA11B1VdDFDqkY8VCnfkBd1ZQ
         mzKz6IuD4fYuPbPlCGvN+i8sO1l5kVVanwMfmWxJ2FRK+ZeYY2aHVTAWz28dD2zxrmvB
         4i7Y7RGFm63mwaipFdUCyea2doWi5l4JcQK6GSrV0dub7ISBNtSjiB8CHxQWv55pJ9mV
         yi7mAxXcj6ruq+lGocXldjSyg8zn9APwMfsU1bCAc+5bhjgiSdRvnplgBHZCEilqQQLN
         ZQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFNcy37c+BnJmbGuVLgBOx81eX2e2c/KJb9k8Y2Otp4=;
        b=PRBHke0rtC76gSxvLxgVZ5LBt9AHbopmVDGJWA/7eWP9/V/l2CXdbWBa6hnVNc1lvO
         JvArEV3qivwAdpw1r0cZDTbtQpDlevpxFlE7bq3JLlhKrp8IHq6EhiuoArUFFiukSDlc
         N0Fy5Tai2fFANxoinFMxUTLzjVVPd/bLrXIocNbID2p2jDplT3IzwsEBRU2Q6ffgG/aT
         oMMtv+YQhOxK2HFb6Q+/Ea5ehjQ/iuRF8Y9HyOF3OCRaThiZpcPYZsUAj/T6ybDOTm5O
         SpW90MIxmw35/m5MdQ6LrHCP0hxwmmeYhk7epm+5hrrb/d2NRKQrDwr8tDdCNS0gwlUu
         ITuQ==
X-Gm-Message-State: AOAM531k3WvYDOawEmlhG5+5hlMguC+UoaD3mdKmOOrD5NF5WGhTlX67
        iISYUFOuCQD3qH756wFm+h6P5s8JoSiZ/6puX8uJnQ==
X-Google-Smtp-Source: ABdhPJw20x8zM9yk0v6py5sxnw1GfLqy7pUfvhYM1HI/OSIxyiJ+BqGcVW7bi0WRGjmMuAfSCpW6oa+KgojFjhu4Z04=
X-Received: by 2002:a17:906:c14a:: with SMTP id dp10mr7112755ejc.426.1626372687355;
 Thu, 15 Jul 2021 11:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626371112.git.zhansayabagdaulet@gmail.com> <343394260f599d940cacc37f1dcc0309239ae220.1626371112.git.zhansayabagdaulet@gmail.com>
In-Reply-To: <343394260f599d940cacc37f1dcc0309239ae220.1626371112.git.zhansayabagdaulet@gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 15 Jul 2021 14:10:51 -0400
Message-ID: <CA+CK2bDT4cnqNNtP-vXqvnt=s+HhZ6_PZ1Vu=qXPbMYzQRUqUw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: KSM: fix ksm_run data type
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 2:01 PM Zhansaya Bagdauletkyzy
<zhansayabagdaulet@gmail.com> wrote:
>
> ksm_run is declared as unsigned long but in run_store(), it is converted
> to unsigned int. Change its type to unsigned int.
>
> Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
> ---
>  mm/ksm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 3fa9bc8a67cf..057d0c245bf4 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -289,7 +289,7 @@ static int ksm_nr_node_ids = 1;
>  #define KSM_RUN_MERGE  1
>  #define KSM_RUN_UNMERGE        2
>  #define KSM_RUN_OFFLINE        4
> -static unsigned long ksm_run = KSM_RUN_STOP;
> +static unsigned int ksm_run = KSM_RUN_STOP;
>  static void wait_while_offlining(void);
>
>  static DECLARE_WAIT_QUEUE_HEAD(ksm_thread_wait);
> @@ -2874,7 +2874,7 @@ KSM_ATTR(pages_to_scan);
>  static ssize_t run_show(struct kobject *kobj, struct kobj_attribute *attr,
>                         char *buf)
>  {
> -       return sysfs_emit(buf, "%lu\n", ksm_run);
> +       return sysfs_emit(buf, "%u\n", ksm_run);

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
