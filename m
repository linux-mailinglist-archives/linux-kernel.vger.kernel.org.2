Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6E94224E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbhJELY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:24:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233842AbhJELYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633432950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wE1bUrVOz4BYaLjUtGwWBCk3EXj9S4WYQ1RY/Lu9Ah8=;
        b=PC1OTrPDU6IhPOsUsRuwgeHkNIMUAIZC+8NwbOCX2sMs/Isf6rqEDi4eMrcDk+9nrPAo1n
        6tXKFk6LEAKkw0EyG0HnjFNBl04lDWDTSNtK70QyQC8LrJyeNdtBjP98z3uOV6bkB9kLwk
        owcj8aIZQ4tj9GD37tJZEHRw+uXxlzo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-4VVrDbRAN52RfFFChFj6UQ-1; Tue, 05 Oct 2021 07:22:29 -0400
X-MC-Unique: 4VVrDbRAN52RfFFChFj6UQ-1
Received: by mail-wm1-f71.google.com with SMTP id s10-20020a1cf20a000000b0030d66991388so1165621wmc.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 04:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wE1bUrVOz4BYaLjUtGwWBCk3EXj9S4WYQ1RY/Lu9Ah8=;
        b=H8qW8VWNjUcq27cH7eNLwA+ZliB8Ax5MIXbBVEXuroCRLjgWsi11KUsVRcvgR/XOa8
         8PqTUoiWYi/lO8XuYA8IBLn/YZfw384UDPfpCAcqhLZUvQu7usHR2BlzI19r7NROT1tn
         Lj6jBIuTLvNe5iOscuQIOsLViraRgqsQ4jgyZUFLI01Z9BxT7nACff++1GhfFXywdize
         KrpnkZEsUtW268aJJTEyZFlDgJhgYyjA+miHK5e9m53HsabG6kwalBopdEgcUq5Tv5El
         HMEYWFEtH0x1dp6jmnXg0ltaOuMq+WVVmdBgZYt8iuVrRpd2emr/epD6VO1wsYcwPD6U
         ZYnQ==
X-Gm-Message-State: AOAM530cbyyBk+PNqY9xVpZY67UFSp9E+62dquWXPig6wRJwQxgQrGNH
        RQOiDHmpKbCAtXUyddN4OsQTgFh/lZEiVBHx/7bB3YPMbul7HxEHHN+OxHqasmdKusIVE6F5Qmx
        BiZQoADOpMlFbgwUpkOowRiWe
X-Received: by 2002:a1c:f713:: with SMTP id v19mr2708859wmh.188.1633432948050;
        Tue, 05 Oct 2021 04:22:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaxSCZ8C9PBcz9/fRUGZM1W9zwisk/Hu/CflYvR2sGCyXuW4+G9Kdy4Fx2/9/mPdA14qVC6A==
X-Received: by 2002:a1c:f713:: with SMTP id v19mr2708838wmh.188.1633432947907;
        Tue, 05 Oct 2021 04:22:27 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
        by smtp.gmail.com with ESMTPSA id u5sm18156337wrg.57.2021.10.05.04.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 04:22:27 -0700 (PDT)
Date:   Tue, 5 Oct 2021 07:22:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/1] virtio: write back features
 before verify
Message-ID: <20211005072110-mutt-send-email-mst@kernel.org>
References: <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
 <20211003032253-mutt-send-email-mst@kernel.org>
 <87ee912e45.fsf@redhat.com>
 <20211004083455-mutt-send-email-mst@kernel.org>
 <878rz83lx0.fsf@redhat.com>
 <20211004110152-mutt-send-email-mst@kernel.org>
 <87zgro23r1.fsf@redhat.com>
 <20211004160005-mutt-send-email-mst@kernel.org>
 <20211005131751.53175b10.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005131751.53175b10.pasic@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 01:17:51PM +0200, Halil Pasic wrote:
> On Mon, 4 Oct 2021 16:01:12 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > 
> > > Ok, so what about something like
> > > 
> > > "If FEATURES_OK is not set, the driver MAY change the set of features it
> > > accepts."
> > > 
> > > in the device initialization section?  
> > 
> > Maybe "as long as". However Halil implied that some features are not
> > turned off properly if that happens. Halil could you pls provide
> > some examples?
> 
> 
> 
> static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
> {
> ...
>     if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
>         qapi_event_send_failover_negotiated(n->netclient_name);
>         qatomic_set(&n->failover_primary_hidden, false);
>         failover_add_primary(n, &err);
>         if (err) {
>             warn_report_err(err);
>         }
>     }
> }
> 
> This is probably the only one in QEMU. Back then I stopped looking
> after the first hit.
> 
> Regards,
> Halil

Hmm ok more failover issues :(
This stuff really should be moved to set_status.

-- 
MST

