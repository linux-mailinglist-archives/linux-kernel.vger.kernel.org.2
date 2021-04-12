Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9397735C5D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbhDLMAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39426 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238448AbhDLMAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618228832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fqhV33RkbsMbtO9g46LNef0TvFJ+Oo49emjwqgVWPXY=;
        b=WCoBJ9ww9/3t1COXjbh1ibLY0xm8m4VvGPrvoE4Fe00mYEYYwbiOwNSdf6EygTzfkkxkeg
        bnDrVvz8fxf65GJcKuUtItHgm20jqe8fLBkkq9WxtgNLJ9vnAC1l/cQGQ9fDfJvOKIn3qL
        69JhbZezDctcg3njJEZskD2azAMx0A0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-MGzVky1IOmeJ8UGhVTNogA-1; Mon, 12 Apr 2021 08:00:30 -0400
X-MC-Unique: MGzVky1IOmeJ8UGhVTNogA-1
Received: by mail-wr1-f72.google.com with SMTP id j4so5935135wru.20
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fqhV33RkbsMbtO9g46LNef0TvFJ+Oo49emjwqgVWPXY=;
        b=SgRc1jE2nF1DgvdcDWfo746/SugKSZH92/ugV1IPEHjZCpWZPH5G/vpYBqd6TGBl33
         qKv/kF2iEgaO5DGmghN5kfFMTLjihiEDfsDVmHNg19pv1xGgmxaiIhsWfWoJLeembSzA
         Z98hLMTP0MTo64NTCEGpnUHxskIEg4YJEyjNQUsTY/SzsfJy6Sr5ABvR9jNjbENilpv+
         tKZdYAFAMCDVEBHrAVB6/+E1fdvmIuxufV4Mx0ivHFOV/9mdPVvvBjjVXzZpxFp28YUT
         Xb5bLxMrdQACqDZPl3xiLHa6l9y5bWYTNXKFrjopdR2EnpdvmoX80KloZFzEB4no+EOq
         vuxg==
X-Gm-Message-State: AOAM532lWm5bideaSHDmAmO/9unZLH4wQjW6uuDYq7Xnj2KG7wp3OAeP
        AsvG56n/LifcUjfy7NgHyB+SmZb2o6Gc+/AAfB9qDWWYDaGjUHP+Fkg+eN1Z1k7Mm5Q4Bq1k9lQ
        ROmvEhHnBfrd5ua+gMw7s5iLe
X-Received: by 2002:a1c:2985:: with SMTP id p127mr21710540wmp.165.1618228829148;
        Mon, 12 Apr 2021 05:00:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2SCE8sMznZG6rxO4GSbL4qQt0Uw6bMoyj3GCEYG1byM8BieOAw3WLYqRj7PoobgERMieckw==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr21710521wmp.165.1618228828984;
        Mon, 12 Apr 2021 05:00:28 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
        by smtp.gmail.com with ESMTPSA id j14sm16118383wrw.69.2021.04.12.05.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 05:00:28 -0700 (PDT)
Date:   Mon, 12 Apr 2021 08:00:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Enrico Granata <egranata@google.com>, jasowang@redhat.com,
        pbonzini@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: Add support for lifetime feature
Message-ID: <20210412074309-mutt-send-email-mst@kernel.org>
References: <20210330231602.1223216-1-egranata@google.com>
 <YHQQL1OTOdnuOYUW@stefanha-x1.localdomain>
 <20210412094217.GA981912@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412094217.GA981912@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:42:17AM +0100, Christoph Hellwig wrote:
> A note to the virtio committee:  eMMC is the worst of all the currently
> active storage standards by a large margin.  It defines very strange
> ad-hoc interfaces that expose very specific internals and often provides
> very poor abstractions.

Are we talking about the lifetime feature here?  UFS has it too right?
It's not too late to
change things if necessary... it would be great if you could provide
more of the feedback on this on the TC mailing list.

> It would be great it you could reach out to the
> wider storage community before taking bad ideas from the eMMC standard
> and putting it into virtio.

Noted.  It would be great if we had more representation from the storage
community ... meanwhile what would a good forum for this be?
linux-block@vger.kernel.org ?
Thanks,

-- 
MST

