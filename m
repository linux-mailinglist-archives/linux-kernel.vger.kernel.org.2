Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D40F3655DF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 12:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhDTKJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 06:09:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230264AbhDTKJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 06:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618913316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a1pYqsNDnaImaveZt19WFrefpysHdoYlJwKJGNtTNq4=;
        b=AcHYZmXYqbeEh4cX5cSX0Z4yYp6A7Ns0ZkqGEEZYCLN3stlRASx5jEyXL3d1sp/Dag+WBO
        T/WsXj90eUTuPgo6b+Jb1BnmN8KrA16qoJ8bFnUzF37C4LYlE/7qNIGDgxoV+/arstHLXX
        7hJ9Keja2FbZVLxxZTeFqqn9P29+L4A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-rvOOWgpeO7OueByO47EZMQ-1; Tue, 20 Apr 2021 06:08:34 -0400
X-MC-Unique: rvOOWgpeO7OueByO47EZMQ-1
Received: by mail-wm1-f72.google.com with SMTP id v5-20020a05600c2145b029012bdd9ddcb7so3653374wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 03:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a1pYqsNDnaImaveZt19WFrefpysHdoYlJwKJGNtTNq4=;
        b=aSS/dtTybn6A/MsMH4QzU9c+KDyVwA1ia9Zf4H3YNVh5hGmu60x7TiL2FLHTS8wWoB
         oft4s1o2HXtvZYmBniA3q2mvFjAeCIJKe1Yr3Q0gMfdV/ellopr0B1VydJQe81WyGPqp
         gUO3OJ0+LzK7D7Vlea28J+Arq2ckY2ZF8buSxBz20E/nAtK/tgAApQJfV3Usz8I+Wm53
         qD3EzqQFwQIlrPLoi01ICoRafWF0KAmmfK6hm5VzMXZzKjuNBtHlUC5aBGsF0Ltz6ao2
         xTaVaGEW9eGAOd/t1+2W5MkVIgd48+c6svh0sZPZzZzWQvwMk63OkqIcRBLUipRRoiTZ
         x4LQ==
X-Gm-Message-State: AOAM530rHEAojybugNywGgsxPo1mCb2dTWvbBcNK/27nqfIKoCoZyKDb
        NVNYvDL9T5XbFc7PT5e4o5xOPqUteJddyz8kOl5y5Sk7jlJF7TEf/7VoQe+vdmsIrOYYrI4JHob
        tr1QiflZQsQfSpafqYCWhbMCc
X-Received: by 2002:adf:bbd2:: with SMTP id z18mr19583495wrg.274.1618913313338;
        Tue, 20 Apr 2021 03:08:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiOVtXxYFOUh6+eZ32xEpHAEZlXERzd+C/fJVENNgoKL6Wlrxpy9j9zC3V92YoEbuatNntfw==
X-Received: by 2002:adf:bbd2:: with SMTP id z18mr19583476wrg.274.1618913313205;
        Tue, 20 Apr 2021 03:08:33 -0700 (PDT)
Received: from redhat.com ([2a10:800a:cdef:0:114d:2085:61e4:7b41])
        by smtp.gmail.com with ESMTPSA id u8sm26806244wrr.42.2021.04.20.03.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 03:08:32 -0700 (PDT)
Date:   Tue, 20 Apr 2021 06:08:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Enrico Granata <egranata@google.com>, jasowang@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio_blk: Add support for lifetime feature
Message-ID: <20210420060807-mutt-send-email-mst@kernel.org>
References: <20210416194709.155497-1-egranata@google.com>
 <20210420070129.GA3534874@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420070129.GA3534874@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 08:01:29AM +0100, Christoph Hellwig wrote:
> Just to despit my 2 cents again:  I think the way this is specified
> in the virtio spec is actively harmful and we should not suport it in
> Linux.
> 
> If others override me we at least need to require a detailed
> documentation of these fields as the virto spec does not provide it.
> 
> Please also do not add pointless over 80 character lines, and follow
> the one value per sysfs file rule.

Enrico would you like to raise the issues with the virtio TC
for resolution?

-- 
MST

