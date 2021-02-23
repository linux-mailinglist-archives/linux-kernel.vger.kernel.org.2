Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A684322AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhBWM5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:57:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232488AbhBWM5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614084982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VGX4av4aELQvmxhToSs06FARrEgYr2ky959AcUMe3H4=;
        b=PUhJ/djDhmLh1c9fIwCGuSSd3uWrMIGEM+CBIR0J/KcXBHHIB5foXVpgLESTeurT4ExzIh
        2InF9OyxftJxzI7QhM9PEFKiewvnx54RgDn/+gFEjdCSJY9Gr4WUhgaaG9gVJOC9cPFZkY
        8qJHw+cdUcJIf2bcqArPiIxGL8IxahQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-fJ5lmySpPVe7qgJktSegyw-1; Tue, 23 Feb 2021 07:56:20 -0500
X-MC-Unique: fJ5lmySpPVe7qgJktSegyw-1
Received: by mail-wr1-f69.google.com with SMTP id h30so42818wrh.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 04:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VGX4av4aELQvmxhToSs06FARrEgYr2ky959AcUMe3H4=;
        b=Fd6e849vmcJ7e98H7k5QVxaq3BjL58v4jud3cok+Lh1fheeZnbIo3L0ExdLs4O3uIN
         06gtqwJCNklLBxbxwkaIorUjadUYQeaesIWa+sgjR+462sBnLhyBdzAGUP9genpt3gA4
         BFf1GfY/Cma2CAHi6covp5zM5VAxitMxgJd0NIgJgecQURIeiEqOjHQ8Nm0QhYrOnUQX
         drjqDhy5gOVljUK+UUvFfYgmIfaVa+jGvi4Bd2JnjizB7eoO5NKTH6jVYOplwkCYuB2E
         G0VJD6j6gtrJcvioKXYMNzJTopv1JSAVJ87ifzT685J/gIinvN4rew0qq/OwZtIkMDfH
         fFdQ==
X-Gm-Message-State: AOAM533xp71V+wuR0xJSIaQ0PPelxIZWqN7P8EAx+O6Y27KHNf1QOrW5
        7KOCbqYeVIYHVMgUUqlvhWFWjniExBzlkcoVXxaqUZG/MhLiWkak/2tN8RczbB3yKonni/EDGUJ
        fKmJsuWf4o6mbXDeLFM2NtR5/
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr6795866wrt.370.1614084979570;
        Tue, 23 Feb 2021 04:56:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOkkpVZ/w6Xbi3Y2JFXjcz0IESdg+8qMCw1uDa0yv860hSl1r4oLfkfq1xmTV0zflrBRnYxw==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr6795852wrt.370.1614084979471;
        Tue, 23 Feb 2021 04:56:19 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id z11sm533005wmf.28.2021.02.23.04.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 04:56:19 -0800 (PST)
Date:   Tue, 23 Feb 2021 07:56:16 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, si-wei.liu@oracle.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v2] vdpa/mlx5: Enable user to add/delete vdpa device
Message-ID: <20210223075508-mutt-send-email-mst@kernel.org>
References: <20210218074157.43220-1-elic@nvidia.com>
 <20210223072847-mutt-send-email-mst@kernel.org>
 <20210223123304.GA170700@mtl-vdi-166.wap.labs.mlnx>
 <20210223075211-mutt-send-email-mst@kernel.org>
 <20210223125442.GA171540@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223125442.GA171540@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 02:54:42PM +0200, Eli Cohen wrote:
> On Tue, Feb 23, 2021 at 07:52:34AM -0500, Michael S. Tsirkin wrote:
> > 
> > I think I have them in the linux next branch, no?
> > 
> 
> You do.

I guest there's a conflict with some other patch in that tree then.
Can you rebase please?

-- 
MST

