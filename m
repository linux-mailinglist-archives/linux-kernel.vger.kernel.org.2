Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A5D3F9E00
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbhH0RYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343495AbhH0RYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:24:23 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC76C0612A5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:23:10 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 2so6229294pfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pW2KRXINIECq2UqrMAjVuApe68m2StZHA9v7va6qTiU=;
        b=rYBmoVs975N+yu2934Kl7Ag8dNi2tkW5MPQBPsQWMJceqaAUViMJX5p8VTsmrLat2L
         1kJT1N4rNPJvHYN4v8xV4LZQQiN0gVYVxxZoK0AWZMQtgbtlsholocVLBSLsdQUjTc7K
         EO/n6pcBnNhyHknntLRnjl3c7dPZnYup1ZY4k8dYXcB6+XwMELnSDRN8GScTXVD9wLYw
         72HE/X1LKTlO7T9MyRzf3/jBybVrYz/zMXfVi26QTtQIvfOSsE3Kyet1JW3IoRhxG7Z4
         s9RsOEhsC/QREunQ94/foNgn4vxgTRk3Re13QZxXDPqu5Xx6dQ43rKJdU90h8PsbIabZ
         TDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pW2KRXINIECq2UqrMAjVuApe68m2StZHA9v7va6qTiU=;
        b=NyVLtw4i17FRGZVa+Wq/MUvS3bqkQ88+O5hnIXZP65GwZ7wQVIBpYbEk6eG7BYk/rd
         zkhO6AZ12XgBBv0snpGyW9ZJzFZH/7HHURgW16ysv8WZ4gfDdJP/JC9Z+cq2/Iun1hHE
         2/MRaQJnqqfK1hbbTZLijf/0xC5nP4p0qvgVe8NK2B88+REXuqPuLzGmTiy2BF17d7eG
         zTWkSlcNGtBupxa+pxJWn2dzkKgwWmpC2XcoxCGXHDhEKCsezIgIcOniBJ3a+V07IWUm
         08N0IXfjBDwwRA33OAUcrFPUkBgLalhfIgZBq96i6YGliIU5CSPfuNduGESq43tDnd1x
         aeAA==
X-Gm-Message-State: AOAM53397+mEAaRjPCety9Kn3USK15sBuCJWx+kHT9s3qOLKlbhbm44Y
        PWwefpGPwtXr9EAUaBIUhNPTiw==
X-Google-Smtp-Source: ABdhPJz+T5dgH3sIVem/Dht2xu+EGET8qPyEg43yvrgPII1mSQTEgb7AA1JRyZkdBQMuVGObTA+XjQ==
X-Received: by 2002:a63:ef14:: with SMTP id u20mr8773852pgh.13.1630084990019;
        Fri, 27 Aug 2021 10:23:10 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n24sm7386923pgv.60.2021.08.27.10.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 10:23:09 -0700 (PDT)
Date:   Fri, 27 Aug 2021 17:23:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Zhu Lingshan <lingshan.zhu@intel.com>
Cc:     peterz@infradead.org, pbonzini@redhat.com, bp@alien8.de,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, kan.liang@linux.intel.com, ak@linux.intel.com,
        wei.w.wang@intel.com, eranian@google.com, liuxiangdong5@huawei.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
        like.xu.linux@gmail.com, boris.ostrvsky@oracle.com,
        Like Xu <like.xu@linux.intel.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Guo Ren <guoren@kernel.org>, Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH V10 01/18] perf/core: Use static_call to optimize
 perf_guest_info_callbacks
Message-ID: <YSkfeXcd6nUT3AOJ@google.com>
References: <20210806133802.3528-1-lingshan.zhu@intel.com>
 <20210806133802.3528-2-lingshan.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806133802.3528-2-lingshan.zhu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021, Zhu Lingshan wrote:
> @@ -2944,18 +2966,21 @@ static unsigned long code_segment_base(struct pt_regs *regs)
>  
>  unsigned long perf_instruction_pointer(struct pt_regs *regs)
>  {
> -	if (perf_guest_cbs && perf_guest_cbs->is_in_guest())
> -		return perf_guest_cbs->get_guest_ip();
> +	unsigned long ip = static_call(x86_guest_get_ip)();
> +
> +	if (likely(!ip))

Pivoting on ip==0 isn't correct, it's perfectly legal for a guest to execute
from %rip=0.  Unless there's some static_call() magic that supports this with a
default function:
	
	if (unlikely(!static_call(x86_guest_get_ip)(&ip)))
		regs->ip + code_segment_base(regs)

	return ip;

The easiest thing is keep the existing:

	if (unlikely(static_call(x86_guest_state)()))
		return static_call(x86_guest_get_ip)();

	return regs->ip + code_segment_base(regs);

It's an extra call for PMIs in guest, but I don't think any of the KVM folks care
_that_ much about the performance in this case.

> +		ip = regs->ip + code_segment_base(regs);
>  
> -	return regs->ip + code_segment_base(regs);
> +	return ip;
>  }
