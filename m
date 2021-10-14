Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4149042D3CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhJNHiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57081 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230155AbhJNHiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634196956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LBTwey9hwKfIjUV/CtWBhOrVA1mXd7MU5D+jzS6jbLc=;
        b=hTetlGdENCmWqMILVsp/9e2dONH43zRswgBOO0l+DF9qlc8V2kJdpJGKye+tLAc7e0F/hp
        V4AaqL5o3sOpmjMYKooLJ2K8MyFfUwRdjLM/wqE68x2jKLHjYrYCpdyCTlSSIJFId/C5dM
        DY7bFjrSYU2CN66h9Xjhwv7K7wm11zM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-qhpiA3s4PQqZXyuw20NUog-1; Thu, 14 Oct 2021 03:35:55 -0400
X-MC-Unique: qhpiA3s4PQqZXyuw20NUog-1
Received: by mail-wr1-f70.google.com with SMTP id h99-20020adf906c000000b001644add8925so684808wrh.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 00:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=LBTwey9hwKfIjUV/CtWBhOrVA1mXd7MU5D+jzS6jbLc=;
        b=CAwmukmeGO+F5jyYkCBFLcMzCh7IELj/1cChoUtryvofiuYjWp/VKg4ujgypJ6QXlk
         bS5Iq39qA37VGSCBWreQ7oU6od1REttddd8NTbqgC9C2MYIIMjAL9U087aFxvsY7xUf9
         WpGtva1qqbtmHqm9hy3yUA4DDsAFrrgImw61Qjlsyci4C3DBK+dQJLla5qiUTihX4GCp
         AoHU0z0PORJPLXIEz3PSmeRenrcUlwplJqa2Egs2Ebh54hF9dvFeANsEIFVIeZ521X+t
         XfARAiZVEdXdVcyZ5n1e0OLZQbzIU4ONVNB4qG4jL0UmG2gftDNRm1MYsA6kdFwvU0Gm
         ddEw==
X-Gm-Message-State: AOAM5326GnC+BvhpjJfUrSSWzjH8x9oWxELcautx8HoVQbuqElmCJv02
        hVIN6kenmOIq795j1HAqo0oE7MAXVbLQTMJpesTGLgSIwmSEbd0olgG81DNr30Uel4sgH8tfzAV
        UogGw/Zm3tQVJFaKJaix5xaUe
X-Received: by 2002:a05:6000:1884:: with SMTP id a4mr4830194wri.356.1634196953911;
        Thu, 14 Oct 2021 00:35:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSt3YUMGlNcOUbeyioJYcYpj5GtzCUeicYuA6BqOXmIkdWdP8qjlptmdEhgv5wx1bk/22iGA==
X-Received: by 2002:a05:6000:1884:: with SMTP id a4mr4830188wri.356.1634196953774;
        Thu, 14 Oct 2021 00:35:53 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c694e.dip0.t-ipconnect.de. [91.12.105.78])
        by smtp.gmail.com with ESMTPSA id g1sm8149250wmk.2.2021.10.14.00.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 00:35:53 -0700 (PDT)
Message-ID: <37a4b381-6204-6c38-f37c-eb078d768f42@redhat.com>
Date:   Thu, 14 Oct 2021 09:35:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 00/11] PageSlab: eliminate unnecessary compound_head()
 calls
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
 <YWXgrhRDIxcoBhA1@casper.infradead.org> <YWXwXINogE0Qb0Ip@cmpxchg.org>
 <YWZQNj+axlIQrD5C@casper.infradead.org> <YWbj6+myCposUKk1@cmpxchg.org>
 <YWcdoktn30ofnsPO@casper.infradead.org> <YWc0a7zlWAdUSCdT@cmpxchg.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YWc0a7zlWAdUSCdT@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It's good to have common north stars to set the direction of where to
> place efforts ("small struct page, dynamically allocated descriptors
> etc.") but I don't think it makes sense to take on yet more tech debt
> in this area for a future that may not pan out the way we think now.
> 

That precisely sums up my thoughts, thanks Johannes.

-- 
Thanks,

David / dhildenb

