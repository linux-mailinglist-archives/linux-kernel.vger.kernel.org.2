Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0913E23E2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 09:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243585AbhHFHUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 03:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242012AbhHFHUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 03:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628234429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HTm9fbXgLtcZGdGW/3I21kvZ1VGYI5U7k0mhmEpEDg0=;
        b=FSTa0CY5QWVMGSAhJkJC7vjnuHrBQCQfqwkY3HEfrr+B3P9NL1ZZzdAfJtB+3FwPXwV1nx
        2WS96G0N6qoKpi1YBaXeve/LdBjuzFszM7dgnpn9eUQH9IyYQFj5DsxiApY/6bHmjiEmYU
        bWdDXK9GSg1mp+a/TUA8U1aSU2vMsns=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-tDQHwIlcM7Co9dnYzqwu1A-1; Fri, 06 Aug 2021 03:20:28 -0400
X-MC-Unique: tDQHwIlcM7Co9dnYzqwu1A-1
Received: by mail-ed1-f72.google.com with SMTP id u25-20020aa7d8990000b02903bb6a903d90so4438146edq.17
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 00:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HTm9fbXgLtcZGdGW/3I21kvZ1VGYI5U7k0mhmEpEDg0=;
        b=VrBUMCpQ6Qs1EGNYwZbJyEi8H2CVHi8YwV0YIT9VMNppL7j6OzREdaOcYlmfQaxSSm
         tF1mTEhx0YjfnoBkDymDWOTaoXHRmpD7He+QHXUixkiZxVbOPlvbFsJ5ST1tU7t6RM3Y
         zuO549GRGm2N05vXRBAc/PtitvK+CejBu/hx4mhgUfacZa5cZVQbpJ2f5tRznE3ix2T1
         Rl0EPVptY8sRa11wUh/PJBJz0naPtGPQKAL/XhWBX3HQXI3/WPkxJGENVVQJ1tstkE3h
         m90/++6/MVhlBSoh4zKoav7jn1PVhQavj16B6dqPh8po9lbCu3bT5e+VBZZepzh3qxA4
         Nmjw==
X-Gm-Message-State: AOAM532a3UauJbBbG7mQ5RLcyeUUFRIR8xhIU9PsLmwVn9AW1bIYGxx8
        Nmv95pBZCQDOTgaWIl9vK50GvcU2YSLM9UBL6Ab6k0ablYtFqVqqg/5LSHkUY+jjTnTHkJE97So
        UoZHuIf0/bX2w/iVJJluC4jk0
X-Received: by 2002:a05:6402:361:: with SMTP id s1mr11209643edw.172.1628234427596;
        Fri, 06 Aug 2021 00:20:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuVKndM6vRqX10g0DMF+zN0NMme5c3sOtXbrtFonOTm7kn0n+W/NJwkU2ojVAcnd/691RvGg==
X-Received: by 2002:a05:6402:361:: with SMTP id s1mr11209627edw.172.1628234427450;
        Fri, 06 Aug 2021 00:20:27 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id p16sm3396595eds.73.2021.08.06.00.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 00:20:27 -0700 (PDT)
Date:   Fri, 6 Aug 2021 09:20:24 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Colin Ian King <colin.king@canonical.com>,
        Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v1 2/7] vsock: rename implementation from 'record' to
 'message'
Message-ID: <20210806072024.ejp2d5sgfatga6oz@steredhat>
References: <20210726163137.2589102-1-arseny.krasnov@kaspersky.com>
 <20210726163328.2589649-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210726163328.2589649-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 07:33:25PM +0300, Arseny Krasnov wrote:
>As 'record' is not same as 'message', rename current variables,
>comments and defines from 'record' concept to 'message'.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> drivers/vhost/vsock.c                   | 18 +++++++++---------
> net/vmw_vsock/virtio_transport_common.c | 14 +++++++-------
> 2 files changed, 16 insertions(+), 16 deletions(-)


This patch is fine, I think you can move here the renaming of the flag 
too.

Stefano

