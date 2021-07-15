Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2323C9DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241897AbhGOLWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 07:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51313 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240366AbhGOLWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 07:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626347963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDEwnHomsUjrAd8IIiBDO6SVng8PAzpjFB7DzaKPf7k=;
        b=BEMREBrQw0IamWk8usUTr0DIQx5QyiuQzIUNW/swv8E+q0p3+f4UYHETWGunLNBeRtCYT9
        NymE+d9zrxn0smmJM2T50C9iapUhFRfdh5mnRNY1O5AvKeT8WLDeTbuqCaj0jdCzeO/sOf
        eRX3vF9jIf4ROLMh4gaCPbkZvZi/nLc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-4thiCPDpNOqBIaPuFHdXLQ-1; Thu, 15 Jul 2021 07:19:22 -0400
X-MC-Unique: 4thiCPDpNOqBIaPuFHdXLQ-1
Received: by mail-wr1-f70.google.com with SMTP id g9-20020adff3c90000b0290140a25efc6dso3192545wrp.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 04:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FDEwnHomsUjrAd8IIiBDO6SVng8PAzpjFB7DzaKPf7k=;
        b=hBdzOigARMl1Gf0usEy4IrDLkg+9de12yklS3f455fp4LmTtScAPeU2hXT9kb9f/AY
         WCP/jPf1RMErmPppdj2/H6YCWl78voQO11DKSwkd6moo4tsat9Ut6Fh66xiM5rendQ8F
         B133vXX7qePcGYwCW+6EEbI9HsXLQcAAgl90DdKpk0En3V9Y54L070s/I2G2q6bI3Mbg
         ZCqSAh2V/tAgV6DGmn6WP6bcQLUExNRXlgAF/Brq5OyCwUZCFxVGNne31J5Xg2mXSQdq
         MieX52G+wAKFHdo31YNlyHslDrQGzkFrLJ+ASNjbfNvp606IJj2/IBctXzuUEQ06uGaj
         c3zA==
X-Gm-Message-State: AOAM530XcA0TT7VXfBlWkYAer/tTufteT3a1/TdZ2JNsgRJKS6DaTcLv
        RFgzxr46lEEHGeYjuJsG+PH+A18rww0Q0Nl8dvLceDVjtSI9UOcnkru6Rj/wSi6bf1HQjEw5ipO
        rrneEmcQY8AidewEZxKL5jZDA
X-Received: by 2002:a7b:c147:: with SMTP id z7mr4019756wmi.110.1626347961372;
        Thu, 15 Jul 2021 04:19:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxBt5tiWczHm64NNwg+8VM1qJ0OsxcPd0Pd0QrHRAt+g+CBldC7DcvCR7rucK1UFnX/7nlPA==
X-Received: by 2002:a7b:c147:: with SMTP id z7mr4019744wmi.110.1626347961153;
        Thu, 15 Jul 2021 04:19:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id d8sm6315639wra.41.2021.07.15.04.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 04:19:20 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/cpuid: Expose the true number of available ASIDs
To:     Like Xu <like.xu.linux@gmail.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20210715104505.96220-1-likexu@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3d2ad944-9e0c-dea7-f0e4-4e55072ccf99@redhat.com>
Date:   Thu, 15 Jul 2021 13:19:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715104505.96220-1-likexu@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/21 12:45, Like Xu wrote:
> The original fixed number "8" was first introduced 11 years ago. Time has
> passed and now let KVM report the true number of address space identifiers
> (ASIDs) that are supported by the processor returned in Fn8000_000A_EBX.
> 
> It helps user-space to make better decisions about guest values.
>
> -		entry->ebx = 8; /* Lets support 8 ASIDs in case we add proper
> -				   ASID emulation to nested SVM */

Why, since we don't have ASID emulation yet anyway?

Paolo

