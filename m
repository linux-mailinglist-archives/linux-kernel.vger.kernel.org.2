Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D412B3E860D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 00:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbhHJW1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 18:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231380AbhHJW1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 18:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628634450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rKtkcMoRO4/SmKHkWSTGcVIokr6+s/Nfptu/B3gHJZ4=;
        b=VRq5dXPptuCXrk1Y4GUcDpjLK1Lp7wMbznfKIXTrMZdhSwWaGT29pw3c0qIRJ4kHC1b0wm
        oK/zPFOAiZgBEpgjYGPqagEJ2Wuor1oG3cn5AH4lSngONLwSB/vx8LS5FtfwD/ipnJK8Hv
        onn+QhFLvKgV5B5dNSNaB3TOv2Z5CTw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-TmbQFms3P0yhKrY0eH3_hw-1; Tue, 10 Aug 2021 18:27:28 -0400
X-MC-Unique: TmbQFms3P0yhKrY0eH3_hw-1
Received: by mail-qk1-f198.google.com with SMTP id 18-20020a05620a0792b02903b8e915ccceso62631qka.18
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 15:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rKtkcMoRO4/SmKHkWSTGcVIokr6+s/Nfptu/B3gHJZ4=;
        b=q4OSTAZAQ0iNC22xNjTJWxEcf53uBdjYER0bZwNuA4trIsRNL/Mi0XY18TfjRkaN/M
         cEE94wmziznDVjENq1VtGWYmHghDhiVd/i0ncHhkRLlQhxDv4TkvBPpbU9NgruSJUt+H
         +p++MpKtQU3hHWO+B38VOSU0/jYeobm3VVYkhZgS7zn3CnAiNR9EINHVwvwFZq4pOyJb
         1Z4PUw6Aq85BiL1u5zrnixCTU6NusAYQR6MyzdbQUjlOhbzc22RW/IILi8UNe5Znoph4
         aabEZrvS/p31SoKxJM14lrJG+EZ5TOHTant5vN5QReOtvkO6jZ1SOCVXlRs6UsTX48gf
         7/hQ==
X-Gm-Message-State: AOAM533m+82dw7nqfm4Q89fYJVS6ZXq4fwSbgvxHvRuLf2ODFT+qnE4T
        iae9itYtig/CueFyYSRrbNbmPUOirOF0ClibyRqZGKlm7CQuWbcjmISeWd07jxZldiHC4lZbF3T
        kjUTDLwQt9nduiwSGfJsEuKmE
X-Received: by 2002:a05:620a:13c8:: with SMTP id g8mr14086268qkl.258.1628634448377;
        Tue, 10 Aug 2021 15:27:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6ol+Dk+1WWikh+M4yXdniloOOnQpQMxQ/tgcF5y35oJ1E0R3kXcExU8u5AzE9C/Qmja70zA==
X-Received: by 2002:a05:620a:13c8:: with SMTP id g8mr14086248qkl.258.1628634448157;
        Tue, 10 Aug 2021 15:27:28 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id o26sm4628328qkm.29.2021.08.10.15.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 15:27:27 -0700 (PDT)
Date:   Tue, 10 Aug 2021 18:27:26 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 7/7] vfio/pci: Remove map-on-fault behavior
Message-ID: <YRL9TmcGcLMRHlgO@t490s>
References: <162818167535.1511194.6614962507750594786.stgit@omen>
 <162818330190.1511194.10498114924408843888.stgit@omen>
 <YRLne7/S1euppJQr@t490s>
 <20210810154512.5aa8eeb3.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210810154512.5aa8eeb3.alex.williamson@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 03:45:12PM -0600, Alex Williamson wrote:
> On Tue, 10 Aug 2021 16:54:19 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Thu, Aug 05, 2021 at 11:08:21AM -0600, Alex Williamson wrote:
> > > diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> > > index 0aa542fa1e26..9aedb78a4ae3 100644
> > > --- a/drivers/vfio/pci/vfio_pci_private.h
> > > +++ b/drivers/vfio/pci/vfio_pci_private.h
> > > @@ -128,6 +128,7 @@ struct vfio_pci_device {
> > >  	bool			needs_reset;
> > >  	bool			nointx;
> > >  	bool			needs_pm_restore;
> > > +	bool			zapped_bars;  
> > 
> > Would it be nicer to invert the meaning of "zapped_bars" and rename it to
> > "memory_enabled"?  Thanks,
> 
> I think this has it's own down sides, for example is this really less
> confusing?:
> 
>   if (!vdev->memory_enabled && __vfio_pci_memory_enabled(vdev))

Maybe "memory_enabled_last"?  No strong opinion, especially for namings. :)
zapped_bars still looks okay to me.  Thanks,

-- 
Peter Xu

