Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E18242123E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhJDPHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhJDPHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633359926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BKqfFNCEMivwB08FbXWvEqkCe6mHCvfbmubuJ0I97xQ=;
        b=Ieh7M4FfymNBW/urghnnxPElmbrM2BtsLLc9B7XDL3tX46o9kUY5u2tXNLRyKVRa1Lg6PS
        s32M9HY+u9LSLJihOEVo6D3xaxYER+iUi/AZ4l3SbNAslfowtbcQo57kzKzrKnpGtuHyPL
        PBYbexiCNFAm2ZbUeGStj301ZrDjWrY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-N_5UWb5nMM2JsfzByy6Lvw-1; Mon, 04 Oct 2021 11:05:25 -0400
X-MC-Unique: N_5UWb5nMM2JsfzByy6Lvw-1
Received: by mail-ed1-f70.google.com with SMTP id t28-20020a508d5c000000b003dad7fc5caeso7573394edt.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 08:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BKqfFNCEMivwB08FbXWvEqkCe6mHCvfbmubuJ0I97xQ=;
        b=BEbuF/9XkmdL8rdOoMUrtoZt93xZStkbHIn82RlNucgPlRM5mCzNg5YQp/QMcyQ2NB
         hkr+EYg254ILMtlzBgceUaRLZd1FugylrWh/y99klyTtVz19NM+gV/NZZDvnSMrnOetU
         C/cgoA38A7XV+DNy+/QTrjxcIVe4+9MDrDupjDM/H5vRX5qBjCTyzU1r37RVw8FlWxoc
         LACZvWzkP//OYTroREvZL5dYKzaRNDB61GQf/zvyIwZfgWlsyq2cw9avi9WzK4OnvMuD
         BcXyVGVBkDtR/UTAj6T2AhGKaHJpMYaGvpkQ4QyEPlFrqP/2rJpMU1YTF5T4iwD2Zkkd
         QAmQ==
X-Gm-Message-State: AOAM532H1YLSLO5UaF0Ley5pTgOOMJenyTHHzIcFrtD/zc0BtKTBGdgP
        xu/RUCsD/AgeY9ab9pWmE1Ghiv46sofDaeaAtgranjMIrPiHn4ZTtcdHWe6lckBGtPyE/QAUcnV
        XtlYXmSCPKJ3EPTU1GSmSaTzc
X-Received: by 2002:aa7:c418:: with SMTP id j24mr2864603edq.227.1633359923326;
        Mon, 04 Oct 2021 08:05:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwU9JadIuhF6Ys560lNNF+Op6UHEczKovjv7KBzOJz0VaWG0AO+P6FEUJqR3gX5bD8rYhffhA==
X-Received: by 2002:aa7:c418:: with SMTP id j24mr2864584edq.227.1633359923175;
        Mon, 04 Oct 2021 08:05:23 -0700 (PDT)
Received: from redhat.com (93-172-224-64.bb.netvision.net.il. [93.172.224.64])
        by smtp.gmail.com with ESMTPSA id x13sm6473465ejv.64.2021.10.04.08.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 08:05:22 -0700 (PDT)
Date:   Mon, 4 Oct 2021 11:05:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211004110152-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <87fstm47no.fsf@redhat.com>
 <20211002141351-mutt-send-email-mst@kernel.org>
 <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
 <20211003032253-mutt-send-email-mst@kernel.org>
 <87ee912e45.fsf@redhat.com>
 <20211004083455-mutt-send-email-mst@kernel.org>
 <878rz83lx0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rz83lx0.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 04:27:23PM +0200, Cornelia Huck wrote:
> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Oct 04, 2021 at 02:01:14PM +0200, Cornelia Huck wrote:
> >> On Sun, Oct 03 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> > @@ -160,6 +163,33 @@ \subsection{Legacy Interface: A Note on Feature
> >> >  Specification text within these sections generally does not apply
> >> >  to non-transitional devices.
> >> >  
> >> > +\begin{note}
> >> > +The device offers different features when used through
> >> > +the legacy interface and when operated in accordance with this
> >> > +specification.
> >> > +\end{note}
> >> > +
> >> > +Transitional drivers MUST use Devices only through the legacy interface
> >> 
> >> s/Devices only through the legacy interface/devices through the legacy
> >> interface only/
> >> 
> >> ?
> >
> > Both versions are actually confused, since how do you
> > find out that device does not offer VIRTIO_F_VERSION_1?
> >
> > I think what this should really say is
> >
> > Transitional drivers MUST NOT accept VIRTIO_F_VERSION_1 through
> > the legacy interface.
> 
> Ok, that makes sense.
> 
> Would it make sense that transitional drivers MUST accept VERSION_1
> through the non-legacy interface? Or is that redundant?

We already have:

A driver MUST accept VIRTIO_F_VERSION_1 if it is offered.


> >
> >
> > Does linux actually satisfy this? Will it accept VIRTIO_F_VERSION_1
> > through the legacy interface if offered?
> 
> I think that the Linux drivers will not operate on feature bit 32+ if
> they are in legacy mode?


Well ... with PCI there's no *way* for host to set bit 32 through
legacy. But it might be possible with MMIO/CCW. Can you tell me
what happens then?


> >> 
> >> Generally, looks good to me.
> >
> > Do we want to also add explanation that features can be
> > changed until FEATURES_OK?
> 
> I always considered that to be implict, as feature negotiation is not
> over until we have FEATURES_OK. Not sure whether we need an extra note.

Well Halil here says once you set a feature bit you can't clear it.
So maybe not ...

-- 
MST

