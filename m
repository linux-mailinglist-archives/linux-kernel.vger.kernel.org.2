Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B61320FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 04:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhBVDmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 22:42:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230064AbhBVDmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 22:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613965282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eByhtyuketU2PjgP2Av/7Fbai5HOSWISKqIauwTJLI8=;
        b=UTcrUczSSBfMndS/KvuGCh9CmCBrGujhqMP4UnS6dAOshprZQbt0o5C4IKfWrcg/GjTawS
        5hpiUhHRg5u1H/7vl1Vim8hxsFxrpOK8m4X9vlOEzdB0Y8qc2nbzKnBG1BzHJEU3yu0jmL
        sW3SprqDKSxd3fzcDGhbohVyGoUIiVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-5H45XKSgN2eP3ihA-EWNkA-1; Sun, 21 Feb 2021 22:41:20 -0500
X-MC-Unique: 5H45XKSgN2eP3ihA-EWNkA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4B77835E20;
        Mon, 22 Feb 2021 03:41:18 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-112.pek2.redhat.com [10.72.13.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A5165B6BE;
        Mon, 22 Feb 2021 03:41:13 +0000 (UTC)
Subject: Re: [PATCH] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20210219084509.48269-1-jasowang@redhat.com>
 <CAK8P3a3wJDAA9X6se4EvSpoQTWyxdyeVt+8vfCCbTpe+Zqixew@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <78f4f064-7e70-0765-95ef-a929f280be68@redhat.com>
Date:   Mon, 22 Feb 2021 11:41:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3wJDAA9X6se4EvSpoQTWyxdyeVt+8vfCCbTpe+Zqixew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/19 6:12 下午, Arnd Bergmann wrote:
> On Fri, Feb 19, 2021 at 9:45 AM Jason Wang <jasowang@redhat.com> wrote:
>> We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
>> lot of confusion. E.g it may break various default configs which want
>> virtio devices.
>>
>> So this patch fixes this by hide the prompot and document the
>> dependency.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Anders Roxell <anders.roxell@linaro.org>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>> Fixes: 86b87c9d858b6 ("virtio-pci: introduce modern device module")
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Note that this effectively makes VIRTIO_PCI_MODERN and VIRTIO_PCI
> synonyms, so git goes back to not being able to have VIRTIO_PCI_MODERN
> by itself, but it seems that this is ok because the legacy part was already
> split out.


There will be a vDPA driver that will select VIRTIO_PCI_MODERN_DEV. It 
used to belong to one large sereis, but it was not merged since it needs 
some rebase.

Thanks


>
>          Arnd
>

