Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB5733238C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhCILCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:02:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229656AbhCILBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615287702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bXofV3jLziu+Wp1oGfyC1i5xxFnpdDDe+U78h4D8xPA=;
        b=P5pM/Kmg4XYFv7O4yaOYg0LV8lgI/EetP5XsSdq/2sBuuK8b6HDKrw0JyL+SDoONuhOmdQ
        DF/RaigTfUpDfe35DUeoeQ6K4H/zhydd0oKNPS6XPNMzECqe5exJtqLOpxuW0arjXqsVqy
        tgAggxSZ4NN1Up3WGfbC91bvXJcpOYg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-vaJg-4AOPB6AcdnIgIgNKg-1; Tue, 09 Mar 2021 06:01:41 -0500
X-MC-Unique: vaJg-4AOPB6AcdnIgIgNKg-1
Received: by mail-wm1-f72.google.com with SMTP id v5so964884wml.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 03:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bXofV3jLziu+Wp1oGfyC1i5xxFnpdDDe+U78h4D8xPA=;
        b=k1WFwNyZzYC7EkmyxFtgDLB41k86LwEdMUeDpcH3AcLd4kqJ75SiuvH3L7rBPWfNw5
         PalWUHkAxmSS1rs4499gHW0XfrN6vSy4J7cSE+gsUBV5oM++Te+6Nv1zNhmErXpZLrw5
         PN2WKS2Lb6TZBruZ/4p2AMor3dTN2lzqe9NA0eKTHSHGa0BmlyNsV5IV26+V4FqVSwXJ
         OWjEDQtDMQZdYjwC5p+eosKqcpCi4TrKrKaiD4IhsiBJgXML+wi3UOLQmE/22BhTRxwq
         zcpBr2kzKpAiNQUqhztrrKPn2gqiovxi+CWeH54AlLyjFyD5FqiZpt/p6i8W5BvKzzft
         TlBA==
X-Gm-Message-State: AOAM531ESKdOlochVG9q+drBTkSLnAF48LqXJ4UT9puR1YxTy/WAQfst
        LZtVHu/4ZGT6vFG5ZlMsLE0VWWBNxBy3A6KAkEwySM1gBNdLSlb5unOXHyX6xREk7sXT16NQRj2
        XRAsQzHugs6+XHR/x5K72Xc34
X-Received: by 2002:adf:b345:: with SMTP id k5mr28070194wrd.14.1615287699864;
        Tue, 09 Mar 2021 03:01:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzetu7r61ByxvgJmvUI/EaGQVn0vPKFr+ABH3NaEeH1/nQMdL0KzNm9JnWnn/K//S0NuROwHQ==
X-Received: by 2002:adf:b345:: with SMTP id k5mr28070175wrd.14.1615287699719;
        Tue, 09 Mar 2021 03:01:39 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id o188sm3661057wme.7.2021.03.09.03.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 03:01:38 -0800 (PST)
Date:   Tue, 9 Mar 2021 06:01:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Anton Yakovlev <anton.yakovlev@opensynergy.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vhost tree with the sound tree
Message-ID: <20210309060118-mutt-send-email-mst@kernel.org>
References: <20210309125833.0355a754@canb.auug.org.au>
 <s5heego3juz.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5heego3juz.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 07:46:12AM +0100, Takashi Iwai wrote:
> On Tue, 09 Mar 2021 02:58:33 +0100,
> Stephen Rothwell wrote:
> > 
> > Hi all,
> > 
> > Today's linux-next merge of the vhost tree got conflicts in:
> > 
> >   sound/virtio/virtio_card.c
> >   sound/virtio/virtio_card.h
> >   sound/virtio/virtio_ctl_msg.c
> >   sound/virtio/virtio_pcm.c
> >   sound/virtio/virtio_pcm.h
> >   sound/virtio/virtio_pcm_msg.c
> >   sound/virtio/virtio_pcm_ops.c
> > 
> > between commits:
> > 
> >   de3a9980d8c3 ("ALSA: virtio: add virtio sound driver")
> >   9d45e514da88 ("ALSA: virtio: handling control messages")
> >   29b96bf50ba9 ("ALSA: virtio: build PCM devices and substream hardware descriptors")
> >   f40a28679e0b ("ALSA: virtio: handling control and I/O messages for the PCM device")
> >   da76e9f3e43a ("ALSA: virtio: PCM substream operators")
> >   ca61a41f389c ("ALSA: virtio: introduce jack support")
> >   19325fedf245 ("ALSA: virtio: introduce PCM channel map support")
> >   575483e90a32 ("ALSA: virtio: introduce device suspend/resume support")
> > 
> > from the sound tree and commits:
> > 
> >   1e2fb08629e5 ("ALSA: virtio: add virtio sound driver")
> >   3fb7ce161568 ("ALSA: virtio: handling control messages")
> >   83ec5db56076 ("ALSA: virtio: build PCM devices and substream hardware descriptors")
> >   68742d8557b8 ("ALSA: virtio: handling control and I/O messages for the PCM device")
> >   def2208d373b ("ALSA: virtio: PCM substream operators")
> >   613515055d34 ("ALSA: virtio: introduce jack support")
> >   96db428c31f1 ("ALSA: virtio: introduce PCM channel map support")
> >   1f77f124f2f2 ("ALSA: virtio: introduce device suspend/resume support")
> > 
> > from the vhost tree.
> > 
> > I fixed it up (the sound tree commits have newer author dates, so I just
> > used them) and can carry the fix as necessary. This is now fixed as far as
> > linux-next is concerned, but any non trivial conflicts should be mentioned
> > to your upstream maintainer when your tree is submitted for merging.
> > You may also want to consider cooperating with the maintainer of the
> > conflicting tree to minimise any particularly complex conflicts.
> 
> Michael, could you drop those?  These must be the old versions that
> contained lots of bugs.  As already announced, you can pull from my
> immutable branch, tagged virtio_snd-5.12-rc2, too.
> 
> Sorry for the mess!
> 
> 
> Takashi

Sorry I just didn't push to the next branch. Will do!

