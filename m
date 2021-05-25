Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88EE3903BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhEYOTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233724AbhEYOSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621952235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qs8EjzEOCz++s3CVPlPwuFgTHOtbAQXpJzzRW8nZD74=;
        b=eQWwSNP00prQajd0SYcxyxBIlCbBWdOQ2xHOz+++28sKbxcKGjiimr4L9g5sdd4GeTl2GG
        6tSquJotv84E1gSPz01dfka/gapPAWPg3mRJSpIFCB6BJW62C0v75goeh0vmnYax6kh0Ym
        QKYMMO7FItGrYnuPkWgI+h4Ixfzsitc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-edjU8Wm1PteeqviCyPnGsg-1; Tue, 25 May 2021 10:17:13 -0400
X-MC-Unique: edjU8Wm1PteeqviCyPnGsg-1
Received: by mail-ej1-f71.google.com with SMTP id nd10-20020a170907628ab02903a324b229bfso8896403ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qs8EjzEOCz++s3CVPlPwuFgTHOtbAQXpJzzRW8nZD74=;
        b=Xz2RckZ7s+yW56eVv2QyQYW20pxFXKf+T7lOa2vuDU4/9TiPa2Gad9/B1/GEP/8gyA
         H2Uvk1wqOYL5CwacjXZkfJzBqetXCpoEubuUowG9TbrZJv26d/bM6On9lmQNk7FJsFh1
         YKSWkf1+M/H1gVaj7l48U0umjiFXsmEXsAgwNiTsGqukVtahT0MOgBGskKtFb6AUGca8
         DEC1jDi2cB3YfiqAYUB4NORM0zY95WlovwoNVKpaVUhVJ/zkGvJENmV4IaYOwNTRw5Pp
         ++n9leZjhNuVmB+v77blZC3LltTN4BMiQmbDwqxu4UMJjAzDYoIjwEsmrOqbwxDKDHfJ
         Ckyg==
X-Gm-Message-State: AOAM530M0hZGA1k6qTVKrbwIYP5b5NdRGdCG1jx/WX+HprU9rX/aW0cD
        pUmzGJzUj+Wwbc/Hsl3WF+txCjWGbyyEPeavspCVDrYNEKCc1AjZV/X1/aHCHOorgVeY/SeTPgs
        NUoQqBd1GfJtWscWQk0uz+jEc
X-Received: by 2002:a05:6402:190e:: with SMTP id e14mr32337350edz.146.1621952231504;
        Tue, 25 May 2021 07:17:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFKL2as0znk9EfRE37BQywDQJb+X3ks+d5tVQoRqTJJqOiRkyF4ZCUMGJz3wAnrUijDO8n7A==
X-Received: by 2002:a05:6402:190e:: with SMTP id e14mr32337320edz.146.1621952231368;
        Tue, 25 May 2021 07:17:11 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id bv17sm9143813ejb.37.2021.05.25.07.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 07:17:10 -0700 (PDT)
Date:   Tue, 25 May 2021 16:17:08 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Colin Ian King <colin.king@canonical.com>,
        Norbert Slusarek <nslusarek@gmx.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, oxffffaa@gmail.com
Subject: Re: [PATCH v10 06/18] af_vsock: rest of SEQPACKET support
Message-ID: <20210525141708.nklo776yq2nnhju7@steredhat>
References: <20210520191357.1270473-1-arseny.krasnov@kaspersky.com>
 <20210520191639.1271423-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210520191639.1271423-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 10:16:36PM +0300, Arseny Krasnov wrote:
>To make SEQPACKET socket functional, socket ops was added
>for SEQPACKET type and such type of socket was allowed
>to create.

If you need to resend, I think is better to use the present in the 
commit message.

Maybe you can rephrase something like this:
"Add socket ops for SEQPACKET type and .seqpacket_allow() callback
to query transports if they support SEQPACKET"


>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/net/af_vsock.h   |  1 +
> net/vmw_vsock/af_vsock.c | 36 +++++++++++++++++++++++++++++++++++-
> 2 files changed, 36 insertions(+), 1 deletion(-)

The patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

