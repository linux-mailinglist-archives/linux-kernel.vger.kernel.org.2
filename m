Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A74B3E4F46
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 00:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbhHIWbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 18:31:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56865 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233565AbhHIWbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628548289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h0IrbGHuas1nNnO8JBZWCL0Gr/6ftbCs5KjGl2Z6+gw=;
        b=hpp/Pb9cB12r+fwxuDpIl4mAA9ZQztr7otwPMk1AQl2T1fSinrP6ZiL+TCsdEtSWQJUKbi
        lqtzl0ORzG8kPBKRSfeIf2Tr9As9FYZiNdY7EMEL5W3EAy+ARSxPeAsqTm9SEXyuufIkrK
        DlMSCg4dmEyWH14edNDfx92lv1JU6ks=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-4u18nSmkM02QCl6r0ESoyw-1; Mon, 09 Aug 2021 18:31:27 -0400
X-MC-Unique: 4u18nSmkM02QCl6r0ESoyw-1
Received: by mail-qk1-f199.google.com with SMTP id h186-20020a37b7c30000b02903b914d9e335so13786591qkf.17
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 15:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=h0IrbGHuas1nNnO8JBZWCL0Gr/6ftbCs5KjGl2Z6+gw=;
        b=SxTFfoZxc1Hztfic87GCQmt6PflnF0eN4bteS0y/k5QAUB+dNawYgxNcWfQXRRpVhj
         4IA8vAec8gkjoQ2oLdFluJNnTW1c0n4Q7U176CC9tmW8iL85NRnMSzjanTCXNEj5uQXm
         SAtk5yqWNVIav9H/skYeQ3dzBCSGqv5Dx1/kOqlIRiXEitwsyjqtt2h8a9ySo/2dfTvm
         0Vwa4NRZkMBjlpARp2G0SyxQP5EE1SIc9iarMiYdKaRg+1ncYY5+gy2SxK2YQrYAVYk4
         NQk/u1BQ4KRtWm2iuVJwhLTvCH0snFIzrE8NwK2aNW1i+eBUCdibWNMmlMMRIKQKFKZV
         wPOw==
X-Gm-Message-State: AOAM533M5YYsoe/goJzp8UdrnC7huK4RgZzvpHhdHBapfOfi1+BSTKnr
        lvXwz10fRx2U4osG4u6w+kuWZH8Ts7P1sqtk9umg+6FwdRwJPcaBDZ+472UZubxlmzoZT05iaaX
        aKL2aGF1KNO3kgLVheOsJy4MZ
X-Received: by 2002:a05:622a:1106:: with SMTP id e6mr21967275qty.172.1628548287326;
        Mon, 09 Aug 2021 15:31:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPycnDHiYPL6a31SVTX6Z6ed2srcb++34DmueTwq0TlFWbTo44l36FO7A/a/2h7olBKZh6Eg==
X-Received: by 2002:a05:622a:1106:: with SMTP id e6mr21967256qty.172.1628548287114;
        Mon, 09 Aug 2021 15:31:27 -0700 (PDT)
Received: from ?IPv6:2601:184:4180:af10::540e? ([2601:184:4180:af10::540e])
        by smtp.gmail.com with ESMTPSA id m197sm9910149qke.54.2021.08.09.15.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 15:31:26 -0700 (PDT)
Subject: Re: [PATCH] vm_swappiness=0 should still try to avoid swapping anon
 memory
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, mhocko@suse.com
References: <20210806231701.106980-1-npache@redhat.com>
 <CALvZod6gCof1bhVwdU7vYYKBRCn_HZBFi4BjSYoSK-dyrmswMA@mail.gmail.com>
 <91605888-e343-2712-c097-bcade4cb389d@redhat.com>
 <CALvZod6Kv_eZcZeJOvypXe_XVzkvLDau7faiDQ2mrqV8kOqq3g@mail.gmail.com>
From:   Nico Pache <npache@redhat.com>
Message-ID: <7301b496-d2fd-b5d1-8159-6613c958f487@redhat.com>
Date:   Mon, 9 Aug 2021 18:31:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CALvZod6Kv_eZcZeJOvypXe_XVzkvLDau7faiDQ2mrqV8kOqq3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> First, the shrink_list() will not be called for anon LRU if get_scan_count()
> has decided to not scan the anon LRU.

get_scan_count() will decide to scan the anon LRU if(sc->is_file_tiny) which is set in shrink_node().

 In shrink_node() the MAY_DEACTIVATE/DEACTIVATE_ANON allows this the be activated.

> Second, I would like to get your attention to the following comment in
> get_scan_count():
>
> "Global reclaim will swap to prevent OOM even with no swappiness"

AFAIK my patchset doesn't prevent any of the OOM cases. It only prevents the anon workingset refaults

from challenging the anon if swappiness=0. 

> It seems like the behavior you are seeing is actually working as intended.
> You may decide to change that behavior but you will need to motivate the
> change.

My V3 has a lot more in the commit log. Hopefully it will clear up my motivation. I will post that now.

