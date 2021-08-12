Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F263E9DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 06:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhHLEuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 00:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233944AbhHLEuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 00:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628743812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3EdCh8jUcOhbmGjP/pel54QwoWirthHm42Spak8Fu+8=;
        b=ZTHtbCvVYWnkFBGemqlbGPe5/NlVvVyIVRrj1ZIpMRX0p7Nfpnu8gt8rgQx8fvDmB4rQNU
        YDaM94UFCwLSmIL1V/6u4HUx8fpxaniyr0cJOPXH0rlUOSClcfotjkTU73Mf2EN0wrsuvC
        XoTOwMERDi1uXdyq8E8gGxBxPHKJaX8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-W_zeSyDOPxW-7jRJytkhyw-1; Thu, 12 Aug 2021 00:50:09 -0400
X-MC-Unique: W_zeSyDOPxW-7jRJytkhyw-1
Received: by mail-ed1-f70.google.com with SMTP id eg56-20020a05640228b8b02903be79801f9aso2373798edb.21
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 21:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3EdCh8jUcOhbmGjP/pel54QwoWirthHm42Spak8Fu+8=;
        b=JJ1nogojOKj97u10V1HANP6jeGBMky0DrqznGLympNY7/QuCKPQJbSGicxzDnV8OUp
         FwNqwuUai8Q/xbf58yJq+iNn6Q0wBitgzx9fjQWz635i9ONrIKorV+I0wfSc982sQgHu
         ygUayVR5mJTc8b+73yDGZTa4JnBXcnc09aUYle7OsPTJhTwQsdq22+JQjp4JaFFjpNWL
         b1DJean5KO8K0nxlw3W/awWqAkP/wECPekJownKVzgJiPSc7FiiYFMJ/16kHtDQGWNmD
         8rLZXrxSMrCcsosdtIGkS0ylk2HVzoJAcbswAtGh93qkavop/ha2tCmjoiG5WC7FMUDN
         mLAw==
X-Gm-Message-State: AOAM5320N9jHXmB3gsngFERF/jzAMr9OAlWwMue6FpaSF1khqob7718t
        n9s+n7RcvX1i+PqZefiAVOkVAPON8I4HRvHMGOYBtSoZ10eU11amT5LHseTYfoIvOqV7nfvtCom
        R/i+SaqH1jKYK5gOwcUfwDSiC
X-Received: by 2002:a17:906:7209:: with SMTP id m9mr1547131ejk.387.1628743808135;
        Wed, 11 Aug 2021 21:50:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz91E0jQ/THuDZMxVBENUTarq0cDXA5MCRzrG+Zz2hon71s0/8E+SBP/0DQrOIwM4NFPdSj+w==
X-Received: by 2002:a17:906:7209:: with SMTP id m9mr1547120ejk.387.1628743807976;
        Wed, 11 Aug 2021 21:50:07 -0700 (PDT)
Received: from redhat.com ([2.55.129.96])
        by smtp.gmail.com with ESMTPSA id t25sm544780edi.65.2021.08.11.21.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:50:07 -0700 (PDT)
Date:   Thu, 12 Aug 2021 00:50:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ivan@prestigetransportation.com,
        xiangxia.m.yue@gmail.com, willemb@google.com, edumazet@google.com
Subject: Re: [RFC PATCH] virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
Message-ID: <20210812004655-mutt-send-email-mst@kernel.org>
References: <20210811081623.9832-1-jasowang@redhat.com>
 <20210811151754.030a22a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <aa3e2aca-05a9-aed7-59ec-eb4bd32d8f76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa3e2aca-05a9-aed7-59ec-eb4bd32d8f76@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 11:23:04AM +0800, Jason Wang wrote:
> 
> 在 2021/8/12 上午6:17, Jakub Kicinski 写道:
> > On Wed, 11 Aug 2021 16:16:23 +0800 Jason Wang wrote:
> > > Try to fix this by using NETIF_F_GRO_HW instead so we're not
> > > guaranteed to be re-segmented as original.
> > This sentence may need rephrasing.
> 
> 
> Right, actually, I meant:
> 
> 
> Try to fix this by using NETIF_F_GRO_HW instead. But we're not sure the
> packet could be re-segmented to the exact original packet stream. Since it's
> really depends on the bakcend implementation.
> 
> 
> > 
> > > Or we may want a new netdev
> > > feature like RX_GSO since the guest offloads for virtio-net is
> > > actually to receive GSO packet.
> > > 
> > > Or we can try not advertise LRO is control guest offloads is not
> > > enabled. This solves the warning but will still slow down the traffic.
> > IMO gro-hw fits pretty well, patch looks good.
> 
> 
> If the re-segmentation is not a issue. I will post a formal patch.
> 
> Thanks


It is but the point is even though spec did not require this
we always allowed these configurations
in the past so hopefully most of them are not broken and combine
packets in the same way as GRO. Let's not break them all
in an attempt to catch bad configs, and meanwhile amend
the spec to recommend doing GW GRO.

> 
> > 

