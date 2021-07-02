Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137523B9D8E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 10:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhGBId3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 04:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230166AbhGBId1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625214654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ebqrOg7XijUonFvzMVuLSVbgtaPdYEqUj8mLxx77yyo=;
        b=gYqBAmEJ1MxYRjABYjxST3xWZGGGZK2clHZIRECjMo69cGRyGq4FW2wNVLjyXJe6PXQYAP
        gA/33rRJ/yiQYmJwoAo2Y1X6fNXE7h6ngPSNLJIPeYWzncXVkUQHgHZX2rvl4PEQaMXhVL
        mDDTLH76QGpJXalZK1Vg1fzIZ+ZDxp8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-XWvu-hHYNhWTaLxl8El8PQ-1; Fri, 02 Jul 2021 04:30:53 -0400
X-MC-Unique: XWvu-hHYNhWTaLxl8El8PQ-1
Received: by mail-wm1-f72.google.com with SMTP id 13-20020a1c010d0000b02901eca51685daso5961753wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 01:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ebqrOg7XijUonFvzMVuLSVbgtaPdYEqUj8mLxx77yyo=;
        b=GzEBkOaF7hNgbxXVBqD3Pqx0GZMLE1xrndFkRGn8ujDfE6LcxF9r0ycTU2s7nyDK6N
         08dQPvYTm1V+bbGLyQMYiCq/Sf4T1tjsDISGb0fcNfUi6ikESfi2xuExj/2jZlwAYQWR
         H1RgpT14TDa0dSWEky9b19VYElJ1k0B/hQI/3JOzSU03PIijZa4ggicvNlenJ7+xb18N
         YK6ih2Nsl97PUd+LfHtlhmGPI07gXgS1Btfd6GY6/u4Eq32Se3vTj2ESJ4E6Pg1lUKzb
         ZytyWtm7cN4YXPQpaq9HpI/gxF+8Tk/sA8tJ3AQDEHuuEu6i6FrvnqLtqlOv7sRlKhRW
         2eqg==
X-Gm-Message-State: AOAM532nTbJ3jb0DtxIhkr6PDYIwklTqVkJyjwWLtwxi2zY5qcQAduko
        dnanWHpdmMVn/T7Fvo3gs6jsL8nFEsRJH3R/VHzMiln26Bu1fw5vbo9QWhUhyfa/WSpbKmC7oyq
        XeOyl1PjnHZ9CAD86yr155Klf
X-Received: by 2002:adf:e6c4:: with SMTP id y4mr1967223wrm.4.1625214652667;
        Fri, 02 Jul 2021 01:30:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8uIwBip3ssxhZ0C7gznIuoJUVg/I2BZmKaIPk2T4beqCdTMa/NQLxn0hIFA0PybOGMb40GA==
X-Received: by 2002:adf:e6c4:: with SMTP id y4mr1967207wrm.4.1625214652525;
        Fri, 02 Jul 2021 01:30:52 -0700 (PDT)
Received: from redhat.com ([2.55.143.136])
        by smtp.gmail.com with ESMTPSA id k6sm897496wrx.41.2021.07.02.01.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 01:30:51 -0700 (PDT)
Date:   Fri, 2 Jul 2021 04:30:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Jason Wang <jasowang@redhat.com>, davem@davemloft.net,
        kuba@kernel.org, brouer@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, will@kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH net-next v3 1/3] selftests/ptr_ring: add benchmark
 application for ptr_ring
Message-ID: <20210702042838-mutt-send-email-mst@kernel.org>
References: <1625142402-64945-1-git-send-email-linyunsheng@huawei.com>
 <1625142402-64945-2-git-send-email-linyunsheng@huawei.com>
 <e1ec4577-a48f-ff56-b766-1445c2501b9f@redhat.com>
 <91bcade8-f034-4bc7-f329-d5e1849867e7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91bcade8-f034-4bc7-f329-d5e1849867e7@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 04:17:17PM +0800, Yunsheng Lin wrote:
> > Let's reuse ptr_ring.c in tools/virtio/ringtest. Nothing virt specific there.
> 
> It *does* have some virtio specific at the end of ptr_ring.c.
> It can be argued that the ptr_ring.c in tools/virtio/ringtest
> could be refactored to remove the function related to virtio.
> 
> But as mentioned in the previous disscusion [1], the tools/virtio/
> seems to have compile error in the latest kernel, it does not seems
> right to reuse that.
> And most of testcase in tools/virtio/ seems
> better be in tools/virtio/ringtest instead，so until the testcase
> in tools/virtio/ is compile-error-free and moved to tools/testing/
> selftests/, it seems better not to reuse it for now.


That's a great reason to reuse - so tools/virtio/ stays working.
Please just fix that.

-- 
MST

