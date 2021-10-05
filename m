Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50989422C3C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhJEPWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:22:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235322AbhJEPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633447250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uacToDR1I0FxC1x9xJ+CimJRSu2bmxQDudmiV7tnB4E=;
        b=E+x4fP6qoIlVTL5rGH1atAObDmJ9L3v3QrGpJHfGRXJIhX+426ewpmd2netoNxmG2yPMMN
        NdwbR769YLhKSBuRId/reZ/PHQU5YRbltyt0HTSw0pndu71rs7a7mIZ72PDAkEfFcsoacw
        zlv8f+/Zuc9W/6+DdIhFkfBA8fUDWdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-ZrHkHQnuPmuuqSH62acTrQ-1; Tue, 05 Oct 2021 11:20:49 -0400
X-MC-Unique: ZrHkHQnuPmuuqSH62acTrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 529B81084683;
        Tue,  5 Oct 2021 15:20:48 +0000 (UTC)
Received: from localhost (unknown [10.39.192.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6D8360BF4;
        Tue,  5 Oct 2021 15:20:30 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        qemu-devel@nongnu.org
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/1] virtio: write back features
 before verify
In-Reply-To: <20211005072110-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
 <20211003032253-mutt-send-email-mst@kernel.org>
 <87ee912e45.fsf@redhat.com>
 <20211004083455-mutt-send-email-mst@kernel.org>
 <878rz83lx0.fsf@redhat.com>
 <20211004110152-mutt-send-email-mst@kernel.org>
 <87zgro23r1.fsf@redhat.com>
 <20211004160005-mutt-send-email-mst@kernel.org>
 <20211005131751.53175b10.pasic@linux.ibm.com>
 <20211005072110-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Tue, 05 Oct 2021 17:20:29 +0200
Message-ID: <87fstf1osi.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Oct 05, 2021 at 01:17:51PM +0200, Halil Pasic wrote:
>> On Mon, 4 Oct 2021 16:01:12 -0400
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > > 
>> > > Ok, so what about something like
>> > > 
>> > > "If FEATURES_OK is not set, the driver MAY change the set of features it
>> > > accepts."
>> > > 
>> > > in the device initialization section?  
>> > 
>> > Maybe "as long as". However Halil implied that some features are not
>> > turned off properly if that happens. Halil could you pls provide
>> > some examples?
>> 
>> 
>> 
>> static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
>> {
>> ...
>>     if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
>>         qapi_event_send_failover_negotiated(n->netclient_name);
>>         qatomic_set(&n->failover_primary_hidden, false);
>>         failover_add_primary(n, &err);
>>         if (err) {
>>             warn_report_err(err);
>>         }
>>     }
>> }
>> 
>> This is probably the only one in QEMU. Back then I stopped looking
>> after the first hit.

After some grepping, I agree that this seems to be the only one.

>> 
>> Regards,
>> Halil
>
> Hmm ok more failover issues :(
> This stuff really should be moved to set_status.

Yes, F_STANDBY does not exist for legacy, so performing those actions
when FEATURES_OK is set looks like the right thing to do.

