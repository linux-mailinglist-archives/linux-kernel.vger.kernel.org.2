Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D183C8B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbhGNTFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26826 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229491AbhGNTFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626289332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jFMVPE+n/KeTvvfcTz8BsFDOSTNgAFC7F/IHRyxFJmc=;
        b=bXxRhIFoazTxxpLl8yyC6bTqj8RdeKujseY9BxPdfJatSPWX2rWvTMU+nOEZ+icyKmH0fv
        ZgPQYQYVkqzMxFweW/AntkTkixdG2q5qrEuF2eP9HXn0hulmer7UuHKR/h58og7EbIC8I1
        eQXpJtGzvd3NVK/F7dWDWbxwraA0eK8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-NRK9HpPhP2ugnhllqbmT5A-1; Wed, 14 Jul 2021 15:02:11 -0400
X-MC-Unique: NRK9HpPhP2ugnhllqbmT5A-1
Received: by mail-ot1-f70.google.com with SMTP id y59-20020a9d22c10000b0290451891192f0so2720858ota.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jFMVPE+n/KeTvvfcTz8BsFDOSTNgAFC7F/IHRyxFJmc=;
        b=dPiIJwgcr6TPb4vEHsX2TftJy/6588aktsXsMhdFHiwfsKGbySKYa7uuHPGAHHalbz
         2ZRqaEdrkrMWw3GDfsl6h9fQ/fpkcsn3mgNUogOFqvlFeTM+g3qeuumHfEyEwfgoS/EY
         zlObqexWoHVKUnl+nQVXAfRTkvIXc6YgM6XcBm/SxV6/Z1N6eLUlXGK3zPdwEoHDrUM7
         IPtXZ8mLNSVTQYmm08gfWa6ioonZ/VV7ATIjpiKE4WFBUSswvB73Ek4QWA9OehBiqUp2
         6wUjAzEYrot99TRxjliXb1+QUf4MfqzOfd+ZOfBgQMtb2ISw2JwbABGax8ePhJxofupM
         lz3w==
X-Gm-Message-State: AOAM530l9ctBSwpmNI3IqeDGstuM+WyOHZF4zaz0eoMxTT4Em5uEktEt
        3ww78fGgH0AVmTB7I1j3n/nFYo/0M5o0O7T9gehoWKYRMQE1UsAEgNTM4b1qXXEowgq6V8VXyc6
        GXJt7lv+YB4uKEy8NtB62a7Nq
X-Received: by 2002:a05:6808:68d:: with SMTP id k13mr8538416oig.83.1626289331021;
        Wed, 14 Jul 2021 12:02:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmWMx0geU1BNiLf2IsT9q6idWWJuEft9e76PzdT0hS84lYGsbY/IMct48LwOS/vpZ04uvQvA==
X-Received: by 2002:a05:6808:68d:: with SMTP id k13mr8538396oig.83.1626289330814;
        Wed, 14 Jul 2021 12:02:10 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id l8sm654946oie.0.2021.07.14.12.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:02:10 -0700 (PDT)
Date:   Wed, 14 Jul 2021 13:02:08 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        kwankhede@nvidia.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210714130208.1eb5c677.alex.williamson@redhat.com>
In-Reply-To: <9c50fb1b-4574-0cfc-487c-64108d97ed73@de.ibm.com>
References: <20210707154156.297139-1-akrowiak@linux.ibm.com>
        <20210713013815.57e8a8cb.pasic@linux.ibm.com>
        <5dd3cc05-f789-21a3-50c7-ee80d850a105@linux.ibm.com>
        <20210713184517.48eacee6.pasic@linux.ibm.com>
        <20210713170533.GF136586@nvidia.com>
        <9512a7fb-cc55-cd9b-cdf9-7c19d0567311@linux.ibm.com>
        <20210713192138.GG136586@nvidia.com>
        <dc18ff02-80f6-e59e-5f08-417434e74706@linux.ibm.com>
        <9c50fb1b-4574-0cfc-487c-64108d97ed73@de.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 19:56:42 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 14.07.21 15:25, Tony Krowiak wrote:
> >   
> >> This patch shows it works as a rwsem - look at what had to be changed
> >> to make it so and you will find some clue to where the problems are in
> >> kvm_busy version.
> >>
> >> In any event, I don't care anymore - please just get this merged, to
> >> AlexW's tree so I don't have conflicts with the rest of the ap changes
> >> for VFIO I've got queued up.  
> > 
> > Christian, can you merge this with AlexW's tree? Halil suggested
> > the 'fixes' and 'cc stable' tags ought to be removed, do I need
> > to post another version or can you take those out when merging?  
> 
> Normally this would go via the KVM/s390 or s390 tree (as Alex did
> not want to handle s390 vfio devices).
> 
> Alex, as Jason is waiting for this to be in your tree could you take
> this patch via your tree ?(please remove cc stable and Fixes for now
> I want this to settle a bit).
> 
> To carry this patch in your tree with my kvm/s390 and s390 maintainer hat
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Is this intended for v5.14 or v5.15?  I don't have a v5.15 next branch
yet, so if this were to get into v5.14 before I create that, it'd be
there for Jason as well.  Posting a branch that we both merge into our
linux-next branches would be another option.  I can take it either way,
just trying to understand what we're wanting to achieve.  Thanks,

Alex

