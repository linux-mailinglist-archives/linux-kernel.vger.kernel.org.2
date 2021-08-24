Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AED3F5C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbhHXKc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:32:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236075AbhHXKcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629801102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=feIhjhva5jefoIxfoE0azoq+AbsdStJdrlY7GGgP55M=;
        b=Grp/aBGff6h+IQKzcuhP/volgFxSahSJj1muP9IeiGj7oGmiZSE36X3qiwXyuhVBf5EFrf
        W4K4wPx5IzdGKqYnD4G4faGs0xCPCLn6xFHR9eJnAWQOCpTfqzawi1sPNxXhn6wnE4THEu
        CaH+7hgkszL/EP52op9TNBSVnxWPmpY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-6S8011SpN2mydgPLtDgVKQ-1; Tue, 24 Aug 2021 06:31:41 -0400
X-MC-Unique: 6S8011SpN2mydgPLtDgVKQ-1
Received: by mail-ed1-f70.google.com with SMTP id e18-20020a0564020892b02903be9702d63eso1681595edy.17
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 03:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=feIhjhva5jefoIxfoE0azoq+AbsdStJdrlY7GGgP55M=;
        b=ehVfPJha5NSaoWxZ4K3XAffMDeqQn7qVcdOqcUO0LVXMF+lLOGWRSWb0bcQKOXZeSc
         mnhjOA74+UJxZanWUNrZD+/EAdGTbzr8hNS4YVvG1JAlnWTHUTmsVDYWwE6BMaOst2zy
         i7ipeRIVwELVGa9qlafQ8vWb4ZJ3cbOkfJeXRSW8QYIAi0aaSxiZq+kD+i8AbxxgVS7M
         ZTa2G+6VuKZgzjNijzmQTcWRy8fZg7DuGGaNn6trdYPuOjsHRmxAh7tuIxG/z7kKC/1i
         1JMaQ/GgJiYhu95m1fx6OILWdrsMplUTSxZj3kqh7QmpEeQ232G+JfXHZm8emEfaI6vF
         MDLQ==
X-Gm-Message-State: AOAM531gHuiybSArI7gI5NbUPh3OhRurAqBfAUx4jMUemHYrKCTivbxi
        r30Vez0ZLPl8sxwX+43uZ703rbfKrqTY8RMq6U8ZUk8nkovtmcIbwoxGssSaWKiyqVkEig6JR5H
        gNAno+kLZ4gkeCbW0OCDfYol0
X-Received: by 2002:a17:906:d04b:: with SMTP id bo11mr40707208ejb.513.1629801100364;
        Tue, 24 Aug 2021 03:31:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1lClZImhRtvJCoGEAqkfeG/l8kJgXUskqq5Rw2DFLftK9EBSu/dk7LEDZ72T8m++O+df9pA==
X-Received: by 2002:a17:906:d04b:: with SMTP id bo11mr40707195ejb.513.1629801100235;
        Tue, 24 Aug 2021 03:31:40 -0700 (PDT)
Received: from steredhat (host-79-45-8-152.retail.telecomitalia.it. [79.45.8.152])
        by smtp.gmail.com with ESMTPSA id c28sm9029348ejc.102.2021.08.24.03.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 03:31:39 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:31:37 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Andra Paraschiv <andraprs@amazon.com>,
        Colin Ian King <colin.king@canonical.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stsp2@yandex.ru" <stsp2@yandex.ru>,
        "oxffffaa@gmail.com" <oxffffaa@gmail.com>
Subject: Re: [RFC PATCH v3 0/6] virtio/vsock: introduce MSG_EOR flag for
 SEQPACKET
Message-ID: <20210824103137.v3fny2yc5ww46p33@steredhat>
References: <20210816085036.4173627-1-arseny.krasnov@kaspersky.com>
 <3f3fc268-10fc-1917-32c2-dc0e7737dc48@kaspersky.com>
 <20210824100523.yn5hgiycz2ysdnvm@steredhat>
 <d28ff03e-c8ab-f7c6-68a2-90c9a400d029@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d28ff03e-c8ab-f7c6-68a2-90c9a400d029@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 01:18:06PM +0300, Arseny Krasnov wrote:
>
>On 24.08.2021 13:05, Stefano Garzarella wrote:
>> Caution: This is an external email. Be cautious while opening links or attachments.
>>
>>
>>
>> Hi Arseny,
>>
>> On Mon, Aug 23, 2021 at 09:41:16PM +0300, Arseny Krasnov wrote:
>>> Hello, please ping :)
>>>
>> Sorry, I was off last week.
>> I left some minor comments in the patches.
>>
>> Let's wait a bit for other comments before next version, also on the
>> spec, then I think you can send the next version without RFC tag.
>> The target should be the net-next tree, since this is a new feature.
>Hello,
>
>E.g. next version will be [net-next] instead of [RFC] for both
>kernel and spec patches?

Nope, net-next tag is useful only for kernel patches (net tree - 
Documentation/networking/netdev-FAQ.rst).

Thanks,
Stefano

