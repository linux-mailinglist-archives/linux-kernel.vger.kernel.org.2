Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A023418ABC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 21:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhIZTSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 15:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47826 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229623AbhIZTSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 15:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632683812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fiTE1F7WDvdOgznkiwGoN92jbdxh+8nMGfk4Hrr1+Bc=;
        b=RsiNkSsosTpvCMx0208qSVnAL0vaovhuldKshgvXhRL/QaOETzadDvy8x0Ab+rbBJBbYzf
        s/15B4BLzug9WdLy+BNTK7uRH7sXqT3etlSYUkpCb5Kdqkhuho9wR/pXdwp/wSTXJz4mnq
        RRA9Bgl7UHfLmScJlETcD45hOzp4a+8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-KMEBche1OhurnYTWw9dKvw-1; Sun, 26 Sep 2021 15:16:51 -0400
X-MC-Unique: KMEBche1OhurnYTWw9dKvw-1
Received: by mail-qt1-f197.google.com with SMTP id c21-20020ac85195000000b002a540bbf1caso58965211qtn.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 12:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fiTE1F7WDvdOgznkiwGoN92jbdxh+8nMGfk4Hrr1+Bc=;
        b=UIinUNvGQfD78DWVOHk/muJuP2Sns8obwSUofbbTpbZoX6xzFH4ogV004Ov7L2pKgd
         vO6CXzDRlWVfky0veaWitXM0DeG+yqqIBiVDtnWdXA5zxNtroABgaBbj0yAKdGJA2l/r
         Dw4ojNKFvt/tBHYZa5lij9YJab970AGjZioH/BGPa9Y5+0yMG6n9VRw/vlZhGSLYTWAI
         YYh0tbPbbNRgL3EfU39ucyUBuUbhFbR2qHLjMetAgy8QEtZLGCmxg8N1wyS9wcpQxy78
         zXkCvsp2i5cx1UY0XQTdGB77v8Xg9IZOBW4JgZHvvmaZOozqZNW0a4bK1qgC6QzXScqC
         eUrw==
X-Gm-Message-State: AOAM5337LcDIKhaf2Y4NrUjDTPQ1bAJF71fITzGk11ckMfwdGP8czmpH
        I+lrEMBEF878IYyq4PZb7S3jKmPEsF6lRTbuLsCSmTsvExMYaSaBKaNAZIJjoklvDz4mIiMxLlz
        u4qOSY27WyijBNz57aw0wca32nJEpa+kOHK2IeIbqM6+dXKItztMYSyJSsaqsXrPKwAtSSH46
X-Received: by 2002:a05:620a:bd4:: with SMTP id s20mr20956108qki.485.1632683811043;
        Sun, 26 Sep 2021 12:16:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAuatQxmxVgw5rQ6fdcXTKSdwnRHJ7bDVdbnds8NToA6utSWNxqb8ncVHO27LWpzKNgdCYUw==
X-Received: by 2002:a05:620a:bd4:: with SMTP id s20mr20956089qki.485.1632683810807;
        Sun, 26 Sep 2021 12:16:50 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id k10sm4221492qkk.124.2021.09.26.12.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Sep 2021 12:16:50 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/2] locking/mutex: remove rcu_read_lock/unlock as we
 already disabled preemption
To:     Yanfei Xu <yanfei.xu@windriver.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20210926101624.2460704-1-yanfei.xu@windriver.com>
Message-ID: <9569eee4-266f-d83b-2af6-194a1a8b165c@redhat.com>
Date:   Sun, 26 Sep 2021 15:16:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210926101624.2460704-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/21 6:16 AM, Yanfei Xu wrote:
> preempt_disable/enable() is equal to RCU read-side crital section,
> and the mutex lock slowpath disable the preemption throughout the
> entire slowpath. Let's remove the rcu_read_lock/unlock for saving
> some cycles in hot codes.

The description is wrong. Preemption is disabled only in the optimistic 
spinning code which is not the complete slowpath. Even though it may 
sound reasonable that disable preemption is likely to prevent reaching 
quiescent state, but I am not totally sure that will always be the case 
as there are different RCU favors.

Cheers,
Longman

