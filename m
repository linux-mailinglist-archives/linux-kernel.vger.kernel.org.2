Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBED3202B7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 02:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhBTBxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 20:53:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229771AbhBTBw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 20:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613785892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eLzvVRICOaSDqurNQM35DBrVE0/HYIW5Fs4l7aQkac0=;
        b=MmPDKXU/P6f8BwkL+lHQcn5ILOemGUIRAh63pAU6bOfzVtage+LLWXQE4hy7vZ2klsCZrw
        enJ6Ow4zDAXRFajCppRVmrG+gmD2QJe3rIkS6LBj2+XPr1zucoUGlHjkZC8N6uaRxjiCPE
        qnDHxXdHfuLT1ruV8CjutBxfvlZ5jpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-91lZ5CFnOhehNkOUl4SdWA-1; Fri, 19 Feb 2021 20:51:28 -0500
X-MC-Unique: 91lZ5CFnOhehNkOUl4SdWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41750801965;
        Sat, 20 Feb 2021 01:51:27 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-57.pek2.redhat.com [10.72.13.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14C4660BFA;
        Sat, 20 Feb 2021 01:51:21 +0000 (UTC)
Subject: Re: [PATCH] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20210219084509.48269-1-jasowang@redhat.com>
 <20210219101321.GA651861@infradead.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e99fe7fa-1fa8-34ee-a1d7-94322419666e@redhat.com>
Date:   Sat, 20 Feb 2021 09:51:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210219101321.GA651861@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/19 6:13 下午, Christoph Hellwig wrote:
> On Fri, Feb 19, 2021 at 03:45:09AM -0500, Jason Wang wrote:
>> We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
>> lot of confusion. E.g it may break various default configs which want
>> virtio devices.
>>
>> So this patch fixes this by hide the prompot and document the
>> dependency.
> Is there any good reason to keep the symbol at all?
>

The plan is to convert IFCVF driver to use this module (select it).

Thanks

