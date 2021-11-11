Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A92B44D6C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 13:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhKKMqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 07:46:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58453 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232126AbhKKMq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 07:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636634619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKc3H6CdVhgitN4KLFQLoNDBlrzn28pYKJNfimv2lu8=;
        b=THtVbcNgIklQXs+pg42nnslrr2HM4e44fvDVys86dreuGltB1qLKuQp8kpm6CEZeHcnRmX
        rCPzEDn+tMPfEIyHFEoz/8Qyx6XaLeh12T9JHKTzkZ7S9Bv3tZ/VtsI0snCy+YlYwnnWbW
        Xbc5JSLZaUR510MuwxeRYEQZ62F0NRg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-1ttEmdbIOc6h_sXR-dLvQw-1; Thu, 11 Nov 2021 07:43:38 -0500
X-MC-Unique: 1ttEmdbIOc6h_sXR-dLvQw-1
Received: by mail-ed1-f71.google.com with SMTP id m8-20020a056402510800b003e29de5badbso5286357edd.18
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 04:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uKc3H6CdVhgitN4KLFQLoNDBlrzn28pYKJNfimv2lu8=;
        b=tgXKzbd3qkwBj+d7nJN/2Dakf27KMgMzLofFCm++V9SnzwsQm3E0kTX+2UjZvS4WL3
         xsluOTUmBh5CILjOGNKukuJPJLlF/2NZtBPeNzlhCrq3FORm5dwVOhyn918eYAOkuzOQ
         uzHTgN7mxefiK7Qbn/IrYAsg6gTfaQY7+IfwQlMl6EE/5rBqHhnd7GlY0xBVUeDUY1HA
         Vz/hiX/qRzNKuMinPPoWLcEB1+lE8+aB2k+GuPW2TEVh2m0hVaPFzu/WYbQpv+zSfikU
         afplcFO+e3UYzNXrsvvj6mCvlW2pfWoRilJIL7zpKo8jahK1JZv3ltnw+jXB+Wi6SJnA
         X4Yg==
X-Gm-Message-State: AOAM5304Hfe9uJQEgJGoY/HCRAvuV6Bd92SzaoCpgYkpEy+uo7FBICql
        a/5mwJ3tuO9lBNkZGsRttE3UJGDcglu5+N1Lcr3KMTd4ResWDt57n3FmoKLOEIzk/Wuc5s5A10Q
        SXJECIHp0ypLN2rqHm3bByDJW
X-Received: by 2002:a05:6402:182:: with SMTP id r2mr9526820edv.313.1636634617079;
        Thu, 11 Nov 2021 04:43:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTF5sKqZoFHMlKzl2tzmMRD3+TAcCnipEnTedxAFD66OImX4D5Ep2weTMCJWFrYKvY0Ps/kw==
X-Received: by 2002:a05:6402:182:: with SMTP id r2mr9526695edv.313.1636634616235;
        Thu, 11 Nov 2021 04:43:36 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id ga1sm1296408ejc.40.2021.11.11.04.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 04:43:35 -0800 (PST)
Message-ID: <83984ea7-9658-4f7d-36bf-b47123329ef4@redhat.com>
Date:   Thu, 11 Nov 2021 13:43:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 0/5] Add Guest API & Guest Kernel support for SEV live
 migration.
Content-Language: en-US
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     seanjc@google.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, joro@8bytes.org, bp@alien8.de,
        Thomas.Lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        brijesh.singh@amd.com, dovmurik@linux.ibm.com, tobin@linux.ibm.com,
        jejb@linux.ibm.com, dgilbert@redhat.com
References: <cover.1629726117.git.ashish.kalra@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <cover.1629726117.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 13:03, Ashish Kalra wrote:
> adds guest api and guest kernel support for SEV live migration.
> 
> The patch series introduces a new hypercall. The guest OS can use this
> hypercall to notify the page encryption status. If the page is encrypted
> with guest specific-key then we use SEV command during the migration.
> If page is not encrypted then fallback to default. This new hypercall
> is invoked using paravirt_ops.
> 
> This section descibes how the SEV live migration feature is negotiated
> between the host and guest, the host indicates this feature support via
> KVM_FEATURE_CPUID. The guest firmware (OVMF) detects this feature and
> sets a UEFI enviroment variable indicating OVMF support for live
> migration, the guest kernel also detects the host support for this
> feature via cpuid and in case of an EFI boot verifies if OVMF also
> supports this feature by getting the UEFI enviroment variable and if it
> set then enables live migration feature on host by writing to a custom
> MSR, if not booted under EFI, then it simply enables the feature by
> again writing to the custom MSR.

Queued, thanks.

Paolo

