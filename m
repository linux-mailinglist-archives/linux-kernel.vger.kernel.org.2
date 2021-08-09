Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B823E4285
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhHIJVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234255AbhHIJVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628500888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LYjjWYC+evDa8CnL289Wbl62ib9AbW6R5Q1/TMSWM8c=;
        b=NzjWMa7JJ22wSeJX59d783eAwd0hT8SBz8OQDHLsgM1G9m14m/CbuHNjCXwRzP9NcNxCTB
        21PwRm5der2jZLOct5tbbzA8iMz9HbbaYW008xS1dGG/PjZryp0D9e/sYX3fDjhDkuaily
        Cd0R6bUHe/P60FouE+YgfJlDhC2TxUE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-KakzBGVjPmuYDyBL8kM5Eg-1; Mon, 09 Aug 2021 05:21:27 -0400
X-MC-Unique: KakzBGVjPmuYDyBL8kM5Eg-1
Received: by mail-wr1-f71.google.com with SMTP id p12-20020a5d68cc0000b02901426384855aso5150577wrw.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 02:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LYjjWYC+evDa8CnL289Wbl62ib9AbW6R5Q1/TMSWM8c=;
        b=tWHcefwydPRilUhSh0Km/GEvbY3Hgb2gHJp8sNTzbj4WktS1loD5LZxNKJ4EZVJTOg
         isFRB/eE68mi5I/3jMV9n2IYlEpa2xkJI+ZekO3IFPdslzyLT+2LNKV4KGS6OIK47HKh
         S9fe4BrI3ZEaFnimrAoavZ+WsWCVpOgvQbHDRww4txoIr63/7jL+9ECjgioVDzm+bKdu
         wlJVEpfNucuTMpJs9MC73KI5D3c9tq6morobeM/6XiLmDmjLrPphmG3FWLCGOf/BL0hI
         1BwBEIaq6vfwZ4EC7x6w6NRw/wMVQSIbDBVfRqXyCEjUSVggnv+D1RNR20lRPbMTfnB9
         QsPQ==
X-Gm-Message-State: AOAM533q4DsV306AjHgi+D6hWt3iSu/cU9mGmgl9YomNAE7FIxVlUagM
        PbOf36/abnUaOPEIjxgEz5kzvbxq0dPVR7WHZAP6uIuuyDv50cPxh7v/f+uUrjDbe3wOpKtShKc
        oWKtzBRz1JJ51bcuDF0Hsg3N1/8b88DD0z6ZmnSOGehCaUzwy/SlxFbjyKfJatrKph9qiy5sU
X-Received: by 2002:a05:600c:154d:: with SMTP id f13mr15884379wmg.0.1628500886509;
        Mon, 09 Aug 2021 02:21:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8YmZCaBBJ2ANqGTx6BtrnhE9knFbxy+Pmi5ITTngK1RldDMsf2BABS9Lujt8YM8pO/HxSjA==
X-Received: by 2002:a05:600c:154d:: with SMTP id f13mr15884363wmg.0.1628500886356;
        Mon, 09 Aug 2021 02:21:26 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id s84sm3822702wme.12.2021.08.09.02.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 02:21:26 -0700 (PDT)
Subject: Re: [PATCH 1/5] mm: gup: remove set but unused local variable major
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, kirill.shutemov@linux.intel.com,
        jack@suse.cz, jhubbard@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210807093620.21347-1-linmiaohe@huawei.com>
 <20210807093620.21347-2-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <896f0f85-364b-1678-5a3e-d32552e9827c@redhat.com>
Date:   Mon, 9 Aug 2021 11:21:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210807093620.21347-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.08.21 11:36, Miaohe Lin wrote:
> Since commit a2beb5f1efed ("mm: clean up the last pieces of page fault
> accountings"), the local variable major is unused. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/gup.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 77150624f77a..430495cb1b91 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1276,7 +1276,7 @@ int fixup_user_fault(struct mm_struct *mm,
>   		     bool *unlocked)
>   {
>   	struct vm_area_struct *vma;
> -	vm_fault_t ret, major = 0;
> +	vm_fault_t ret;
>   
>   	address = untagged_addr(address);
>   
> @@ -1296,7 +1296,6 @@ int fixup_user_fault(struct mm_struct *mm,
>   		return -EINTR;
>   
>   	ret = handle_mm_fault(vma, address, fault_flags, NULL);
> -	major |= ret & VM_FAULT_MAJOR;
>   	if (ret & VM_FAULT_ERROR) {
>   		int err = vm_fault_to_errno(ret, 0);
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

