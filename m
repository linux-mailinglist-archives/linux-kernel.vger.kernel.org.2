Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3E240241A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 09:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242557AbhIGHWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 03:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242279AbhIGHV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 03:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630999249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s4Ly7fIbQ4JKQE44G4Zaruzx7ULS/iZdWe5zbP0bV4I=;
        b=edKusAHD1kMbBzuAII0yENeX3/NhnkVYyWVhlE7vjib1Cng+7Wz3fPGPRiTBc7O673L0OX
        Hw7zFKrKfhlYbaOQiCXHwpMRsvEIcyAgYCYahhCLd0kErqz5hdNvUd+qIFqiIEpa31sW1T
        iqlHhBDeKHx1PwQ1o16O8GaivfnBIIM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-LiL2dblcOG-gjuwDyDPqxg-1; Tue, 07 Sep 2021 03:20:48 -0400
X-MC-Unique: LiL2dblcOG-gjuwDyDPqxg-1
Received: by mail-ed1-f69.google.com with SMTP id o11-20020a056402038b00b003c9e6fd522bso4642705edv.19
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 00:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s4Ly7fIbQ4JKQE44G4Zaruzx7ULS/iZdWe5zbP0bV4I=;
        b=FoojUgn0uXDCQDCeDBkwIenTs3an+sc9e85CX1WHU9CJGcvbjuD20HcEMJWSsYiuOr
         iLmNlVYMZb8mVY01QDhvJqrlaMZux0EcgPS2KuQqPocXYRTrysyEFZKB+oWdjKQKhaIh
         /JoezJa/0u15ObdTM9p17Ox/kFXcSFWpd95dsKD0UzDbX0/Y0zAa55JcRh48HnOc5Op+
         oSx4Xmv+ze54Jqtc4aB4Ib5fmRgl3i5bx+V0tdTGVhDAK11VgJQn8noLH7p5xJTq8D11
         IScl5EXW+/EddDkMVa7+ZqCUCDjm2L+V6Iy2hh+qQwlKWl94YhtQUkrttwbDtoUZqYxi
         ALUA==
X-Gm-Message-State: AOAM5307zQAJRCGTWdMeQm3PGK/GYNERm5dKoxU34TKtwZz2UQz9JM6k
        VuQUu2ZrYUV4EW5xgLvGbrACmNgxTki9Zrc+7liNAwiP7uUn0HDTi5Ot2UG1YJJU/QN1kIzwWC7
        PbOtaLYKvyiUnPlCIbwl+lm6R
X-Received: by 2002:a17:906:8684:: with SMTP id g4mr17008907ejx.262.1630999246766;
        Tue, 07 Sep 2021 00:20:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycsKk7/2k3FGDdBfsw54D5sdZdgF9d1aZBwueZVYMOIqt9Oei7oj8hYc05kHLYdWZZo5FKfg==
X-Received: by 2002:a17:906:8684:: with SMTP id g4mr17008891ejx.262.1630999246637;
        Tue, 07 Sep 2021 00:20:46 -0700 (PDT)
Received: from steredhat (host-79-51-2-59.retail.telecomitalia.it. [79.51.2.59])
        by smtp.gmail.com with ESMTPSA id n13sm5828597edq.91.2021.09.07.00.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 00:20:46 -0700 (PDT)
Date:   Tue, 7 Sep 2021 09:20:43 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add VM SOCKETS (AF_VSOCK) entry
Message-ID: <20210907072043.zaxobbj5gvj2qm3w@steredhat>
References: <20210906091159.66181-1-sgarzare@redhat.com>
 <52DB430E-AD5D-45A5-BF72-C103B2BD2511@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52DB430E-AD5D-45A5-BF72-C103B2BD2511@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 02:50:59PM +0000, Jorgen Hansen wrote:
>
>
>> On 6 Sep 2021, at 11:11, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> Add a new entry for VM Sockets (AF_VSOCK) that covers vsock core,
>> tests, and headers. Move some general vsock stuff from virtio-vsock
>> entry into this new more general vsock entry.
>>
>> I've been reviewing and contributing for the last few years,
>> so I'm available to help maintain this code.
>>
>> Cc: Dexuan Cui <decui@microsoft.com>
>> Cc: Jorgen Hansen <jhansen@vmware.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>
>> Dexuan, Jorgen, Stefan, would you like to co-maintain or
>> be added as a reviewer?
>
>Hi Stefano,
>
>Please add me as a maintainer as well. I’ll try to help more out.

This is great :-)

Since this patch is already in the net tree, please can you send a 
followup adding yourself as co-maintainer?

Thanks,
Stefano

