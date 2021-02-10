Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A279316676
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhBJMTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:19:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231671AbhBJMOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612959158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fo185b+KWk8zT3SUUKGeVFpd35TVy7HrhZIt8uxdMU0=;
        b=dTllJmQc5kfX0b4uf8MeyCdNs00B0+63FDox50ON0vH2KozQoOUZ3C9tM+SIVru+Vdh38N
        wfjt/U3B2x4kZtEqW4uS+Kq9QIMA7nNhee6T5TxkNxdjaNI1Z5piko99Qd91x10+TCiqLs
        6kYUNHW6Y1/HRQAzA8z73H9JkZHci7o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-BVEb-Rs5O5CTiisOPPTC6g-1; Wed, 10 Feb 2021 07:12:36 -0500
X-MC-Unique: BVEb-Rs5O5CTiisOPPTC6g-1
Received: by mail-wr1-f69.google.com with SMTP id x12so1627870wrw.21
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fo185b+KWk8zT3SUUKGeVFpd35TVy7HrhZIt8uxdMU0=;
        b=JPAputaQoGuL/d0l8K2K1Czao8NYbGXN8NTg70Ad2JDdhyeIjzRDy2u+DA4XsqwIvh
         h0yAE1WYjFa9TqcnrpVTvCZFiw8Zuf21SDPJVJxd4vO6Kh1dSYV3bP2gC1PWVaIR8Zv8
         BXv2ms9ykwoO/bz0O26E2nnlHkxn++5JxaTRLBcJjesASL4Oq+5/a1qy51mtSA55Gp4x
         P12XDsA4TKuWA6kgEO7zv8gM1k4HgCo/T04RXWat5J/AltI8ssGOxMfPbAqMKqQx7gvq
         ZUxkVIXmTYbn426i4XzrxHoH/fzEc+46rgJQJl2t2hHvF7U2T41t2zOiKlNmsGZefCa4
         Dxrw==
X-Gm-Message-State: AOAM530ZhDhs9UFCyi4PTdZrSBiG+aTtgVsURa7O6cURGfQbFc23pJvB
        aQnlomiM+AXlsM8PX3ivycZPqJWTBjmANI0gSG0U2ZfGJgihtqZ8QyeVrZ/TjRComhirdeTggz0
        7obofK2c9qneK7hdrd1tgEp7X
X-Received: by 2002:a1c:480a:: with SMTP id v10mr2730115wma.132.1612959155134;
        Wed, 10 Feb 2021 04:12:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqJ1zRXwLt0V7vMoyUlpyzWYnYnT3tXF+r0Hdj1LTI3bX10t05o4NRDt3JSbViSeLbfsdcxQ==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr2730098wma.132.1612959154945;
        Wed, 10 Feb 2021 04:12:34 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id w4sm2695060wrt.69.2021.02.10.04.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 04:12:34 -0800 (PST)
Date:   Wed, 10 Feb 2021 07:12:31 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        Parav Pandit <parav@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
Message-ID: <20210210071129-mutt-send-email-mst@kernel.org>
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210209054302.GA210455@mtl-vdi-166.wap.labs.mlnx>
 <20210209090014.xolf5kxri3xdmacz@steredhat>
 <cdd75885-3610-8685-14f3-5467a8ef1501@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdd75885-3610-8685-14f3-5467a8ef1501@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:17:19PM +0800, Jason Wang wrote:
> 
> On 2021/2/9 下午5:00, Stefano Garzarella wrote:
> > On Tue, Feb 09, 2021 at 07:43:02AM +0200, Eli Cohen wrote:
> > > On Mon, Feb 08, 2021 at 05:17:41PM +0100, Stefano Garzarella wrote:
> > > > It's legal to have 'offset + len' equal to
> > > > sizeof(struct virtio_net_config), since 'ndev->config' is a
> > > > 'struct virtio_net_config', so we can safely copy its content under
> > > > this condition.
> > > > 
> > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported
> > > > mlx5 devices")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > 
> > > Acked-by: Eli Cohen <elic@nvidia.com>
> > > 
> > > BTW, same error in vdpa_sim you may want to fix.
> > > 
> > 
> > Commit 65b709586e22 ("vdpa_sim: add get_config callback in
> > vdpasim_dev_attr") unintentionally solved it.
> > 
> > Since it's a simulator, maybe we can avoid solving it in the stable
> > branches. Or does it matter?
> 
> 
> I think not, since the module depends on RUNTIME_TESTING_MENU.
> 
> Thanks
> 

Well people use the simulator for development...
I'm not going to block this patch on it, but if someone
has the cycles to post a stable branch patch, that would be
great.


> 
> 
> > 
> > Thanks,
> > Stefano

