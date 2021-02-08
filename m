Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20913312A2F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 06:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBHFoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 00:44:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229587AbhBHFoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 00:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612762960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rurmJQ4opTwfFXGQeyUIRfP+jPm6sD9BukDZ25cciA=;
        b=RUJplFY/TCs/w7sN7p7B2zvoL9NTftT3eZUljOTqGGnrB7yXCogzlu4YauFqr7GdNEf782
        LnImN8Ly3X3xRkhrHbosJCc04l8MUBvrHcE9dn68GgAKThKAqG4I1r5ieZhGpXRsGB9gCQ
        X+w+Cpt/sjq8M3i+LGXFf7cSJ7BVaHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-IDOr3tdoNKeQ4hMRY90kYw-1; Mon, 08 Feb 2021 00:42:37 -0500
X-MC-Unique: IDOr3tdoNKeQ4hMRY90kYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10C68869ECC;
        Mon,  8 Feb 2021 05:42:36 +0000 (UTC)
Received: from [10.72.13.185] (ovpn-13-185.pek2.redhat.com [10.72.13.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E66DC5D9D5;
        Mon,  8 Feb 2021 05:42:28 +0000 (UTC)
Subject: Re: [PATCH V3 16/19] virtio-pci: introduce modern device module
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        lulu@redhat.com, sgarzare@redhat.com, rdunlap@infradead.org
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-17-jasowang@redhat.com>
 <20210205103214-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <24cb3ebe-1248-3e31-0716-cf498cf1d728@redhat.com>
Date:   Mon, 8 Feb 2021 13:42:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205103214-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/5 下午11:34, Michael S. Tsirkin wrote:
> On Mon, Jan 04, 2021 at 02:55:00PM +0800, Jason Wang wrote:
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> I don't exactly get why we need to split the modern driver out,
> and it can confuse people who are used to be seeing virtio-pci.


The virtio-pci module still there. No user visible changes. Just some 
codes that could be shared with other driver were split out.


>
> The vdpa thing so far looks like a development tool, why do
> we care that it depends on a bit of extra code?


If I'm not misunderstanding, trying to share codes is proposed by you here:

https://lkml.org/lkml/2020/6/10/232

We also had the plan to convert IFCVF to use this library.

Thanks

>

