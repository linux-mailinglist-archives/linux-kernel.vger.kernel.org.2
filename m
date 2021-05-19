Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CCB388FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346915AbhESOF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240179AbhESOF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621433076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q0X6ufyJH5fadmIknxn4nGcWs1xnqbL6wQGkTAtdW1c=;
        b=Tw8RKgQRCXH+fmkXIrxv+lnkjg+Y1aqhfdZycLors3SXtB9ey72H2FSEA15QtBFt/+IlF3
        R1XyJO7Cp3tReLJlLHbQCHo5Agiw0KsQ8CaUrG4VXnHM8sn8Z3wJ29NKAFT3e1Xgs7DlU2
        hUOR2RpO1DWbuVpTmx1jVrMrIRr/Cm4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-xIAkG71hPs6wsS98J4OlYQ-1; Wed, 19 May 2021 10:04:34 -0400
X-MC-Unique: xIAkG71hPs6wsS98J4OlYQ-1
Received: by mail-qt1-f197.google.com with SMTP id o15-20020a05622a138fb02901e0ac29f6b2so9873143qtk.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q0X6ufyJH5fadmIknxn4nGcWs1xnqbL6wQGkTAtdW1c=;
        b=ku4+pjaIHuV/JoTkfAuCAexG2rcWTCpAd1CBB3k6GVlH1SyvzAv/L0KbjeN7GYtFQS
         lDWmVB5fyGuKESM9INVeMruuIAXI4dT5OWrq8Q8GuHmC7HamuUDya2AkBBExkVCqYhBF
         DxlbuUox/V3uckTkaWcUqGh6De861B2Zkv9EWOqn9UQMXPR1eZApG8iVokbHXFSVWwpF
         XI2I9Z9SgZz3C/aDzZodm2ZFU+/jAIeWLPsWvVkwhpgec4BwDf1XbS8eW2DPUGD7cta0
         g1fRKEAE3vIj0Q+FID8iUqWWA06TbvG/IO7GcKKNeeDXD2SOus7bcbWrPIQbOoVOVFL9
         3O6g==
X-Gm-Message-State: AOAM533xM+vYRHPev2rJ7/UmHSujzPezahWyW30UTcwU+pp7m+a4fnVW
        uPXqgjaVHJS/Fv6rcf7rm8HvRWa44Z9CD/7PfHHsJsSuRcr9z84MffW/8wntSU8lcC2dDkW6ybN
        F9PLTJm63xGFiVR4PXemJCX72
X-Received: by 2002:a05:6214:d87:: with SMTP id e7mr13037374qve.53.1621433074137;
        Wed, 19 May 2021 07:04:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6J2iQWttFbTggjwn9zrUjjmVN+9VOim38VY5Z448bl6PpUs3xqQHJcSoYTLuhDbSvYY+iNA==
X-Received: by 2002:a05:6214:d87:: with SMTP id e7mr13037337qve.53.1621433073770;
        Wed, 19 May 2021 07:04:33 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id b13sm802748qkl.16.2021.05.19.07.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:04:33 -0700 (PDT)
Date:   Wed, 19 May 2021 10:04:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, bskeggs@redhat.com,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jhubbard@nvidia.com, rcampbell@nvidia.com, jglisse@redhat.com,
        hch@infradead.org, daniel@ffwll.ch, willy@infradead.org,
        bsingharora@gmail.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 5/8] mm: Device exclusive memory access
Message-ID: <YKUa8HZjfFW2Dhb1@t490s>
References: <20210407084238.20443-1-apopple@nvidia.com>
 <2235357.HsqDk0zIjc@nvdebian>
 <YKUBbVuvm5FUJRMl@t490s>
 <2569629.VzlulnA7BY@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2569629.VzlulnA7BY@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 11:11:55PM +1000, Alistair Popple wrote:
> On Wednesday, 19 May 2021 10:15:41 PM AEST Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > On Wed, May 19, 2021 at 09:04:53PM +1000, Alistair Popple wrote:
> > > Failing fork() because we couldn't take a lock doesn't seem like the right
> > > approach though, especially as there is already existing code that
> > > retries. I get this adds complexity though, so would be happy to take a
> > > look at cleaning copy_pte_range() up in future.
> > 
> > Yes, I proposed that as this one won't affect any existing applications
> > (unlike the existing ones) but only new userspace driver apps that will use
> > this new atomic feature.
> > 
> > IMHO it'll be a pity to add extra complexity and maintainance burden into
> > fork() if only for keeping the "logical correctness of fork()" however the
> > code never triggers. If we start with trylock we'll know whether people
> > will use it, since people will complain with a reason when needed; however
> > I still doubt whether a sane userspace device driver should fork() within
> > busy interaction with the device underneath..
> 
> I will refrain from commenting on the sanity or otherwise of doing that :-)
> 
> Agree such a scenario seems unlikely in practice (and possibly unreasonable). 
> Keeping the "logical correctness of fork()" still seems worthwhile to me, but 
> if the added complexity/maintenance burden for an admittedly fairly specific 
> feature is going to stop progress here I am happy to take the fail fork 
> approach. I could then possibly fix it up as a future clean up to 
> copy_pte_range(). Perhaps others have thoughts?

Yes, it's more about making this series easier to be accepted, and it'll be
great to have others' input.

Btw, just to mention that I don't even think fail fork() on failed trylock() is
against "logical correctness of fork()": IMHO it's still 100% correct just like
most syscalls can return with -EAGAIN, that suggests the userspace to try again
the syscall, and I hope that also works for fork().  I'd be more than glad to
be corrected too.

-- 
Peter Xu

