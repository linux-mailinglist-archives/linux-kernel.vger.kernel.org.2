Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806803A1235
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbhFILUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:20:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237111AbhFILUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623237504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5D2f0RDMNoW7UtQkRweMkgymnt4in4bolBggOQUTyEQ=;
        b=XdibKVCSNqe6NSsjL0b00/F5RBoIXPArHPPU/FKcb1AX2te9P+AW/Fetf8vhTdDdktO6hh
        bRI9Ca2C/I/55pEBP7JI1GVBakXltFVhBiiqPFH5uwBmyTeQvVsZ/nFx05s6bj+vECQjna
        EmyJmtNp4Gn/bqvWnDRThf7Ko3cERb8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-ihj9QDh1OLGLTGfSv6oKzg-1; Wed, 09 Jun 2021 07:18:23 -0400
X-MC-Unique: ihj9QDh1OLGLTGfSv6oKzg-1
Received: by mail-wm1-f72.google.com with SMTP id m33-20020a05600c3b21b02901a44b1d2d87so1825963wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5D2f0RDMNoW7UtQkRweMkgymnt4in4bolBggOQUTyEQ=;
        b=f+SkHYHfib3WFfxqoq/XsCnRhmVWPWknyge7ftts6V6gqLrLZswQVbFU61g8G+pfy2
         UsPwqHziUA3SG5mfPXVafyd7lisdO3Rg8UkqQat7u0x5s4SMU+UN7Rkctq6O0BO7gFel
         DZddI/NlWH9ymQxfuT+wXpPVCkhzUDD9xl90gnhpCHzI+Fh6QzvSTwMHztGpCY1i/kxR
         S8ThK1GBd4sL2TGAHx2kP7ok8F/h5KpTin/cwJQ3AHzBt2FRpmybZoZdccrcKcqFN9xl
         q7JJDtHozSFxaWkrKYmnUYIel1wopdnWn5F1K3tGIU+euIAYl/XSJ8fAGPmi5DVhawga
         8amA==
X-Gm-Message-State: AOAM5337vrf1A1odDkuLOdK99ndc7UxRPowqdkdFQVcJsCJ4jtfkkuDG
        Q98bgrY0Wspdl5MCB4dCbaY2roh0s3w6xXeJaPWRLaDF9OkosckHuluNw2ivlmNsk9rueUNaIK9
        CcgTBlDguFmKRJnfEuV1OdsMZ
X-Received: by 2002:adf:e389:: with SMTP id e9mr27427046wrm.424.1623237501923;
        Wed, 09 Jun 2021 04:18:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxOLZzQ5/x7hlD+8shRSv+b5ugVVvpIrozrvEwykG0k3f1jFUc3fyD9nSe/yijhIjCFM9mNQ==
X-Received: by 2002:adf:e389:: with SMTP id e9mr27427036wrm.424.1623237501773;
        Wed, 09 Jun 2021 04:18:21 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c611d.dip0.t-ipconnect.de. [91.12.97.29])
        by smtp.gmail.com with ESMTPSA id q3sm23778565wrz.71.2021.06.09.04.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 04:18:21 -0700 (PDT)
Subject: Re: [PATCH] mm/nommu: unexport do_munmap()
To:     Liam Howlett <liam.howlett@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210604194002.648037-1-Liam.Howlett@Oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <cb975b7f-b8f0-dc33-7a5c-c488157ecf6e@redhat.com>
Date:   Wed, 9 Jun 2021 13:18:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210604194002.648037-1-Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.06.21 21:40, Liam Howlett wrote:
> do_munmap() does not take the mmap_write_lock().  vm_munmap() should be
> used instead.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>   mm/nommu.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 0997ca38c2bd..3a93d4054810 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1501,7 +1501,6 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struct list
>   	delete_vma(mm, vma);
>   	return 0;
>   }
> -EXPORT_SYMBOL(do_munmap);
>   
>   int vm_munmap(unsigned long addr, size_t len)
>   {
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

