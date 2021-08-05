Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F5B3E0FB0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 09:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbhHEHxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 03:53:47 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.234]:21941 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231173AbhHEHxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 03:53:44 -0400
X-Greylist: delayed 1241 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Aug 2021 03:53:44 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 6FD22102FFD
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 02:32:48 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id BXs0meVyzK61iBXs0miQ5e; Thu, 05 Aug 2021 02:32:48 -0500
X-Authority-Reason: nr=8
Received: from host-95-239-202-226.retail.telecomitalia.it ([95.239.202.226]:38688 helo=x1.bristot.me)
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mBXrz-004KWc-PN; Thu, 05 Aug 2021 02:32:47 -0500
Subject: Re: [ANNOUNCE] v5.14-rc4-rt5
To:     Daniel Wagner <wagi@monom.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20210804165017.nizmbj3m7hkqzqop@linutronix.de>
 <20210805063123.mj4rggncauziryv4@beryllium.lan>
 <20210805065351.c7eieltqihduwisr@beryllium.lan>
 <20210805070008.nvhzjp56lbx5uwk2@beryllium.lan>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
Message-ID: <07fff459-375b-38ef-ec4d-647beb268731@kernel.org>
Date:   Thu, 5 Aug 2021 09:32:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805070008.nvhzjp56lbx5uwk2@beryllium.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.239.202.226
X-Source-L: No
X-Exim-ID: 1mBXrz-004KWc-PN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-239-202-226.retail.telecomitalia.it (x1.bristot.me) [95.239.202.226]:38688
X-Source-Auth: kernel@bristot.me
X-Email-Count: 4
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/21 9:00 AM, Daniel Wagner wrote:
> On Thu, Aug 05, 2021 at 08:53:53AM +0200, Daniel Wagner wrote:
>> On Thu, Aug 05, 2021 at 08:31:23AM +0200, Daniel Wagner wrote:
>>> Just a heads up. I get these build errors:
>>
>> I suppose this should be:
> 
> and while at it, there are two more compile errors. The first one is
> obvious, the second one is just guessing.
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index c05a33a2f865..41e3d63160a7 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -1896,14 +1896,14 @@ static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
>                 if (locked >= 0) {
>                         /* Requeue succeeded. Set DONE or LOCKED */
>                         WARN_ON_ONCE(old != Q_REQUEUE_PI_IN_PROGRESS &&
> -                                    old != Q_REQUEUE_PI_WAIT)
> +                                    old != Q_REQUEUE_PI_WAIT);
>                         new = Q_REQUEUE_PI_DONE + locked;
>                 } else if (old == Q_REQUEUE_PI_IN_PROGRESS) {
>                         /* Deadlock, no early wakeup interleave */
>                         new = Q_REQUEUE_PI_NONE;
>                 } else {
>                         /* Deadlock, early wakeup interleave. */
> -                       WARN_ON_ONCE(old != Q_REQUEUE_PI_IN_WAIT);
> +                       WARN_ON_ONCE(old != Q_REQUEUE_PI_WAIT);
>                         new = Q_REQUEUE_PI_IGNORE;
>                 }
>         } while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
> 

same problems, same fixes here.

-- Daniel
