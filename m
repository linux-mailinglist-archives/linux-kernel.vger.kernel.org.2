Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7823C61A5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 19:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhGLRPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 13:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhGLRPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 13:15:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C26AC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 10:12:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a127so16999382pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+MqNZFYMQBihL0ZnQ18LtV00/u+f9r0ZXvs1SjqWuz8=;
        b=UOI+YQ1yAZu5INM6vP1vhH/OD5DCgJ9TYfw7jkklZkXHQJXqRXI6kJAQa6Y05PqSWr
         IUccdQRDCEBq75qsy+M4v5Zsa9eUPJil19UGq8aTVV1P+ugZyfPmaFCG0iHjUMvX6zy2
         cugkR2zOKIBfOxAUtpsv5m0vZ6GWUhB/AawNejyg5ncSMAh0aEE6oiQyRx9ZiBXcd8Yl
         r7N4wcehP3oGxrLX8yaNxu1Zg5K6t3ER8ai2c7vx24Oo5vDQYHXCn1ZHei/5hLvOf3pc
         EoOxvARt6Brj65wkUhRspI3A++vi59u2hCcCmQHXXtKR3jWxlMsJQf3ygdaeQf+7cgti
         uPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+MqNZFYMQBihL0ZnQ18LtV00/u+f9r0ZXvs1SjqWuz8=;
        b=faajsuFgTwTz90Vnl3B3tE0d1vvV5BPaRInc6M1dKnQbOErhYluyMdXTSxMsn8/JiM
         0lzFtieQr8iNN1p+MrNmViRc05t70Nz2Vmnm1hdfIWjY0guOyCv34RbH5hKe3s6kBrOy
         qLUMamtEdgEgtcO+bPBc1eEHOvLD11j6ubMtDSMUqfU8C1no8dfPeRzjuYFObIkMDzZv
         4SeZhJI9sypULkkX8VTxv1K9Bc1Yn9ksBpyE89BDylP1GkO6pBvv9obI3iDyD6f7QfJG
         AIP0hMYIxXfdI/F/w+BPrbrhpiNDtLYLgVjJcxyZw7grxI19DwEXVKqWAyUW+uyVyauo
         MWFQ==
X-Gm-Message-State: AOAM531/Prx2YSHU9CGu9n7WvAIqt4F1bFnxkdJBfaGAwPidaJNTuJwQ
        jfRwhH4ffvZPo20LVVBbV3o=
X-Google-Smtp-Source: ABdhPJyDLtGiKc/jvV5pIAf5hdHhyx0Yiw1NIfwLJNHR7yaBik6UNF9JtK3DAbEqFHxQU/HKd02w+w==
X-Received: by 2002:a63:7949:: with SMTP id u70mr166943pgc.168.1626109945735;
        Mon, 12 Jul 2021 10:12:25 -0700 (PDT)
Received: from localhost (udp264798uds.hawaiiantel.net. [72.253.242.87])
        by smtp.gmail.com with ESMTPSA id l3sm23098pju.57.2021.07.12.10.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:12:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Jul 2021 07:12:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        xuqiang36@huawei.com, paskripkin@gmail.com
Subject: Re: [PATCH v2] workqueue: fix UAF in pwq_unbound_release_workfn()
Message-ID: <YOx392cwdEHMMnD0@slm.duckdns.org>
References: <20210709071100.4057639-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709071100.4057639-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Yang.

> +static void free_pwq(struct pool_workqueue *pwq)
> +{
> +	if (!pwq || --pwq->refcnt)
> +		return;
> +
> +	put_unbound_pool(pwq->pool);
> +	kmem_cache_free(pwq_cache, pwq);
> +}
> +
> +static void free_wqattrs_ctx(struct apply_wqattrs_ctx *ctx)
> +{
> +	int node;
> +
> +	if (!ctx)
> +		return;
> +
> +	for_each_node(node)
> +		free_pwq(ctx->pwq_tbl[node]);
> +	free_pwq(ctx->dfl_pwq);
> +
> +	free_workqueue_attrs(ctx->attrs);
> +
> +	kfree(ctx);
> +}

It bothers me that we're partially replicating the free path including pwq
refcnting. Does something like the following work?

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 104e3ef04e33..0c0ab363edeb 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3693,7 +3693,7 @@ static void pwq_unbound_release_workfn(struct work_struct *work)
 	 * If we're the last pwq going away, @wq is already dead and no one
 	 * is gonna access it anymore.  Schedule RCU free.
 	 */
-	if (is_last) {
+	if (is_last && !list_empty(&wq->list)) {
 		wq_unregister_lockdep(wq);
 		call_rcu(&wq->rcu, rcu_free_wq);
 	}
@@ -4199,6 +4199,10 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 	}
 	put_online_cpus();
 
+	if (ret) {
+		flush_scheduled_work();
+	}
+
 	return ret;
 }
 
-- 
tejun
