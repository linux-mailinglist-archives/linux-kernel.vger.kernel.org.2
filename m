Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C0544E461
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbhKLKM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:12:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234927AbhKLKMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636711774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GpT2YYqG29Jg+Uxsx2CrH+IJrT+DNnW+q/s5xR+/nO8=;
        b=chVFhlOEM41HG0kWG6eKDS1G72jpwZJGtAftfbZNpxxeOmEjE0H84QQ4X1POkl6SfrCGth
        P78XMJRGbmDbZ0HRojHfKOMgx+VbAsZQDp9SSOCbh03igWTQuepyuPl7bsvuE/U5jVXQjS
        +2AKDDz6Byud0DTUP0EheioJPkl2Zrs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-l2QdQiQ1OyaVDBzP6sOEhQ-1; Fri, 12 Nov 2021 05:09:34 -0500
X-MC-Unique: l2QdQiQ1OyaVDBzP6sOEhQ-1
Received: by mail-ed1-f70.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso7785429edj.20
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 02:09:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GpT2YYqG29Jg+Uxsx2CrH+IJrT+DNnW+q/s5xR+/nO8=;
        b=nPayDeUZHABfmL2YsXUHryv4GKQE+fk+n7Q/plNDJP6wWzF1xwphJ4DpvJAZr7HdeH
         SVQpvn7s3zTax8oRe4rnSo+4uwkOIIGyJwppGqckWqD22rDY8Rw5F3GoORyq00rpEPJ4
         G5rczk8TflOzd+Du+xEOqv1lvFgZi1Z4dApnyU7vZO1mtGujJwTVjSyuX8UOMGM5xdzB
         TBECVLGUzvS+VixfgiZQvIEhYcNsfns8hx/MnO0v/4eaA8n7Kdx70Crqah1AsbIs9V9q
         RTAO3a7k3vl98LI899UApe9P4koZMtPKpgfdAtmB6mFSqAuNEXwb+nVIlcqji3rVCeTR
         yxpA==
X-Gm-Message-State: AOAM533i3tat6R9GU66jrd8mqBX8mYcwBP2i0fV5uYYw+THIxmBqUec8
        ZQpIxdyUNEUVvc17OuGVkfM6NCWVbsiLB2pbO/uogRt3/PEGHU9B2jDGnecRyVzMPYbfDoPAw15
        ifTX2twRTyCisnOZQCQC0oRiz
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr17383098ejc.356.1636711772008;
        Fri, 12 Nov 2021 02:09:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwIZCg8KaRPHh5tzSrNXTPjAyfDOZFhQ7POM6eHpQhHd+dmXCDKysUay1ewM1e6Mb40QOB2uQ==
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr17383074ejc.356.1636711771835;
        Fri, 12 Nov 2021 02:09:31 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:ac28:448d:9310:293c:3a8b])
        by smtp.gmail.com with ESMTPSA id ho30sm2409248ejc.30.2021.11.12.02.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 02:09:31 -0800 (PST)
Date:   Fri, 12 Nov 2021 05:09:27 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pciehp: fast unplug for virtual machines
Message-ID: <20211112050508-mutt-send-email-mst@kernel.org>
References: <20211111090225.946381-1-kraxel@redhat.com>
 <20211111115931-mutt-send-email-mst@kernel.org>
 <20211112095629.uoxfuhsvhicsdxgd@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112095629.uoxfuhsvhicsdxgd@sirius.home.kraxel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 10:56:29AM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > > This patch adds the fast_virtual_unplug module parameter to the
> > > pciehp driver.  When enabled (which is the default) the linux
> > > kernel will simply skip the delay for virtual pcie ports, which
> > > reduces the total time for the unplug operation from 6-7 seconds
> > > to 1-2 seconds.
> > 
> > BTW how come it's still taking seconds, not milliseconds?
> 
> I've tackled the 5 seconds only, biggest chunk and easy target because
> the only reason to have that is to allow operators press the attention
> button again to cancel, so the risk to break something here is rather
> low.
> 
> There are some more wait times elsewhere, to give the hardware the
> time needed when powering up/down slots, which sum up to roughly one
> second, and the time the driver needs to shutdown the device goes on
> top of that (typically not much).
> 
> take care,
>   Gerd

Probably also unnecessary for a virtual bridge. We'll need to fix these
up if we want native hotplug to be useful for workloads like kata -
these expect hotplug time in the milliseconds.

-- 
MST

