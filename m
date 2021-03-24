Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB5134841A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhCXVrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhCXVrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:47:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043B9C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=NJDrbVDR974AzIhf4bPFDDM/VSRlumokXHq+kOQq04I=; b=TJe0RUBeZH3hS+i4JL5DAuzGMS
        wQ0JXjkkSCt8f3IrJTkgaqr39WdD9bFGv4LKkit3Id8ziJwY6jA+xCjat8v9HidlN0X3zJ1C7+AwX
        sNCerkFSMGhx6rTM3MVJd5YwbiiHPYs++p+MQbxr8l4DTmidKMZLRLqB0RjEj2s4YEfQtMvChwlB1
        sSgFPqtxy6pc+9GfpKyg6a9l7I1uoi40xmvy3/txYDSOS1K5IZBUbIyqMWiAwQYJHp/MpKJh4dbPq
        knUa+hOOoJcjrqMVBTE2JVoMFw156c/tYf7Dg57gplKdlyeF0SUpoWePmYV/iAip4An9E5Tt4ymMI
        9xScT5kw==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPBLN-000FpC-FB; Wed, 24 Mar 2021 21:47:14 +0000
Subject: Re: [PATCH] misc: genwqe: Rudimentary typo fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, haver@linux.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20210324062828.14807-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d6366447-add9-0fcf-b4f1-1787afcecb58@infradead.org>
Date:   Wed, 24 Mar 2021 14:47:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324062828.14807-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 11:28 PM, Bhaskar Chowdhury wrote:
> 
> s/requsted/requested/  .....two different places.
> s/equests/requests/
> s/occured/occurred/    ......two different places.
> s/conditon/condition/
> s/requestors/requesters/
> 
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/misc/genwqe/card_ddcb.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/genwqe/card_ddcb.c b/drivers/misc/genwqe/card_ddcb.c
> index 0db4000dedf2..98f6cd3fc66a 100644
> --- a/drivers/misc/genwqe/card_ddcb.c
> +++ b/drivers/misc/genwqe/card_ddcb.c


> @@ -1182,7 +1182,7 @@ static irqreturn_t genwqe_vf_isr(int irq, void *dev_id)
>   *
>   * The idea is to check if there are DDCBs in processing. If there are
>   * some finished DDCBs, we process them and wakeup the
> - * requestors. Otherwise we give other processes time using
> + * requesters. Otherwise we give other processes time using

"requestor" seems to be a word AFAICT.

>   * cond_resched().
>   */
>  static int genwqe_card_thread(void *data)
> --

and codespell says (for linux-next):

drivers/misc/genwqe/card_ddcb.c:985: emtpy  ==> empty


The other changes LGTM.

-- 
~Randy

