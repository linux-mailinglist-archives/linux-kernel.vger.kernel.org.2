Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E21A314B79
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhBIJYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:24:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58492 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229666AbhBIJVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612862379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BFjv4UtzY9Kq1FYF0dpb6VHrc3ljOiW5dWjb2Re6blw=;
        b=CI9dABxLinBFcyq38IYwSWHSJWt+eLNMag0qIzNF8ASr0s80k6gyZSbWYZaVEJnqRM+kAn
        V0+5ziSghAp9pfw4nDjDBn4+0b50JxjhO0NXspx2ueKjyNhY6nSfSPmFQh7Z5tmlcIewSU
        ZnFIEC4T96A6/qdsg/x8XvogCEMoSro=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-dV2QrBfIN9CVvVoNpTUc6Q-1; Tue, 09 Feb 2021 04:19:37 -0500
X-MC-Unique: dV2QrBfIN9CVvVoNpTUc6Q-1
Received: by mail-wr1-f71.google.com with SMTP id x1so9734429wrg.22
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 01:19:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BFjv4UtzY9Kq1FYF0dpb6VHrc3ljOiW5dWjb2Re6blw=;
        b=W5atCEJvLepSc3GTntSwg9tcdKsPg+x0JEUW43mpy+yZegSNfKju/MP1WQ923sEeEk
         W7ephNdOzRyiPnMTV19Y6wf1HUlxbRJnkyH8iZm5tAdJrcd8R5i0S1JBZRUQsWa1sair
         lT/BcMebMu1IAPTg8hEuLYeSIGB4vOgNce1FEnMd5b3VhKZAx1+lVP7bABXJhMoy34p3
         vXrqbiQy7D/fu/ug5hFz8OwGyhnhLj0WWVb0OcJrJ6Ur/8ymDAwp31DWyLUpG1+UsBPN
         ritxaJHvV3i1CUoHGad6JduYGa6lf74+LATSOosU7KRFVqJl64ZShkELKnAGWWO7lK2Z
         xKvA==
X-Gm-Message-State: AOAM530rgeHX/ItUZhcGqCgPgeDIMFYh0+YGBbzmiVEi5XSPreWIlPoz
        E+/prLOTQZ7E0BcskmFMmtbR2nGZEdIMe5zEe8RFyxIvI79GlFBRGLaNLV+vmn6cpcV7TlvLRfY
        JwlxWq3J+jDucSQdxzAEZk7py
X-Received: by 2002:a1c:7905:: with SMTP id l5mr2532083wme.171.1612862375892;
        Tue, 09 Feb 2021 01:19:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylyGxN6rAcQNsffz+2zGcPZnteVoUtmo8yoEcEep7Stu6LpFbD+RJDHfXVYYs7gR1qW5cazQ==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr2532068wme.171.1612862375679;
        Tue, 09 Feb 2021 01:19:35 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u142sm3652118wmu.3.2021.02.09.01.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 01:19:34 -0800 (PST)
Subject: Re: [PATCH 1/2] mm: provide a sane PTE walking API for modules
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, jgg@ziepe.ca,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        dan.j.williams@intel.com, Daniel Vetter <daniel@ffwll.ch>
References: <20210205103259.42866-1-pbonzini@redhat.com>
 <20210205103259.42866-2-pbonzini@redhat.com>
 <20210208173936.GA1496438@infradead.org>
 <3b10057c-e117-89fa-1bd4-23fb5a4efb5f@redhat.com>
 <20210209081408.GA1703597@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d238b495-dbae-1bc4-3397-5bceadfddb7e@redhat.com>
Date:   Tue, 9 Feb 2021 10:19:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210209081408.GA1703597@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/21 09:14, Christoph Hellwig wrote:
> On Mon, Feb 08, 2021 at 07:18:56PM +0100, Paolo Bonzini wrote:
>> Fair enough.  I would expect that pretty much everyone using follow_pfn will
>> at least want to switch to this one (as it's less bad and not impossible to
>> use correctly), but I'll squash this in:
> 
> 
> Daniel looked into them, so he may correct me, but the other follow_pfn
> users and their destiny are:
> 
>   - SGX, which is not modular and I think I just saw a patch to kill them
>   - v4l videobuf and frame vector: I think those are going away
>     entirely as they implement a rather broken pre-dmabuf P2P scheme
>   - vfio: should use MMU notifiers eventually

Yes, I'm thinking mostly of vfio, which could use follow_pte as a 
short-term fix for just the missing permission check.

There's also s390 PCI, which is also not modular.

Paolo

> Daniel, what happened to your follow_pfn series?


