Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552873D7276
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 11:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbhG0J6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 05:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236061AbhG0J6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627379891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T2rQBG2yVNE7y1+uB+3b6lsmKXViZKQecoiM/1czVBA=;
        b=bRH4vwXBcOndJjokaH4cZmn4MTEeDQ/MhhWfKYC93Iy1QOvuk98kT9jolpU14OVvHNSpjd
        +Je2/kHtK6HWSYEqeZSe6rp7BA3uY89vpRgU5vdo+oLFX0fvRf0IjCR+eLMHYY8peHytst
        8SO0T30IlJiXJgklsSN9nr3yXUvgvfc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-i1Uzu4yeNsmZgtvsBNXIAw-1; Tue, 27 Jul 2021 05:58:07 -0400
X-MC-Unique: i1Uzu4yeNsmZgtvsBNXIAw-1
Received: by mail-ej1-f71.google.com with SMTP id qf6-20020a1709077f06b029057e66b6665aso1959494ejc.18
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 02:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T2rQBG2yVNE7y1+uB+3b6lsmKXViZKQecoiM/1czVBA=;
        b=aO30Ezmlex651gl2olnSuJ59sthPKHFWYVR46oHqgORpQsIwbD9yThvPuU6zuk/1oB
         WYfgWSZdKxBr0keCGLTCPJos89BYhrOFeFwxNwlor36GZF33foHm2FxbTWoUUaI3aiEp
         Q0dmo0EH8UKXjXRfy9uMJzbFtSbFJ4IQGmFeh9FE1D64BOpN8OCSbs0+QoIaI1A+mbGl
         PsuiW0fZasSGMTQBal2Wu2zexatHB4SEXMVCd6pDloK1WLhQdPL2wpnAFHHO2I0ZWB9i
         3TCNB+06NPwHeCKhkbL74KWfewqHoYSvvAcjPtTyXmXs7MSJ7ox1QFfksfRYyD6qECT5
         0low==
X-Gm-Message-State: AOAM531oRLQZ0w20k3f6Y6kLRUn9x36r8WFgEk8yCzvlo07YOSf90qel
        5VjSIREVNn81l/HQi/w+ehxkUVKZRLu1VFbgJ6UnwlewKZWjAscQAMrJA+cDH+GnjcHr+q7HtYu
        UErwdbW4PyEDI/7lYhzt4CBux
X-Received: by 2002:a17:906:ce47:: with SMTP id se7mr3742422ejb.240.1627379886418;
        Tue, 27 Jul 2021 02:58:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8eyrbNlN1DVbEoRIS2U/HCt0SR/iGRuCNgiSKmvCYAIQaFF1wZB5TRpL7dxgdXFiMYR9Wkg==
X-Received: by 2002:a17:906:ce47:: with SMTP id se7mr3742409ejb.240.1627379886242;
        Tue, 27 Jul 2021 02:58:06 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id f18sm726664ejx.23.2021.07.27.02.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 02:58:05 -0700 (PDT)
Date:   Tue, 27 Jul 2021 11:58:03 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oxffffaa@gmail.com" <oxffffaa@gmail.com>
Subject: Re: [MASSMAIL KLMS] Re: [RFC PATCH v1 0/7] virtio/vsock: introduce
 MSG_EOR flag for SEQPACKET
Message-ID: <20210727095803.s26subp3pgclqzvi@steredhat>
References: <20210726163137.2589102-1-arseny.krasnov@kaspersky.com>
 <20210727075948.yl4w3foqa6rp4obg@steredhat>
 <2df68589-96b9-abd4-ad1c-e25918b908a9@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2df68589-96b9-abd4-ad1c-e25918b908a9@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 12:34:36PM +0300, Arseny Krasnov wrote:
>
>On 27.07.2021 10:59, Stefano Garzarella wrote:
>> Caution: This is an external email. Be cautious while opening links or attachments.
>>
>>
>>
>> On Mon, Jul 26, 2021 at 07:31:33PM +0300, Arseny Krasnov wrote:
>>>       This patchset implements support of MSG_EOR bit for SEQPACKET
>>> AF_VSOCK sockets over virtio transport.
>>>       Idea is to distinguish concepts of 'messages' and 'records'.
>>> Message is result of sending calls: 'write()', 'send()', 'sendmsg()'
>>> etc. It has fixed maximum length, and it bounds are visible using
>>> return from receive calls: 'read()', 'recv()', 'recvmsg()' etc.
>>> Current implementation based on message definition above.
>>>       Record has unlimited length, it consists of multiple message,
>>> and bounds of record are visible via MSG_EOR flag returned from
>>> 'recvmsg()' call. Sender passes MSG_EOR to sending system call and
>>> receiver will see MSG_EOR when corresponding message will be processed.
>>>       To support MSG_EOR new bit was added along with existing
>>> 'VIRTIO_VSOCK_SEQ_EOR': 'VIRTIO_VSOCK_SEQ_EOM'(end-of-message) - now it
>>> works in the same way as 'VIRTIO_VSOCK_SEQ_EOR'. But 'VIRTIO_VSOCK_SEQ_EOR'
>>> is used to mark 'MSG_EOR' bit passed from userspace.
>> At this point it's probably better to rename the old flag, so we stay
>> compatible.
>>
>> What happens if one of the two peers does not support MSG_EOR handling,
>> while the other does?
>>
>> I'll do a closer review in the next few days.
>Thank You, also i think MSG_EOR support must be described in spec

Yep, sure!

What do you think about the concerns above?

Stefano

