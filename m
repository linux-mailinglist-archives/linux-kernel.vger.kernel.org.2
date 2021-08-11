Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C084F3E8F88
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbhHKLgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237385AbhHKLgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628681776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+S2exkjtlBxygOtOf45G5PJ8smTzamomsBrJITv8Zac=;
        b=WMopg2I4kkWef8EoyR5o5hHMTcEI/59s17Clt9hDxRPcVHAaLQu8GdaGqoj0QnIBuUW4Yt
        U04anzgsF9W655f8PwShcB6c3dOxdxX2Yt0XYCQf48UDTWDRd8O8B0lMTFxFd+PqVj6vw0
        I/JlUK6gLjBINf3kVCRVakgmAVrXVtY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-riBtCIKGMlyAsoj-kBmrbw-1; Wed, 11 Aug 2021 07:36:13 -0400
X-MC-Unique: riBtCIKGMlyAsoj-kBmrbw-1
Received: by mail-ej1-f69.google.com with SMTP id ja25-20020a1709079899b02905b2a2bf1a62so570392ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 04:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+S2exkjtlBxygOtOf45G5PJ8smTzamomsBrJITv8Zac=;
        b=C0A7670WiWNkRfvZWAa8GEE4b2i2NSzb5YGlUO0FO7iiLyrLZhqUYxkIGMLpjm9UpA
         I49WS1myaTgP0RN9B80ClOgmG/Vb42zwoWCV4vdjJjlpPaPaJjEpcRZFbE/ewPDGy7xH
         JHS5s/OJNiukeYXHD/+DNmtT48IpSSsIRIl7fjEeGqBrRLNsI2GuP4rMYP98yeF6Pacw
         VkD7+vcvAEROXM0pT5Whxd0qqk6bXS2YX83pqUEso/+2j3AYz7RTSuKI/8qRnM0YIvbl
         Ltoe1ctS/lVWPauMiV67sypo8F3nOyS4EZargSLADQ2+6t6yWN1sDPGWDzpMYqqZMTFA
         VhNg==
X-Gm-Message-State: AOAM5337JnQR0HLjyjR3ysij0Kw1naZYxhpd7Pyf6fm0sfZUKgZ3Ekxa
        A+G9iyvz9f3EuldL4x9ywTy11C4PzF5azG3U+XRu2UUl+lTvOpie/wDVBqsMPB8I6WlZgs5/XH9
        fMaD2mBPU48dXvZHMzAJvTG4N
X-Received: by 2002:a05:6402:94b:: with SMTP id h11mr10671264edz.76.1628681771938;
        Wed, 11 Aug 2021 04:36:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUzWqNXPpLEiXwfgxkzBIN1W6Pp9trzh8bVCD3xoae7TLtfwWpOMpwPsaWV3Cw8DEovIjkXQ==
X-Received: by 2002:a05:6402:94b:: with SMTP id h11mr10671247edz.76.1628681771743;
        Wed, 11 Aug 2021 04:36:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id h19sm1463315ejt.46.2021.08.11.04.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 04:36:10 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] KVM: x86/mmu: Add detailed page size stats
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>
References: <20210803044607.599629-1-mizhang@google.com>
 <20210803044607.599629-4-mizhang@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f047f6ea-6d66-b7a7-cb39-7f5427876913@redhat.com>
Date:   Wed, 11 Aug 2021 13:36:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803044607.599629-4-mizhang@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/21 06:46, Mingwei Zhang wrote:
> +	union {
> +		struct {
> +			atomic64_t pages_4k;
> +			atomic64_t pages_2m;
> +			atomic64_t pages_1g;
> +			atomic64_t pages_512g;
> +		};
> +		atomic64_t pages[4];
> +	};
>   	u64 nx_lpage_splits;

This array can use KVM_NR_PAGE_SIZES as the size.

Queued, thanks!

Paolo

