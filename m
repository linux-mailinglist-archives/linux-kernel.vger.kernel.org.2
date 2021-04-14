Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D6935F9F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhDNRbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350698AbhDNRbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618421482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pwu8ITVpaktX/oaFXebOFcED+CIuIn8065SfkxgfWGI=;
        b=foQvjc3s0ZEtrldIiYePQl5xO747Hgz0vu3XoGP1TESxsTOaU0pU4qU6w9KNZzl+jEFwxl
        83ed0eLAcxRthubRE+GmYpo+2WGg9UYKaDYLdc+ZUfqtu8cjb8/5JYHTOJGtJ8Wt/hO77O
        mhgfRvLkrafo9ddZhkIFTWT38lA+cM0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-CQdCdmyNPYaUUY8SfeIT7A-1; Wed, 14 Apr 2021 13:31:21 -0400
X-MC-Unique: CQdCdmyNPYaUUY8SfeIT7A-1
Received: by mail-qk1-f197.google.com with SMTP id o4so4954878qkg.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Pwu8ITVpaktX/oaFXebOFcED+CIuIn8065SfkxgfWGI=;
        b=fyyIkFgT8BjKok7FLE9VEriiPvKZhbB4J0L5v+ulojfr39RyptSqy8GA8yHUVzYJbV
         xD2P01jPXI/5qAz1MO1JAoXOctUCicv4vyTMg5qFE05LVKXI+88VJaWK9WMcPxOv9jCD
         Jv5e0TQ8d1n9BhpeP2iO2URGIAtn8bVmN35abiZs05Wc4JeRQLELlGzdYTSfY8PCY2sQ
         0T+56pLeAuOIlREpPgOaF1Nwct/jWRXYwBZoOD8HNq9hglSf/MpEEiGKTKz1t4pj8GBK
         ZFrbMwYEcjmyYjg7LUKUNh2nCIK3xqBW90rHvo+6WKrhQ4lzAbCA7USlWbbGcdAq22Km
         G4HQ==
X-Gm-Message-State: AOAM530X/S0RyeFzfURVw2y/4GqVRt+mIbu//PBzEgZ1K3xSEXPU83eu
        rq7gzQHCbiTRsKuc8c46J+nwyyRF+6gTia+TEzWw4Uy8VQyQD07irXCRhUXg0b1jZskebXzI6O5
        pKxl0zb1IubPAyo3yoHG4oq0H
X-Received: by 2002:ae9:dcc1:: with SMTP id q184mr6147240qkf.482.1618421480631;
        Wed, 14 Apr 2021 10:31:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRXvclwrtNw0vyg4pKHWPDmETRkr+Mf1wxudR7KTzhxmhPecsOFB7lkLfuIC0V32mXc/loLw==
X-Received: by 2002:ae9:dcc1:: with SMTP id q184mr6147223qkf.482.1618421480434;
        Wed, 14 Apr 2021 10:31:20 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id t17sm18505qtr.42.2021.04.14.10.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 10:31:19 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [External] : Re: [PATCH v14 4/6] locking/qspinlock: Introduce
 starvation avoidance into CNA
To:     Andi Kleen <ak@linux.intel.com>, Waiman Long <llong@redhat.com>
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20210401153156.1165900-1-alex.kogan@oracle.com>
 <20210401153156.1165900-5-alex.kogan@oracle.com>
 <87mtu2vhzz.fsf@linux.intel.com>
 <CA1141EF-76A8-47A9-97B9-3CB2FC246B1A@oracle.com>
 <4a9dbfa7-db68-a2dc-9018-a5b74f0f421c@redhat.com>
 <20210414172602.GW3762101@tassilo.jf.intel.com>
Message-ID: <6c968acd-dda2-ed1f-6582-b7811030761e@redhat.com>
Date:   Wed, 14 Apr 2021 13:31:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210414172602.GW3762101@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/21 1:26 PM, Andi Kleen wrote:
>> The CNA code, if enabled, will be in vmlinux, not in a kernel module. As a
>> result, I think a module parameter will be no different from a kernel
>> command line parameter in this regard.
> You can still change it in /sys at runtime, even if it's in the vmlinux.

I see, thank for the clarification.

Cheers,
Longman

