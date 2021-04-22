Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29D6367B21
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhDVHbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:31:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235037AbhDVHbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619076670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XgTehN3/NyaVKZ7FW4MkOjMjlpGG8PCtMVmQI1FgYuU=;
        b=fiPRNTVeOWIDv3vtpoxI76hUt1yf5t88HPT2gW6OitWd6Qd0RSi7t09PRvU+eTBd0kmT0D
        sUJ5I3EkRniSIvz1EWX5Fat3Co5KPFd/OzE6PEPBCXBOlpyffz3EjNS62Qs542Tu5H2FK4
        TZnRH3DaATkUEbg+tirkuMe+U78vdsQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-kjztQR0QOd6ghpqQhD73jQ-1; Thu, 22 Apr 2021 03:30:05 -0400
X-MC-Unique: kjztQR0QOd6ghpqQhD73jQ-1
Received: by mail-ed1-f69.google.com with SMTP id v5-20020a0564023485b029037ff13253bcso16243259edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XgTehN3/NyaVKZ7FW4MkOjMjlpGG8PCtMVmQI1FgYuU=;
        b=SiUpzaHxb9/XsYs7sDyH4R4krysgGCKtC9ykTVOUHwkCVd38w3FuXZqKYQto+ggeir
         wDx6V1kQ9to38BmgLX9kg9npQvdSNP+7meR8BzBH1Ia4z4GFC775f+RATDibSVKG4dgP
         QmrmmGE8ZcK6ruaGMbzInsfKi9snXWg2zTDDzHJhlBZ2T5HUazVpNEgbECszs75U0zj3
         4MypUo+8e07ODUosO+HS47RY3V2pWz7LD08aDrNWMvrHY6eaXb5zNPEZZWAmv+9WJ3YX
         X1EbtEy9uw99tiy6wRLFjqd6WkFQp7JZ4kbua7qNdebU99yzWuHQ0T8XQkjVz4n7iAX9
         71Lw==
X-Gm-Message-State: AOAM533kjJYc/cQmH6H1AydWcBUhZzO+AgKWQIQ7LH0iaLwFe8h6zsE8
        4Tl5W1ttl6a+uncMSx9frYFPji65GOeOg4DXiGIsegVVePffCDhA0KdaJNfd0LNsPII76zdXYVQ
        QAk8/38SUp2k8DGRvXVMqbviY
X-Received: by 2002:a05:6402:451:: with SMTP id p17mr2050250edw.223.1619076604149;
        Thu, 22 Apr 2021 00:30:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiNMCMSKUrm1BcR/2l+x4SSrt+dlYKfzqOC2tNMELsxcx0vTAuCEjJNb0Lu5qru537VaKKnw==
X-Received: by 2002:a05:6402:451:: with SMTP id p17mr2050227edw.223.1619076603937;
        Thu, 22 Apr 2021 00:30:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id z17sm1297427edx.36.2021.04.22.00.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 00:30:03 -0700 (PDT)
Subject: Re: [PATCH v5 15/15] KVM: SVM: Skip SEV cache flush if no ASIDs have
 been used
To:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20210422021125.3417167-1-seanjc@google.com>
 <20210422021125.3417167-16-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7e15de5-5b04-7a33-1d7d-81edf07193ba@redhat.com>
Date:   Thu, 22 Apr 2021 09:30:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210422021125.3417167-16-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 04:11, Sean Christopherson wrote:
> +	int ret, pos, error = 0;
> +
> +	/* Check if there are any ASIDs to reclaim before performing a flush */
> +	pos = find_next_bit(sev_reclaim_asid_bitmap, max_sev_asid, min_asid);
> +	if (pos >= max_asid)
> +		return -EBUSY;

There's a tiny bug here which would cause sev_flush_asids to return 0
if there are reclaimed SEV ASIDs and the caller is looking for an SEV-ES
ASID, or vice versa.  The bug used to be in __sev_recycle_asids, you're
just moving the code.

It's not a big deal because sev_asid_new only retries once, but we might
as well fix it:

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 02b3426a9e39..403c6991e67c 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -74,12 +74,13 @@ struct enc_region {
  	unsigned long size;
  };
  
+/* Called with the sev_bitmap_lock held, or on shutdown  */
  static int sev_flush_asids(int min_asid, int max_asid)
  {
  	int ret, pos, error = 0;
  
  	/* Check if there are any ASIDs to reclaim before performing a flush */
-	pos = find_next_bit(sev_reclaim_asid_bitmap, max_sev_asid, min_asid);
+	pos = find_next_bit(sev_reclaim_asid_bitmap, max_asid, min_asid);
  	if (pos >= max_asid)
  		return -EBUSY;
  

Paolo

>   	/*
>   	 * DEACTIVATE will clear the WBINVD indicator causing DF_FLUSH to fail,
> @@ -87,14 +92,7 @@ static inline bool is_mirroring_enc_context(struct kvm *kvm)
>   /* Must be called with the sev_bitmap_lock held */
>   static bool __sev_recycle_asids(int min_asid, int max_asid)
>   {
> -	int pos;
> -
> -	/* Check if there are any ASIDs to reclaim before performing a flush */
> -	pos = find_next_bit(sev_reclaim_asid_bitmap, max_sev_asid, min_asid);
> -	if (pos >= max_asid)
> -		return false;
> -
> -	if (sev_flush_asids())
> +	if (sev_flush_asids(min_asid, max_asid))
>   		return false;
>   
>   	/* The flush process will flush all reclaimable SEV and SEV-ES ASIDs */
> @@ -1846,10 +1844,11 @@ void sev_hardware_teardown(void)
>   	if (!sev_enabled)
>   		return;
>   
> +	/* No need to take sev_bitmap_lock, all VMs have been destroyed. */
> +	sev_flush_asids(0, max_sev_asid);
> +
>   	bitmap_free(sev_asid_bitmap);
>   	bitmap_free(sev_reclaim_asid_bitmap);
> -
> -	sev_flush_asids();
>   }
>   
>   int sev_cpu_init(struct svm_cpu_data *sd)
> 

