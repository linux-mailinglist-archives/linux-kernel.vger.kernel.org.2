Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD3545E981
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 09:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359409AbhKZIll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 03:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344599AbhKZIjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 03:39:40 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B06FC0613ED;
        Fri, 26 Nov 2021 00:30:02 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso6246401wmr.5;
        Fri, 26 Nov 2021 00:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=7ZOiyO6C3S5TMCle8OceoflO7UZxiS4NLdWgZ2MHY4s=;
        b=Y7dNqeLO0zhbvsREBc88l5S30Z+tcj9+9CyAW+wYWwxKRQXskmMGHh92Y1rkuu0bYE
         k87wgdKsBBUEmWIZkk7pYoJF3XKjfcqShBkXMxoURX1DUV4L+lmnYVQTYvIkZGWQMvbu
         SnkUTDElB1hs/5chlhDRpWnHlbkUdML+bGM0umF4UvOAsDKtZEG1YeDV77sMnRqsg8cG
         Sw9/zUxCDEy23lDfzNkI1avOxBpha3w+YU3FR+m4OdZ0od7yoc9a1x5XQ0wMvQ3XQSoh
         Nw67JVHm3kN/vaQYRYX8fp/qmkgRLnfqKbi6TzzO4frm6L4cU/nC7zuhjw3PxGlimT63
         Yvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=7ZOiyO6C3S5TMCle8OceoflO7UZxiS4NLdWgZ2MHY4s=;
        b=weGKLgRYRiAQ+MN5h1rQqiL7Odjaav3lhKdZ8diiwouiryNU1WZRbvBnl+JM/cdlWt
         LS6HrKZUMzsy2p8rF9uXu97l/LOw57bTKRmq/JdTpE0QLmayVWUndAW8iQE5lCYm9Vbr
         Kk7dFRhH9B+z19pqK7BuymEr+/9PD0KxPTIwB8hvCCUOE8pEWdGMxZp1yZlf3OPaS7V7
         6MwPIGE3Eabm9Q8KZW6U05GkDzXoX+hNAVndXq4FM2tvjn27KLa1ilCkclPXTjd3pmk+
         l2Lgz5OiV94CKDgx74WJck7KI82Xte3Gjhnw1qSTOaU9Z9+vHZMpyNwNRIGjhejvZzJk
         aAPA==
X-Gm-Message-State: AOAM532h90BbKam6snlQB1i0ly4azQvNRYgbV7JqXoeo5wqTEoNx8mAN
        7J51OZm6u1X7pw==
X-Google-Smtp-Source: ABdhPJy7LlIGoEGElB4NHkI37M+dM/f3anVsufxi3WgRq6iYE53koTYvPKJNXSHABycFOjCf+xsngA==
X-Received: by 2002:a7b:c197:: with SMTP id y23mr13941265wmi.44.1637915401177;
        Fri, 26 Nov 2021 00:30:01 -0800 (PST)
Received: from [192.168.0.209] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id d188sm11953498wmd.3.2021.11.26.00.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 00:30:00 -0800 (PST)
From:   "Colin King (gmail)" <colin.i.king@googlemail.com>
X-Google-Original-From: "Colin King (gmail)" <colin.i.king@gmail.com>
Message-ID: <dcd6ed6a-a915-49b5-a428-f21f2e3e3e00@gmail.com>
Date:   Fri, 26 Nov 2021 08:29:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH][next] hugetlb: Fix spelling mistake "hierarichal" ->
 "hierarchical"
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        Colin Ian King <colin.i.king@googlemail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211125090635.23508-1-colin.i.king@gmail.com>
 <aa7ad39528c768dfd3a33890cf7d14b59ba3a5fc.camel@perches.com>
In-Reply-To: <aa7ad39528c768dfd3a33890cf7d14b59ba3a5fc.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2021 08:15, Joe Perches wrote:
> On Thu, 2021-11-25 at 09:06 +0000, Colin Ian King wrote:
>> There is a spelling mistake in a literal string and a comment. Fix them.
> []
>> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> []
>> @@ -495,11 +495,11 @@ static int hugetlb_cgroup_read_numa_stat(struct seq_file *seq, void *dummy)
>>   	 * The hierarchical total is pretty much the value recorded by the
>>   	 * counter, so use that.
>>   	 */
>> -	seq_printf(seq, "%stotal=%lu", legacy ? "hierarichal_" : "",
>> +	seq_printf(seq, "%stotal=%lu", legacy ? "hierarchical_" : "",
>>   		   page_counter_read(&h_cg->hugepage[idx]) * PAGE_SIZE);
> 
> Not sure this should be changed as seq output is nominally ABI.

This just landed in linux-next, so I doubt many folk are using it. Let's 
fix it before it lands mainline.

> 
>>   
>>   	/*
>> -	 * For each node, transverse the css tree to obtain the hierarichal
>> +	 * For each node, transverse the css tree to obtain the hierarchical
> 
> Fixing the comment typo is good.  Thanks.
> 
> 

