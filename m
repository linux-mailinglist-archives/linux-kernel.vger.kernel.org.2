Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0893348A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 21:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhCJUGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:06:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232089AbhCJUGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615406773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZqOerku4ka3IhMUBjG/XTRlN6lYxBxQ2MLf7EPvQE8=;
        b=YsVScwomaOWWykcBchGPe3qU1/WmuiEM6y25aPuNOYYhURbOAWgconkgYwyFDpvKAU00qR
        dRQV9YUN+Z4ETpWFqTrMNEu2hu/HBIKkMHZFAdzU9mnKYg8ed2mIpQ5I9uSDs9zzlUFKxu
        s/oW1AjgKbt5a/q+q9eKjE05BYm6LAk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-3bzfaoFoN6qBV-X5jo3hhA-1; Wed, 10 Mar 2021 15:06:09 -0500
X-MC-Unique: 3bzfaoFoN6qBV-X5jo3hhA-1
Received: by mail-qk1-f198.google.com with SMTP id x11so10469830qki.22
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MZqOerku4ka3IhMUBjG/XTRlN6lYxBxQ2MLf7EPvQE8=;
        b=UzXgzP2y1tbMo6lu3NhOHHztiaSyQhUMaeLqcw7nHNXrEwFeWG5zpG2bstYjg20j8F
         hy6tgtay9L1X8Obcogcmxc1G4iYITxaBX/XXvvUkh3yNHmwM9/FX3564XccdA5sWfcM5
         CLi9XadBUQGB59QFq3uuOPTUtRCXc4Wk0wdbNmvtlboNjMUjsuc9fVuclCJ/tQQS8D5i
         UF+5MXbtShRXY6h7NTk8rgPO+MUYSX7zgSfsZcQyScWEMk8WbplwcLioJvFEb7LIxQBX
         G678ZyFNUZGEGF0ODHb+K7hjcNh5rPV5O9R7nFGYUXKc9uBIbIavLYZMoj9cGqLhcW0e
         NHeA==
X-Gm-Message-State: AOAM531bEPV7VtKVSTFBL8Ep+joDNnJUFt+X3wDSsHQhqAx7lvZgLQ3o
        xcVFSrt7wcoBEVcczgulQUwRDkV2eeEcFSiLKFtO0Mo2S0Pz1oaoMgFTqngIO4dmwhKKW84iDnR
        tik8Boj0vl8xVT9OgXqtueSeE
X-Received: by 2002:aed:3741:: with SMTP id i59mr2410753qtb.303.1615406769019;
        Wed, 10 Mar 2021 12:06:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzT3IYnqEF4ggAfCl202qrDbK8JrUuXkacUIxpIN6UHTxsbOnQgsrU2TqIx7iJ6zbkiigwpgA==
X-Received: by 2002:aed:3741:: with SMTP id i59mr2410742qtb.303.1615406768814;
        Wed, 10 Mar 2021 12:06:08 -0800 (PST)
Received: from xz-x1 ([142.126.89.138])
        by smtp.gmail.com with ESMTPSA id 131sm284373qkl.74.2021.03.10.12.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 12:06:08 -0800 (PST)
Date:   Wed, 10 Mar 2021 15:06:07 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, prime.zeng@hisilicon.com,
        cohuck@redhat.com
Subject: Re: [PATCH] vfio/pci: Handle concurrent vma faults
Message-ID: <20210310200607.GG6530@xz-x1>
References: <161539852724.8302.17137130175894127401.stgit@gimli.home>
 <20210310181446.GZ2356281@nvidia.com>
 <20210310113406.6f029fcf@omen.home.shazbot.org>
 <20210310184011.GA2356281@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210310184011.GA2356281@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 02:40:11PM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 10, 2021 at 11:34:06AM -0700, Alex Williamson wrote:
> 
> > > I think after the address_space changes this should try to stick with
> > > a normal io_rmap_pfn_range() done outside the fault handler.
> > 
> > I assume you're suggesting calling io_remap_pfn_range() when device
> > memory is enabled,
> 
> Yes, I think I saw Peter thinking along these lines too
> 
> Then fault just always causes SIGBUS if it gets called

Indeed that looks better than looping in the fault().

But I don't know whether it'll be easy to move io_remap_pfn_range() to device
memory enablement.  If it's a two-step thing, we can fix the BUG_ON and vma
duplication issue first, then the full rework can be done in the bigger series
as what be chosen as the last approach.

Thanks,

-- 
Peter Xu

