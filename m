Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8144353F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhJTTqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 15:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20018 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231360AbhJTTqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634759038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lk2DJIwlIwjubwL7omTN8Cbj68q/qeG7nk2u/Kt/9zw=;
        b=BhevXjC8o61Q/wLiNEfnwNtkopTrfRzZqJPw0bPNdKigB5jbRcrhGvLZCnMrhTAOCXh0Si
        gT7Rl/04Bj35Wa23tvIY9ujkjMJ0nuoHwcR3vx48H3Tn7pvKAQugZZFvyyO3XZXK8i71rP
        /wj4JaB0gym8DeNfMg+vGewPfO94okk=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-CRSVTddEP_-8f29XnjIKrA-1; Wed, 20 Oct 2021 15:43:56 -0400
X-MC-Unique: CRSVTddEP_-8f29XnjIKrA-1
Received: by mail-oo1-f71.google.com with SMTP id u1-20020a4a6141000000b002b6d25c0103so3755549ooe.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lk2DJIwlIwjubwL7omTN8Cbj68q/qeG7nk2u/Kt/9zw=;
        b=wIq3MJLK3QPYI2IWBj1FuH4iiiBSr7Flu0+pHrFPWIR8iZG4mpkkluR73IZNqBHqKE
         i8Z/RIT5KYbRCTcah1MQIbVz801Xs0DvyzYEwfo8ya0/iUjf2m0IHYhTvesMQ2aJDmUR
         PfRmclYJJ2g6zV7OKLCBuXtYoEROBjf7dF+BZPtwn4d0BVQYJCw0JAbIuoD62Ky56oPb
         c/NRKC5BiQWFwByodf/fXJkmiajC7ByYd2OJgNIufAsKztac0h81KFLLALhP0QMscrtX
         scy1MQ7hzu7EzaDVopm/t9TuOtb6IMgysJEFtdaxWmoEIGrEWmugSbKF1d7XJF2hZrOd
         qp7w==
X-Gm-Message-State: AOAM531/x4QZ0CbJyNWcTW5/gt8CPCnSyWikWj9q/r8CjPA1EB0irWOs
        sNWPgH7AB7ZTbsdY67D/XCp15bLlR+Xp0eBwA3MyY/WCnZz14YSJkgnXR0zYerFB+yIE7d+p9zr
        4JPAzH7eDfULBNmaBZuYxCnep
X-Received: by 2002:a05:6808:1302:: with SMTP id y2mr1174541oiv.24.1634759035920;
        Wed, 20 Oct 2021 12:43:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIrpYN9cTB9TC6WsVyKmSGG23X2bm1qKF+DFN41pM/W3tUAe3kxPe7gtECWW+vXwL4nZJN6Q==
X-Received: by 2002:a05:6808:1302:: with SMTP id y2mr1174533oiv.24.1634759035762;
        Wed, 20 Oct 2021 12:43:55 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id u21sm598415oiv.25.2021.10.20.12.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 12:43:55 -0700 (PDT)
Date:   Wed, 20 Oct 2021 12:43:52 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH v2 08/14] x86/retpoline: Create a retpoline thunk array
Message-ID: <20211020194352.7id6nkvtpenmt3p2@treble>
References: <20211020104442.021802560@infradead.org>
 <20211020105842.981215247@infradead.org>
 <20211020155750.3u74bkcp66leeyed@treble>
 <f33b9c4e-08c1-f88d-4873-82050a944010@citrix.com>
 <20211020170956.g67xcsvvdkuqg3qa@treble>
 <20211020192229.GP174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211020192229.GP174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 09:22:29PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 20, 2021 at 10:09:56AM -0700, Josh Poimboeuf wrote:
> > On Wed, Oct 20, 2021 at 05:46:39PM +0100, Andrew Cooper wrote:
> > > On 20/10/2021 16:57, Josh Poimboeuf wrote:
> > > > On Wed, Oct 20, 2021 at 12:44:50PM +0200, Peter Zijlstra wrote:
> > > >> Stick all the retpolines in a single symbol and have the individual
> > > >> thunks as inner labels, this should guarantee thunk order and layout.
> > > > How so?
> > > >
> > > > Just wondering what the purpose of the array is.  It doesn't seem to be
> > > > referenced anywhere.
> > > 
> > > The array property is what makes:
> > > 
> > > > +	reg = (target - &__x86_indirect_thunk_rax) /
> > > > +	      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);
> > > 
> > > safe in the next path.
> > 
> > The thunks were already 32-byte aligned.  I don't see how slapping a few
> > unused symbols around them does anything.
> 
> Previously there were 16 (or rather 15 without rsp) separate symbols and
> a toolchain might reasonably expect it could displace them however it
> liked, with disregard for the relative position.
> 
> However, now they're part of a larger symbol. Any change to their
> relative position would disrupt this larger _array symbol and thus not
> be sound.
> 
> This is I think the same reasoning used for data symbols. On their own
> there is no guarantee about their relative position wrt to one aonther,
> but we're still able to do arrays because an array as a whole is a
> single larger symbol.

Makes sense, I think (and good fodder for the commit log).

-- 
Josh

