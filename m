Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C4941983F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhI0PxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:53:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235100AbhI0PxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632757905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/vgpSXmiTJjoeFVzvxVktr7agfW9UwhR9y61Ap04cEk=;
        b=dg1M2tErlrZL2UZ5+qxSyU5xjL8aS4sHgpfmVyOJkzXV1pI0ndsuPWoivZDw3tPzH8BXZl
        4S0xqe6bP55zgTmhwosxquGEXko+B4gSzRRatp1PJdFXFlgVYQc8fU5BfRFX4vDelcIvs+
        tsWM13zYfxvKZN97Otj07X9rqusWaXU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-Awii3jzhPUGjT4rCBDaSQw-1; Mon, 27 Sep 2021 11:51:44 -0400
X-MC-Unique: Awii3jzhPUGjT4rCBDaSQw-1
Received: by mail-wr1-f72.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso14209346wrb.20
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/vgpSXmiTJjoeFVzvxVktr7agfW9UwhR9y61Ap04cEk=;
        b=xqzpzU5ZMjkEwyurOaNNtenCkqnVbw7g0rad6M1U2UJzll+9EkctrXwpTynGSuEMo4
         wY52OBDfVJMJQCie9fgN/4YKc4sY9qYqp8at9XRjCzadc/JggbLxTZe6BYr1Xi3KFz6U
         40U3Lgp8HPHKSkcnYM3p09KLtycqBaSXkNm76HyCACTChAqLIDnYCVZAggLvH95eHxHA
         YFteaK263CjESGmPmrQ47ew177yFfIoWbAF1FR1asOaHQ5vV8cwEttBDl6KizChSUWCz
         a1dfJ9u8haJKsqUIi3SQ0pY15ccu6E6zXsmVURGx6cMVVk/sX9Dc5nE6oKwbGB4G/t5t
         OeFg==
X-Gm-Message-State: AOAM530Csnnl2m+buyEhvYz4FR6l8hjYmFNmYBjarILTMSA63K/pueJa
        mcG0cVPgtVL1HL0UDDtLnENepu0MLEjFf9ICq1dViaUmP/PFiuZmrezbeKM84hBXUsyOuv6X8Oe
        pUPk8fosQzYDP/3A0Z5RhkUYU
X-Received: by 2002:a1c:a78d:: with SMTP id q135mr685570wme.36.1632757903078;
        Mon, 27 Sep 2021 08:51:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWTyyR4BQrL35V7YoVFE/8tnjzyceGwJuLvzKyMN+8BuumNqGsYOneMg0dw3n5qeSkT146PA==
X-Received: by 2002:a1c:a78d:: with SMTP id q135mr685553wme.36.1632757902915;
        Mon, 27 Sep 2021 08:51:42 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c654d.dip0.t-ipconnect.de. [91.12.101.77])
        by smtp.gmail.com with ESMTPSA id c18sm9623733wmb.27.2021.09.27.08.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 08:51:42 -0700 (PDT)
Subject: Re: [RFC] arm64: mm: update max_pfn after memory hotplug
To:     Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
References: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
 <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <833493d2-d585-47ee-c258-79eae5deff36@redhat.com>
Date:   Mon, 27 Sep 2021 17:51:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.09.21 00:54, Chris Goldsworthy wrote:
> From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> 
> After new memory blocks have been hotplugged, max_pfn and max_low_pfn
> needs updating to reflect on new PFNs being hot added to system.
> 
> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> ---
>   arch/arm64/mm/mmu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index cfd9deb..fd85b51 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1499,6 +1499,11 @@ int arch_add_memory(int nid, u64 start, u64 size,
>   	if (ret)
>   		__remove_pgd_mapping(swapper_pg_dir,
>   				     __phys_to_virt(start), size);
> +	else {
> +		max_pfn = PFN_UP(start + size);
> +		max_low_pfn = max_pfn;
> +	}
> +
>   	return ret;

Note: didn't verify if updating max_low_pfn is correct here.

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

