Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AA04224DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhJELWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:22:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233812AbhJELWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633432829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8DxNvJPCW0wWRkzK7is2TKN8eqfqYzj6jjWzgoTSkB0=;
        b=e0aYcaFWOZo/4omRkx0JYetzZKQa/I7CIfvFiUblZfa3cajE+EuWIYITt7gv1l043UWSoz
        RjJQE8pJ3vHgAns64m1NuoHxEfK8JvVwB+8ZLh2MXe7IrFH5W3/w0cpuEfYsp3DV75j0V/
        B9fkUmpoy/lRTJk4XfW47q0HOo9CMb4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-KIXpbJW2M46OWJKt2CrmRw-1; Tue, 05 Oct 2021 07:20:26 -0400
X-MC-Unique: KIXpbJW2M46OWJKt2CrmRw-1
Received: by mail-ed1-f70.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso7487785edf.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 04:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8DxNvJPCW0wWRkzK7is2TKN8eqfqYzj6jjWzgoTSkB0=;
        b=HBWLVTisKhfbitAaaF/FimHSwcjBy1y5rdfyc6RP2EZEDLQTtW6Y8FF9nQBNz8mAyg
         /Zp/LQvqgY8laRy8IQsd6Tz7JB5ub72eLPKcX1XSrc6z0UHEc970wWQkumgND08pzKYr
         lgCUWDMRQyf+70+I43m1KNmib1hX/5zo6YvmmUN+KgXMG/GRcKNgiygkib2Jlgc8J9ZT
         o3sapSEIWckZy2sTmT4DIDyBjlcECcmfY1DABl6j1PoXLGTN5jhka6gJWpBuRjYlWMHC
         XxNGL75fYsCHtqgsgZ2kbfC73BoD9XnN4cafN7sF1Lzt4XdotzXp7ClnHZ1mFCQxg1cS
         hS6Q==
X-Gm-Message-State: AOAM531/y8BS1eN3zavpEoY/cQuSTRdEOZB8scx8tu26mC7ACc+6kFQa
        8tYBcyahgcTYVckNMzN0vsCOf4vnYEGpXyASnuhBsr4L/n3aCQlT9ckWSkTNdFYitZ5/b7St76G
        DV5zKgm7EMnPvbRAjU1XMOLUh
X-Received: by 2002:a17:906:3a0a:: with SMTP id z10mr12655454eje.111.1633432825630;
        Tue, 05 Oct 2021 04:20:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwX7CkJhv+B6EpESQjJAlERsSi/L6SFxie1MuYGz7XrNTrZeHjtBwjO3hp8O2z35qxUHeEJOQ==
X-Received: by 2002:a17:906:3a0a:: with SMTP id z10mr12655428eje.111.1633432825464;
        Tue, 05 Oct 2021 04:20:25 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
        by smtp.gmail.com with ESMTPSA id b2sm8650876edv.73.2021.10.05.04.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 04:20:24 -0700 (PDT)
Date:   Tue, 5 Oct 2021 07:20:20 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        markver@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>,
        qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Xie Yongji <xieyongji@bytedance.com>, stefanha@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211005072006-mutt-send-email-mst@kernel.org>
References: <87r1d64dl4.fsf@redhat.com>
 <20210930130350.0cdc7c65.pasic@linux.ibm.com>
 <87ilyi47wn.fsf@redhat.com>
 <20211001162213.18d7375e.pasic@linux.ibm.com>
 <87v92g3h9l.fsf@redhat.com>
 <20211002082128-mutt-send-email-mst@kernel.org>
 <20211004042323.730c6a5e.pasic@linux.ibm.com>
 <20211004040937-mutt-send-email-mst@kernel.org>
 <20211005124303.3abf848b.pasic@linux.ibm.com>
 <87lf372084.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf372084.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 01:13:31PM +0200, Cornelia Huck wrote:
> On Tue, Oct 05 2021, Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Mon, 4 Oct 2021 05:07:13 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> Well we established that we can know. Here's an alternative explanation:
> >
> >
> > I thin we established how this should be in the future, where a transport
> > specific mechanism is used to decide are we operating in legacy mode or
> > in modern mode. But with the current QEMU reality, I don't think so.
> > Namely currently the switch native-endian config -> little endian config
> > happens when the VERSION_1 is negotiated, which may happen whenever
> > the VERSION_1 bit is changed, or only when FEATURES_OK is set
> > (vhost-user).
> >
> > This is consistent with device should detect a legacy driver by checking
> > for VERSION_1, which is what the spec currently says.
> >
> > So for transitional we start out with native-endian config. For modern
> > only the config is always LE.
> >
> > The guest can distinguish between a legacy only device and a modern
> > capable device after the revision negotiation. A legacy device would
> > reject the CCW.
> >
> > But both a transitional device and a modern only device would accept
> > a revision > 0. So the guest does not know for ccw.
> 
> Well, for pci I think the driver knows that it is using either legacy or
> modern, no?
> 
> And for ccw, the driver knows at that point in time which revision it
> negotiated, so it should know that a revision > 0 will use LE (and the
> device will obviously know that as well.)
> 
> Or am I misunderstanding what you're getting at?

Exactly what I'm saying.

