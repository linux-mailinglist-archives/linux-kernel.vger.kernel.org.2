Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8109F42D97A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhJNMuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 08:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229912AbhJNMuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634215678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zts4wXOWu/9Ni/KeqGelE9EoK5pSBbv4ItyFw5Cwy1M=;
        b=ds+Zbyaix3VImn9EDk77sh+dfTFKQIuuGo3t3acqlFxpKkkLfvL1CAh6A/IrG1ZNRcuVI+
        lBT3bDaIsAp64zADYMtkQb2v4gxK6kTL2bc14M4FbzVInYJ5+7v/OfT6i6K4F7iReShbVI
        Grq4lOyN9uHDSsLZD4yoHps3QP7EHMM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-4etc_d8nMnCP8E_MGdcuBQ-1; Thu, 14 Oct 2021 08:47:57 -0400
X-MC-Unique: 4etc_d8nMnCP8E_MGdcuBQ-1
Received: by mail-io1-f71.google.com with SMTP id d7-20020a056602228700b005ddba37de42so2159650iod.23
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 05:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zts4wXOWu/9Ni/KeqGelE9EoK5pSBbv4ItyFw5Cwy1M=;
        b=CbiLS8CKqv6llD1cIA8uhgmc8h2CQXSdanit/gBTq6tD3Z7ZUGWuszcSaIkIY97b5Z
         O5VwolcMJ800hrgxnK0gWm1bU29Vs/Z1hfPfT0tjSk6ITW9pNfmQJfv7tD2dNnFTy+V9
         CthLhWZGXT5KJv6HUU3Y97e2pnWsXWNiWn9hBEUCt8cPqmjNtqi5zwf9glk6aEvQZR4+
         qvMqdjQuOiOrvWJ1IorKnGJ2t1sw3DwVmGa22wSl1luCJsBkVTouqvtbLBWFO83vjD0e
         Zc4hgrErU+wleyrmuYvJgfr3KMY6UvqOoKQISZ3b2WSQY3BdXX41sVOJqt62nvgOnmUc
         ny6w==
X-Gm-Message-State: AOAM532wDXguvSfmHjY3Vje3ShYTmMfNQtfVxPTf1gO19/nzpQDJyeWa
        dMqaqaaTnlt6ebmYgGZ/NX6d4n5rus4KJF+5brUmYk/g4lAN6CqNqLGFgdb4y/+LkDw0Ac/S8lX
        dXmuz5GU9omlX57SnEICrhyc5
X-Received: by 2002:a05:6e02:1003:: with SMTP id n3mr2194512ilj.279.1634215676792;
        Thu, 14 Oct 2021 05:47:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcUlaMKfFfxBh+m4iFjzpyGmVPGjXrXEhqIkLjyOOrAv9ODnxnPthK6F3nUmZoZbX/Mo091g==
X-Received: by 2002:a05:6e02:1003:: with SMTP id n3mr2194497ilj.279.1634215676617;
        Thu, 14 Oct 2021 05:47:56 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id j13sm1187025ilr.47.2021.10.14.05.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 05:47:55 -0700 (PDT)
Date:   Thu, 14 Oct 2021 07:47:53 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     rostedt@goodmis.org, bp@suse.de, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: Make unknown command line param message clearer
Message-ID: <20211014124753.wng5iuzluukz4val@halaneylaptop>
References: <20211013223502.96756-1-ahalaney@redhat.com>
 <20211013161259.39e88182200b7a582c0cf632@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013161259.39e88182200b7a582c0cf632@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 04:12:59PM -0700, Andrew Morton wrote:
> On Wed, 13 Oct 2021 17:35:02 -0500 Andrew Halaney <ahalaney@redhat.com> wrote:
> 
> > The prior message is confusing users, which is the exact opposite of the
> > goal. If the message is being seen, one of the following situations is
> > happening:
> > 
> >  1. the param is misspelled
> >  2. the param is not valid due to the kernel configuration
> >  3. the param is intended for init but isn't after the '--'
> >     delineator on the command line
> > 
> > To make that more clear to the user, explicitly mention "kernel command
> > line" and also note that the params are still passed to user space to
> > avoid causing any alarm over params intended for init.
> > 
> > Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
> > Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> 
> Thanks.
> 
> BTW, I'm still sitting on your "init/main.c: silence some
> -Wunused-parameter warnings", awaiting a response to Rasmus's
> suggestion:
> https://lkml.kernel.org/r/f06b8308-645b-031b-f9c6-b92400a269aa@rasmusvillemoes.dk
> 

Whoops, that got caught in spam (along with rostedt's replies
yesterday... darn gmail). Let me add looking at that to the todo list,
thanks Andrew!

