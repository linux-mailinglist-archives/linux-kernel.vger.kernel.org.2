Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B350D3414A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhCSFW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:22:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:47067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232586AbhCSFWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616131304;
        bh=IrV4y//Hk8JVuz6zzvm632etLA5RlZHsOy0GreCQhTQ=;
        h=X-UI-Sender-Class:Subject:From:To:Date:In-Reply-To:References;
        b=RW71I1srElXc1KcqY48AmGptec0yXboa4+r7NPxfeHf1jPGBXJiXgt3jFeoi7x5SV
         2C9kuUrgF/5tgnVBm2QWiNBFiqk+NRFs9v+TYXthvDV3LwCUGDAFn5fJvdVPsk44bL
         ZYwppLfyi8YO/kUtojPkIERjlaP0Jzj5e+RPUp+o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MlNtP-1m6bKf1YwX-00llF9; Fri, 19
 Mar 2021 06:21:44 +0100
Message-ID: <b135934766964005677a8faa983919b052409a54.camel@gmx.de>
Subject: Re: [PATCH] futex: use wake_up_process() instead of wake_up_state()
From:   Mike Galbraith <efault@gmx.de>
To:     Wang Qing <wangqing@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 19 Mar 2021 06:21:43 +0100
In-Reply-To: <1616122760-11790-1-git-send-email-wangqing@vivo.com>
References: <1616122760-11790-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LtHlwKRPoSxYaVLYHJ82SkRWkFCDVzG51rQOx+LgdG2VRtQDqGf
 hcocEQgzLSQG34Gv7Jlu5I7EU60/7gji4tr4ZHYl/yvXBfJma9n7sPTXWN947/7zqhYpp5o
 yiwOUGmRlLIP46GEs1hR7eU8uPmjL4LdQeDtXcsNai9bGIujaGG1PQ1zxzCe2xlado1t+5N
 82NyPxs1aVS9UeDR+8dsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:alBLgklLxQA=:VYD0YGwEyONzKjOjemvT1k
 Hp5PHwMvhxeGxEltn/gQ3sBjOhjs0yANbQFtIHpxzKGgYk57nY4Fk5GKVz1tu3esAg4m9suvl
 RK1wLeqYu83Udm08ArSXYP68AQ4MU7IlvmvjtEsWeKVq03EmuF++5Rrn2vWwFfOdIi2GeLYih
 1DaUgy1qWDKnpo3+NEoPHc3AKweVKlQLoh+VvTIbj5t9esjEjvkPahH1JUUQ+1arrA1OREnaY
 QmRGnrlDRUilcP6r3e1klf0PAsWwZ51dgtGurfhxHevHrStQN46of/bNHPPx0Ahnl9fsn/CM+
 rD7CbulPIp0I/lVOcJ1c5CbtjIrs3uP7PF6ZLlB7EnJwfdIntVQHa6humNDXFewWm59/jnTC1
 jzEBHVnmWkBiwJmTEhu4GJ2OFoAppy/vw+bTSGfKdxCLrPDBw80gDzCLLYVDSNMzou/TGtlRF
 Ogl1pE4AnjA3Jj0U2vSfs9lQ6SWI1ZVYMLLspA3mRUrSYC8jJPvn5dbgJQYVE5MUGHTwIf5IK
 2l5enAy5d9lsGPymO76nefUlMAX1oiepjN/0FE8u7X7xjokgzmDBOG6LnyOFCoZRhimFxPURD
 jOwkNEzUPPjL3L24SvkNfoJWsucRBOmP+Fau6OaMmdUqQOwfF857lAZ5LycE+euNQ4+6T5uSm
 XsEN10R3przqeh7C6Lga8N25HPRAfJpzEjRRRU9eYewSHsNSV84wjKN1Atl3tpx2TvCr34m8O
 +jcspfRGw1FCGal2+Z2hId1EJUQ/+rX8w7Qn7jSTbzTVx5sEgvH+NShmAZT8z17XgpofyLVWg
 VoXcLsMMQgjrR+l4XEoNqSYucZZacAWSXqGz1sQClWsAfSq1QvoJamKBGs7RY7us3G6XrwdIp
 HRw+OKcFOXcKTYYvhKHg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-03-19 at 10:59 +0800, Wang Qing wrote:
> Using wake_up_process() is more simpler and friendly,
> and it is more convenient for analysis and statistics

I likely needn't bother, and don't have a NAK to paste on this thing,
but here's another copy of my NOPE for yet another gratuitous change
with complete BS justification.

>
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  kernel/futex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/futex.c b/kernel/futex.c
> index e68db77..078a1f9
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -1820,7 +1820,7 @@ void requeue_pi_wake_futex(struct futex_q *q, unio=
n futex_key *key,
>
>  	q->lock_ptr =3D &hb->lock;
>
> -	wake_up_state(q->task, TASK_NORMAL);
> +	wake_up_process(q->task);
>  }
>
>  /**

