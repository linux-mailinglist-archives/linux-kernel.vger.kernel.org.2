Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBBE339098
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhCLPBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:01:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231778AbhCLPBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615561280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dY5uAwZg117bNtRKEEBL+2LzAlswxrz2wq+X03tujc0=;
        b=JXF9r/LLvIORh6Vdafosmv1WkSr/ZbesvUHcY6gKTS9oSRd7XqOjQ18bhDZxYymLoVnkZ6
        H9XHYzkXA1YCFomEFKvZava8FjdL2mkahA7Iq3zKDobnoWMn9BTVCmd8kV9LUhMG3Q5obw
        YPH5iiXyqiEKh/grv6NC+QvwJhFpiCs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-u96rOPEmMJKlIBrmgJMW0w-1; Fri, 12 Mar 2021 10:01:18 -0500
X-MC-Unique: u96rOPEmMJKlIBrmgJMW0w-1
Received: by mail-wm1-f71.google.com with SMTP id a3so2144847wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dY5uAwZg117bNtRKEEBL+2LzAlswxrz2wq+X03tujc0=;
        b=NlkGrVudQGdtJzg0NRCz6LhJj0YPQ1q6//M+bOYxvZsmMf3IrtyqotVdikXEearEog
         hyPMEBAu9QjIPA6Hi5fG4kV9B3ZQ+U2aRaX90NzkWnlK56LL+BHtFN5XLaP3KrfCD0+K
         6FgykdAFEXMGWiufjYnvH15uk6+Zc2G0xDdI+qtTNBkGMlwsrlFNRR/rkb1JIZp0iLCM
         JHZRWcPUKVFZebCIHxX577PGOEK5QyxewDtsFtHypJ3+GJxSiTk3PVczw30OUfvwHgLV
         r1Dx2GdZP39F7NR5T5QCL5TOMq6KdTOdRradAnZNvn23NrQ8zQBjDd/k+HGj9QkpZVez
         PXEw==
X-Gm-Message-State: AOAM532cMAx6hFcTm1hlzQEKN5U6BQfOGqnWd1sbQPH1zEucfRku2slq
        vBy2wHFGq7etcR6IUTxFLjbEZdstIsU7dfmgbjmpxnrcPoNUNIDggfHQr04frJfXHcVs1HYX51O
        yBvXDqFbNlINMDsllpDv/yr4g
X-Received: by 2002:a1c:195:: with SMTP id 143mr13140056wmb.81.1615561277066;
        Fri, 12 Mar 2021 07:01:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwU/+j7YIHGGD7r2/oDTZXMPTuZH3Lx7EWKi5joHVZyKzFAUrs1mT0L3T9QcEyLqXmzz7K7Aw==
X-Received: by 2002:a1c:195:: with SMTP id 143mr13139730wmb.81.1615561274237;
        Fri, 12 Mar 2021 07:01:14 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id c8sm691886wmb.34.2021.03.12.07.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:01:13 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:01:10 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Colin Ian King <colin.king@canonical.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v6 04/22] af_vsock: implement SEQPACKET receive loop
Message-ID: <20210312150110.344tr3wgz5cwruzz@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210307175948.3464885-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210307175948.3464885-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 08:59:45PM +0300, Arseny Krasnov wrote:
>This adds receive loop for SEQPACKET. It looks like receive loop for
>STREAM, but there is a little bit difference:
>1) It doesn't call notify callbacks.
>2) It doesn't care about 'SO_SNDLOWAT' and 'SO_RCVLOWAT' values, because
>   there is no sense for these values in SEQPACKET case.
>3) It waits until whole record is received or error is found during
>   receiving.
>4) It processes and sets 'MSG_TRUNC' flag.
>
>So to avoid extra conditions for two types of socket inside one loop, two
>independent functions were created.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/net/af_vsock.h   |  5 +++
> net/vmw_vsock/af_vsock.c | 95 +++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 99 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

