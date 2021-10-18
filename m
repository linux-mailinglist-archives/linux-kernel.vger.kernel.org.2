Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5414317B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhJRLqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:46:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33518 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230381AbhJRLqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634557475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KeixeMV2EogBAUUjIMMzujFC6vH6Vam8STyg+YsaQ90=;
        b=ennZLZ2zbVuqbnU2WQcbpPwlOolFxXU3thLtbvn8IL9tEB4NJK7J+O58ekD8rKNrNNu2Of
        5fDjVO6m042ieOb3QhlHAxXLNZXLvB4RWB5hy0UHbLe7h7nW07NrLwjCHGcGZq0Y0FTETo
        USeApaqyQmUAZvE5XNz7zUz8D5IYo/U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-U39hZVvEMhiF4hgBQMhWjA-1; Mon, 18 Oct 2021 07:44:34 -0400
X-MC-Unique: U39hZVvEMhiF4hgBQMhWjA-1
Received: by mail-wr1-f70.google.com with SMTP id f1-20020a5d64c1000000b001611832aefeso8753390wri.17
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 04:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KeixeMV2EogBAUUjIMMzujFC6vH6Vam8STyg+YsaQ90=;
        b=uddRnb8r67DJTFlUKMs5NkdMpGhzYfYxbYfoKrQPLdPChQcjNTKlVF2CrAb3i+Zkgu
         hVmduDKeNv7kGNFxwsUG+xW3thwcq58PTLOpCpaABSFnxn97o+whBAs3G0Y4Zgn1Vf+w
         EzON/lqTYwZZjCsbEESCEQND8nK7ats32eJ1kKa214HxdsH1AzFw3urndv4qvpnKp7yD
         ADNIYbnC8s7qTCpxslKERU7wnCS/Hgx4VaeBlWBHfV1+tBH8Xg3omFzqEWUAEqBCiWaR
         ZWRGmdCyPFvBKHIFraU3FSAdjI4ENYFfLyxXUPA5xNC8WAh5sDpXT8Ks3XLvOWW9LyZM
         mcVg==
X-Gm-Message-State: AOAM533cqcLo8nWv5jo6rslfLZbvWlaapFWiQqKaX11t5d3mNieR0amF
        5zQ4F7AP8ZLJZKb0/juCQ82vKkYYjYaw02sTDari3Xksh5+L0Ytl1q+O55LH0IhyyLec36zbBIw
        Rh8K6iyXA9vbq1IjT3621SGbG
X-Received: by 2002:a1c:9d97:: with SMTP id g145mr29273137wme.78.1634557473026;
        Mon, 18 Oct 2021 04:44:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzM7xblvRzkieqyGQRoyyigfLr3YHi5vClYT5nTsuGDzx7Nn0wiXpFo+D+jMwR3Yhbu5vd0iw==
X-Received: by 2002:a1c:9d97:: with SMTP id g145mr29273114wme.78.1634557472776;
        Mon, 18 Oct 2021 04:44:32 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k6sm12708013wri.83.2021.10.18.04.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 04:44:32 -0700 (PDT)
Message-ID: <d23aa747-f962-fb5c-7ad7-9dc3277fe83e@redhat.com>
Date:   Mon, 18 Oct 2021 13:44:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH RFC] KVM: SVM: reduce guest MAXPHYADDR by one in case
 C-bit is a physical bit
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Matlack <dmatlack@google.com>,
        linux-kernel@vger.kernel.org
References: <20211015150524.2030966-1-vkuznets@redhat.com>
 <YWmdLPsa6qccxtEa@google.com>
 <eaddf15f13aa688c03d53831c2309a60957bb7f4.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <eaddf15f13aa688c03d53831c2309a60957bb7f4.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/21 09:54, Maxim Levitsky wrote:
> 
> I'll say, a hack to reduce it by 1 bit is still better that failing 
> tests, at least until AMD explains to us, about what is going on.

What's going on is documented in the thread at
https://yhbt.net/lore/all/4f46f3ab-60e4-3118-1438-10a1e17cd900@suse.com/:

> That doesn't really follow what Andrew gave us, namely:
> 
> 1) On parts with <40 bits, its fully hidden from software
>
> 2) Before Fam17h, it was always 12G just below 1T, even if there was
> more RAM above this location
>
> 3) On Fam17h and later, it is variable based on SME, and is either
> just below 2^48 (no encryption) or 2^43 (encryption)

If you can use this information to implement the fix, that'd be very 
nice.  I didn't apply the hackish fix because I wanted to test it on a 
SME-enabled box.

Paolo

