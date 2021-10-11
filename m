Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A54428715
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 08:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhJKHAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:00:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13976 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233148AbhJKHAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:00:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633935533; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=k8tTotxLDJjjEVEHtHiSBd970P+txsfK0O5LCyddwGA=; b=os8EaaJtmxZFSBJywxqkRTEo/z2V/uHveCqMv60VnAdP8Wpg4WHIhFu+6rh0jmhUtmDWNANE
 TWjqlrIEMfnG6TCxGRxetZWWVsVrAVyz3gzqe8q9nLpm39DAuRyZ4rtTv2SiPALUbsex7mxw
 yyEg496MXx1FQP7zzoCUSgO4IXw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6163e0ac03355859c84530bb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 06:58:52
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 82857C43619; Mon, 11 Oct 2021 06:58:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.109] (unknown [49.204.182.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DBBD2C4338F;
        Mon, 11 Oct 2021 06:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org DBBD2C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v2] mm: page_alloc: Add debug log in free_reserved_area
 for static memory
To:     Faiyaz Mohammed <quic_faiyazm@codeaurora.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com
Cc:     guptap@codeaurora.org
References: <1633935350-19628-1-git-send-email-quic_faiyazm@codeaurora.org>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <5a744f0b-1283-7fe1-ee5a-c87ca6d10b0a@codeaurora.org>
Date:   Mon, 11 Oct 2021 12:28:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1633935350-19628-1-git-send-email-quic_faiyazm@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this patch.

On 10/11/2021 12:25 PM, Faiyaz Mohammed wrote:
> From: Faiyaz Mohammed <faiyazm@codeaurora.org>
> 
> For INITRD and initmem memory is reserved through "memblock_reserve"
> during boot up but it is free via "free_reserved_area" instead
> of "memblock_free".
> For example:
> [    0.294848] Freeing initrd memory: 12K.
> [    0.696688] Freeing unused kernel memory: 4096K.
> 
> To get the start and end address of the above freed memory and to account
> proper memblock added pr_debug log in "free_reserved_area".
> After adding log:
> [    0.294837] 0x00000083600000-0x00000083603000 free_initrd_mem+0x20/0x28
> [    0.294848] Freeing initrd memory: 12K.
> [    0.695246] 0x00000081600000-0x00000081a00000 free_initmem+0x70/0xc8
> [    0.696688] Freeing unused kernel memory: 4096K.
> 
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> ---
>  mm/page_alloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 668edb1..8a1929d4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8153,6 +8153,11 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
>  	if (pages && s)
>  		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
>  
> +#ifdef CONFIG_HAVE_MEMBLOCK
> +		memblock_dbg("memblock_free: [%#016llx-%#016llx] %pS\n",
> +			__pa(start), __pa(end), (void *)_RET_IP_);
> +#endif
> +
>  	return pages;
>  }
>  
> 
