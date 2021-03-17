Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F02F33E889
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 05:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhCQEof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 00:44:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:58975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhCQEoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 00:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615956212;
        bh=pJbsKm9VwSvKzTX5rhriYfLdd1mLkTppfCsPSlXn1xA=;
        h=X-UI-Sender-Class:Subject:From:To:Date:In-Reply-To:References;
        b=anTancwGPTYecb84D3R6tj0iJugMLjgzZnJFzu47pL/Sl66EMFYh3sdIpKT/Pq1Km
         0f0g33/DC920y7PULr27pO8j2iuy67bCNzZs9AkvKfsv1yW0PEQ7mzerWn1UMuHLxX
         jS1QP0RZHWVo7hs+PrhXiD2+2YcQPyInM/CdC+GE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV63q-1lFLWf45IM-00S4Zz; Wed, 17
 Mar 2021 05:43:32 +0100
Message-ID: <4cb1a9ae15c414435020630cf6362163ddda1550.camel@gmx.de>
Subject: Re: [PATCH] sched: swait: use wake_up_process() instead of
 wake_up_state()
From:   Mike Galbraith <efault@gmx.de>
To:     Wang Qing <wangqing@vivo.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 17 Mar 2021 05:43:27 +0100
In-Reply-To: <1615893602-22260-1-git-send-email-wangqing@vivo.com>
References: <1615893602-22260-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rU/gNnqafSnt4CS9ugYpgBNx6tZUek2JAIwlo0Oqrv5IMIatL4M
 /oJI2MY5A1fF0LrB4k1pd7Xi3apz2IerfwjymTmAeLqtP4JWg7OJG380M2a47UZG86HbrN1
 Udb3EdHK9yOC7zeYLeSn3UiM/nIdnQo7GYjOXrtYJv7bV+e8KDEzkzIxeiWUJuio9iM5dfO
 AQpCkO5KdcKPGXVyWte4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GDxoxjcQJF8=:n47DPI62ygiA5No/BNVv9i
 GPXfjgnczmWRqsI+79dxf66wyIL6Y8PReddgedLCDp8I5karhrga5Jfpx9JlyI+shISyQL3wp
 x4M9S/eWqQG9HHzAZLvewC1fwDMmB0hElsRNRDGg1p7nQLvnye8N7kM5ONTDQJCtiit+lMYRM
 UEv1V9kutpp7I6hPULPCo3GOB03GuoBACaHmNKNXpD5xjykPZKZeDPUKAvYPu1XPWlBcalJa9
 Utr0w4x0/M6Qi7Zwc9w3r0ExaX93sJ0jdzg6HUqQuKuY8sJSyRyYUV2UT1R039QgQ6jQz6hKx
 De1+4FeWj2HCJjhs5OgotgV+v7N+pXEmV0gZYy1lItKokgTG9aG9yOpkssaf/5I02tXtxKyBq
 hB1Qwtr7ha7/5jwAHjF12rN10PwDH1MlgIutLL2jhngA6xYnWx09YtQJ9TTj6S2AnwDJniQEW
 RB3LSPqiDh/g8QN/HnBW/EcwGpelKwrIcglqPzLxP4/pfPBrowImHSfOp0p0XiaKghroOINgS
 JIYAre+rddP86zlqom7G+sqRJoSm3+Oy9Dm2eciejSdc20JFbK2MaiBrkSP+y6hh57ROSUWMT
 V2U4boKco6Uwa8PFgxd9ThV/a0izdPTR+ri/1fFIArfA2fxG0yz88j44a8eWRaIxq5y9xoVMR
 aZH8WaN4+IdNRjtPsTrcEYV463oLS1zeWlL8ZjbwEgEZnEXfOWmWFQ3YRcEgkQkRA91QbBtsO
 O5RvKIAUuTGaXiI68vJVlWHCNVEWvkf4Jy4XpJwVtZ6X3LMDXkU6X0czdI5hCFoy+AvofZFBK
 +8yWC6OipBZlQeQH3iVeSitdZpX5tW9SWlrUed6NOPmjywhXqIfZ8K5+sd9XqalrZysaN889I
 ZRTNl1Cnd+9h7r7ZpR1A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-03-16 at 19:20 +0800, Wang Qing wrote:
> Why not just use wake_up_process().

IMO this is not an improvement.  There are other places where explicit
TASK_NORMAL is used as well, and they're all perfectly clear as is.

> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  kernel/sched/swait.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
> index e1c655f..7a24925
> --- a/kernel/sched/swait.c
> +++ b/kernel/sched/swait.c
> @@ -69,7 +69,7 @@ void swake_up_all(struct swait_queue_head *q)
>  	while (!list_empty(&tmp)) {
>  		curr =3D list_first_entry(&tmp, typeof(*curr), task_list);
>
> -		wake_up_state(curr->task, TASK_NORMAL);
> +		wake_up_process(curr->task);
>  		list_del_init(&curr->task_list);
>
>  		if (list_empty(&tmp))

