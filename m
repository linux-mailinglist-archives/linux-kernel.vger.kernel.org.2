Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820F53F9C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhH0Q3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhH0Q3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:29:43 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B42CC0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 09:28:54 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id t4so7750510qkb.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HsecH+zskpsc+sAnBqxr5ZuZz+jO6o+sSCHY/MtxvCQ=;
        b=O1ffWDj7gAU7klyHfuCVwiedzSG5T6fkgdQCMhj0P1ar6RbFlyx71pvhEk1OKUDQGq
         /AQ/MfTpQwfDq/xNUNkLrzBbSZbOMJudxV2IYXIRHPsYsHK9M18TcS3EslzExK2Y2aUO
         ipvMFYA2RcVazQeT+Rk6gR0SxP8dqlXpAPDz3mLV+JwGaoQlpUqTwjrqWRaIPB1G40kV
         ay2uWYYWefjPTGoyFqUJk/FMyA8illo3bCr41jvANHIKZXmZ5BVnRdcwMxW5TRG3M894
         7aWMZbWdJcR/I29AcajAzsoNg6jT9xhbcHoQwvwsyv9YST2s9AQRc4SbM5KnHZXIiVgU
         CanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HsecH+zskpsc+sAnBqxr5ZuZz+jO6o+sSCHY/MtxvCQ=;
        b=FXkFSZIZJHr6qGb723fWLk9O13uOFNk0e84YFobZwBy9XJl2xQkM+CwKfFSrIzcBhm
         wX8OiEZzP4Dr0N47bkDuxkjs20JfifXDjuIKEa5urf29Ecwq2n0hEydot3IwMaFti/lu
         hl8l/jgQI1rlP47PQ7U73sxPZXtYgHlj66xfo3iJqocgNuWd2T7PO10wck9IKNh7wyLM
         v2kqK/xvnA15QviJ+uWMxVwjjNMWOqN/fmfPzqp0bzRS1Ss0rd0e30F+nJvxrcJbUGs2
         eSBYMGC/CCmh8EK/J3/OA5HxKHdsvCi33SJvc/xaFKiQinLYbI2xr7DcdubIQGIS+VdL
         WEPw==
X-Gm-Message-State: AOAM5338uLX0TGpEF9kyc39ekoVunQAxYP0n2BGa4Jpyu/SqbxdN1zl3
        ILzlEAa4feVe7NsPTYH/OQwpBg==
X-Google-Smtp-Source: ABdhPJyEcY7aHVkmZaX3V0QWCBw0ZIrtvIgwijSbOHgj0i3rDzXComqPaqDsO3KbB50/gP6092KbSA==
X-Received: by 2002:ae9:ec0f:: with SMTP id h15mr10159256qkg.224.1630081733346;
        Fri, 27 Aug 2021 09:28:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id c2sm3754947qte.22.2021.08.27.09.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 09:28:52 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mJeiq-005jqI-8p; Fri, 27 Aug 2021 13:28:52 -0300
Date:   Fri, 27 Aug 2021 13:28:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     linux-mm@kvack.org, linux-rdma@vger.kernel.org,
        akpm@linux-foundation.org, jglisse@redhat.com, yishaih@nvidia.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/hmm: bypass devmap pte when all pfn requested flags
 are fulfilled
Message-ID: <20210827162852.GL1200268@ziepe.ca>
References: <20210827144500.2148-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827144500.2148-1-lizhijian@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 10:45:00PM +0800, Li Zhijian wrote:
> Previously, we noticed the one rpma example was failed[1] since 36f30e486d,
> where it will use ODP feature to do RDMA WRITE between fsdax files.
> 
> After digging into the code, we found hmm_vma_handle_pte() will still
> return EFAULT even though all the its requesting flags has been
> fulfilled. That's because a DAX page will be marked as
> (_PAGE_SPECIAL | PAGE_DEVMAP) by pte_mkdevmap().
> 
> [1]: https://github.com/pmem/rpma/issues/1142
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

You need to add a 

Fixes: 405506274922 ("mm/hmm: add missing call to hmm_pte_need_fault in HMM_PFN_SPECIAL handling")

> diff --git a/mm/hmm.c b/mm/hmm.c
> index fad6be2bf072..4766bdefb6c3 100644
> +++ b/mm/hmm.c
> @@ -294,6 +294,12 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>  	if (required_fault)
>  		goto fault;
>  
> +	/*
> +	 * just bypass devmap pte such as DAX page when all pfn requested
> +	 * flags(pfn_req_flags) are fulfilled.
> +	 */
> +	if (pte_devmap(pte))
> +		goto out;

I liked your ealier version better where this was added to the
pte_special test - logically this is about disambiguating the
pte_special and the devmap case as they are different things.

Jason
