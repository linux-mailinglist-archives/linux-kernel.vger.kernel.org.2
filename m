Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E63322F86
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhBWRVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:21:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233672AbhBWRVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614100790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EsllZvb5aY/YCacxiEhrsEkqyhREKB3RZGWTsSboykY=;
        b=MK93H481Mq0bGepL+nOA7b+kZiXeqw5V8OiOUqesqzFnBmMaJ4J+KR7iKZMTkEqH7dkF42
        G4c6AZ1VuGrj9aix1QiveEyoW/RxHGeoKPHjQ9bV8/rJF+NaJd5xWQeYyhDM8QSXnxUnzC
        BcpWd29MEtWkTHZ8/Oldf//OEgqaAYI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-vuOAzP2tNi-rjaZ-UGGRcA-1; Tue, 23 Feb 2021 12:19:46 -0500
X-MC-Unique: vuOAzP2tNi-rjaZ-UGGRcA-1
Received: by mail-wr1-f72.google.com with SMTP id b7so2928383wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EsllZvb5aY/YCacxiEhrsEkqyhREKB3RZGWTsSboykY=;
        b=OiI5uXeXsx5ZUYUv5tWhbtlJBHnJT5kJzQwWsyxLPSI1+hbf93TnjnT3QC3Au2weZ0
         /WWpDbLmuJNfqfoOqjrMpN9hFne1gemn91WbGpNmYBOy1H9MOI2frZWoA4CIhBa9eTLx
         iN16K0lsbBXpQiougFugBkC9U5/u2CaB5AMz5vGy/GPkzYYluKsSYQ5XfgJVRU4zzFID
         YUXNypYs63gFIlHH6yW0HfKz/z3tS6a73XF3jJffF2aKgz0M8vW1dDOlU9nU1I8JJbNO
         PqlhsghtDnOYNdzeh6R1seVrjs6GpgcNuSTH1RsDtWAdSTEEzb9/WO7Yg1QG0glT37s8
         hjZA==
X-Gm-Message-State: AOAM530Ij4IbTurK5JgDT/RW7cyXZMueTqPf6phTZtzotcDW8Jb0ul2b
        317wAQTWyyUpU/v8aViCa9ItV2bl8JR5XCw2uyDDA9djsXut8X8Teu1bkLAbJ6QclT8YlV3guF7
        PgCZ8L4f2Gpt777OKTEHmR2xWfhuNPtTqI/yKhDiDgZGNr26pOmEZ37m3KerXpFQI0Qiy52TvPm
        5e
X-Received: by 2002:a05:600c:2184:: with SMTP id e4mr25495754wme.107.1614100785075;
        Tue, 23 Feb 2021 09:19:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTqsbeZfswgBPjjTp7acWcwMD3JJBfE4MKCQO22zeb+8dT2melZmGj9anF8RdYT8XU3Oww2A==
X-Received: by 2002:a05:600c:2184:: with SMTP id e4mr25495729wme.107.1614100784852;
        Tue, 23 Feb 2021 09:19:44 -0800 (PST)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id o124sm3591810wmo.41.2021.02.23.09.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 09:19:44 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: vmx/pmu: Fix dummy check if lbr_desc->event is
 created
To:     Sean Christopherson <seanjc@google.com>,
        Like Xu <like.xu@linux.intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210223013958.1280444-1-like.xu@linux.intel.com>
 <YDU4II6Jt+E5nFmG@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <52a30738-08b5-740c-7c6e-b7a6edcbe552@redhat.com>
Date:   Tue, 23 Feb 2021 18:19:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDU4II6Jt+E5nFmG@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/21 18:15, Sean Christopherson wrote:
> If event
> creation fails in that flow, I would think KVM would do its best to create an
> event in future runs without waiting for additional actions from the guest.
> 
> Also, this bug suggests there's a big gaping hole in the test coverage.  AFAICT,
> event contention would lead to a #GP crash in the host due to lbr_desc->event
> being dereferenced, no?

Yes, testing contention would use the tools/testing/selftests/kvm 
framework rather than just kvm-unit-tests.

Paolo

