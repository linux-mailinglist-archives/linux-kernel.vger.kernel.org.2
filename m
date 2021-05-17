Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40123824C9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 08:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhEQGxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 02:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230148AbhEQGw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 02:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621234297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f7qNgC8imSHKbn6li286hRYwuW3Kgkex7BvbIupjpGc=;
        b=L2im/GdJyeCvDavHITZJK9gfie3E3kI7t1TWGb82a/XBAPPFfJZcDSFoHUa0cO1GvZtN/F
        kHFjuIowdmOhoBKc8JvhkO8sh92oXSmEpoxObJ2pvQ9lyYhgy2Nz94YxU4e7E5/l274IF9
        EJSqvYhhneBWPIcCMrxCwINGS9acD7A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-n8NL2SwyOF-xeb6H69X4nQ-1; Mon, 17 May 2021 02:51:35 -0400
X-MC-Unique: n8NL2SwyOF-xeb6H69X4nQ-1
Received: by mail-wm1-f70.google.com with SMTP id o10-20020a05600c4fcab029014ae7fdec90so1051947wmq.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 23:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=f7qNgC8imSHKbn6li286hRYwuW3Kgkex7BvbIupjpGc=;
        b=ogtU9cPFyr09v+SkvAywBLKFcfVr9LzSKNoWTo8IYP0Gx4OEIMLAQ9Dj4LNyLPJM4c
         8xZxOTJrnW+MZjt71zodKeHX+nsDE1l9JuVe7BqBv1kXsvTO6er++F7jqp6PGrJrhydc
         /YXgj3XYIQr3HPdVwHzLN97SmT9GIIJadcjaBnWaK2r0/tNFO068whImNZzmrbczd16m
         XIQVr1/pWos64ZJco3/HvBH7BX6Je6LkD/FiQQXkTpY4w2xFyh4+a33T4OO5C3Cjpdqg
         LelS3TiJis8cc80HyWZFBCBRubz3Z1Kdo8SUq4M47fs7GBUcslfkcGzpS9mK0Uzcygc6
         NXCA==
X-Gm-Message-State: AOAM5321GY6LWUPRWVj+7JrSf4KN5nmU24pzpxeXMY8PCd54+h6BED8Q
        ESa5c+j5RnAzUPPUv0eS8NqFNYuKV32DiE1kAc6lVhvI1Sg1MY13WaGvESBQmgXYYSxsUsh6Lgy
        q6s126nrgiP/NgAYvMJTXxRHV
X-Received: by 2002:adf:fd82:: with SMTP id d2mr73783376wrr.218.1621234292984;
        Sun, 16 May 2021 23:51:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9tfRW+YS/gxDEIQCy7gwUfbRmVNS3PFiKPseSRXngi3Mq9CGDyrCDyAFl1I6VqBfyTpMgVQ==
X-Received: by 2002:adf:fd82:: with SMTP id d2mr73783362wrr.218.1621234292843;
        Sun, 16 May 2021 23:51:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-104.dyn.eolo.it. [146.241.245.104])
        by smtp.gmail.com with ESMTPSA id k7sm16778838wro.8.2021.05.16.23.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 23:51:32 -0700 (PDT)
Message-ID: <2e1ffc55aedb5d10eacce34cb7a5809138528d03.camel@redhat.com>
Subject: Re: [PATCH 5.10 380/530] udp: never accept GSO_FRAGLIST packets
From:   Paolo Abeni <pabeni@redhat.com>
To:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Date:   Mon, 17 May 2021 08:51:31 +0200
In-Reply-To: <20210515083717.GD30461@amd>
References: <20210512144819.664462530@linuxfoundation.org>
         <20210512144832.263718249@linuxfoundation.org> <20210515083717.GD30461@amd>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-05-15 at 10:37 +0200, Pavel Machek wrote:
> Hi!
> 
> > From: Paolo Abeni <pabeni@redhat.com>
> > 
> > [ Upstream commit 78352f73dc5047f3f744764cc45912498c52f3c9 ]
> > 
> > Currently the UDP protocol delivers GSO_FRAGLIST packets to
> > the sockets without the expected segmentation.
> > 
> > This change addresses the issue introducing and maintaining
> > a couple of new fields to explicitly accept SKB_GSO_UDP_L4
> > or GSO_FRAGLIST packets. Additionally updates  udp_unexpected_gso()
> > accordingly.
> > 
> > UDP sockets enabling UDP_GRO stil keep accept_udp_fraglist
> > zeroed.
> 
> What is going on here? accept_udp_fraglist variable is read-only.

Thank you for checking this!

The 'accept_udp_fraglist' field is implicitly initilized to zero at UDP
socket allocation time (done by sk_alloc).

So this patch effectively force segmentation of SKB_GSO_FRAGLIST
packets via the udp_unexpected_gso() helper.

We introduce the above field instead of unconditionally
segmenting SKB_GSO_FRAGLIST, because the next patch will use it (to
avoid unneeded segmentation for performance's sake for UDP tunnel), as
you noted.

Please let me know if the above clarifies the situation.

Thanks!

Paolo

