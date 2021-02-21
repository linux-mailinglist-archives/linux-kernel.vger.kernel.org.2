Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0AD320E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 00:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhBUXi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 18:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbhBUXiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 18:38:55 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFF5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 15:38:15 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id t26so9150798pgv.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 15:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ewxqEQFZCqRPZepFJZrArWqJzNzRyrMy8DlI7kZWdbY=;
        b=tBabDsQM88C48+TrDFasmGxRf9lo5KwLdwTxTlg6mOAIgYZzAu1QYqLxKOml6fQOpU
         sRCdc7uSzDIWN6ysldM0C5UOcR78C8eihFm52FXeZeU+HQ4csvIauJLeaLgfzaUJ8Qnr
         5JJNoaB/g4w2yfmgFyCLRE7Ps4aKp6JA1lhrUFiAc2A2JIjLe+3z1R0c/lJrPe9Ll3N/
         J2mJXNLavJiiqF/v9E+t0MVLpwv3xigXA33nIZlLGhFCGxR2J11FiNfdpT0diMrfrxQE
         imsmjKZfRkFo6vfVn41CuIorDhu+QEmQ3y9hFxktPLlCaY0wJ8AWWG96mxJpPBkj7MRL
         K8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ewxqEQFZCqRPZepFJZrArWqJzNzRyrMy8DlI7kZWdbY=;
        b=IRaaElX4TjwXkGFFtab/L1LEDeamjhfw/5txgHc5h7dpQWZyKIwiQo5sB4KF7G6nNT
         vDGSeUrw0MXo5YyVUUMJvROJli/PzS2J1DTaTjTbJbm8YJfLRGf01cu0paj/TF1mgR6H
         vFCjbZH7mNJspsGluNI9VW3bsdxSFn5+ae8fRKoc3UPLioQvtZ3n7ZENxAHdtIdac+Bj
         Yl9Lxvq1Bye2quE0raLPgsLsJLMVvQhBxp+S3FQdtjgMSxPLjU3Izi8gyN0f92a5RaI+
         Inz7Fuxdlsz8Ph7QmMJLUyubuVTHe4+K4lY3XANJKAtCFqsLpzXhE9oN8WWLbZkfGiI7
         RG8Q==
X-Gm-Message-State: AOAM530AuYRqWMwrOG2M2IfZzBL0PIeSx2lAf7le0zcTghkI8I7x205z
        fexUPTAlkBkBlTDf+rbErn29aQ==
X-Google-Smtp-Source: ABdhPJzdBl7iEW57AktQz1trvZZaWXb2g0jBAcCa1BGnJzyovv2hB07dcYLx+z1UHy8R8jqqeRueQA==
X-Received: by 2002:a63:c042:: with SMTP id z2mr17881788pgi.201.1613950692408;
        Sun, 21 Feb 2021 15:38:12 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id h20sm15842126pfv.164.2021.02.21.15.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Feb 2021 15:38:11 -0800 (PST)
Subject: Re: [PATCH v6 3/7] Reimplement RLIMIT_NPROC on top of ucounts
To:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-mm@kvack.org
Cc:     Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <cover.1613392826.git.gladkov.alexey@gmail.com>
 <72fdcd154bec7e0dfad090f1af65ddac1e767451.1613392826.git.gladkov.alexey@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <72214339-57fc-e47f-bb57-d1b39c69e38e@kernel.dk>
Date:   Sun, 21 Feb 2021 16:38:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <72fdcd154bec7e0dfad090f1af65ddac1e767451.1613392826.git.gladkov.alexey@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/21 5:41 AM, Alexey Gladkov wrote:
> diff --git a/fs/io-wq.c b/fs/io-wq.c
> index a564f36e260c..5b6940c90c61 100644
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -1090,10 +1091,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
>  		wqe->node = alloc_node;
>  		wqe->acct[IO_WQ_ACCT_BOUND].max_workers = bounded;
>  		atomic_set(&wqe->acct[IO_WQ_ACCT_BOUND].nr_running, 0);
> -		if (wq->user) {
> -			wqe->acct[IO_WQ_ACCT_UNBOUND].max_workers =
> -					task_rlimit(current, RLIMIT_NPROC);
> -		}
> +		wqe->acct[IO_WQ_ACCT_UNBOUND].max_workers = task_rlimit(current, RLIMIT_NPROC);

This doesn't look like an equivalent transformation. But that may be
moot if we merge the io_uring-worker.v3 series, as then you would not
have to touch io-wq at all.

-- 
Jens Axboe

