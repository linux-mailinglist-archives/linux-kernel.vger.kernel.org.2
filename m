Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD9E3FE479
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbhIAVDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52096 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244913AbhIAVDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630530165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nBI2ltINoLF2WMdaOQSg8GJs4aIarAV4j3nj9NG4RCY=;
        b=HByoika+oOEO8lw/ZOUcWUwDCrQnHgKm2FQSoPaVxYCEJQoevFTusP7iBADyaSaVAVb+no
        ESiVyXlLwa1/1pI59YMEiplIeqJW+TxJV9L0pJAiVVXTDatgOzjNEdYnM6gMZslniEZ8AX
        NHQVsQYHDe6qQgn0MHh1Y+AOxgY4HfQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-2_sAma2fOimueUp2PzDDVA-1; Wed, 01 Sep 2021 17:02:44 -0400
X-MC-Unique: 2_sAma2fOimueUp2PzDDVA-1
Received: by mail-ot1-f71.google.com with SMTP id r10-20020a056830448a00b0051b9c05a2a8so529232otv.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nBI2ltINoLF2WMdaOQSg8GJs4aIarAV4j3nj9NG4RCY=;
        b=AvJx/EoTrf4KIWhgjXx+1XmaWNeuWyJ61kpQ02yBzEP2eqfWmTbaWy+excajZ0h8vO
         fR8HhR2SAM1E9KvMLimMgHRC23g1i6aTKddmbFeZk86M0R+H6Z/xFfr4TyW6zhLIK1AT
         g//F2tL7w2Ohhfep826gZVYQLAr7Fc4ALfMahyvoppP0tcMCPr8d1qIQtfYaqEi06Zgk
         jD2m3m7UxyJZSO1CK8myxs5EYxHK9XP74HZkPsn79Jr1mVByXHa321MfJXML/hDrqHjn
         AOYToBJ1FRWBUskLkEa2jkcK1Hr9tot+l7/kz7s2NeeTSk0U57Aje8T0W3EPnW1sHXYg
         srNQ==
X-Gm-Message-State: AOAM531cG+WrhykTWE2fMkpdHjE6PFGh/2YGedbLZnQcwPrFbST+dN5L
        0NYfP9n1TBktetPRsAlpCWjVrcEiaLsrLFl7VcU72g9I3kIYIVDvYaZz6mOAwBNM2Kgrb+RhH/2
        Flf0EwtOFTDPsjx7BZSq/KV3n
X-Received: by 2002:a9d:2278:: with SMTP id o111mr1184909ota.229.1630530163657;
        Wed, 01 Sep 2021 14:02:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVUSuG9t8V3EY9ijjDut6hzkV3I1FofZCKPV4YLZB5pOCffAS8WhHs+T2fCeGtw9DYBKnfGw==
X-Received: by 2002:a9d:2278:: with SMTP id o111mr1184892ota.229.1630530163442;
        Wed, 01 Sep 2021 14:02:43 -0700 (PDT)
Received: from [192.168.0.112] (ip68-102-24-81.ks.ok.cox.net. [68.102.24.81])
        by smtp.gmail.com with ESMTPSA id q26sm160065otf.39.2021.09.01.14.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 14:02:43 -0700 (PDT)
Subject: Re: [PATCH Part2 v5 17/45] crypto: ccp: Add the
 SNP_{SET,GET}_EXT_CONFIG command
To:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        tfanelli@redhat.com
References: <20210820155918.7518-1-brijesh.singh@amd.com>
 <20210820155918.7518-18-brijesh.singh@amd.com>
From:   Connor Kuehl <ckuehl@redhat.com>
Message-ID: <2b07b160-48af-4682-1a4b-2716cd13fb65@redhat.com>
Date:   Wed, 1 Sep 2021 16:02:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820155918.7518-18-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/21 10:58 AM, Brijesh Singh wrote:
> +2.4 SNP_SET_EXT_CONFIG
> +----------------------
> +:Technology: sev-snp
> +:Type: hypervisor ioctl cmd
> +:Parameters (in): struct sev_data_snp_ext_config
> +:Returns (out): 0 on success, -negative on error
> +
> +The SNP_SET_EXT_CONFIG is used to set the system-wide configuration such as
> +reported TCB version in the attestation report. The command is similar to
> +SNP_CONFIG command defined in the SEV-SNP spec. The main difference is the
> +command also accepts an additional certificate blob defined in the GHCB
> +specification.
> +
> +If the certs_address is zero, then previous certificate blob will deleted.
> +For more information on the certificate blob layout, see the GHCB spec
> +(extended guest request message).

Hi Brijesh,

Just to be clear, is the documentation you're referring to regarding the
layout of the certificate blob specified on page 47 of the GHCB spec?
More specifically, is it the `struct cert_table` on that page?

https://developer.amd.com/wp-content/resources/56421.pdf

If so, where is the VCEK certificate layout documented?

Connor

> +/**
> + * struct sev_data_snp_ext_config - system wide configuration value for SNP.
> + *
> + * @config_address: address of the struct sev_user_data_snp_config or 0 when
> + *		reported_tcb does not need to be updated.
> + * @certs_address: address of extended guest request certificate chain or
> + *              0 when previous certificate should be removed on SNP_SET_EXT_CONFIG.
> + * @certs_len: length of the certs
> + */
> +struct sev_user_data_ext_snp_config {
> +	__u64 config_address;		/* In */
> +	__u64 certs_address;		/* In */
> +	__u32 certs_len;		/* In */
> +};

