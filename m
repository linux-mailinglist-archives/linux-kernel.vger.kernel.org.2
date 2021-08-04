Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4FF3DFFA8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 12:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237643AbhHDKxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 06:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237591AbhHDKxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 06:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628074400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6KanqtDGf5yMoMf0Yr0/h3HuP/VnRTg0lfzUasPTQcw=;
        b=OzMXQ47PWo2i1mLT0hHMp06NcQ3RLHc+pMiOYxsMw1tQnjQnhHWiyWgrXPcxK7i6eMJTnA
        b/XxgrIS4a8yixpQQqwSe951TIEgauMKb8E/klhN+tAFIpzpaDDbf+C9N3MA1X+wDnVav2
        ye0cEFAqFWvmnGFoPcXxw2bQtDk4N70=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-tavSgEmnNjak7pj9hLZc_w-1; Wed, 04 Aug 2021 06:53:17 -0400
X-MC-Unique: tavSgEmnNjak7pj9hLZc_w-1
Received: by mail-wm1-f71.google.com with SMTP id 21-20020a05600c0255b02902571fa93802so1550431wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 03:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6KanqtDGf5yMoMf0Yr0/h3HuP/VnRTg0lfzUasPTQcw=;
        b=E4VVJuXVpJSNOX8PkEdhXFanhfkAd5OSbqqsqJBBw8L5YFMeu/UhbbL+HAEU40MTGV
         TOjjpVhSIrxQOi2y+fg0IXD9aBqnX3cO9jBCgtypJheNZ37hOf4qVOYfZ1Y8W/fZ+DLT
         H2pwK0PhcrGiIR3VX2+IYFRqr6lSI9dwiXA6Y9AppXhFG1+xeEmawsuidKKAtTh63QZc
         PFbfzK2DOEOPjYsznK4ZcE3i1d7CIDf7KNb1AsWzs/2QyY0rgc7Mhpg3LS6tkm1OIG0U
         ztO7zelH1i/lRD7EA6UUSvYF/SqHLw8W2Kfnwm5kBJOw7AgcG30xYpMmwTAHPMJhhT4X
         S8dA==
X-Gm-Message-State: AOAM531F984Y5PJNB5y1+7flw6DKdxWmd18hoWNR/Rp+fVR00ch6DTYW
        zNBBJaOA9enVv9eK38GpBu7Di+GUbcjCCiZL7npLCf5ERJPitjvPzTVtdYX3m9QqYxlxIEHPpH6
        CFKUvs4f9YAJqiuu0B1XO2kGs
X-Received: by 2002:a1c:20ce:: with SMTP id g197mr9309323wmg.46.1628074395309;
        Wed, 04 Aug 2021 03:53:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjtjf0U1T/UySuCXKrvBA+Akcv6vU4ZionNIPodF9VTA/UUHbVay0Z2xl6itwUausCAMPYaw==
X-Received: by 2002:a1c:20ce:: with SMTP id g197mr9309296wmg.46.1628074395109;
        Wed, 04 Aug 2021 03:53:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id h16sm2114466wre.52.2021.08.04.03.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 03:53:14 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: SVM: improve the code readability for ASID
 management
To:     Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Alper Gun <alpergun@google.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Peter Gonda <pgonda@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20210802180903.159381-1-mizhang@google.com>
 <YQlz4YDu/W8+YsZl@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3226fb50-94c3-49d2-de9a-d4fea81b5b0a@redhat.com>
Date:   Wed, 4 Aug 2021 12:53:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQlz4YDu/W8+YsZl@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/21 18:50, Sean Christopherson wrote:
> This patch missed sev_asid_free().
> 
> And on a very related topic, I'm pretty sure the VMCB+ASID invalidation logic
> indexes sev_vmcbs incorrectly.  pre_sev_run() indexes sev_vmcbs by the ASID,
> whereas sev_asid_free() indexes by ASID-1, i.e. on free KVM nullifies the wrong
> sev_vmcb entry.  sev_cpu_init() allocates for max_sev_asid+1, so indexing by
> ASID appears to be the intended behavior.  That code is also a good candidate for
> conversion to nr_asids in this patch.

It's also missing this (off by one for SEV guests, pointless extra work for
SEV-ES):

index da5b9515a47b..7fbce342eec4 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -147,7 +147,7 @@ static int sev_asid_new(struct kvm_sev_info *sev)
  	min_asid = sev->es_active ? 1 : min_sev_asid;
  	max_asid = sev->es_active ? min_sev_asid - 1 : max_sev_asid;
  again:
-	asid = find_next_zero_bit(sev_asid_bitmap, max_sev_asid, min_asid);
+	asid = find_next_zero_bit(sev_asid_bitmap, max_asid + 1, min_asid);
  	if (asid > max_asid) {
  		if (retry && __sev_recycle_asids(min_asid, max_asid)) {
  			retry = false;


Queued both Mingwei's patch and yours, thanks (to 5.14-rc in order to avoid conflicts).

Paolo

