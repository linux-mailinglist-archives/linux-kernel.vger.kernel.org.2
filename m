Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8AA345A37
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCWJAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:00:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52111 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhCWI7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:59:32 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lOcsX-0005ma-37; Tue, 23 Mar 2021 08:59:09 +0000
Date:   Tue, 23 Mar 2021 09:59:08 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     zhouchuangao <zhouchuangao@vivo.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Collingbourne <pcc@google.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/signal: Modify the comment of function
 check_kill_permission
Message-ID: <20210323085908.wdz6gamyoddhnu7e@wittgenstein>
References: <1616486638-82721-1-git-send-email-zhouchuangao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1616486638-82721-1-git-send-email-zhouchuangao@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 01:03:56AM -0700, zhouchuangao wrote:
> Maybe it's easier for us to understand the function of
> check_kill_permission.
> 
> Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
> ---
>  kernel/signal.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index f2a1b89..2fbf68a 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -823,8 +823,10 @@ static bool kill_ok_by_cred(struct task_struct *t)
>  }
>  
>  /*
> - * Bad permissions for sending the signal
> - * - the caller must hold the RCU read lock
> + * Check if the signal has permission to kill the process.

Hey,

This phrasing is misleading imho. It's not about whether the signal has
permission but whether the caller has permissions to send the signal.

Christian
