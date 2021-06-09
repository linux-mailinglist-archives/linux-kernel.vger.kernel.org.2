Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170373A1167
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhFIKtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:49:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44937 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238498AbhFIKta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623235655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l4wI9TUgwebBtcJu8KunXfdxhxFN31VCnuQ/kJr2Jiw=;
        b=BVwf0W1WNB+TqkJgM4FgQKDFIlWmqn3njJ+ol7q/1z9rsaiEqx/5WV7IDqduF2BdJKT1kw
        gD3ZCFtgYiEwhiPu4pnGlk76faq358sRLmjrXoQeJ4p+IZc4kaoQmDgrUv0BZUm3wbb5Z6
        49ygz39gj4FKrEskN1srwAdkguVtlQs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-fDkXl_CmOv6qwZgqaYl3Ng-1; Wed, 09 Jun 2021 06:47:34 -0400
X-MC-Unique: fDkXl_CmOv6qwZgqaYl3Ng-1
Received: by mail-qk1-f197.google.com with SMTP id l6-20020a3770060000b02902fa5329f2b4so16807196qkc.18
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=l4wI9TUgwebBtcJu8KunXfdxhxFN31VCnuQ/kJr2Jiw=;
        b=h3G6ebtmGnXY51fZJG/wp6Au1xpLhrj25u/NbB/vTlsaZAKq4iL716z8W22rNqlzxC
         Mn5T3e2Y8KJWsTNFa+1wGc2L7iTVDiw/UlMIshZxi0J+i/HDvhRgeU5jc72wyZxJEZP4
         qtQxGeUyo4dENuZMYoqBuCZngw3CwJSVz98/hU9qfvdndUwUpAIXgy+Geq4kKFYIStjI
         ABNcAlG9p7bhvTNVTBmXMEmKmtKqNxl9UZLynR6EE8EWBfv37aevj7agfAnTX/H73DFR
         gSDxAML28yrekksQQwamrc+/pNxIJy4miBaD0I0N50s6O2tex0KVVtE4jVUauYP82j3E
         9wFA==
X-Gm-Message-State: AOAM531I8EVuj2TAfD9oLx3kBzzEtJSKRh9NjkRWk3sdSbMPgOo8NTPJ
        gIzRmo+KrPMsrX3bU9zMbG6sP94o7zR22u0buYzaNefkZl7LOfKdwA0qLUCEo+sdIqYwXbgLriE
        wai2BnhAPRZxhJqQljaxY8927
X-Received: by 2002:a0c:83e1:: with SMTP id k88mr5187189qva.40.1623235654161;
        Wed, 09 Jun 2021 03:47:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxyuPdC4YjpCJVo0T592xKUQnvy9FswLTlTEEIRBoGnM06yco8eLchZ9Yx0UBzn05zFEI47w==
X-Received: by 2002:a0c:83e1:: with SMTP id k88mr5187170qva.40.1623235653946;
        Wed, 09 Jun 2021 03:47:33 -0700 (PDT)
Received: from [192.168.0.106] ([24.225.235.43])
        by smtp.gmail.com with ESMTPSA id h6sm3665234qta.65.2021.06.09.03.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 03:47:33 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 0/2] net: tipc: fix FB_MTU eat two pages and
 do some code cleanup
To:     menglong8.dong@gmail.com
Cc:     ying.xue@windriver.com, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
References: <20210609103251.534270-1-dong.menglong@zte.com.cn>
From:   Jon Maloy <jmaloy@redhat.com>
Message-ID: <672e78df-5bb0-78eb-3022-f942978138f5@redhat.com>
Date:   Wed, 9 Jun 2021 06:47:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609103251.534270-1-dong.menglong@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/21 6:32 AM, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
>
> In the first patch, FB_MTU is redefined to make sure data size will not
> exceed PAGE_SIZE. Besides, I removed the alignment for buf_size in
> tipc_buf_acquire, because skb_alloc_fclone will do the alignment job.
>
> In the second patch, I removed align() in msg.c and replace it with
> ALIGN().
>
>
>
>
> Menglong Dong (2):
>    net: tipc: fix FB_MTU eat two pages
>    net: tipc: replace align() with ALIGN in msg.c
>
>   net/tipc/bcast.c |  2 +-
>   net/tipc/msg.c   | 31 ++++++++++++++-----------------
>   net/tipc/msg.h   |  3 ++-
>   3 files changed, 17 insertions(+), 19 deletions(-)
>
NACK.
You must have missed my last mail before you sent out this.  We have to 
define a separate macro for bcast.c, since those buffers sometimes will 
need encryption.
Sorry for the confusion.
///jon

