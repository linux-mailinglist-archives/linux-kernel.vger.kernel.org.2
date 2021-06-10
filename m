Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFED3A21A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 02:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFJBAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 21:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJBAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 21:00:48 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5660C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 17:58:53 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id g142so18837026ybf.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 17:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3mjj4EoLZYxsLHjSbLAkAp/jjfexiG2VptOQzcXqoU=;
        b=SgDiv4QhKqgy5WXYeAH/beq4Vk5LNuXSW5kb7KV4j8p6ta5EM1fr/hDEKMzI760+X6
         DqTL57iqBxW2zab46r84n7ctXYoH0oefWWhYqjZbzK/pYsejzSBOEcmRUmCMktc/gaDI
         lhzrCbS+H7X+ciJWWl40yiLI4R9OZJPNHujmPIJwjX+rtKrY0Itbf6GwOGJOJ43YZXm/
         dWGOhY3w3I87Qrol4cX3/TUtRRbQE0uIkeAOsiv9p+xijbq7TwhFjzDIKUCcGH4ix8I7
         u4pR6eTwbH67UpP0d9woOWYUIV1LxRL+ALaU65ULyaFKKyMEEGG+o8PHOOua8IShAO8b
         xTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3mjj4EoLZYxsLHjSbLAkAp/jjfexiG2VptOQzcXqoU=;
        b=bAK9MZHkJ2MOZvRzfslwjfAYdp82c58gGoG/h1l8su5RUeilefDsGQNW4lfiSwhuZQ
         2IS9psuv//30CDaHtRGOYq8AS13Xzf+Rp/TV/K5Lu+1QHfAEx+VxWSO5EXtdftcpxCrY
         fbAjEBjBiYiLBaP5Mnyk8iEaKjk02QDLC4M9L0VsYavxms863bNmNZEtg4WsP0x6Xf8K
         v1gYGGRoRjSlnp1noSKLkDBeD4a+rXoqm7yUyx3L8FtQVVfQiT7P4uMs/K+TCJkCcFTO
         0C4LMU1yhJB1c3XtoQ815elybdqRTF+qjIXO3mArlqtb01Kz8XHwwnm6D+eDeOlsogmc
         9ucg==
X-Gm-Message-State: AOAM530qe+876vhqSFbvncsGczTW/V1MLKSd3dPXq5Pr6SjKNntlbiY4
        Hrb1y2R72XJcFGQ+1U2y5KBCH/IMogb6NYCqs3kv6g==
X-Google-Smtp-Source: ABdhPJygNH2KQD2QLuU+00UUWls3cXcHGHurfCUsUtT3Gxw2KRHz90Md89HnQ0zHjebLcMxtFCDhKfq2OcJkWCmk0LU=
X-Received: by 2002:a25:1ec2:: with SMTP id e185mr3796066ybe.23.1623286732601;
 Wed, 09 Jun 2021 17:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210430195232.30491-1-michel@lespinasse.org> <20210430195232.30491-9-michel@lespinasse.org>
In-Reply-To: <20210430195232.30491-9-michel@lespinasse.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 9 Jun 2021 17:58:41 -0700
Message-ID: <CAJuCfpG=q=PAX9+8hgH8v4Jz96qn6yKDZhno-0hSkAveWGDe8g@mail.gmail.com>
Subject: Re: [PATCH 08/29] mm: add FAULT_FLAG_SPECULATIVE flag
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 12:52 PM Michel Lespinasse
<michel@lespinasse.org> wrote:
>
> Define the new FAULT_FLAG_SPECULATIVE flag, which indicates when we are
> attempting speculative fault handling (without holding the mmap lock).
>
> Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
> ---
>  include/linux/mm.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8ba434287387..021fdab5b721 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -434,6 +434,7 @@ extern pgprot_t protection_map[16];
>   * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
>   * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
>   * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
> + * @FAULT_FLAG_SPECULATIVE: The fault is handled without holding the mmap_sem.

nit: s/mmap_sem/mmap_lock

>   *
>   * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
>   * whether we would allow page faults to retry by specifying these two
> @@ -464,6 +465,7 @@ extern pgprot_t protection_map[16];
>  #define FAULT_FLAG_REMOTE                      0x80
>  #define FAULT_FLAG_INSTRUCTION                 0x100
>  #define FAULT_FLAG_INTERRUPTIBLE               0x200
> +#define FAULT_FLAG_SPECULATIVE                 0x400
>
>  /*
>   * The default fault flags that should be used by most of the
> @@ -501,7 +503,8 @@ static inline bool fault_flag_allow_retry_first(unsigned int flags)
>         { FAULT_FLAG_USER,              "USER" }, \
>         { FAULT_FLAG_REMOTE,            "REMOTE" }, \
>         { FAULT_FLAG_INSTRUCTION,       "INSTRUCTION" }, \
> -       { FAULT_FLAG_INTERRUPTIBLE,     "INTERRUPTIBLE" }
> +       { FAULT_FLAG_INTERRUPTIBLE,     "INTERRUPTIBLE" }, \
> +       { FAULT_FLAG_SPECULATIVE,       "SPECULATIVE" }
>
>  /*
>   * vm_fault is filled by the pagefault handler and passed to the vma's
> --
> 2.20.1
>
