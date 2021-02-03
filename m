Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E35F30D4A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhBCIGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:06:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232474AbhBCIGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612339482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+oG1iepI5e+YoRSW15dR/Lg6jPhIDaE96zUxkSlCngY=;
        b=OcYuoymMmPzvZXB9CsrD2Dtumsbz6uzxWN+NAMZ0pSwW6spKmv1snEhYwEIkKUJPyDl4xB
        S11xf7nYA8sQVXLDVLDsq3UVw2uLJqSt5L+euPu8iq240kHsEYeOnfcu2skQcuSf6wiB1u
        OLjXgJ9LwRWwMBefsAG0sR6qbe1eWSM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-ySLSXRxYMRqi7iuqwo9-oQ-1; Wed, 03 Feb 2021 03:04:40 -0500
X-MC-Unique: ySLSXRxYMRqi7iuqwo9-oQ-1
Received: by mail-ej1-f71.google.com with SMTP id eb5so1835352ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 00:04:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+oG1iepI5e+YoRSW15dR/Lg6jPhIDaE96zUxkSlCngY=;
        b=Epd+6M5+RLhAv5N8JyaCeBJHodpGlEL6eFSajOeXrhbtRTR8fHLjKuMRoTFLsah9b+
         FtS8f6u8uMfaEPcKO/bNkUcfHuns0UAKioSlVqNjLsqt4r2+SiwQh30o85+Kl5EsiJZT
         +g/fH9r6D43aZwQKvFJHZxvlb96eb5b/7Mpr+WSByYvYMlsxOVUPIJ/NGfCiE45Lh2Wq
         qSXtU0jOrSvzUEjblye2O8ZcP/w4tli0EcXVgwBoR0WVbe4jhTUGBJJFlRybpYaRK/d3
         pSznmDDtJ7cL7MSoXaE/bFjCJr6pFs7OJBgwNwmX0xEfvUFX7vty5HXtdlpLms8L+JuB
         6VMA==
X-Gm-Message-State: AOAM531PRdFTzUYjCNtl5zkpfzilt5Zjz0+0H3hQAiwC1JFgjl8Bm/g1
        BzuvguyQUzmEc1Q8b80hQp5W3pju94v9xqbrSvqMa/CA4KKQnwJuhE2XfGDDvHLwBK5t1kvo7sL
        iWkjBo87liL0165AGD6SIipBt
X-Received: by 2002:a17:906:9249:: with SMTP id c9mr2055019ejx.416.1612339479659;
        Wed, 03 Feb 2021 00:04:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9ieYS7R8bKJ//fPnjyvJXLt8OWDR0VRxfS3newcnOgK3FN3F9pIY3diGwH0IR9kZERgI0pA==
X-Received: by 2002:a17:906:9249:: with SMTP id c9mr2054998ejx.416.1612339479416;
        Wed, 03 Feb 2021 00:04:39 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id o11sm483181eds.19.2021.02.03.00.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 00:04:38 -0800 (PST)
Subject: Re: [PATCH v4 1/3] KVM: SVM: use vmsave/vmload for saving/restoring
 additional host state
To:     Sean Christopherson <seanjc@google.com>,
        Michael Roth <michael.roth@amd.com>
Cc:     kvm@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210202190126.2185715-1-michael.roth@amd.com>
 <20210202190126.2185715-2-michael.roth@amd.com> <YBnwaiy8L/O0PCrR@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <509b0e43-7f15-53bc-ab08-e27edbb855f8@redhat.com>
Date:   Wed, 3 Feb 2021 09:04:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YBnwaiy8L/O0PCrR@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/21 01:38, Sean Christopherson wrote:
>>   
>> +static inline void vmload(hpa_t pa)
> This needs to be 'unsigned long', using 'hpa_t' in vmsave() is wrong as the
> instructions consume rAX based on effective address.  I wrote the function
> comment for the vmsave() fix so that it applies to both VMSAVE and VMLOAD,
> so this can be a simple fixup on application (assuming v5 isn't needed for
> other reasons).
> 
> https://lkml.kernel.org/r/20210202223416.2702336-1-seanjc@google.com
> 

Yup, fixed.

Paolo

