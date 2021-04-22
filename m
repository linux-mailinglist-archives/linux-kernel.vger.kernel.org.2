Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA49367E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhDVKDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235704AbhDVKDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619085780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xNNORhYicU7gfoyOCuO0kweWS4Sw8ld/VVblR3G06wg=;
        b=Rh4v+YxFnMEngod4L53ym1QpbhxpXQ8iNAQd+sJum8lPSE0UvqVbuzyCm8Bvj4xudfWZIG
        ILij7JobfNtKV3lIziGXnGbACDFJpeJm3FGYPS//7kT2g0BVWLQr9Bz/t9oqqlr/i1iiug
        Drk7RXuA9gy4+8bC4q2rjn0H9/gEir8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-MR4gu6LfMVa9g70VsHwWfg-1; Thu, 22 Apr 2021 06:02:21 -0400
X-MC-Unique: MR4gu6LfMVa9g70VsHwWfg-1
Received: by mail-ed1-f70.google.com with SMTP id bf25-20020a0564021a59b0290385169cebf8so9083353edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 03:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xNNORhYicU7gfoyOCuO0kweWS4Sw8ld/VVblR3G06wg=;
        b=kzqlzla/33b7xHF+1p7ziy4qt1bbEs8HaJn1ccduCubuVkRxHizp4L9j6FCUGgN6dM
         X7k0SlSqpSyfvPCcMgBWnh7glyBzfAT667hDz3Nj1u+h8KVhGZK+YqqP5de0rZ8mdp1Y
         /h4xhgxt17X917PU8INCv/Zbt3m03Smk9AOlFSpPihK8vGvNO0YMt1hcX3zoZ5BMrtrG
         n7RkeZuEpW3qULeGLLEZe14yrQSW6752vkw0tGK60jZd/08PIXibTEvqOWFY39GhzPDC
         1TKqy4G0mSw/0gihI9pvp0G0DKSA8v1Hh+AVO2Ypg7huSzrY6Pu0UBOAbSqB+Q0ydUmV
         j92w==
X-Gm-Message-State: AOAM5305saLiNDcnuxsnR4+tVjTeNqs1dwm/+eZFxL0PB1NTMngt8NpL
        JgSRmcXSnmk/Nd03su9OvG+Yo5pSikDjYL2RZquA04cHztr8ujMAxoi+RG8fiIEAa3pDmsOjRJw
        vTrBIvBrsWKoe182hwpxdst6V
X-Received: by 2002:a17:906:704a:: with SMTP id r10mr2573013ejj.312.1619085740354;
        Thu, 22 Apr 2021 03:02:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoHUf/42/0fX52T0AvMJggbGbBnbTG84Gu4+wvT51LpZ70eW/cmD2f8ZCtTt0nyd7+UiYVVg==
X-Received: by 2002:a17:906:704a:: with SMTP id r10mr2572977ejj.312.1619085740170;
        Thu, 22 Apr 2021 03:02:20 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id l15sm1662876edb.48.2021.04.22.03.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 03:02:19 -0700 (PDT)
Date:   Thu, 22 Apr 2021 12:02:17 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Colin Ian King <colin.king@canonical.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Alexander Popov <alex.popov@linux.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stsp2@yandex.ru" <stsp2@yandex.ru>,
        "oxffffaa@gmail.com" <oxffffaa@gmail.com>
Subject: Re: [RFC PATCH v8 00/19] virtio/vsock: introduce SOCK_SEQPACKET
 support
Message-ID: <20210422100217.jmpgevtrukqyukfo@steredhat>
References: <20210413123954.3396314-1-arseny.krasnov@kaspersky.com>
 <20210421095213.25hnfi2th7gzyzt2@steredhat>
 <2c3d0749-0f41-e064-0153-b6130268add2@kaspersky.com>
 <20210422084638.bvblk33b4oi6cec6@steredhat>
 <bfefdd94-a84f-8bed-331e-274654a7426f@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bfefdd94-a84f-8bed-331e-274654a7426f@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 12:40:17PM +0300, Arseny Krasnov wrote:
>On 22.04.2021 11:46, Stefano Garzarella wrote:
>> On Wed, Apr 21, 2021 at 06:06:28PM +0300, Arseny Krasnov wrote:
>>> Thank You, i'll prepare next version. Main question is: does this
>>> approach(no SEQ_BEGIN, SEQ_END, 'msg_len' and 'msg_id') considered
>>> good? In this case it will be easier to prepare final version, because
>>> is smaller and more simple than previous logic. Also patch to spec
>>> will be smaller.
>> Yes, it's definitely much better than before.
>>
>> The only problem I see is that we add some overhead per fragment
>> (header). We could solve that with the mergeable buffers that Jiang is
>> considering for DGRAM.
>
>If we are talking about receive, i think, i can reuse merge logic for

Yep, for TX the guest can potentially enqueue a big buffer.
Maybe it's still worth keeping a maximum size and fragmenting as we do 
now.

>
>stream sockets, the only difference is that buffers are mergeable
>until previous EOR(e.g. previous message) bit is found in rx queue.
>

I got a little lost.
Can you elaborate more?

Thanks,
Stefano

