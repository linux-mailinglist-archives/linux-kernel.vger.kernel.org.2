Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A1E37F9FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbhEMOt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:49:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234647AbhEMOsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620917218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rGg3l/7n8SNDT+a7ouZ0AJr+1X0/uEbg6PfCHzDeJoQ=;
        b=bN9ZqnZLXJtuYP3TFSOTkRfvH+oMvBiuP4maIYH9tU7r+/NZ814RlfC74cc5g/YEEWzjtL
        E9QTXkd0BBXb0cERXoPSZNGjrlsu4lr0MXUAW0SuGqTX/ZZrOGdrUGi2HyIfgzCyKCcl8P
        2WetjCbfkoFkV5E4iRaluDJD5CilwA4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-rBvo7eCCM6q7op7_aS0nVg-1; Thu, 13 May 2021 10:46:57 -0400
X-MC-Unique: rBvo7eCCM6q7op7_aS0nVg-1
Received: by mail-ed1-f72.google.com with SMTP id h16-20020a0564020950b029038cbdae8cbaso3286346edz.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 07:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rGg3l/7n8SNDT+a7ouZ0AJr+1X0/uEbg6PfCHzDeJoQ=;
        b=S9YAhcnvCVnqPiaO7w2xL70z9vnzJkO8F6wWsRaedsClL1en5UPqi3bY+hsQmoyX9X
         NGpPM45fZflMsSeN/g45EPiCl39kBu0DU7SAlpkj116LmmqloWqqvMQjQDZm0FtTim5n
         F0J6aBxRrk+kAypGo1FxqMc5Ynb+5I5fO+/gPl7EY7Lih/OpVTai2ct6jWTEV3le3MI7
         P9m8kjh/ZvsdfAyGVmt/jj07cgigEub8cWvnKoiUlEMqyd+q9qCs2G7HkRjaeaa5oWp8
         HyeW3rAEoS5a7o3w3jen08VfTONVJeBuWP9Td/Wb1bRpJ3wCVeB7XNSkGWT0K2xPaSXU
         dASg==
X-Gm-Message-State: AOAM533G9eFf4KSaBO5mTjnRpYflTmNhVG/CqdYRxNiuvfoOsXnX1W9r
        /nYbboqgUBuCWc6sxBTi8GqGIUzFGAl0xDHkUnnuWaGHu3wJxg1zD4VWhct8L7h1D6taKVwhC/p
        vq27n0AckULSwroo77H9Jx+S1
X-Received: by 2002:a17:907:3e28:: with SMTP id hp40mr21283563ejc.523.1620917216241;
        Thu, 13 May 2021 07:46:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzSceLI37ohYl3OTJmHxOffRDbF3BNal57WXUnEN0Xk+EFEMUtvnnXnlAzBST0LnZ+IGqHEw==
X-Received: by 2002:a17:907:3e28:: with SMTP id hp40mr21283545ejc.523.1620917216075;
        Thu, 13 May 2021 07:46:56 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id i8sm2536335edu.64.2021.05.13.07.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 07:46:55 -0700 (PDT)
Date:   Thu, 13 May 2021 16:46:53 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Andra Paraschiv <andraprs@amazon.com>,
        Colin Ian King <colin.king@canonical.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v9 19/19] af_vsock: serialize writes to shared socket
Message-ID: <20210513144653.ogzfvypqpjsz2iga@steredhat>
References: <20210508163027.3430238-1-arseny.krasnov@kaspersky.com>
 <20210508163738.3432975-1-arseny.krasnov@kaspersky.com>
 <20210513140150.ugw6foy742fxan4w@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210513140150.ugw6foy742fxan4w@steredhat>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 04:01:50PM +0200, Stefano Garzarella wrote:
>On Sat, May 08, 2021 at 07:37:35PM +0300, Arseny Krasnov wrote:
>>This add logic, that serializes write access to single socket
>>by multiple threads. It is implemented be adding field with TID
>>of current writer. When writer tries to send something, it checks
>>that field is -1(free), else it sleep in the same way as waiting
>>for free space at peers' side.
>>
>>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>---
>>include/net/af_vsock.h   |  1 +
>>net/vmw_vsock/af_vsock.c | 10 +++++++++-
>>2 files changed, 10 insertions(+), 1 deletion(-)
>
>I think you forgot to move this patch at the beginning of the series.
>It's important because in this way we can backport to stable branches 
>easily.
>
>About the implementation, can't we just add a mutex that we hold until 
>we have sent all the payload?

Re-thinking, I guess we can't because we have the timeout to deal 
with...

>
>I need to check other implementations like TCP.
>

Thanks,
Stefano

