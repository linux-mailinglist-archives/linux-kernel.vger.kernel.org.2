Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA1D3B2193
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 22:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhFWUJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 16:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21771 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhFWUJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 16:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624478838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=neF7bHjkt8eYKISsLyJ+tcj35PVPa1INMUV3P696VPc=;
        b=Hq+RdzbdtkDTDHFz1AwikmPuU7l0625HNccSHFKZktwuZMXXODfeDfvzvaWVXRBR2g+nF2
        i/hnrQr83p2eCy55C+NfuPpgekwM+OnONZGg4KV/9iaLKTakwzfBKGdSTiEXRwTjJ9yHFS
        RiJuI+bQUhMV70QG8eOrgS94N0XM1lc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-MrFHavLkPpa_KUiLNDzgKw-1; Wed, 23 Jun 2021 16:07:17 -0400
X-MC-Unique: MrFHavLkPpa_KUiLNDzgKw-1
Received: by mail-ed1-f69.google.com with SMTP id x10-20020aa7cd8a0000b0290394bdda92a8so1962190edv.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 13:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=neF7bHjkt8eYKISsLyJ+tcj35PVPa1INMUV3P696VPc=;
        b=pgS3ardRetdEyPH46YZttQ+fEy8u8onhhyQT5cI+5RBmyyWhB8wQIr4lZSf8GYRvW2
         y4EmD19OJxOvLQyMmhEI/RTZ+EyspHC6IcPp7ZBCfzvfOsZ/fCUU+hFQPLAm2NiupOy+
         wyBOwb/sa9NHC95CcSXa8GX2acSfpreuVVZ/6qADrAfYoLLLlk11MaiZdCIP/SuHfxsB
         P+TxdEFBo7ZUsd7tOTVUvC6d++tdJ5u6lGOMYN5+D8Bx0GD3GabiVja/DTGJN2fQI6Pc
         TLHe4XrVOT2ao4nMe0CaZhHM07LPiMCRfb6P705r0asTUUGaGrFQ7eeiI6362waDAjlH
         rSCw==
X-Gm-Message-State: AOAM533rUnGCnOJT6hl2WkCQeJtXJF4lT65K02/KGWVRcm7y7H1/CUDA
        2UTRFZjJkhXDt0gg9NZFimQfyBzIUMJyvnm8K0b1/UKVGSZLrHY83QVibWZ/U7Svu5D9fFJsFc/
        3Z/XCGNfiqmCqgOBslhbHtgHR
X-Received: by 2002:a50:fb81:: with SMTP id e1mr2024858edq.108.1624478835995;
        Wed, 23 Jun 2021 13:07:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmptMwf95DiiS+2XVGKk2apg0X56qNgcCZFBN3pHQ+jFXLL5u0rTEH8y9YOQ09UVZQh6FRsA==
X-Received: by 2002:a50:fb81:: with SMTP id e1mr2024833edq.108.1624478835870;
        Wed, 23 Jun 2021 13:07:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u17sm582011edt.67.2021.06.23.13.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 13:07:14 -0700 (PDT)
Subject: Re: [PATCH 41/54] KVM: x86/mmu: Consolidate reset_rsvds_bits_mask()
 calls
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <20210622175739.3610207-42-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b2b61da6-613c-f3cd-d974-a7e30d356244@redhat.com>
Date:   Wed, 23 Jun 2021 22:07:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210622175739.3610207-42-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/21 19:57, Sean Christopherson wrote:
> Move calls to reset_rsvds_bits_mask() out of the various mode statements
> and under a more generic !CR0.PG check

CR0.PG=1, not =0.

Paolo

