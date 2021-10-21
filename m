Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3559436122
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhJUMPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:15:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:59079 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230379AbhJUMPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634818367;
        bh=wRQ5OoGNi6KY8iyRTE4gesxaok+9j0+I4ZgzhMwQplA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=HHISPmIKtRNrjRfLMCJg2PwXQ6UeqSNhjpIIxm2aA4O21jTV1f0/Sl12fYF3cpEa/
         JqclRBeoF7qmZ1qb46JRlhLi+dhLdV1uLqtU8MQw8H+lKbbgXQ07nX3kEPpCQuy8NB
         vSqOBGiUqj2AJ8EYAkvXmOQdpOhCeESrmD/rnUBc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.156.15]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybGX-1mtnjG2CRp-00z0Ne; Thu, 21
 Oct 2021 14:12:47 +0200
Message-ID: <24721f4b-56e5-7751-d4f1-7bd3d96be163@gmx.de>
Date:   Thu, 21 Oct 2021 14:12:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] parisc: Make use of the helper macro kthread_run()
Content-Language: en-US
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211021084214.2289-1-caihuoqing@baidu.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20211021084214.2289-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ukz2kgys2BqrVMAY0zo1n4K7NabqEU2VOd58oderjO+vEhxXxn2
 FLNV30RoHfvMWngmlN3MinsN59HlVcb6mW51ILKGTa2GWl13R4GJgzPKAgPixwLEuTa4N9h
 Cn0YUcz/rMpaauW8joM6p2ue3gmFW2OX6uIKvtmh0lsBBDdwFxcJLtdoh4oY2i/gL1KCHvL
 eMnTUWQ+gFswRD6SMw9YA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EDVFd37g4E8=:kpp6HKbpic0Qeq1ovwDShr
 IVrG5FRGyaL+3UCiX9W4pLqdUMqdDA6869YMYsLknj+E+ca4M6VsbEQWzvYQ/BOTxXfyNbO0/
 CRqzRxoJCUMdHZmDQiTzayJimFCrjSxyM/iYxVrQhpzxleUGJqFuEprvYwzfMQgigVC3vzRzr
 DnCY5x8jBPud3WqCyhIwf7q2r7U5X1ZAOfIHw+0ECre2oqIE8dhJXlD2Mos/nihsFFmT1UTws
 e1m5siEM5WoOUnZWPFVzqhIFjLeNIZzs+cx0wzcPetgt4q7R27r3bcQEo3fCklawX7OkTi220
 /bQypGoKZQIPaR7SZi47+dk6kNqfk8keLGOSMEIbjmQPUaQuTSX1X/N/UKIIRM8VLr3yRkcLU
 yhes32qHBxJeCPI4T4xF+CQnjZ1+Q5lcQ9FX6OTUw5vl4WZ+GwFE+asYYkJiqpOryXKVBquMe
 sszNcCDV3Xvmt6R179x01rOC9tuZqg4x7MkZFNuIFYqvJEzEW87g8jc8bgqRLuE4MRaQYjvoF
 ulrbiwX/OSfsaZ3zIVXCSxBp/x2IE7c4c9tD2miVb8EfoVvZGHJn4AdtMZLrgf/K6bHadhrBs
 gKL/gdYE7l9A0K4sVavMTBkfnAHF3Mr5SxCweS+gB7gM1Rk1SdXEX90dHb7aZ5x0tRy40N4qd
 hk4RquB2JgLDbctcPPi0lhvJeeOg/4jk1Pj0TUeyQGiwhTkZuB/xRe7z7pfNj5vLf/w35yCWX
 9Y8zN5cXtzVd198BVqUbjtqef7fu3jxR/zsN4OVvOWYTDc6dQSovkJQv2/ylfCm7JXDSMXo6R
 vOYptGvexQObSJ284cqDllE7/5fsw+FE93Gr3Ap3HfDvm4V7hzntbBjo6ASbXIAI4lSPNJ1Qk
 gE88JdhcfjLdcSAbrdbswe2xbMGs2IGHodckAzOdqfZhuO0TLNlBzoz2WJaCALOe5OAuOC5Hb
 sUQboRxwBMlg55HIkc76xJULQPPvdlG2EJM5mplqE5TYFE0XhlYjmekKiIJd9zw83iXaHHsRg
 XCtUW1W1SI0HUAByD19oTn85b6zglSLpzQx1/nDrh8qqDusVP+hvOJoIdixNucHZOw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/21 10:42, Cai Huoqing wrote:
> Repalce kthread_create/wake_up_process() with kthread_run()
> to simplify the code.
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Thanks, applied.

Helge


>  arch/parisc/kernel/pdt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
> index fcc761b0e11b..e391b175f5ec 100644
> --- a/arch/parisc/kernel/pdt.c
> +++ b/arch/parisc/kernel/pdt.c
> @@ -352,12 +352,10 @@ static int __init pdt_initcall(void)
>  	if (pdt_type =3D=3D PDT_NONE)
>  		return -ENODEV;
>
> -	kpdtd_task =3D kthread_create(pdt_mainloop, NULL, "kpdtd");
> +	kpdtd_task =3D kthread_run(pdt_mainloop, NULL, "kpdtd");
>  	if (IS_ERR(kpdtd_task))
>  		return PTR_ERR(kpdtd_task);
>
> -	wake_up_process(kpdtd_task);
> -
>  	return 0;
>  }
>
>

