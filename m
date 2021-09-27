Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3A741924B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbhI0KiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:38:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233784AbhI0KiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632739002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hPcoSfISBwgrMcGuhcb0aAcLEaKSf2xroV1zxbFfhaI=;
        b=GuDK0DSMuXeGhejlG4rF0BKgXazo5dZmJfnjO6M+x42Sa9xuqDAeee+XP7XEIqsNhDeYUy
        2+OyBzRrP7wfSfPif5CdCOozsXHYrFAY1cc3u/ktX11BlcstiV7TFp31OkWUVP3fGSggBg
        33UZpPSsSK+P9bte3lAglD7nyzmOb7U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-YgjS9GgkM1KF3SteQtz_LQ-1; Mon, 27 Sep 2021 06:36:40 -0400
X-MC-Unique: YgjS9GgkM1KF3SteQtz_LQ-1
Received: by mail-wr1-f69.google.com with SMTP id m1-20020a056000180100b0015e1ec30ac3so13915632wrh.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hPcoSfISBwgrMcGuhcb0aAcLEaKSf2xroV1zxbFfhaI=;
        b=zaGQAy3ndMnfurNCdNkm4cQ8hRm/b1S3KNIrTCOH9DbSy8wiBW+GsRt+SdSpn2Q3QJ
         JvdI8vKE029KzhxM5G/mCh6iWnYI3bayLbhiILJl5EVOEeO1h3ry2PUmnBaCJVelraVd
         Kgz8UKhzTUUTukrC5V6dBx/g2WYIGFX0EQF2MQkGO2RGF57YFQ8QCVunpZVcd4FmUmTn
         fhT2tRKx8NOLq/b2IUmc5PURc5K+fRFn36v8NqMaI8DyRBCnlGsFfBBj9Fb9T+90MiYV
         +DBIqnNWamCyZ//f4xtzkT/EIIjBq8yPxdVZPQo/HHHOCW1Go94dlNBQ6Zsfanm2Ynn3
         CPdg==
X-Gm-Message-State: AOAM533Qtl7Fhln1GIm/k8C3CCssn0f4SirSOW6UJ3OYXHdaMauW+nBL
        Jig25eZxKqjn6SC5ohSecQ70FNgkficB1oxGfDPvOCkJONUNkODjd+PZdP8INQkZH/fB72MtSAM
        i9AXAVzj6vgard2v/MZNr4nCQ
X-Received: by 2002:a5d:4eca:: with SMTP id s10mr27305635wrv.255.1632738999484;
        Mon, 27 Sep 2021 03:36:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZIvmWUAOTtPoqPTquH6vQYxZL6UjiYrw4VN8L1y6fYbJCmFAWd/xqPQ26IOsO48cQQ6fDrA==
X-Received: by 2002:a5d:4eca:: with SMTP id s10mr27305617wrv.255.1632738999277;
        Mon, 27 Sep 2021 03:36:39 -0700 (PDT)
Received: from redhat.com ([2.55.16.138])
        by smtp.gmail.com with ESMTPSA id r9sm16003737wru.2.2021.09.27.03.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 03:36:38 -0700 (PDT)
Date:   Mon, 27 Sep 2021 06:36:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wei.yang1@linux.alibaba.com
Subject: Re: [PATCH v3 7/7] eni_vdpa: add vDPA driver for Alibaba ENI
Message-ID: <20210927063000-mutt-send-email-mst@kernel.org>
References: <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <cover.1632313398.git.wuzongyong@linux.alibaba.com>
 <296014fa3b765f2088a3183bf04e09863651a584.1632313398.git.wuzongyong@linux.alibaba.com>
 <CACGkMEt5rQv8DFdsYuJ6SF2YOsh_3YP_yzSsdL3X_n3Mfz3Gag@mail.gmail.com>
 <20210926032434.GA32570@L-PF27918B-1352.localdomain>
 <CACGkMEtrGtbzNrf96uz9zwZ7ohNg1-dUoMLfL4HWoZwv8Zejdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtrGtbzNrf96uz9zwZ7ohNg1-dUoMLfL4HWoZwv8Zejdw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 12:18:26PM +0800, Jason Wang wrote:
> > > I wonder if the following can work with ENI:
> > >
> > > -device virtio-net-pci,mrg_rxbuf=off
> > >
> > > ?
> >
> > ENI didn't work.
> > I will remove F_MRG_RXBUF when get_features.
> 
> I think we need to fail FEATURE_OK if F_MRG_RXBUF is not negotiated.
> Since VERSION_1 requires a fixed header length even if F_MRG_RXBUF is
> not negotiated.
> 
> But this trick doesn't come for free. If some driver doesn't support
> mrg_rxbuf, it won't work.
> 
> Thanks

Yea. Ugh. Down the road I think we'll add legacy support to vdpa on
strongly ordered systems.  Doing it in userspace is just too messy imho.
But yes, this kind of hack is probably ok for weakly ordered systems.
BTW we need to set VIRTIO_F_ORDER_PLATFORM, right?

-- 
MST

