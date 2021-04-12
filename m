Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D86035C82C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242128AbhDLOFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242106AbhDLOFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618236284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Milm+ZpD4p8fQX5ep4YA+mBfvp9QBbTbvO+DYpJDU18=;
        b=dNr3YaZeiu1x6wUthEgY52ZmTtqjJ9xUvcP5tjsSBpm8dM7j3qlzTPlqJ6OgablfCz6e3J
        yQAUms/UeDQT/P5z37JkjxWPd/9UVZwmJmQ8gN0Oo+zDN6dSg1n69BJacrkw9pWnwAmG88
        dnStCEKfDzy/RbJW+vAdVIu63IpEkfg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-STVnN9MJPF6h9_yXwDzZKA-1; Mon, 12 Apr 2021 10:04:41 -0400
X-MC-Unique: STVnN9MJPF6h9_yXwDzZKA-1
Received: by mail-ej1-f69.google.com with SMTP id gn30so3959603ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 07:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Milm+ZpD4p8fQX5ep4YA+mBfvp9QBbTbvO+DYpJDU18=;
        b=ghiHPOrf3Mvlk6Vv1yIH8FucYAG/NABrOdtW0U6AlzMdt5bPXf5GC646EGgAvRP4il
         VMvwXsVHi4olANONLFmSe1Wv8mU4wpWQdZcKIyB1PRljZXqVB7PqnNtRht6gCO0Vzx0C
         hrICwQh+0D67FRq37gQHQutwDK65jf44nGZYxZuw4zKZ4Uzl5VKQZbZdfpT909iKONTJ
         1D48f2zECsgK8t3UKUiweLoF37UWvKDNjbcZtam/2LRAgj3lp57JRNoilZY6ND3KP1Ll
         m1fJKa/3S58Sk9Ssk+C2qiSRbh8015+QkD9Omsk9IkBB3gIFV/j4ijxQPx+7QWIpHi1X
         0xdg==
X-Gm-Message-State: AOAM531JzkwNeXb/HUcrg47OMlj9JUGZb0z29vaippor7W/TxlISJU59
        pm181/LgIGOcID2xa5pcUgok7uwHOsE7e6mPucA8l8aZ61RS3Mj1wVEZADqbnpGR8GQPuOoiqen
        tPgUyMGduzFndyOGzDhAepN9r
X-Received: by 2002:a17:907:367:: with SMTP id rs7mr13497901ejb.468.1618236280399;
        Mon, 12 Apr 2021 07:04:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAO03nKUgqVdQNXtykFitW8Mn5GTR/gCbYmSlRkP2aDoipwEngT50nePILvx+KJFTgeG/aKA==
X-Received: by 2002:a17:907:367:: with SMTP id rs7mr13497872ejb.468.1618236280127;
        Mon, 12 Apr 2021 07:04:40 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id h3sm6860322edv.80.2021.04.12.07.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 07:04:39 -0700 (PDT)
Date:   Mon, 12 Apr 2021 16:04:37 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Jiang Wang ." <jiang.wang@bytedance.com>,
        Jorgen Hansen <jhansen@vmware.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "cong.wang@bytedance.com" <cong.wang@bytedance.com>,
        "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Andra Paraschiv <andraprs@amazon.com>,
        Alexander Popov <alex.popov@linux.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [RFC] vsock: add multiple transports support for
 dgram
Message-ID: <20210412140437.6k3zxw2cv4p54lvm@steredhat>
References: <20210406183112.1150657-1-jiang.wang@bytedance.com>
 <1D46A084-5B77-4803-8B5F-B2F36541DA10@vmware.com>
 <CAP_N_Z-KFUYZc7p1z_-9nb9CvjtyGFkgkX1PEbh-SgKbX_snQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP_N_Z-KFUYZc7p1z_-9nb9CvjtyGFkgkX1PEbh-SgKbX_snQw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiang,
thanks for re-starting the multi-transport support for dgram!

On Wed, Apr 07, 2021 at 11:25:36AM -0700, Jiang Wang . wrote:
>On Wed, Apr 7, 2021 at 2:51 AM Jorgen Hansen <jhansen@vmware.com> wrote:
>>
>>
>> > On 6 Apr 2021, at 20:31, Jiang Wang <jiang.wang@bytedance.com> wrote:
>> >
>> > From: "jiang.wang" <jiang.wang@bytedance.com>
>> >
>> > Currently, only VMCI supports dgram sockets. To supported
>> > nested VM use case, this patch removes transport_dgram and
>> > uses transport_g2h and transport_h2g for dgram too.

I agree on this part, I think that's the direction to go.  
transport_dgram was added as a shortcut.

>>
>> Could you provide some background for introducing this change - are you
>> looking at introducing datagrams for a different transport? VMCI datagrams
>> already support the nested use case,
>
>Yes, I am trying to introduce datagram for virtio transport. I wrote a
>spec patch for
>virtio dgram support and also a code patch, but the code patch is still WIP.
>When I wrote this commit message, I was thinking nested VM is the same as
>multiple transport support. But now, I realize they are different.
>Nested VMs may use
>the same virtualization layer(KVM on KVM), or different virtualization layers
>(KVM on ESXi). Thanks for letting me know that VMCI already supported nested
>use cases. I think you mean VMCI on VMCI, right?
>
>> but if we need to support multiple datagram
>> transports we need to rework how we administer port assignment for datagrams.
>> One specific issue is that the vmci transport won’t receive any datagrams for a
>> port unless the datagram socket has already been assigned the vmci transport
>> and the port bound to the underlying VMCI device (see below for more details).
>>
>I see.
>
>> > The transport is assgined when sending every packet and
>> > receiving every packet on dgram sockets.
>>
>> Is the intent that the same datagram socket can be used for sending packets both
>> In the host to guest, and the guest to directions?
>
>Nope. One datagram socket will only send packets to one direction, either to the
>host or to the guest. My above description is wrong. When sending packets, the
>transport is assigned with the first packet (with auto_bind).

I'm not sure this is right.
The auto_bind on the first packet should only assign a local port to the 
socket, but does not affect the transport to be used.

A user could send one packet to the nested guest and another to the host 
using the same socket, or am I wrong?

>
>The problem is when receiving packets. The listener can bind to the
>VMADDR_CID_ANY
>address. Then it is unclear which transport we should use. For stream
>sockets, there will be a new socket for each connection, and transport
>can be decided
>at that time. For datagram sockets, I am not sure how to handle that.

yes, this I think is the main problem, but maybe the sender one is even 
more complicated.

Maybe we should remove the 1:1 association we have now between vsk and 
transport.

At least for DGRAM, for connected sockets I think the association makes 
sense.

>For VMCI, does the same transport can be used for both receiving from
>host and from
>the guest?

Yes, they're registered at different times, but it's the same transport.

>
>For virtio, the h2g and g2h transports are different,, so we have to 
>choose
>one of them. My original thought is to wait until the first packet 
>arrives.
>
>Another idea is that we always bind to host addr and use h2g
>transport because I think that might
>be more common. If a listener wants to recv packets from the host, then 
>it
>should bind to the guest addr instead of CID_ANY.

Yes, I remember we discussed this idea, this would simplify the 
receiving, but there is still the issue of a user wanting to receive 
packets from both the nested guest and the host.

>Any other suggestions?
>

I think one solution could be to remove the 1:1 association between 
DGRAM socket and transport.

IIUC VMCI creates a skb for each received packet and queues it through 
sk_receive_skb() directly in the struct sock.

Then the .dgram_dequeue() callback dequeues them using 
skb_recv_datagram().

We can move these parts in the vsock core, and create some helpers to 
allow the transports to enqueue received DGRAM packets in the same way 
(and with the same format) directly in the struct sock.


What do you think?

Thanks,
Stefano

