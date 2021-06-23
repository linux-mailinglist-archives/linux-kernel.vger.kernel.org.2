Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EE43B1E60
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 18:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhFWQMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230006AbhFWQMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624464629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rnf1xld2zG7ITor+H4pye+Ce8VDHDjjS7DCz0019lgk=;
        b=TgA0zZZSilkQB93EgKRjTqxyxtuFZH3Jh/Yvxg/jz9AZUDMjohZIMOb2MEazqDUC10uybZ
        4wEukasizkqXN1oVOrsxR4iOPutCRBnRgYil2zyA6dumeBjoRnA3qa9+mEMWRLQJf06+E4
        wUHImbqRNhG8N7Bqv8FTK/kL2qcedfQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-w4c-nmdOOd23sEJBznMW3Q-1; Wed, 23 Jun 2021 12:10:22 -0400
X-MC-Unique: w4c-nmdOOd23sEJBznMW3Q-1
Received: by mail-ed1-f69.google.com with SMTP id v8-20020a0564023488b0290393873961f6so1580741edc.17
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 09:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rnf1xld2zG7ITor+H4pye+Ce8VDHDjjS7DCz0019lgk=;
        b=F7+DDY58J+DuCkPkZxTaUIHP+/W9zZ8lPs1nTjL3zQ9I+Ks9ZzzEtbdSKycENqoswt
         oKQ+gwQS9QK3cydBf9IWUo+Wyxq7oeIhpyS4gi/4kaqQhKLRHuX3egImG5UWxLhqaWZo
         2R73BQxBvg5QyDFyll8Hdf1yfcEZt6zxyvljDvGqc1v/1u1e558yR2b+p1QC4uC3hgAs
         xqiJVgCuRuG2QeejNLGsR2c1bgy3uVOOnwb6bnVDppQ4A20/3DLQjrtUZvgXk+szn1Ux
         1SKYjYerquhHksUOzA2XQy9VdrNy/+NIq3Boa6EkgpRoPiMaphoPb74m8DFK/LYFvbMh
         Zlnw==
X-Gm-Message-State: AOAM532qRFoNLZyhO4mdymFwNSeUWR6ABIbRaWA7BeE0MHsEQXUGcuHn
        348mGeEvc0sjgifyC7rYZS4yBUXvVd93qcRz4OwkuU/KZltst0JAogOCrOcuCFkh/k9+jYrWhTW
        fxXbDRInFkX139i/CLGhCSzZm
X-Received: by 2002:a17:906:5049:: with SMTP id e9mr840282ejk.30.1624464618606;
        Wed, 23 Jun 2021 09:10:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1pKANbb6hP+TU5DFw0ClGZrpYkWFi0a2by+iDKCeEPzurXLgBC+9knH9a6wa4g8T3K5CnSw==
X-Received: by 2002:a17:906:5049:: with SMTP id e9mr840077ejk.30.1624464616406;
        Wed, 23 Jun 2021 09:10:16 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id x21sm260208edv.97.2021.06.23.09.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 09:10:15 -0700 (PDT)
Date:   Wed, 23 Jun 2021 18:10:13 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vringh: Use wiov->used to check for read/write desc order
Message-ID: <20210623161013.qg3azanyxt7nucgl@steredhat>
References: <1624361873-6097-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1624361873-6097-1-git-send-email-neeraju@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 05:07:53PM +0530, Neeraj Upadhyay wrote:
>As iov->used is incremented when descriptors are processed
>in __vringh_iov(), use it to check for incorrect read
>and write descriptor order.
>
>Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>---
> drivers/vhost/vringh.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
>index 4af8fa2..14e2043 100644
>--- a/drivers/vhost/vringh.c
>+++ b/drivers/vhost/vringh.c
>@@ -359,7 +359,7 @@ __vringh_iov(struct vringh *vrh, u16 i,
> 			iov = wiov;
> 		else {
> 			iov = riov;
>-			if (unlikely(wiov && wiov->i)) {
>+			if (unlikely(wiov && wiov->used)) {
> 				vringh_bad("Readable desc %p after writable",
> 					   &descs[i]);
> 				err = -EINVAL;
>-- 
>QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>hosted by The Linux Foundation
>

