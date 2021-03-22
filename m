Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A572A344EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhCVSma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbhCVSmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:42:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14951C061574;
        Mon, 22 Mar 2021 11:42:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o16so18262924wrn.0;
        Mon, 22 Mar 2021 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NDKS9bjDkSd8pyAADwHG0veM+Jj9ek5ktbAJaPyPQgc=;
        b=emIMhnyCmYiLn4PObMyhcg2fhCLigz+fBkhgy0+aFcI3EPJ3FRvS7C4UHcIdwVxtuM
         Hynhkh/RozexhQ9rnv8mDb8nFZF+99Gpf66DTi3VANzzZadiVk5DRMshYKacz/7aWvmr
         kigEp1Dia7ZVb7btg371ph4jCCacQqnPq7mnIlTVfj+CbKCIGiTTrpFROod2gPHryY1t
         DgQONC+TEshODeDBdfd6E1dUviDOuqcGCxCMP8KQMaIMqnrn9KLUp/fFZW+B5cwdQqBM
         3q300E0NWGRWozZRHaJDh6y5PN6s/Lnk3UWMyd2+QEA52VxPeeBng1UC6dbj7nB+U2wF
         9BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NDKS9bjDkSd8pyAADwHG0veM+Jj9ek5ktbAJaPyPQgc=;
        b=G+D6VnSHAbp13ZauKZcgLI4BSW2KvzcoY++8PjizhU6pq07LG5MII27bcQwnrd2OzR
         Z7WsJu3sspnvqU98rvm+i3OmrwtXJ5RGW+chSIdgE3RzfnFo0HiyOyMImIfFMW2ZdRcc
         X/fUgD2uc3UF6Fj8MY2r6+TzvoPtR3OrhbvYtrTw6ooxHMVE5M2VP/w+UdEbtRVYKF+i
         icmnaBoZBqoafWY1NIiJeKoYSTlThB81UsL9hxiftVDtwFyL3vKQqf61+YusyhqkP6ZL
         tfLglNtvXP9Th2Hz3Oy1aWNFTELH4zoJwcN206vVVA9T4GmeN87sM/fG6wvXXyF7asm8
         LTXg==
X-Gm-Message-State: AOAM533AD4hFbIG/XJynQEXCwtTNvr+8NEw9K7zEJX+iRaOSvmwesa1c
        p7zHuv/pv5CTU7v+lRwGT9s=
X-Google-Smtp-Source: ABdhPJwuVapglcJc4ltYexF/7Sif9Q08VJfCe1k1gPwDscYvvPZJHxzLANP0CG8UOT8s73OkKojbyw==
X-Received: by 2002:adf:fbcc:: with SMTP id d12mr897295wrs.151.1616438525814;
        Mon, 22 Mar 2021 11:42:05 -0700 (PDT)
Received: from LEGION ([111.119.187.31])
        by smtp.gmail.com with ESMTPSA id g5sm21178867wrq.30.2021.03.22.11.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 11:42:05 -0700 (PDT)
Date:   Mon, 22 Mar 2021 23:41:58 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        colin.king@canonical.com, dan.carpenter@oracle.com
Cc:     musamaanjum@gmail.com
Subject: [PATCH] io_uring: Initialize variable before use
Message-ID: <20210322184158.GA2095479@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) Initialize the struct msghdr msg in the start of the function
2) Uninitialized variable msg.msg_flags can get used if branch happens to
out_free before initialization.

So initialize variable in question in the start of the function for
simplicity in logic and use.

Addresses-Coverity: ("Uninitialized variable")
Addresses-Coverity: ("Uninitialized variable read")
Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 fs/io_uring.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index bba74631954b..d5f83326abff 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4677,7 +4677,8 @@ static int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_buffer *kbuf;
 	struct io_sr_msg *sr = &req->sr_msg;
-	struct msghdr msg;
+	struct msghdr msg = {.msg_name = NULL, .msg_control = NULL, .msg_controllen = 0,
+			     .msg_namelen = 0, .msg_iocb = NULL, .msg_flags = 0};
 	void __user *buf = sr->buf;
 	struct socket *sock;
 	struct iovec iov;
@@ -4701,13 +4702,6 @@ static int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 	if (unlikely(ret))
 		goto out_free;
 
-	msg.msg_name = NULL;
-	msg.msg_control = NULL;
-	msg.msg_controllen = 0;
-	msg.msg_namelen = 0;
-	msg.msg_iocb = NULL;
-	msg.msg_flags = 0;
-
 	flags = req->sr_msg.msg_flags | MSG_NOSIGNAL;
 	if (flags & MSG_DONTWAIT)
 		req->flags |= REQ_F_NOWAIT;
-- 
2.25.1

