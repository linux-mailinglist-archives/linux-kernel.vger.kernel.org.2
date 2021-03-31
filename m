Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0082734FB80
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhCaIZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhCaIZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:25:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D347BC061574;
        Wed, 31 Mar 2021 01:25:42 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 12so9710090wmf.5;
        Wed, 31 Mar 2021 01:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=QKFnYdgxCTs9FGGNMYff7ZI05Y1mnMJJCeghzxi1wSk=;
        b=qQRvPY4UJHmk29rpzNOc1Ns1R5raZhpNSxiACGDXuxaeVsNUw5d0IROLvR/PTKeubA
         fxVIGhLEnqzY97DL6nlbHzM9k2K5v2JrbEgiEYTRsOpgYoDqRP5ChkDvmcXTWSITqntC
         iVMZ40GkYBABn86vJN1Xo2D5fiI5a3g1H4ItolXfFkhiA7x3+XZ6YcCAMRBYpnRUBYhL
         qn099CPWet80p8qKDMj+lcciK+5Q0VubtRpIFmN8ORI/StVgcYtIk4qhLiLfxFQO448O
         F2/RSySLbC/5M+HcdPVI79fnDH/LhhJiycfA+23JZfDb4JfGhlE086QNtyrg4pmy4bCy
         AACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QKFnYdgxCTs9FGGNMYff7ZI05Y1mnMJJCeghzxi1wSk=;
        b=BHhvhZjotYQarEbnK3+eu/qBXnsc2ubupNVV1cFcLinm/eGcIMUhlwhoQUtmLa39AI
         iqE9IeQVr6LlH1GvA/BDL+0KG3BTSRUfTcNXd4Im2sMq0UHYMcMtGaOhiGOUEbod8MUA
         +RgZizRuM+QrUyHYRfcjCP2wWoWgss+wVsfQBGCZuenv3caTnZbW3rSGmUJdhtPd/Pv0
         tT95auiNLPGf4SLKFOPExNaIeuRtd+er5iSe67QGmu2g1vpI6G22WJSUhfLkAb3gL6vG
         w9PY2EFFP88ecgP+2X8MENWgmSc908O1/1NzZPa8V6cVRgdEcmfGIMJLNwrVR8hBx0Ka
         bnRw==
X-Gm-Message-State: AOAM530ir1B++bHUi6v/l5kMl047DzhVB9+wbsYvb1q6Fq6RsHSeYzrb
        r0cvvhskVA1fyNh9NTRiA54=
X-Google-Smtp-Source: ABdhPJzvsSIcCDvyjhMbOrngpcXKCqPlZhBnOo4C1/IjObcsdQd8Slw4UEqTL/seqDz2GuVeQ2yAoQ==
X-Received: by 2002:a1c:e18b:: with SMTP id y133mr2102174wmg.22.1617179141616;
        Wed, 31 Mar 2021 01:25:41 -0700 (PDT)
Received: from 192.168.10.5 ([39.46.7.73])
        by smtp.gmail.com with ESMTPSA id b131sm2842550wmb.34.2021.03.31.01.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 01:25:41 -0700 (PDT)
Message-ID: <39d9d56afe1418861aeb09d0b555b79bcd227e45.camel@gmail.com>
Subject: Re: [PATCH] io_uring: Initialize variable before use
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        colin.king@canonical.com, dan.carpenter@oracle.com
Cc:     musamaanjum@gmail.com
Date:   Wed, 31 Mar 2021 13:25:35 +0500
In-Reply-To: <20210322184158.GA2095479@LEGION>
References: <20210322184158.GA2095479@LEGION>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-03-22 at 23:41 +0500, Muhammad Usama Anjum wrote:
> 1) Initialize the struct msghdr msg in the start of the function
> 2) Uninitialized variable msg.msg_flags can get used if branch happens to
> out_free before initialization.
> 
> So initialize variable in question in the start of the function for
> simplicity in logic and use.
> 
> Addresses-Coverity: ("Uninitialized variable")
> Addresses-Coverity: ("Uninitialized variable read")
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---
>  fs/io_uring.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index bba74631954b..d5f83326abff 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -4677,7 +4677,8 @@ static int io_recv(struct io_kiocb *req, unsigned int issue_flags)
>  {
>  	struct io_buffer *kbuf;
>  	struct io_sr_msg *sr = &req->sr_msg;
> -	struct msghdr msg;
> +	struct msghdr msg = {.msg_name = NULL, .msg_control = NULL, .msg_controllen = 0,
> +			     .msg_namelen = 0, .msg_iocb = NULL, .msg_flags = 0};
>  	void __user *buf = sr->buf;
>  	struct socket *sock;
>  	struct iovec iov;
> @@ -4701,13 +4702,6 @@ static int io_recv(struct io_kiocb *req, unsigned int issue_flags)
>  	if (unlikely(ret))
>  		goto out_free;
>  
> -	msg.msg_name = NULL;
> -	msg.msg_control = NULL;
> -	msg.msg_controllen = 0;
> -	msg.msg_namelen = 0;
> -	msg.msg_iocb = NULL;
> -	msg.msg_flags = 0;
> -
>  	flags = req->sr_msg.msg_flags | MSG_NOSIGNAL;
>  	if (flags & MSG_DONTWAIT)
>  		req->flags |= REQ_F_NOWAIT;

Reminder. Does anybody has any comments on it?


