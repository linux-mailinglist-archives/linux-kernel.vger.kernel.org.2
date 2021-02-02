Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0159030C29B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 15:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhBBO41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 09:56:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233019AbhBBOzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612277624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63iUIFUeXpHPrYf2eKlD+tbc5HBRhOL3GBF5o8JxTlk=;
        b=AecdHk59BaWFIhfosA8h4M6FOExtBAzF0tI+McGk9/kyFcM/ahFjtsH4SLn11bYxzvmy5M
        jLFDcz6227VDulba4oqFQP5UAYNLdTTIXaIT79rNZKz3MYWeERo3b7TWwi8uS1Je4Qwber
        6VSwURCx3p3CS8xMiQ8FbgVUDXk0jps=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-STswga_eNPm23MSLpo_Wrw-1; Tue, 02 Feb 2021 09:53:42 -0500
X-MC-Unique: STswga_eNPm23MSLpo_Wrw-1
Received: by mail-ed1-f70.google.com with SMTP id y6so9697769edc.17
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 06:53:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=63iUIFUeXpHPrYf2eKlD+tbc5HBRhOL3GBF5o8JxTlk=;
        b=A5dJ9b+t9zrC5E0DKgd+KJ4P1KtxIj+1ya7unWxBfjYvFAsbx9ArxIgFkGDPe3EZVb
         /CT09AAmZJNTiIbJFrEXZw/ZS8XDq3XAzBW9fcjvAaEHeaRo37NG4G1f4wnn73aiBzRw
         8fAj8SPF5n0AX0zckZ2cy1OfFz7U1JD8C5wMcp5JY9GJi8RFrelIBYyrFYgnr50rQLKU
         JVMg/66ohjLfxk5wGRyEHrjZiN6goee4M0tUJ4iF5pNBUDdFZw1i4zWYqGIwoLyrNV62
         O4Wkp/sKiB+dOuxS+pEJ+QO/+9LwJDkBIOsTgGnhzlAD+FKQpN/sf1lm4gIaN7vJvwUR
         bMtA==
X-Gm-Message-State: AOAM531s9p6NLwLT2NdIy9acDRKQiqoxUYn7JuNdNqXcVUDKY8X8NIlG
        Mih8PDRHWuH6vLuCV8EskehtWTtr0wxeqWhjZETznqeeo26HmDAMryaD/mxlQtA1qTTqxeUtni8
        FDk5gZSUjRp7BtrUDHAuxuGLIWKbgxu3pZ4OKQ3GTWEAHc5I+cawrIPgHCDDkmuz+fH47VyMC1m
        jV
X-Received: by 2002:aa7:da98:: with SMTP id q24mr24166767eds.370.1612277621023;
        Tue, 02 Feb 2021 06:53:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxS9mIrFl6AZTBNvZUMHlM02ABoapOleP6I0hNt3ggSqA97e6S5oPNkoPpxyqUQzT6OIB0y9w==
X-Received: by 2002:aa7:da98:: with SMTP id q24mr24166742eds.370.1612277620810;
        Tue, 02 Feb 2021 06:53:40 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x17sm9996283edd.76.2021.02.02.06.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 06:53:39 -0800 (PST)
Subject: Re: [PATCH v14 11/11] selftests: kvm/x86: add test for pmu msr
 MSR_IA32_PERF_CAPABILITIES
To:     Like Xu <like.xu@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, ak@linux.intel.com,
        wei.w.wang@intel.com, kan.liang@intel.com,
        alex.shi@linux.alibaba.com, kvm@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210201051039.255478-1-like.xu@linux.intel.com>
 <20210201060152.370069-1-like.xu@linux.intel.com>
 <20210201060152.370069-5-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f77954f5-02ad-8a40-d7d3-31614628b007@redhat.com>
Date:   Tue, 2 Feb 2021 15:53:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210201060152.370069-5-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/21 07:01, Like Xu wrote:
> 
> +uint64_t rdmsr_on_cpu(uint32_t reg)
> +{
> +	uint64_t data;
> +	int fd;
> +	char msr_file[64];
> +
> +	sprintf(msr_file, "/dev/cpu/%d/msr", 0);
> +	fd = open(msr_file, O_RDONLY);
> +	if (fd < 0)
> +		exit(KSFT_SKIP);
> +
> +	if (pread(fd, &data, sizeof(data), reg) != sizeof(data))
> +		exit(KSFT_SKIP);
> +
> +	close(fd);
> +	return data;
> +}

In order to allow running as non-root, it's better to use the 
KVM_GET_MSRS ioctl on the /dev/kvm file descriptor.

The tests pass, but please take a look at the kvm/queue branch to see if 
everything is ok.

Paolo

