Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43D8327497
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 22:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhB1V3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 16:29:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22556 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231162AbhB1V2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 16:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614547649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h8Erxl2uAhVRjyIZZpSw14ya09f39S8gw2UbjCw0S0w=;
        b=L5ehP8Y9cQhmOOx6QiQSSQGB+tZK+dGanqKHRw7koB1oe7YYcGKTi7pjwkXLifdATlvB22
        VSO0edHkoaA4RTSNv3YgSDYHChv7orqnWee9dy8ct3l/wPNhfOnN59RWlKSacNkYMpo0pP
        qop+Sbw3+b7ia0tdYU4Fm7gs7PvElv0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-aGl15P7xO3W-6TVCJo7YVQ-1; Sun, 28 Feb 2021 16:27:27 -0500
X-MC-Unique: aGl15P7xO3W-6TVCJo7YVQ-1
Received: by mail-ej1-f72.google.com with SMTP id ml13so5639046ejb.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 13:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h8Erxl2uAhVRjyIZZpSw14ya09f39S8gw2UbjCw0S0w=;
        b=j3nm08YHmiDyG8oPZb8TxDqGWgti9KvocZe9BsWaRh8On0b0OrTG/nIKuhNo9WSrco
         XEk+XWRoBJINywpL+2lY5L6KNeh1GeYOhZEYn2zq5YNydP6ZFc3TPbqhUmnrNJRguceg
         sHysDPIpoZGr7XtqHJpiGTEvP0GZgUkZrx/KPPj11Yqouzy0zxAtmnUd98IxUnN8GZiV
         /dwzBZJNAJ/ipapRX/pYHh3rEyZWf130GBRI3F2+QvRs35l8Uf3zsAIYAmfnC+b97nGA
         3tDn7PZPNxPneyQFE0i8mU55dLfEO9m+/p7QhqL0cq4o/hatQDLRpUU3jq6r18bIU9/U
         Nraw==
X-Gm-Message-State: AOAM530U07fYRJ+WvgtMdka9OrHyzwrecrA9WdaJc7qfbc69LK9Ls0Oo
        Dbyl97ysh7SBP2Z9yP3Ar6Kuv8vFSJg1Q6zBYaZxS8+cO9Ep9Mcwa9YDW0kg0/OSCfeAcA/ge+C
        +BXmK+SgzUnbAltKhc6SJke9M
X-Received: by 2002:a05:6402:50c8:: with SMTP id h8mr13170595edb.360.1614547646399;
        Sun, 28 Feb 2021 13:27:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQ6jCc9+dU7zV1WxCqoV1CE3zGmJfGpzvUi/N9qj2WdyBA/tM4wl7SoqLgRgWmy6Sdh81JZQ==
X-Received: by 2002:a05:6402:50c8:: with SMTP id h8mr13170588edb.360.1614547646299;
        Sun, 28 Feb 2021 13:27:26 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id cq20sm12388210edb.18.2021.02.28.13.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 13:27:25 -0800 (PST)
Date:   Sun, 28 Feb 2021 16:27:23 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     Jason Wang <jasowang@redhat.com>, elic@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210228162604-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <3e833db8-e132-0b00-34d0-7559bab10123@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e833db8-e132-0b00-34d0-7559bab10123@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 04:56:42PM -0800, Si-Wei Liu wrote:
> 
> Hi Michael,
> 
> Are you okay to live without this ioctl for now? I think QEMU is the one
> that needs to be fixed and will have to be made legacy guest aware. I think
> the kernel can just honor the feature negotiation result done by QEMU and do
> as what's told to.Will you agree?
> 
> If it's fine, I would proceed to reverting commit fe36cbe067 and related
> code in question from the kernel.
> 
> Thanks,
> -Siwei


Not really, I don't see why that's a good idea.  fe36cbe067 is the code
checking MTU before FEATURES_OK. Spec explicitly allows that.

-- 
MST

