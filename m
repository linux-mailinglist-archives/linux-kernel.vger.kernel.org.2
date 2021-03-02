Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6EC32A076
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381106AbhCBEUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:20:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60828 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243127AbhCBAIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 19:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614643583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T/aiJeapuQ+NZzOZkRrqvlKGqnUujQPL10pvb6Ntbtg=;
        b=cDt+y3CMh4Q9uJri//BIBHpK3TnFyrzaSGUnhhC40EO0kh1Jkzz+4I6n+v4Z4JAaE73JF/
        f7glhh1qb5HrO3MxgkaKLVGrEMFPRva45505Mw7xy0zKnUthMC5V4WY7xlQvq/oYRgfRXE
        5PsbKpGfjbjdxJUnWFMq9yxXs69YHrg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-IUxHi1LONxW6UDaduwV4vA-1; Mon, 01 Mar 2021 19:06:22 -0500
X-MC-Unique: IUxHi1LONxW6UDaduwV4vA-1
Received: by mail-qt1-f198.google.com with SMTP id p37so2389078qtb.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 16:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T/aiJeapuQ+NZzOZkRrqvlKGqnUujQPL10pvb6Ntbtg=;
        b=dCOno1MrdacttOZP3lCIZxchikHZyhaMbulAwr6fS2HvY6nuknpgcYQIFKexwXiB1p
         o5d7CFm5TjUWd/U1ySB9fwIF/o+CHvNTJt90FbJ9mbpYyh9mE90ypEZNwdSDme0Gf+kZ
         Mon+3tp2w+xhXE7Jrch/aME0fH7m9J4VxiNQ5TOkV1HiBitKaaLyxM9bo6IF3vfgV3lu
         rMaQoETCetILumgCbelsXdUh7QxaCJeugbLCQeVbLJaWZekk++x6U5KNjsiCV/RSCQ6d
         TkSxljF79A+6k0EHlhyw56SF0yW+5MCXmU10OE3TCR1FDtONOWIkFwTkHTNyEI8YufCh
         x5Ng==
X-Gm-Message-State: AOAM532qM5ouJhVhOzB6fZffb+mGmy76hjrRpOjH2F440UrWWHvfcaT5
        FxldLTxYPSXzBVNzRXRVAvvrotDvT0wm36AXo4ETrUmNT+S/4UbPZtAomYewujntxVbrE3NxBff
        1A/fTYFucwkCqDMsD6UnSazxy
X-Received: by 2002:ac8:5bcb:: with SMTP id b11mr6649594qtb.310.1614643579843;
        Mon, 01 Mar 2021 16:06:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcnv16zMaJRKcmOZnagUsNfHhxOrjezH8D48HG1NzLKqeQVMIbP5pVLdf186x3mNcecveDqw==
X-Received: by 2002:ac8:5bcb:: with SMTP id b11mr6649567qtb.310.1614643579447;
        Mon, 01 Mar 2021 16:06:19 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id o11sm11628945qta.1.2021.03.01.16.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 16:06:19 -0800 (PST)
Date:   Mon, 1 Mar 2021 19:06:17 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] docs: filesystem: Update smaps vm flag list to latest
Message-ID: <20210302000617.GJ397383@xz-x1>
References: <20210212225533.12589-1-peterx@redhat.com>
 <87v9aa1pue.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v9aa1pue.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 03:17:13PM -0700, Jonathan Corbet wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > We've missed a few documentation when adding new VM_* flags.  Add the missing
> > pieces so they'll be in sync now.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  Documentation/filesystems/proc.rst | 5 +++++
> >  1 file changed, 5 insertions(+)
> 
> So this patch doesn't apply; what version of the kernel did you generate
> it against?  Could you redo against current kernels, please?

Sure.  "mt" just got added, hence conflicted, but the rest are still missing.
Reposting.  Thanks,

-- 
Peter Xu

