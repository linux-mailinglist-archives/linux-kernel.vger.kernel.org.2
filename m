Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36B331FD44
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhBSQin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhBSQi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:38:29 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E2FC06178A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 08:37:48 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id d20so4990437ilo.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 08:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QopIIrFF742BKqlOh4+TqmLjkxOTaJiQM9hc+/gnVxg=;
        b=xldRnNMtCqOBtzAdSkbWqDWK1ZbBF6xEYQZCfkn3Y7jcOIl3VVDqypJDMNaSi54KE1
         w5LVCAGlgEGfzdrZ86fr6IYN3EPax5C50K8P9YGyH/PbZ8Zx/hY+CcxcvvcchvODNXc2
         WyorXES1uKg5brfvrOuCQ9Ht4vWMeJGjFEO4hmvtMwWoEPHyuh1tfidic+3IF3ctBVet
         KDCu+30h/EzmrPC3/j8Sqjhcru3Z1CLS3vGB5FZryibLYYvzatBb7tPPkHfEUXFkobqm
         Q4nit8t2eBFzFSSdjciLL3gsu9vjwjHTERF2kHJrZViI4kb20kuxpp0LRFLcw/GBHMaD
         BUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QopIIrFF742BKqlOh4+TqmLjkxOTaJiQM9hc+/gnVxg=;
        b=DTWpLXZ+GMFE7RgCrkgg1GanJiFFQ9s0l6hgtR7cW7tCBueHmBuL6xkHzFwB4zZ65M
         wmai5gZ08+Qs/bhWCv8FLmMEnGj9I/t7jNPMqW1yzEU/XbE2TSh7xUXdS0Oe0Eg0vn1w
         JroVk8WaFY6muTU70GXr8BO3DR0i+roAFLh3bpJuNOdFUm0J6D/NoQqgJj7eS+MuEe7/
         Ka9U22SHg/2kFyAGRlliKb0GZIz6LWiv+ifGtvGElM5lW/VVwH9+E1f+kckPG93nkIO3
         Xdmn8sof3y3Zp4VG2AkUYxt4TVf/kya51TMy42oK2CbsUjoTEiuCC8AJ1dd5nlbmIZr1
         /6tQ==
X-Gm-Message-State: AOAM532kcbxqGh/BqPZHFJptEj5c7hVFT5om5j5lfnx0Rn19OKzq9Vcm
        nLqdI0WAb521EEPkWZaMeEc/Yw==
X-Google-Smtp-Source: ABdhPJxaKeetAYFXJydsPreGczSfycYq3Pg3RINKEm67oHsdXLXdiZ/SpgwXBek/ZmbU589cfA+RMQ==
X-Received: by 2002:a05:6e02:13eb:: with SMTP id w11mr4524720ilj.103.1613752667719;
        Fri, 19 Feb 2021 08:37:47 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g3sm6741393ile.10.2021.02.19.08.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Feb 2021 08:37:47 -0800 (PST)
Subject: Re: [next]: fs/io_uring.c:6171:10: error: implicit declaration of
 function 'io_sendmsg_prep_async'; did you mean 'io_req_prep_async'?
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-mips@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        io-uring@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <CA+G9fYt1Bk=DW1VoPgWe9ZHHoHu+6OyZi7ndMJHmoR14uJePyQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b4c660b0-ab0e-ec4c-2771-346ca164bf92@kernel.dk>
Date:   Fri, 19 Feb 2021 09:37:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYt1Bk=DW1VoPgWe9ZHHoHu+6OyZi7ndMJHmoR14uJePyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/21 9:08 AM, Naresh Kamboju wrote:
> Linux next tag 20210219 arm and mips builds failed due to below error.
> 
> Following build configs failed
> arm (s3c6400_defconfig) with gcc-8
> arm (s3c6400_defconfig) with gcc-9
> arm (s3c6400_defconfig) with gcc-10
> 
> mips (e55_defconfig) with gcc-8
> mips (e55_defconfig) with gcc-9
> mips (e55_defconfig) with gcc-10
> 
> fs/io_uring.c:6171:10: error: implicit declaration of function
> 'io_sendmsg_prep_async'; did you mean 'io_req_prep_async'?
> [-Werror=implicit-function-declaration]
>    return io_sendmsg_prep_async(req);
>           ^~~~~~~~~~~~~~~~~~~~~
>           io_req_prep_async
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

This should fix it, cleaning it up a bit at the same time.


commit b1c892df32ebf6f30c995e23dcafeae2392ad1bc
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Feb 19 09:35:19 2021 -0700

    io_uring: make the !CONFIG_NET helpers a bit more robust
    
    With the prep and prep async split, we now have potentially 3 helpers
    that need to be defined for !CONFIG_NET. Add some helpers to do just
    that.
    
    Fixes the following compile error on !CONFIG_NET:
    
    fs/io_uring.c:6171:10: error: implicit declaration of function
    'io_sendmsg_prep_async'; did you mean 'io_req_prep_async'?
    [-Werror=implicit-function-declaration]
       return io_sendmsg_prep_async(req);
                 ^~~~~~~~~~~~~~~~~~~~~
                 io_req_prep_async
    
    Fixes: 93642ef88434 ("io_uring: split sqe-prep and async setup")
    Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/fs/io_uring.c b/fs/io_uring.c
index b7bae301744b..c9a5c498dc3b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5127,56 +5127,32 @@ static int io_connect(struct io_kiocb *req, unsigned int issue_flags)
 	return 0;
 }
 #else /* !CONFIG_NET */
-static int io_sendmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
-{
-	return -EOPNOTSUPP;
-}
-
-static int io_sendmsg(struct io_kiocb *req, unsigned int issue_flags)
-{
-	return -EOPNOTSUPP;
-}
-
-static int io_send(struct io_kiocb *req, unsigned int issue_flags)
-{
-	return -EOPNOTSUPP;
-}
-
-static int io_recvmsg_prep(struct io_kiocb *req,
-			   const struct io_uring_sqe *sqe)
-{
-	return -EOPNOTSUPP;
-}
-
-static int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
-{
-	return -EOPNOTSUPP;
-}
-
-static int io_recv(struct io_kiocb *req, unsigned int issue_flags)
-{
-	return -EOPNOTSUPP;
-}
-
-static int io_accept_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
-{
-	return -EOPNOTSUPP;
-}
-
-static int io_accept(struct io_kiocb *req, unsigned int issue_flags)
-{
-	return -EOPNOTSUPP;
-}
-
-static int io_connect_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
-{
-	return -EOPNOTSUPP;
-}
-
-static int io_connect(struct io_kiocb *req, unsigned int issue_flags)
-{
-	return -EOPNOTSUPP;
-}
+#define IO_NETOP_FN(op)							\
+static int io_##op(struct io_kiocb *req, unsigned int issue_flags)	\
+{									\
+	return -EOPNOTSUPP;						\
+}
+
+#define IO_NETOP_PREP(op)						\
+IO_NETOP_FN(op)								\
+static int io_##op##_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe) \
+{									\
+	return -EOPNOTSUPP;						\
+}									\
+
+#define IO_NETOP_PREP_ASYNC(op)						\
+IO_NETOP_PREP(op)							\
+static int io_##op##_prep_async(struct io_kiocb *req)			\
+{									\
+	return -EOPNOTSUPP;						\
+}
+
+IO_NETOP_PREP_ASYNC(sendmsg);
+IO_NETOP_PREP_ASYNC(recvmsg);
+IO_NETOP_PREP_ASYNC(connect);
+IO_NETOP_PREP(accept);
+IO_NETOP_FN(send);
+IO_NETOP_FN(recv);
 #endif /* CONFIG_NET */
 
 struct io_poll_table {

-- 
Jens Axboe

