Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCAB3B697C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbhF1UM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:12:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232527AbhF1UMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624910998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GcUi3W4j9bCnAK214Ds5fcL7OghjM76ZAY3mDl17NWE=;
        b=KNogKfXcS/gVYIHoV9f9x2WpdTqBSDbbQbebDN0ECvlQSwWbnqLvnizQBTHIHQEMQAZoga
        2yzxlCWSmqVoOZRTsUC3z0aVv3wvHborXt/F8L7ywyGMX3LM+dS+qz4TstwQOSh58lW6bC
        thJyTG3ldzRnadQnV3ARj8504/STjFc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-2Y_QElnIPu2A7lNM7gVD1w-1; Mon, 28 Jun 2021 16:09:57 -0400
X-MC-Unique: 2Y_QElnIPu2A7lNM7gVD1w-1
Received: by mail-ot1-f71.google.com with SMTP id t4-20020a9d77440000b0290463a472d9a2so8738354otl.16
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GcUi3W4j9bCnAK214Ds5fcL7OghjM76ZAY3mDl17NWE=;
        b=tK56pCEnI2jUJQBaLeNjYKnhgUVDMhlh3atY1Ee3n5/SkGpWGg1nx9JeCTtOqcjgec
         6fzeMk4hqlK6OjMSqxsdVPXa97POx8yEJyWsqanuh964HdQ4rVEIFGFLjsexVjflIgcB
         TSjBdn6mZssLpwydC907Cvo58DKyp8wXw24HrJ0Ix0lh6BVfRiJ68jmArEuuWV15FRsG
         LnC2BhD1dKBVmXcYTBCTaCJHFGJU5gski66gBTkqKvmr9urH1y2J8Lv2A4rn3iQbf6f+
         qJoS+0X0aEmPL6+WXT8XsB0ukyA7oxotPYxTSS9pNYVBmMFYbBVW525wf1aDb98iBf9X
         VCGQ==
X-Gm-Message-State: AOAM532l1uwUSqSdfhPN8QHcdzF6hE47vW2q+p0P1LDhaNkPQtwgsO4U
        rBBGfNKYE2d3LODBep6AP+UBByFwIMIhNbXitzgPiKRucUo2X7zSF0SkMJY3s/cksYfPK5pgscu
        0D0CyfyJBL+683zQ8y0Kt1Jbw
X-Received: by 2002:a9d:2eb:: with SMTP id 98mr1117109otl.297.1624910996800;
        Mon, 28 Jun 2021 13:09:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxvgkuJCkP8FaMaWBqXZ3yhxO6gzSOe/UIQ9vZvArYTVkEENW1WrRNMhzfo7YDVfxnVPh6pg==
X-Received: by 2002:a9d:2eb:: with SMTP id 98mr1117096otl.297.1624910996562;
        Mon, 28 Jun 2021 13:09:56 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id o24sm3636373otp.13.2021.06.28.13.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 13:09:56 -0700 (PDT)
Date:   Mon, 28 Jun 2021 14:09:55 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>
Cc:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cohuck@redhat.com>, <jgg@nvidia.com>
Subject: Re: [PATCH] vfio/mtty: Enforce available_instances
Message-ID: <20210628140955.17e770ec.alex.williamson@redhat.com>
In-Reply-To: <641a865f-a45b-10ed-8287-3759191a9686@nvidia.com>
References: <162465624894.3338367.12935940647049917981.stgit@omen>
        <ee949a98-6998-2032-eb17-00ef8b8d911c@nvidia.com>
        <20210628125602.5b07388e.alex.williamson@redhat.com>
        <641a865f-a45b-10ed-8287-3759191a9686@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2021 01:22:00 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 6/29/2021 12:26 AM, Alex Williamson wrote:
> > On Mon, 28 Jun 2021 23:19:54 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> On 6/26/2021 2:56 AM, Alex Williamson wrote:  
> >>> The sample mtty mdev driver doesn't actually enforce the number of
> >>> device instances it claims are available.  Implement this properly.
> >>>
> >>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> >>> ---
> >>>
> >>> Applies to vfio next branch + Jason's atomic conversion
> >>>      
> >>
> >>
> >> Does this need to be on top of Jason's patch?  
> > 
> > Yes, see immediately above.
> >   
> >> Patch to use mdev_used_ports is reverted here, can it be changed from
> >> mdev_devices_list to mdev_avail_ports atomic variable?  
> > 
> > It doesn't revert Jason's change, it builds on it.  The patches could
> > we squashed, but there's no bug in Jason's patch that we're trying to
> > avoid exposing, so I don't see why we'd do that.
> >  
> 
> 'Squashed' is the correct word that 'revert', my bad.
> 
> >> Change here to use atomic variable looks good to me.
> >>
> >> Reviewed by: Kirti Wankhede <kwankhede@nvidia.com>  
> > 
> > Thanks!  It was Jason's patch[1] that converted to use an atomic
> > though, so I'm slightly confused if this R-b is for the patch below,
> > Jason's patch, or both.  Thanks,  
> 
> I liked 'mdev_avail_ports' approach than 'mdev_used_ports' approach 
> here. This R-b is for below patch.

Got it, added.  Thanks Kirti!

