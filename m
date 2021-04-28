Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CAD36D486
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 11:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbhD1JJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 05:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23204 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229643AbhD1JJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619600909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fhr6VD9MpmIRwGw/LQkBVjKYFz4C2wLpeHZjuBPrxEw=;
        b=K12dyoJ6FUTb7XJozjP3pAYRBfr/077POcjMw+WVC3GYu75zFeSOfrTut0165Vl6A27pWx
        1/EKw27F87Si4QzUjGSY+la6MroEuSHBd/Awa5Lsv/mMjEOH7GVVr65zAXpqp5NQ0D7N80
        yRJevCwKjZy/PbK6aQOQ6r1I+yv3qq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-0_PvrvcsMLaWe9oxDTpISQ-1; Wed, 28 Apr 2021 05:08:27 -0400
X-MC-Unique: 0_PvrvcsMLaWe9oxDTpISQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00D4D19251A4;
        Wed, 28 Apr 2021 09:08:26 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-113.ams2.redhat.com [10.36.113.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48FE919C45;
        Wed, 28 Apr 2021 09:08:24 +0000 (UTC)
Date:   Wed, 28 Apr 2021 11:08:21 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Thomas Huth <thuth@redhat.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] arch/s390/configs: Change CONFIG_VIRTIO_CONSOLE to "m"
Message-ID: <20210428110821.70aa5774.cohuck@redhat.com>
In-Reply-To: <c015ef3f-ff88-113b-a089-e2af9202399a@de.ibm.com>
References: <20210428082442.321327-1-thuth@redhat.com>
        <c015ef3f-ff88-113b-a089-e2af9202399a@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2021 10:31:54 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 28.04.21 10:24, Thomas Huth wrote:
> > In former times, the virtio-console code had to be compiled into
> > the kernel since the old guest virtio transport had some hard de-
> > pendencies. But since the old virtio transport has been removed in
> > commit 7fb2b2d51244 ("s390/virtio: remove the old KVM virtio transport"),
> > we do not have this limitation anymore.
> > Commit bb533ec8bacd ("s390/config: do not select VIRTIO_CONSOLE via
> > Kconfig") then also lifted the hard setting in the Kconfig system, so
> > we can finally switch the CONFIG_VIRTIO_CONSOLE knob to compile this
> > driver as a module now, making it more flexible for the user to only
> > load it if it is really required.  
> 
> Isnt that a distro specific decision? I would be perfectly fine to have
> this change in Fedora, Redhat and co. Not so sure about defconfig.
> We often use the defconfig in our CI and development things to have a
> kernel config that boots up fine, even without a ramdisk. I agree that
> virtio console is no longer really the most important console but does
> it really hurt? Is any distro using the defconfig unmodified?

Having a value in the defconfig that will be sensible for most users
sounds good to me, independent of what different distros choose to do.
(Or am I misunderstanding the purpose of the defconfig?)

For booting without a ramdisk, I see that virtio-blk and virtio-input
are y, while other virtio drivers are m. That should be sufficient,
shouldn't it?

