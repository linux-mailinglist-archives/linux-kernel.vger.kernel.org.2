Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B13C36F763
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhD3Iwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:52:36 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64434 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhD3Iwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:52:35 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FWmM65lWcz9wpv;
        Fri, 30 Apr 2021 10:51:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kDMDiR5czLYa; Fri, 30 Apr 2021 10:51:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FWmM64dTtz9wkP;
        Fri, 30 Apr 2021 10:51:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E0978B87A;
        Fri, 30 Apr 2021 10:51:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ILHb2NrNnZ0M; Fri, 30 Apr 2021 10:51:46 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B86C08B876;
        Fri, 30 Apr 2021 10:51:45 +0200 (CEST)
Subject: Re: [PATCH 2/3] powerpc: prom_init: switch to early string functions
To:     Daniel Walker <danielwa@cisco.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     xe-linux-external@cisco.com, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
References: <20210430042217.1198052-1-danielwa@cisco.com>
 <20210430042217.1198052-2-danielwa@cisco.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <e5de3724-ea9d-45a5-8f08-98ff325d055f@csgroup.eu>
Date:   Fri, 30 Apr 2021 10:51:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210430042217.1198052-2-danielwa@cisco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 30/04/2021 à 06:22, Daniel Walker a écrit :
> This converts the prom_init string users to the early string function
> which don't suffer from KASAN or any other debugging enabled.
> 
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> ---
>   arch/powerpc/kernel/prom_init.c        | 185 ++++++-------------------
>   arch/powerpc/kernel/prom_init_check.sh |   9 +-
>   2 files changed, 51 insertions(+), 143 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index ccf77b985c8f..4d4343da1280 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -225,105 +225,6 @@ static bool  __prombss rtas_has_query_cpu_stopped;
>   #define PHANDLE_VALID(p)	((p) != 0 && (p) != PROM_ERROR)
>   #define IHANDLE_VALID(i)	((i) != 0 && (i) != PROM_ERROR)
>   
> -/* Copied from lib/string.c and lib/kstrtox.c */

Please leave the second part of the comment as you have not removed prom_strtobool()

