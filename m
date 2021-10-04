Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBF2421149
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhJDO3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233767AbhJDO3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633357651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LIG9qMDkxH/Rmc/0k4eqilgYZwh4mc9sxcj/N2tODz8=;
        b=QLWl+Ob5uMsM/e5s1amWVa1Md+YVYYUwKqtyrWFrisKTjFFiGbj941ZklLEr/8i5MEJh+7
        B22OowabuD21e7CAA5lG2vqge6Eogq4de4xUGZbi+LTBvm6KvOLHUUJ7NL2Owf+kM0CN4d
        1hvWVEUFuMyi6cnUtWFi+P7D0HB3adc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-7_cAvUANPKCmXPubGlravA-1; Mon, 04 Oct 2021 10:27:27 -0400
X-MC-Unique: 7_cAvUANPKCmXPubGlravA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 296B484A602;
        Mon,  4 Oct 2021 14:27:26 +0000 (UTC)
Received: from localhost (unknown [10.39.193.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C8C45C1CF;
        Mon,  4 Oct 2021 14:27:25 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
In-Reply-To: <20211004083455-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <87fstm47no.fsf@redhat.com>
 <20211002141351-mutt-send-email-mst@kernel.org>
 <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
 <20211003032253-mutt-send-email-mst@kernel.org>
 <87ee912e45.fsf@redhat.com>
 <20211004083455-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Mon, 04 Oct 2021 16:27:23 +0200
Message-ID: <878rz83lx0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Oct 04, 2021 at 02:01:14PM +0200, Cornelia Huck wrote:
>> On Sun, Oct 03 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > @@ -160,6 +163,33 @@ \subsection{Legacy Interface: A Note on Feature
>> >  Specification text within these sections generally does not apply
>> >  to non-transitional devices.
>> >  
>> > +\begin{note}
>> > +The device offers different features when used through
>> > +the legacy interface and when operated in accordance with this
>> > +specification.
>> > +\end{note}
>> > +
>> > +Transitional drivers MUST use Devices only through the legacy interface
>> 
>> s/Devices only through the legacy interface/devices through the legacy
>> interface only/
>> 
>> ?
>
> Both versions are actually confused, since how do you
> find out that device does not offer VIRTIO_F_VERSION_1?
>
> I think what this should really say is
>
> Transitional drivers MUST NOT accept VIRTIO_F_VERSION_1 through
> the legacy interface.

Ok, that makes sense.

Would it make sense that transitional drivers MUST accept VERSION_1
through the non-legacy interface? Or is that redundant?

>
>
> Does linux actually satisfy this? Will it accept VIRTIO_F_VERSION_1
> through the legacy interface if offered?

I think that the Linux drivers will not operate on feature bit 32+ if
they are in legacy mode?

>> 
>> Generally, looks good to me.
>
> Do we want to also add explanation that features can be
> changed until FEATURES_OK?

I always considered that to be implict, as feature negotiation is not
over until we have FEATURES_OK. Not sure whether we need an extra note.

