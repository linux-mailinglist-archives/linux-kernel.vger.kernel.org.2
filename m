Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4FF3FB856
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbhH3Ofi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhH3Ofe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:35:34 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1965CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 07:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=mkGTDPNkt+i0u372UDIl+CX0pOwINf5R8IDtgqkrmm0=; b=vgwD7dHvsWoj01UZg923MZmsZt
        PUbyVQXfMg/kqJQoJTx8IiThC7uvXXkphmhXniJZrfKzzu4F6Inp1D2JNqgPJHqMm7wWEm5ETrDkB
        /aGyADDagiejrbResWNqbXOgSBIlto+2EHPu+pHKqu1QMpebuDQcTsvJq49ptpJvJ0008pDQvuBp3
        nPENZcU8O+jBLR/YJYk4jMdFNZFeRDTJn1jhp+hvI8TTsaXFXQEy3WmzQ+DvKg1CVTD6sfk1xWE7x
        QteADdy4RPLHd/q4CfQ8RR1BA5Ol+h9wmehE9InWd2IkGQWSdesMN8N9xUaT7EBXVIoysOGLd5JBa
        aKZasuFQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKiMw-00HS00-Jh; Mon, 30 Aug 2021 14:34:38 +0000
Subject: Re: Why is Shmem included in Cached in /proc/meminfo?
To:     Mikko Rantalainen <mikko.rantalainen@peda.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <5a42eb2b-fd7b-6296-f5d6-619661ad1418@peda.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0d11f620-0562-e150-259d-85de8d10cd7a@infradead.org>
Date:   Mon, 30 Aug 2021 07:34:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5a42eb2b-fd7b-6296-f5d6-619661ad1418@peda.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add linux-mm mailing list]

On 8/30/21 12:44 AM, Mikko Rantalainen wrote:
> It's not immediately obvious from fs/proc/meminfo.c function
> meminfo_proc_show() but the output of Cached: field seems to always
> include all of Shmem: field, too.
> 
> Is this intentional? Usually cache is something that can be discarded if
> needed but shared memory (e.g. used to contain files in tmpfs) cannot be
> discarded without a data-loss. As such, I'd argue that it shouldn't be
> included in the Cached: output.
> 
> A simple fix could be
> 
> -	cached = global_node_page_state(NR_FILE_PAGES) -
> -			total_swapcache_pages() - i.bufferram;
> +	cached = global_node_page_state(NR_FILE_PAGES) -
> +			total_swapcache_pages()
> +			- i.bufferram - i.sharedram;
> 


-- 
~Randy

