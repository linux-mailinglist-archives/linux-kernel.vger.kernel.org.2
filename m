Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A05B345CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhCWLYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhCWLYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:24:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64BDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 04:23:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jy13so26439244ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 04:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w2mw+IKy+QrhKxllQ8y4LIdko3rj7rSdl88PKxiyefM=;
        b=X0TTrJdmjHuSIk+LOr9SUK5uEbvkSjTc1JpNAFLcEMYV0JhCw+8mxPepc7UrqlOqHx
         iIgKvVwrXB2/BySvG4LwQ9lbBab/13690lXM9h12dVy7kJHa8S0kvBKX7pYJ/hZqfcZv
         5txEpj9Xu1rRgl874PtpLYbqVTIUyBNO7WtlCBEjUuCweOu/G8omPMYWkEaHINlRqxxn
         hM/APujpCNeXpI/++joSZafQyGPQutdZU558cNvKDO03kkGOa+B0tkaiBEWgcKuonhX8
         28I12IlVdu8Pfo7Y4RYkEg7Yrbwm3dzF2hDniLaiSGfANmq9InznLzfzIyem5ehwY3hX
         SGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=w2mw+IKy+QrhKxllQ8y4LIdko3rj7rSdl88PKxiyefM=;
        b=P2iJhecxP29dj+8S2GIRcT5NVtFvzsoXYXewjOEdX8D4SqBXZOGDaZmuilohYm5/Vv
         bBUOG3O7tAouP+0HM5Q8YxacBxzIVbYN27vYF9tVfRmWRBmKs1t3IEsM1e7js5wjgp5t
         fwEi35znLivdTQa0XI4VL9AAVayV0tfH1RfvGbUKKl8YvoyGax2MaWyXlTQXuRIMwFct
         dHOLf/FCoC7h1Mxjc70YVvLGb4f2Jwu2k9fRaOIUD1tbcJ/Ls5kIUCjU5owHt3/jbFw8
         P3e7BKXl0qFC3xTQxF7h1F+Dvtpjw1cQY/f5zuI+J3Nio+4xY1L6knqI7kmaGzdieIF5
         3Kww==
X-Gm-Message-State: AOAM531sSHUAqRM+rwHFykL1brO0PjoLPq1xl3GYOe7oxl30gHhWYCxy
        eaFJ1bezdZMD/NNQDHDzjUw=
X-Google-Smtp-Source: ABdhPJy7Ks+XyG8kYY3wAddgRtTyFGomWJfgnpGMbZ7iUi13YceTbgSfbahwTSjSyxL4wdZUgNYajA==
X-Received: by 2002:a17:906:81c9:: with SMTP id e9mr4364420ejx.456.1616498638748;
        Tue, 23 Mar 2021 04:23:58 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id mc10sm10837835ejb.56.2021.03.23.04.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 04:23:58 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 23 Mar 2021 12:23:56 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] locking/mutex: Remove repeated declaration
Message-ID: <20210323112356.GC3939639@gmail.com>
References: <1616461774-18644-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616461774-18644-1-git-send-email-zhangshaokun@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:

> Commit 0cd39f4600ed ("locking/seqlock, headers: Untangle the spaghetti monster")
> introduces 'struct ww_acquire_ctx' again, remove the repeated declaration.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  include/linux/mutex.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index 0cd631a19727..d80c0e22c822 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -20,8 +20,6 @@
>  #include <linux/osq_lock.h>
>  #include <linux/debug_locks.h>
>  
> -struct ww_acquire_ctx;
> -
>  /*
>   * Simple, straightforward mutexes with strict semantics:
>   *

Please also group the pre-declarations together, that's the canonical 
pattern we use in headers.

I.e. have something like this at the top:

  struct ww_class;
  struct ww_acquire_ctx;

Thanks,

	Ingo
