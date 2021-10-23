Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C349438566
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 22:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhJWUyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 16:54:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:55775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230159AbhJWUyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 16:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635022307;
        bh=TuXi+3xGQPup3cVO6potgB4Q4tS+Wp3uV8XhZ3JjkSc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=OFL7yB+cs5lImL53Qo3IrbavcWvhKn0siIL/V/ZHa0mVtRebATgtDqutB976kI2Sa
         dwGdqqDOvCt4OC703Qi1Cc3gh8EEZ2cYQYl+nLyg8wF5C7fIsJQ0EEep30GD/NNspA
         LfQkOmWENYp6yENUJfVa7l2dLqqT+N3yNy4Y+SJ8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.178.51]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKm0-1mL3tZ27kg-00OlKF; Sat, 23
 Oct 2021 22:51:47 +0200
Message-ID: <819be457-e595-27ff-a8db-1326ecfe3579@gmx.de>
Date:   Sat, 23 Oct 2021 22:51:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH][next] parisc: Fix spelling mistake "Plase" -> "Please"
Content-Language: en-US
To:     Colin King <colin.i.king@googlemail.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-parisc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211023114518.18600-1-colin.king@canonical.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20211023114518.18600-1-colin.king@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gc7KjTZXwQMC5sCnauJRh+d/0jcdSD1ydMXgAlnH6MgnSEv8gF8
 sfpsgQJmtz3sHYFqs32IM4L6APH/UqI1A/gAl3Tbpy2Byb6hEo6QSOOnzrCZ3GAMBNrEVax
 pjm9eF4/ZcfB0U8rj9UPREGR97B6Z6RGgfmqmDSdcIy00A3fHY9i0byKAvXwM8dKkOVfxku
 h/2Qxx/aIs9JE9kYA/bMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:A5xPzONqOVs=:IOJNmLdjedWWp4W4qEZY6Q
 EMBqIZLsaJAVPoYCpx3i4xFV4XP3V/FJC3qlERsI0O6iMNkI9xtV6cd3vT9WDdsipSqKV1BoI
 HINHVwVA7yO3Yl8dSpIgfMEaxOQjQLC0y15M9ysVJytHOEQa1lP7MXTEQRJbCsvKoSuO9RiDz
 BC2rwumQ+hC4Pmrg/d6aKA3IHsft/245rDiewCDgUXX/nFnP/xeKb3gLQ7fk4RsBaHBwEqk34
 A2y7sFPuBTyQ/VcyRuuPr2273K0o53iZxAYWctQhDdUuEd/k4e6px3+19A2ZvDu7vOFoJjNwZ
 jLMg8Og1Jy2tKZ7zGqG8fFFpItfYA1MawcjTUH/mjIXeTU3yS0Yi5GO0zL1TojYzY/PNmFT5U
 +ZATcnGiEgVML9/pOTSK/weYGV3fyLuwSKCTAtwJqH8wFgqDGyVGCer3wDORtl3WfmKxzLiuD
 usSWkXpLWNql4xnXkcy8OBfKMbpGf99hR9YAAy4t8zk83jMJaI1hR+nNdAscipd+GlIEPh0fM
 iHyBcTP9sXiUmm7LE56XL75VDED7YkR5WsBV7JaGjjpZvCm0+Sfz10gg3olBKbmNiAMu0iugp
 5lGcaZc/sNd+biVStWmktKUCeAq65lPZ0yXXde1UTeD5z2q087CeUmMa75xJzEDTH0RkjCjgt
 /MKkpqTBbv2LMZ2ZIEnNqZJdq2TWU+odRwd2kHIENYTr6qCobjLtUoc0DAb1T+XAzgheQaurJ
 Ph5LoFWbTxwut9XTunAq1LVdRpqGQPCPVQQ9qoFgDLmHC8mt/V1mZlPG9p9F6HqMm3CeNZARA
 FZs6OtpDUW9aRsKi5l5NgZzkOhfUsfTytmMBXBGyLPc3uysng6cIM2J1nufokVFHRfiNLgr2k
 moQyLEkzZCdQkTeIpcvUAB1mXEd1fKoJWta3xE/duxZAJgx3c1E3L5wj97X6krigWZCN531Op
 ec/pxdGckHvqW6K67dtp9fhRpGKg5Aa+aV5x5MK76Hh/efxf4g+rda4ibmrreJY9R0Cq4nJSi
 7wE5WpY6whneOvKzr/TKR2CpMRbq3S9fAWXD8E/fgn2pA9aNbeWFHewGPNCuiNmZICioF++4N
 UapwdZvYBgMG3s=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/21 13:45, Colin King wrote:
> From: Colin Ian King <colin.i.king@gmail.com>
>
> There is a spelling mistake in a pr_warning message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks!
I've fixed it in the original patch.

Helge

> ---
>  arch/parisc/kernel/sys_parisc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_pa=
risc.c
> index d11834377676..2b34294517a1 100644
> --- a/arch/parisc/kernel/sys_parisc.c
> +++ b/arch/parisc/kernel/sys_parisc.c
> @@ -413,7 +413,7 @@ static int FIX_O_NONBLOCK(int flags)
>  			!test_thread_flag(TIF_NONBLOCK_WARNING)) {
>  		set_thread_flag(TIF_NONBLOCK_WARNING);
>  		pr_warn("%s(%d) uses a deprecated O_NONBLOCK value."
> -			" Plase recompile with newer glibc.\n",
> +			" Please recompile with newer glibc.\n",
>  			current->comm, current->pid);
>  	}
>  	return flags & ~O_NONBLOCK_MASK_OUT;
>

