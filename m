Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11674193EC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbhI0MRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48976 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234073AbhI0MQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632744919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xfGw456gQ82ABMdVQA6RV36suyfhz5P7yHLPAXAnVXo=;
        b=d7nSrpax0TV87RgWD7LzXTXA9fuuVOI1uv2oFJnZ3AQnUMGNDgf+x+KTIa2awZwH2kB8vJ
        +P2TtpXIvmVyfmIT5yT/Jo3zh8RXhjxGfenzUZxKlp6aJ0tU5nWs37sNb3mMqw4kTWnuRm
        DNaCJvCE8axavWrYWs8FR3rBWQVRmg8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-peYaDu2lNTSY9NYdpiGHuA-1; Mon, 27 Sep 2021 08:15:17 -0400
X-MC-Unique: peYaDu2lNTSY9NYdpiGHuA-1
Received: by mail-ed1-f72.google.com with SMTP id ec14-20020a0564020d4e00b003cf5630c190so17673331edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xfGw456gQ82ABMdVQA6RV36suyfhz5P7yHLPAXAnVXo=;
        b=hIgPxstuHOrbp5YlfWd3WjpYlDezZb77/jbhmrWHZ3dnkJ/CeamEH69SjszRPzoTqK
         SRAMVRGd+4dry93mRN9HTr+l1ofrRK5mfz7LlKQPyPIFX/nYW0cHOtIBrmDmdK0XHsoq
         +0sywNcs+oXgsX6MBVwRWCycDkEU69uNBLdwWZuKF3GpKfykk95tjyUciW2qUKWECOvd
         t/x+q6RG8RZ0JPlIvteXdkn9h+T4pKwXUqxFUW2TICQsdv/C2VEXcVODcbJGniDvP6P5
         pJIP4P5LYXkqNSGoDgKm3ncTQ3dMMQuvpj84tJDOWlXOAbqD9EuJZ5Vrwyz5Wb8mmuqy
         ExkA==
X-Gm-Message-State: AOAM531lef7mVmhA1l1hfQu+LATAUKqwJ3wrpWFCFsl4aXr0Z/faOPlM
        sMgGmOGogvT/VfarxlT/3kJMAMZ42ABhyappDh1ONhJR4d3PfsQupVCa3h3viUyzNEkIwFy5wQE
        ct/0Dmqe7SG2HiF1Gj3qjE3Je
X-Received: by 2002:a17:906:645:: with SMTP id t5mr26598283ejb.163.1632744916821;
        Mon, 27 Sep 2021 05:15:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYrlEJwbP/ga5Kfs4eTDSfaiizoMsvrkJq+jpz3Bdf3pQgRF3DIzW7YPNIyOgL0671UqQlYg==
X-Received: by 2002:a17:906:645:: with SMTP id t5mr26598256ejb.163.1632744916639;
        Mon, 27 Sep 2021 05:15:16 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p24sm10309001edq.27.2021.09.27.05.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 05:15:15 -0700 (PDT)
Message-ID: <bcd40d94-2634-a40c-0173-64063051a4b2@redhat.com>
Date:   Mon, 27 Sep 2021 14:14:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] KVM: x86: Expose Predictive Store Forwarding Disable
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Babu Moger <babu.moger@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tony.luck@intel.com, peterz@infradead.org,
        kyung.min.park@intel.com, wei.huang2@amd.com, jgross@suse.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <163244601049.30292.5855870305350227855.stgit@bmoger-ubuntu>
 <YVGkDPbQmdwSw6Ff@zn.tnic> <fcbbdf83-128a-2519-13e8-1c5d5735a0d2@redhat.com>
 <YVGz0HXe+WNAXfdF@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YVGz0HXe+WNAXfdF@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/21 14:06, Borislav Petkov wrote:
>> Because the guest kernel needs to know which MSRs to write when you touch
>> the SSBD prctl, so that PSFD is properly disabled*inside the guest*.
> It already knows which - the same one which disables SSB. PSF is
> disabled*together*  with SSB, for now...

Right, not which MSR to write but which value to write.  It doesn't know 
that the PSF disable bit is valid unless the corresponding CPUID bit is set.

Paolo

