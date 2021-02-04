Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B0230F990
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbhBDRWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:22:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238430AbhBDRUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612459159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svxv4qHQFsjuspjy9H8OUHej/pXhuE68vUQIP6dXJ/4=;
        b=F0N5R5LMOXwbegx2bR1PfbmsbpDZtW8ek/DNo6p+9QlkcPnjp/2CS/oGLQwPcJWP0357+L
        DZPwNUMuS0yyuuzMIiDN4K4ftPAFYVMAEPVW9XGvfaaGTAfVbhUoYi7Qc4yLPixfgP9c6I
        Ifyifz82Qc2CoP5pxUmj28JiWfZzWvc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-wIBWxoY-McGviIt9n-dO9A-1; Thu, 04 Feb 2021 12:19:17 -0500
X-MC-Unique: wIBWxoY-McGviIt9n-dO9A-1
Received: by mail-wr1-f71.google.com with SMTP id l10so3178505wry.16
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 09:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=svxv4qHQFsjuspjy9H8OUHej/pXhuE68vUQIP6dXJ/4=;
        b=HUAGtl6iut242hDSpSi48FevyUqID9NCchSJ18cYdDuc6LEOl8lrL2THutM+shrgEo
         xR80PqaYpNWGt2BXBL/Pbizt3PVOTb9KdBXcHKIt4pkNMPOnEbneI8bZ/D1KLY85fHY6
         vTGdZFN+pVqIjpbe2qfkiNmEWt4sH8Pu9o+2ecqBWMNwqC/FsWaZXMviAhv6Vy30oMMq
         Srnf/jX/MnrvSVrBP101fGIltpPcTY6TboDqtKvu1aoU9yKkedLN8HZ98KdtIL5jPkq5
         R3pmXUHePO2EZlo8dW9aY1ZZIn0TMOz/vOpNnyEg0B/A9aQaI6YGNzQRTYR7IEu2bvhF
         5vpA==
X-Gm-Message-State: AOAM533XY9k6pzOfa4iOHmFJUSN6eQ+vjiGk7VdRZ1ZGgvOrxOSrRM3D
        FYxJUi3Y86NRxR9tvT0B+jH9AmIWrzHTF7Em5/Gj1pVghzUg0RidU6xslv2mUNgC+KWrt1GMhvQ
        UzlDVPyEnz8xBTT7GZwqja/I0
X-Received: by 2002:a5d:4d08:: with SMTP id z8mr431591wrt.240.1612459155982;
        Thu, 04 Feb 2021 09:19:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTw9mCRRbJKUqPWl3+xwvMGDovGs/dhnqnx6zj4Qqqsg5EuahQrAPC93yk1JaoSgJaBIOgag==
X-Received: by 2002:a5d:4d08:: with SMTP id z8mr431581wrt.240.1612459155833;
        Thu, 04 Feb 2021 09:19:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k4sm9679664wrm.53.2021.02.04.09.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 09:19:15 -0800 (PST)
Subject: Re: [PATCH] mm: Export follow_pte() for KVM so that KVM can stop
 using follow_pfn()
To:     Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@google.com>,
        Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        kvm@vger.kernel.org
References: <20210204171619.3640084-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <42ac99c2-830e-e4b7-00b9-011d531a0dda@redhat.com>
Date:   Thu, 4 Feb 2021 18:19:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210204171619.3640084-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/21 18:16, Sean Christopherson wrote:
> Export follow_pte() to fix build breakage when KVM is built as a module.
> An in-flight KVM fix switches from follow_pfn() to follow_pte() in order
> to grab the page protections along with the PFN.
> 
> Fixes: bd2fae8da794 ("KVM: do not assume PTE is writable after follow_pfn")
> Cc: David Stevens <stevensd@google.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: kvm@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> Paolo, maybe you can squash this with the appropriate acks?

Indeed, you beat me by a minute.  This change is why I hadn't sent out 
the patch yet.

Andrew or Jason, ok to squash this?

Paolo

>   mm/memory.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index feff48e1465a..15cbd10afd59 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4775,6 +4775,7 @@ int follow_pte(struct mm_struct *mm, unsigned long address,
>   out:
>   	return -EINVAL;
>   }
> +EXPORT_SYMBOL_GPL(follow_pte);
>   
>   /**
>    * follow_pfn - look up PFN at a user virtual address
> 

