Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E61C352C21
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbhDBPIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 11:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbhDBPIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:08:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB3AC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=1teqCTETeToKPn6a30tmZDLAJuMpZDlRxZ5TqucHjvM=; b=HvV8f2maAMpY8XKrmPEZNaT5t6
        ICl9omA6tcHN+x1NLvy/4TA319DuhWFFQhJNtjj9ELZq7NrnxnyPQ9wZ0TyWThT4/jwfwRt997Zfu
        JjJ091fNsoIDFCuUMdhJ6AAg6A0TZbS2DHJqsjyCbOeKfhIMKjegmw9skrzE9tyBfKejudqopWx4d
        c906GGpfIF3XKaSA+TlbSxbwBC7DaJCrY4aK8expOONrOhXo9NXsPss7TrjqWRLfe/BKvHjPbm+Un
        NipFFMGsiSNnGto0ncPF8leNY/LD3L6jHMwmp8+I2UEbLGAVKbnDpt/CycmyU2g7RWUtzZs4pHM2N
        Cz5v79hw==;
Received: from [2601:1c0:6280:3f0::e0e1]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lSLOz-007m4b-Oj; Fri, 02 Apr 2021 15:08:03 +0000
Subject: Re: [PATCH] tools: Fix a typo in kernel-chktaint
To:     Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, corbet@lwn.net
References: <20210402070514.336376-1-standby24x7@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d12dfced-ab61-fe21-69ab-2210108e1dd6@infradead.org>
Date:   Fri, 2 Apr 2021 08:07:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210402070514.336376-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/21 12:05 AM, Masanari Iida wrote:
> This patch fixes a spelling typo in kernel-chktaint
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  tools/debugging/kernel-chktaint | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
> index 607b2b280945..719f18b1edf0 100755
> --- a/tools/debugging/kernel-chktaint
> +++ b/tools/debugging/kernel-chktaint
> @@ -25,7 +25,7 @@ if [ "$1"x != "x" ]; then
>  	elif  [ $1 -ge 0 ] 2>/dev/null ; then
>  		taint=$1
>  	else
> -		echo "Error: Parameter '$1' not a positive interger. Aborting." >&2
> +		echo "Error: Parameter '$1' not a positive integer. Aborting." >&2
>  		exit 1
>  	fi
>  else
> 


-- 
~Randy

