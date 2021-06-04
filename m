Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821BB39BB60
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFDPFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230083AbhFDPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622819012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N8yh602NOt1FboICUCF579RgmHMOnP9aRS2NkQT/Xt8=;
        b=aawnn6M1B+HmNMtSau7Bk4JnMA6uS14EhwX6GcRmMzm/3pNkm3/BG5j7UWd1f4jpBUY8dQ
        oXCW+i0+AOOFmETGlwmISt+aFXIrQuz6p/Y/TKmkRfEynliN6XANAki8AAycXCM3XmRddr
        ySl46HBh0DxJMnCOC741ZPrJ/hrAN50=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-NJIYth20PnKquE6GLbPsWw-1; Fri, 04 Jun 2021 11:03:30 -0400
X-MC-Unique: NJIYth20PnKquE6GLbPsWw-1
Received: by mail-ej1-f71.google.com with SMTP id am5-20020a1709065685b02903eef334e563so3552779ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 08:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N8yh602NOt1FboICUCF579RgmHMOnP9aRS2NkQT/Xt8=;
        b=uhW7CY44zmjlayDwUoXrjBsaM4l5tDpSpGc0V6ZSGqpIBKGC1yQ4Ws4fyL/xTM5bq1
         l38R4jmFzz5lrmYMYYGCtgzrrVUx7FGMB/WCQbslZZ9YhS+nNwHUvmqwxLfxdDZJcNvr
         rmMQ2VbkvrrOVcQlLPJZx5shofKRXNTIeaenvz2SyFs+mT8c8SwgvWCTcJOGaZGytosU
         msIX9R7hfS9CZ4prsKx4erCEIZ31982PFgXU2DcANaz1WskmVp9U+UPsUhdfx98Ozb/g
         T9ATKPh1NxSM+DDDRzVVGhgNYh8sJMPJUROl3kbpXYFVS4JOQ5MkKpJIQikJyNBHz4bV
         y87w==
X-Gm-Message-State: AOAM532aV5Fxim/9L1y5fXqlJ/W2ZMX03TXm8p8ckfsjwBJ92P/BQr0R
        oETukoYX27fxGFQR8HTEIQkq8LUd+CPbXwPypobTPt7WGIuijyvoo9h7knSNmkwD0dM25THxql2
        AZgdIBjeGDNjQey48R2BT9w1Q
X-Received: by 2002:a17:906:33c8:: with SMTP id w8mr4691008eja.46.1622819009562;
        Fri, 04 Jun 2021 08:03:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjb/RE98uava1ct94kKaUaYfBzH7VQ7rmLgnwo11bRlUBdrfcaLuOG3pu0IuBN8h+k7vCmHA==
X-Received: by 2002:a17:906:33c8:: with SMTP id w8mr4690982eja.46.1622819009287;
        Fri, 04 Jun 2021 08:03:29 -0700 (PDT)
Received: from steredhat ([5.170.129.161])
        by smtp.gmail.com with ESMTPSA id a97sm3488933edf.72.2021.06.04.08.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:03:28 -0700 (PDT)
Date:   Fri, 4 Jun 2021 17:03:24 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Colin Ian King <colin.king@canonical.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oxffffaa@gmail.com" <oxffffaa@gmail.com>
Subject: Re: [PATCH v10 11/18] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <20210604150324.winiikx5h3p6gsyy@steredhat>
References: <20210520191357.1270473-1-arseny.krasnov@kaspersky.com>
 <20210520191801.1272027-1-arseny.krasnov@kaspersky.com>
 <20210603144513.ryjzauq7abnjogu3@steredhat>
 <6b833ccf-ea93-db6a-4743-463ac1cfe817@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6b833ccf-ea93-db6a-4743-463ac1cfe817@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 04:12:23PM +0300, Arseny Krasnov wrote:
>
>On 03.06.2021 17:45, Stefano Garzarella wrote:
>> On Thu, May 20, 2021 at 10:17:58PM +0300, Arseny Krasnov wrote:
>>> Callback fetches RW packets from rx queue of socket until whole record
>>> is copied(if user's buffer is full, user is not woken up). This is done
>>> to not stall sender, because if we wake up user and it leaves syscall,
>>> nobody will send credit update for rest of record, and sender will wait
>>> for next enter of read syscall at receiver's side. So if user buffer is
>>> full, we just send credit update and drop data.
>>>
>>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>> ---
>>> v9 -> v10:
>>> 1) Number of dequeued bytes incremented even in case when
>>>    user's buffer is full.
>>> 2) Use 'msg_data_left()' instead of direct access to 'msg_hdr'.
>>> 3) Rename variable 'err' to 'dequeued_len', in case of error
>>>    it has negative value.
>>>
>>> include/linux/virtio_vsock.h            |  5 ++
>>> net/vmw_vsock/virtio_transport_common.c | 65 +++++++++++++++++++++++++
>>> 2 files changed, 70 insertions(+)
>>>
>>> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>>> index dc636b727179..02acf6e9ae04 100644
>>> --- a/include/linux/virtio_vsock.h
>>> +++ b/include/linux/virtio_vsock.h
>>> @@ -80,6 +80,11 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
>>> 			       struct msghdr *msg,
>>> 			       size_t len, int flags);
>>>
>>> +ssize_t
>>> +virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>>> +				   struct msghdr *msg,
>>> +				   int flags,
>>> +				   bool *msg_ready);
>>> s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
>>> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>>>
>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>> index ad0d34d41444..61349b2ea7fe 100644
>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>> @@ -393,6 +393,59 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>>> 	return err;
>>> }
>>>
>>> +static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
>>> +						 struct msghdr *msg,
>>> +						 int flags,
>>> +						 bool *msg_ready)
>>> +{
>>> +	struct virtio_vsock_sock *vvs = vsk->trans;
>>> +	struct virtio_vsock_pkt *pkt;
>>> +	int dequeued_len = 0;
>>> +	size_t user_buf_len = msg_data_left(msg);
>>> +
>>> +	*msg_ready = false;
>>> +	spin_lock_bh(&vvs->rx_lock);
>>> +
>>> +	while (!*msg_ready && !list_empty(&vvs->rx_queue) && dequeued_len >= 0) {
>> I'
>>
>>> +		size_t bytes_to_copy;
>>> +		size_t pkt_len;
>>> +
>>> +		pkt = list_first_entry(&vvs->rx_queue, struct virtio_vsock_pkt, list);
>>> +		pkt_len = (size_t)le32_to_cpu(pkt->hdr.len);
>>> +		bytes_to_copy = min(user_buf_len, pkt_len);
>>> +
>>> +		if (bytes_to_copy) {
>>> +			/* sk_lock is held by caller so no one else can dequeue.
>>> +			 * Unlock rx_lock since memcpy_to_msg() may sleep.
>>> +			 */
>>> +			spin_unlock_bh(&vvs->rx_lock);
>>> +
>>> +			if (memcpy_to_msg(msg, pkt->buf, bytes_to_copy))
>>> +				dequeued_len = -EINVAL;
>> I think here is better to return the error returned by memcpy_to_msg(),
>> as we do in the other place where we use memcpy_to_msg().
>>
>> I mean something like this:
>> 			err = memcpy_to_msgmsg, pkt->buf, bytes_to_copy);
>> 			if (err)
>> 				dequeued_len = err;
>Ack
>>> +			else
>>> +				user_buf_len -= bytes_to_copy;
>>> +
>>> +			spin_lock_bh(&vvs->rx_lock);
>>> +		}
>>> +
>> Maybe here we can simply break the cycle if we have an error:
>> 		if (dequeued_len < 0)
>> 			break;
>>
>> Or we can refactor a bit, simplifying the while() condition and also the
>> code in this way (not tested):
>>
>> 	while (!*msg_ready && !list_empty(&vvs->rx_queue)) {
>> 		...
>>
>> 		if (bytes_to_copy) {
>> 			int err;
>>
>> 			/* ...
>> 			*/
>> 			spin_unlock_bh(&vvs->rx_lock);
>> 			err = memcpy_to_msgmsg, pkt->buf, bytes_to_copy);
>> 			if (err) {
>> 				dequeued_len = err;
>> 				goto out;
>> 			}
>> 			spin_lock_bh(&vvs->rx_lock);
>>
>> 			user_buf_len -= bytes_to_copy;
>> 		}
>>
>> 		dequeued_len += pkt_len;
>>
>> 		if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR)
>> 			*msg_ready = true;
>>
>> 		virtio_transport_dec_rx_pkt(vvs, pkt);
>> 		list_del(&pkt->list);
>> 		virtio_transport_free_pkt(pkt);
>> 	}
>>
>> out:
>> 	spin_unlock_bh(&vvs->rx_lock);
>>
>> 	virtio_transport_send_credit_update(vsk);
>>
>> 	return dequeued_len;
>> }
>
>I think we can't do 'goto out' or break, because in case of error, we still need
>to free packet.

Didn't we have code that remove packets from a previous message?
I don't see it anymore.

For example if we have 10 packets queued for a message (the 10th packet 
has the EOR flag) and the memcpy_to_msg() fails on the 2nd packet, with 
you proposal we are freeing only the first 2 packets, the rest is there 
and should be freed when reading the next message, but I don't see that 
code.

The same can happen if the recvmsg syscall is interrupted. In that case 
we report that nothing was copied, but we freed the first N packets, so 
they are lost but the other packets are still in the queue.

Please check also the patch where we implemented 
__vsock_seqpacket_recvmsg().

I thinks we should free packets only when we are sure we copied them to 
the user space.

> It is possible to do something like this:
>
>		virtio_transport_dec_rx_pkt(vvs, pkt);
>		list_del(&pkt->list);
>		virtio_transport_free_pkt(pkt);
>
>		if (dequeued_len < 0)
>			break;
>
>>
>>
>

