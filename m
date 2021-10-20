Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48F143458E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 08:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhJTG6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 02:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229741AbhJTG6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 02:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634712994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4AkzbJIuIOJAHop1s/JVJ6BQuEIDhfjRfELf4n/z/2I=;
        b=R4LrYzsf3pcOJrC8Qx8QoUfhxH7n2gr9YSue3oFfQbp+7O1YW7ccz4N/fdXTOOHRYC8nOj
        9GJtLliaFqX/7iG9lmFxoH9WIiTF2v9vhF3d2EedBbB76Dip9q/GnmuipW9zsQ2ISVilXX
        ZB9PxmIniUWEgfOMp86dC+EZ3H0DfCI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-H8m9-lxGMs-G5P3l7_KGwg-1; Wed, 20 Oct 2021 02:56:32 -0400
X-MC-Unique: H8m9-lxGMs-G5P3l7_KGwg-1
Received: by mail-wm1-f71.google.com with SMTP id c5-20020a05600c0ac500b0030dba7cafc9so3649849wmr.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 23:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4AkzbJIuIOJAHop1s/JVJ6BQuEIDhfjRfELf4n/z/2I=;
        b=TIBQMKarZW7TA6FRxJR0Gfpp75rPrvzANovhI83pdSYPiPfwv/TREeHGn08V1BGWFQ
         A8G43PKYlBc0n/zmXflwLTCIx+ln1acm7sGQjbvSEgyEBQBQwYuDIfX/omYfSzlCFAhr
         AyYfi/eL7eVMZkQb3IFgu/ArA/sFfP5jrqDWuDLJVXDHcDA5Y/LxOcGvb5IJDSjrzGAL
         eChAP+mjGEDrBlB0YJxZnsXvXgpFUN4u5+DWPBh+n5T3dnU7K8VlyysU077ssEwMhKEX
         o6iBCqzF9NqRlG1LDrMOKJZEpJjlUIQCi8IQzp/KRXwTE+69H0D6RgYBQpWWrmaIoA0y
         qw3Q==
X-Gm-Message-State: AOAM532URE1lTv2UNy5Cpr6Qd+43RxnEDapHqxBz1CvHulD5IU3duQPc
        CwG+CjVGK7rolPyyWG40b0bZIuvNNpfwaKqQys6gCzUiLZp+nCyHr5sMhvymtotK/tYjqTluK4H
        GNLg7ZbZLCaaJIQPnz6/Y51NK
X-Received: by 2002:a05:600c:3511:: with SMTP id h17mr11395061wmq.144.1634712991608;
        Tue, 19 Oct 2021 23:56:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5SkgS8SqfS8Adhn6/vlFcugcP4JX/aBBXBKoEulQcrWp4NjXFrc67Bvqi3WdGXtuiT74YGA==
X-Received: by 2002:a05:600c:3511:: with SMTP id h17mr11395040wmq.144.1634712991425;
        Tue, 19 Oct 2021 23:56:31 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
        by smtp.gmail.com with ESMTPSA id a127sm4151894wme.40.2021.10.19.23.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 23:56:30 -0700 (PDT)
Date:   Wed, 20 Oct 2021 02:56:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Dongli Zhang <dongli.zhang@oracle.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 06/12] virtio_pci: harden MSI-X interrupts
Message-ID: <20211020022529-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-7-jasowang@redhat.com>
 <c6641b6a-6204-2b41-e775-ad329314711c@oracle.com>
 <20211015132639-mutt-send-email-mst@kernel.org>
 <CACGkMEujcgMTtLiJWx5ZazVgM5qopB0ZVDkvg6cEuyRGAL31AA@mail.gmail.com>
 <c51930a2-3f47-407a-2b1a-fdd1d23ca7c2@oracle.com>
 <CACGkMEvSVA=qx6m7BvM-P9mm=KpPihWhVWUycj2WGnwxfa+HAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEvSVA=qx6m7BvM-P9mm=KpPihWhVWUycj2WGnwxfa+HAA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 09:33:49AM +0800, Jason Wang wrote:
> > In my own opinion, the threat model is:
> >
> > Attacker: 'malicious' hypervisor
> >
> > Victim: VM with SEV/TDX/SGX
> >
> > The attacker should not be able to steal secure/private data from VM, when the
> > hypervisor's action is unexpected. DoS is out of the scope.
> >
> > My concern is: it is very hard to clearly explain in the patchset how the
> > hypervisor is able to steal VM's data, by setting queue=0 or injecting unwanted
> > interrupts to VM.
> 
> Yes, it's a hard question but instead of trying to answer that, we can
> just fix the case of e.g unexpected interrupts.
> 
> Thanks

I think this it's still early days for TDX. So it's a bit early to talk
about threat models, start opening CVEs and distinguishing between
security and non-security bugs.

-- 
MST

