Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B70B322B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 14:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhBWNEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 08:04:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232760AbhBWNCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 08:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614085273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7olXrBgcNfrl7Xfap2MQ05IvCMZZ7nmfJl2qzSQ1mTM=;
        b=Uycqcv2BgeDhPYb8LN/Ff92nRgEq8CgOjDvcQf7ar2hu8Hzpy9+aBbDINjhr+WhMwDTD9s
        jKnUWb/LE+dmnA6MHqYiyZlVJm46lsgJrskT9N0QKwrU58VutT6MDmrJM/x8qMr8ojis48
        9h83VAjThx6lqMZTR+wBacVQyqq/uZc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-BdjN-bqnNhOXgoWZQ7rX8Q-1; Tue, 23 Feb 2021 08:01:11 -0500
X-MC-Unique: BdjN-bqnNhOXgoWZQ7rX8Q-1
Received: by mail-wm1-f70.google.com with SMTP id s192so1158026wme.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 05:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7olXrBgcNfrl7Xfap2MQ05IvCMZZ7nmfJl2qzSQ1mTM=;
        b=IVePE+mX6aHU2yLmnGcYjlyHsqjQ2pF9dv3MWV3p6eDWw56emdBiAnt7/wOkm2Q/Bf
         zjAp/y2WrB+HHVPUetPu6rR2aWwdC3tzlgJGdcEbTkqrG9xoO2w52qSgMPwqd8TsoT96
         UCHgLAI/4CDQZIscMLqMLV8pY/fsFX5eXcnm9N/TgeDnIxbOlYc+siOmltI8sRa1hBuB
         9BciMus3TmkimnlwKor2kvWXn07RzDmlUnoPLx+7fv9v+UAykBw71/5DR7RPSqYKjL6P
         ZCNmsdcBq5u7f4pf9Yr8xTq0Id5gW3C4K1n/6dKXw9ukK80Smasxzo8MucOp7GdVHqtL
         4vfA==
X-Gm-Message-State: AOAM533g5mW49pC41a/qhKTZdGQ/XXwaPLalRsxUwVToBh0Jt9vUuiT8
        2K610DKLyca9kaOrnRZx2p3qj6q6+4L/SJJTJgn3lf9QttgxFrjpQ4knn4rybAMwoolYHe6AjZN
        APJU9ZE/+qUmKOTTryErgcw3W
X-Received: by 2002:a05:600c:1990:: with SMTP id t16mr21113987wmq.27.1614085270447;
        Tue, 23 Feb 2021 05:01:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgb/3q4OEcpSFHwNO4qrmyR4vFsVyf8uD9qB4e3ysKpUTQL04Mc86X1QmiWVqCMVLRx0QpsQ==
X-Received: by 2002:a05:600c:1990:: with SMTP id t16mr21113972wmq.27.1614085270326;
        Tue, 23 Feb 2021 05:01:10 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id n66sm2532052wmn.25.2021.02.23.05.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 05:01:09 -0800 (PST)
Date:   Tue, 23 Feb 2021 08:01:07 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, si-wei.liu@oracle.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v2] vdpa/mlx5: Enable user to add/delete vdpa device
Message-ID: <20210223080038-mutt-send-email-mst@kernel.org>
References: <20210218074157.43220-1-elic@nvidia.com>
 <20210223072847-mutt-send-email-mst@kernel.org>
 <20210223123304.GA170700@mtl-vdi-166.wap.labs.mlnx>
 <20210223075211-mutt-send-email-mst@kernel.org>
 <20210223125442.GA171540@mtl-vdi-166.wap.labs.mlnx>
 <20210223075508-mutt-send-email-mst@kernel.org>
 <20210223125949.GA171769@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223125949.GA171769@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 02:59:49PM +0200, Eli Cohen wrote:
> On Tue, Feb 23, 2021 at 07:56:16AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Feb 23, 2021 at 02:54:42PM +0200, Eli Cohen wrote:
> > > On Tue, Feb 23, 2021 at 07:52:34AM -0500, Michael S. Tsirkin wrote:
> > > > 
> > > > I think I have them in the linux next branch, no?
> > > > 
> > > 
> > > You do.
> > 
> > I guest there's a conflict with some other patch in that tree then.
> > Can you rebase please?
> > 
> 
> Parav, will send later today.

Sorry, no need to resend Parav's patches in linux-next.
Just this one ...

> > -- 
> > MST
> > 

