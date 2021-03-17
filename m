Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F67F33EB74
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhCQI1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229780AbhCQI0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615969591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EwapMQi0nkg7eVnbf33AM5coVysoOM+HGdcBLVsx95o=;
        b=f/QzM11EGVFDOr1Tc43DKvtcbTyLiMlvmeqvzew7008PcXWVR/UYeHiFysFo6yfqmh8Po5
        X8G35CihJ32ATZQFav1VDOoBq+kzzJ4XAunclTIog8PuuGbF4PNAK9GkBP1vGTmx57DLM9
        4mQjlScJEBqzdPge2h1pWlujCOh9TMY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-CPz9IL5wOxyho6KIY7CIXg-1; Wed, 17 Mar 2021 04:26:29 -0400
X-MC-Unique: CPz9IL5wOxyho6KIY7CIXg-1
Received: by mail-ej1-f72.google.com with SMTP id fy8so14831200ejb.19
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EwapMQi0nkg7eVnbf33AM5coVysoOM+HGdcBLVsx95o=;
        b=nhJTriJIBOODGv3COLXlMRfpsIeJUgBSo1vjrwmjVQ/azpLRxbAQlG3CtzimYeSYIE
         hPu1cTJ+OdtZDCmyf81SNv8vv84rHfPtfDBMm/SGUT7Hx3+bdREFwdyhHr/e9OQ5k6yp
         hjXHxbuqcR8lksPHO0DdaXen0mkC5Fb/xjk4qhOuYKX+ly9C1oAKvOya/MW42t490g7c
         zhv4iFmONFerFZmTgfOmUOGFeULUcAx8idkP2a0f2Y9FrKYHGQznOO6oC6WWMB6QWnQ3
         tDf4k90FyheQYw5jZq6AZjIN0pdgJDga97JsK6JmYU0kChyhpvpT/c0yK/XjLfXhpn+Y
         vXVQ==
X-Gm-Message-State: AOAM531+B1B88c4kLzWag9VWjWP+owmnPW0W5XPcKU4trAaZ2sTOd3OD
        aaHLlgGUJgM+1Q+xp8DW0wkCewBg0xYA9U7EAhF8gYeeOSVfbY1HM6U5touqdsDIztfMoptiP7K
        0wCd8JEsByTI4+DL/7MuUQTxp
X-Received: by 2002:a05:6402:34c8:: with SMTP id w8mr42273340edc.235.1615969588489;
        Wed, 17 Mar 2021 01:26:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzs2IfIabALxEDPdD531JeAvmlPd3oXH08kwxGnDTWawZHEErYQNxcoHlVJ8xZAWJMW4AVeug==
X-Received: by 2002:a05:6402:34c8:: with SMTP id w8mr42273327edc.235.1615969588341;
        Wed, 17 Mar 2021 01:26:28 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id r19sm11964199edp.52.2021.03.17.01.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:26:27 -0700 (PDT)
Date:   Wed, 17 Mar 2021 09:26:25 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] vhost: Fix vhost_vq_reset()
Message-ID: <20210317082625.euxknnggg4gv7i5m@steredhat>
References: <20210312140913.788592-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210312140913.788592-1-lvivier@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:09:13PM +0100, Laurent Vivier wrote:
>vhost_reset_is_le() is vhost_init_is_le(), and in the case of
>cross-endian legacy, vhost_init_is_le() depends on vq->user_be.
>
>vq->user_be is set by vhost_disable_cross_endian().
>
>But in vhost_vq_reset(), we have:
>
>    vhost_reset_is_le(vq);
>    vhost_disable_cross_endian(vq);
>
>And so user_be is used before being set.
>
>To fix that, reverse the lines order as there is no other dependency
>between them.
>
>Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>---
> drivers/vhost/vhost.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

