Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8327E3B419E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhFYK2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230461AbhFYK2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624616774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vMw5C8dl564umFyPWG1xHixg+zwgl7dZDUVZw4IaqoY=;
        b=JbhwfU8BFEdu8RwGMqWIYY5aZOliRnkVRmPlrJ9zxLrqUWeirCXC1+o/D5bwdTfqGXTkYY
        Yx7c0MCooEAGmRO/B0QdwguVUav7anSIxX8Gkap/6snUROrybhtdPJq6W/yYhtaDF5X2M2
        /Qj92u9rAl0DiLdMQHtHty9LJb7VALs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-OftnyCsBPeuJZZU0MXORIw-1; Fri, 25 Jun 2021 06:26:13 -0400
X-MC-Unique: OftnyCsBPeuJZZU0MXORIw-1
Received: by mail-ed1-f70.google.com with SMTP id v12-20020aa7dbcc0000b029038fc8e57037so4955422edt.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 03:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vMw5C8dl564umFyPWG1xHixg+zwgl7dZDUVZw4IaqoY=;
        b=Ic9bk+nrpxSFVovCN/HS8QBg9csALlgFDIDhhE/Eie3BpBf7BIl9UPTb1S9lvl7/Hl
         433os/ZoRQDKlKo4UOcvYBVDTioGM2Xm3NKHzFnSh0LPUFQe7OEhB9eB4tvxn7sVlQT1
         w+R1f31NSufcmXvPz3WWpw81SSq0pYV/HET7yR53JhKRLhtMFw/6YvLOrFsPsJP45MjT
         8OhzD2vJ8OdWtAAnW4azxjUKntiybuAcL0WAqQ5J4qksWfT5UbI+50Fu0sn/yFZsNosk
         IV3ijQzGFmLeZVWeunUEke042Uktj3Cv6xS7DwPwM4Aq1yIio/g/AzEndvkSwWTDMVin
         M3yg==
X-Gm-Message-State: AOAM531W4kjOi1vZeGhXaJDNbBpcggMZe7/UQ+eego5XfU4xTzGIe9xW
        GS3m1W9Pq1QpWXVCYMzyLVc75wXzUimQ0xqgddKvzeW+iedl8rUS2iaSW2Hh71kr7rUJ7AkRZNT
        zp9W4EoolOJe1mc4Zqsvr7bHN
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr9965437ejj.16.1624616772008;
        Fri, 25 Jun 2021 03:26:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybqrlmR2ywwW6ezLVClI1uPt0HAzsewHMFFo7eLTt/eRECW+NExFJWG7ffDg16fJX4AkYLVA==
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr9965413ejj.16.1624616771784;
        Fri, 25 Jun 2021 03:26:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e8sm2504896ejl.74.2021.06.25.03.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 03:26:11 -0700 (PDT)
Subject: Re: [PATCH 09/54] KVM: x86/mmu: Unconditionally zap unsync SPs when
 creating >4k SP at GFN
To:     Yu Zhang <yu.c.zhang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <20210622175739.3610207-10-seanjc@google.com>
 <20210625095106.mvex6n23lsnnsowe@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb6885fa-4ad3-8da4-8d8e-ebfee30ad159@redhat.com>
Date:   Fri, 25 Jun 2021 12:26:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210625095106.mvex6n23lsnnsowe@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/21 11:51, Yu Zhang wrote:
> While reading the sync pages code, I just realized that patch
> https://lkml.org/lkml/2021/2/9/212 has not be merged in upstream(
> though it is irrelevant to this one). May I ask the reason? Thanks!

I hadn't noticed it, thanks for reminding me.

Paolo

