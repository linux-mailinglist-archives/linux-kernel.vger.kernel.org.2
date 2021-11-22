Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C344590F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 16:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbhKVPMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 10:12:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55390 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239609AbhKVPMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637593749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6FKvlRZrt4m5mC/c2VxqmjglipRP1IiZmDEAqO2Wrw=;
        b=Tv9YJJV2cZQywzSfMKOAQukKk64uiqUX/h4R9M6e0Ms3WA2rJL8c5tycDs+8EJ2gvPpZv/
        o0XWycrxyeiG/gZ+FnSnUTzdf1C8lpqAZ2A2XbNfS8UZtm59fWEBXplCtSiz0zszC6Xucv
        F6WzOpa49Fk4H+KsyavuiV6Z/QLZTNw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-1qycwTnDOSqn0tBWR871lw-1; Mon, 22 Nov 2021 10:09:08 -0500
X-MC-Unique: 1qycwTnDOSqn0tBWR871lw-1
Received: by mail-qk1-f199.google.com with SMTP id p18-20020a05620a057200b00467bc32b45aso15100480qkp.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 07:09:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=x6FKvlRZrt4m5mC/c2VxqmjglipRP1IiZmDEAqO2Wrw=;
        b=DsncZmLbRqZjSCL2yL7ZaVQoI3UXC7HjMPlrt1FxUcMvsQZI9W9dIG69y34CTCCDHZ
         NnUNPMBF5ecT8mizcv6+TnwDNpek9udiNT7SEBHyzYZNIg7K7TmF3EV1bxgRbIYYUh9s
         hrRsak2ML5Zx9mj0mYmnLWXVQ4mmdyEb0To1ezaooLaGkR4y4/2fLwWmx6VNIpDpUYzN
         pUW34KLrmAPJVwOP81q2URVbZyG+ebfvqMNvai3dwqXbvmWfELsTRUt9d16Pkc/PPfI6
         w1BoXtKMLz0lB0uvo1iGqSO9cv+c3457Palho0xjI32bVjhO0x3ccFx1mlEY2gi78ysL
         h1XA==
X-Gm-Message-State: AOAM533NQb3ypQh9E6AVSTQ7yauXCKk/qyB+3hb7g9++MU/J+W3Lk+Qm
        6UqjN9mlcciW88ItxSpNVXQUOQMN3PZbiYa1XpbYB0iwYhDbFmh/SdMYpKOgmeyqwMJj2Gs7tgm
        GLFqD2IgrKhf7Vx6pFk07Q1q5
X-Received: by 2002:ac8:7d09:: with SMTP id g9mr31906472qtb.179.1637593747399;
        Mon, 22 Nov 2021 07:09:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbZVVq9tqUsY/mwtqtd3tKobzHPLElrLwYu91NlYg9m6H6Npakdn38yAM5k07w9Xe3N4TUzA==
X-Received: by 2002:ac8:7d09:: with SMTP id g9mr31906441qtb.179.1637593747162;
        Mon, 22 Nov 2021 07:09:07 -0800 (PST)
Received: from m8.users.ipa.redhat.com (cpe-158-222-141-151.nyc.res.rr.com. [158.222.141.151])
        by smtp.gmail.com with ESMTPSA id v16sm4407640qkj.93.2021.11.22.07.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 07:09:06 -0800 (PST)
Message-ID: <afdf9c4a4005f6aeaded9e976c48160933f3c447.camel@redhat.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
From:   Simo Sorce <simo@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephan Mueller <smueller@chronox.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, Tso Ted <tytso@mit.edu>,
        linux-crypto@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
Date:   Mon, 22 Nov 2021 10:09:05 -0500
In-Reply-To: <YZs+5ZGc1G5O3vF5@kroah.com>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
         <2560758.ogP2UNPRoF@tauon.chronox.de> <YZsyZua9T8DD6JF5@kroah.com>
         <11035663.0FQYWtqqoJ@tauon.chronox.de> <YZs+5ZGc1G5O3vF5@kroah.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-22 at 07:55 +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 22, 2021 at 07:42:02AM +0100, Stephan Mueller wrote:
> > Am Montag, 22. November 2021, 07:02:14 CET schrieb Greg Kroah-Hartman:
> > 
> > Hi Greg,
> > 
> > > On Mon, Nov 22, 2021 at 06:34:43AM +0100, Stephan Mueller wrote:
> > > > Am Sonntag, 21. November 2021, 23:42:33 CET schrieb Jason A. Donenfeld:
> > > > 
> > > > Hi Jason,
> > > > 
> > > > > Hi Stephan,
> > > > > 
> > > > > You've posted it again, and yet I still believe this is not the
> > > > > correct design or direction. I do not think the explicit goal of
> > > > > extended configurability ("flexibility") or the explicit goal of being
> > > > > FIPS compatible represent good directions, and I think this introduces
> > > > > new problems rather than solving any existing ones.
> > > > 
> > > > The members from the Linux distributions that are on copy on this may tell
> > > > you a different story. They all developed their own downstream patches to
> > > > somehow add the flexibility that is needed for them. So, we have a great
> > > > deal of fragmentation at the resting-foundation of Linux cryptography.
> > > 
> > > What distros specifically have patches in their kernels that do
> > > different things to the random code path?  Do you have pointers to those
> > > patches anywhere?  Why have the distros not submitted their changes
> > > upstream?
> > 
> > I will leave the representatives from the distros to chime in and point to 
> > these patches.
> 
> Then why not work with the distros to get these changes merged into the
> kernel tree?  They know that keeping things out-of-the-tree costs them
> time and money, so why are they keeping them there?

I can speak for my distro.
We have not proposed them because they are hacks, we know they are
hacks, and we know they are not the long term solution.
Yet we have no better way (in our products, today) so far to deal with
these issues because what is needed is an effort like LRNG (does not
have to be this specific implementation), because hacks will not cut it
in the long term.

> I recommend getting the distros to chime in on what their requirements
> are for the random code would probably be best as they are the ones that
> take on the "random fips requirement of the day" more than anyone else.

Greg,
I think you can takes Stephan's introduction and supporting material
from this patchset to see what are the requirements. These patches have
not been maturing in a void, but Stephan basically distilled
discussions between multiple vendors as well as regulatory bodies (as
you can see he has reviews from BSI and NIST requirements are also
fully represented here).

He addressed a few aspects I can mention but are not the only ones:
performance (esp on NUMA systems), not blocking at boot due to lack of
entropy, NIST/BSI conformance, flexibility so that future regulatory
requirements can be easily integrated and upstreamed.


> > Yet, these changes are commonly a band-aid only that have some additional 
> > drawbacks. Bottom line, there is no appropriate way with the current code to 
> > allow vendors what they want to achieve. One hint to what changes vendors are 
> > attempting can be found in [1] slide 20.
> 
> What exactly do vendors "want to achieve"?  Where are they saying this?
> 
> > [1] https://www.chronox.de/lrng/doc/lrng_presentation_v43.pdf
> 
> I see nothing on that slide that mentions actual requirements other than
> "the current code does not match this random government regulation".
> 
> Please provide valid reasons, from distros.
> 

Please let me know in what format you want to see these requirements,
and I will work with other to provide them.

Simo.


> thanks,
> 
> greg k-h
> 

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




