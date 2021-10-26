Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC9343BC52
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 23:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbhJZVZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 17:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbhJZVZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:25:32 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C63C061570;
        Tue, 26 Oct 2021 14:23:08 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n67so1050377iod.9;
        Tue, 26 Oct 2021 14:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GuopS/a00IpLOIPNe2GKE1DFE1mO+ey9OPeZTHiR3zg=;
        b=HGvA4MzKTjZL/5S/Ax9qmsmJ1yjWqvdcyb5dCy5ejqiJpxupo/WzagOc9/Qn5BdXpG
         MhBA9V6ldCmU3o9eBRyuo//QvHPpfsPHsM7S5LSiQaAerg9m5eH4DejYfFtyzhWjolA8
         rxm0tVJaIBKBVcp7VUnWEJ/VW447UiwqNxWpwpWp26vQx/vjbNIqj6PtHSOj/IycVXHw
         O4bevGuGznrczJl5p7SG4kyN/RCpeECGvcDccz72itvei+Ww4M63qK8Teil2cz/l2QJd
         3ybXpgT4TCFHlfJQ7WQmWtghVgUVQVndGMSIou88F/Sra69Yhv44iff1paDnpXJBBMxh
         cy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GuopS/a00IpLOIPNe2GKE1DFE1mO+ey9OPeZTHiR3zg=;
        b=cSclCE/ENNtzAp12PQg3HkHWWHgAVgol7sKmUnEPQjc/akK3+tmnnMjYC2K1GHHPvA
         bRLGMP3hFOfpamhTzroCYwDy54iS9dV0RzgJ2xoPtTReUQPZor5o4h3PvAZ9urgOWJsK
         kXQmWKmi5DbBHfQUB3Aw61SN3VV+lz/qQlauVX5OCVvfnW4rwCdmhmrtvTUHaZr5Wruw
         oGEYIFkJGshuBXuDFbWYiHSkBIwlMAQuQHZjSm16hOuolvBnnNZ9AhbZwC1PA6Vi12Zo
         WIydHpCiFNBNiYPxWugFMi7FcwsbV45aGEcS5nUPnYUN8qV/QeRIIfQFv4mUFlI1paY3
         lYkA==
X-Gm-Message-State: AOAM533OZCRkW9Ab9lPim03xMw0ib0+Txr9C80UI6dlUEx0bDHtXv1DC
        cwrJFV7vXCFYz5CQkpHiTwc=
X-Google-Smtp-Source: ABdhPJzqzsY2gK2GmXc9n5IETpAcUQzxLrDimx7RS3PPSC8eh7v8wHnMlcd3ums7sbtxAAmvMw262A==
X-Received: by 2002:a05:6602:2d13:: with SMTP id c19mr17058694iow.199.1635283388054;
        Tue, 26 Oct 2021 14:23:08 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id s7sm11979875iow.31.2021.10.26.14.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:23:07 -0700 (PDT)
Date:   Tue, 26 Oct 2021 17:23:05 -0400
From:   Trevor Woerner <twoerner@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Joe Perches <joe@perches.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] coding-style.rst: trivial: fix location of driver model
 macros
Message-ID: <20211026212305.GB6830@localhost>
References: <20210423184012.39300-1-twoerner@gmail.com>
 <CANiq72mUBh+76iy5uCAGHpKHDnTGRVyQduMngEWDMCF6kRySJA@mail.gmail.com>
 <CAHUNapQfFBcqrX7MvUvq8qbPgk2bPu-h3+9NxAUFpRtpOGFODw@mail.gmail.com>
 <87a6ivg5ex.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a6ivg5ex.fsf@meer.lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-10-26 @ 09:41:10 AM, Jonathan Corbet wrote:
> Trevor Woerner <twoerner@gmail.com> writes:
> 
> > ping?
> >
> > It doesn't look like this was picked up by trivial? Although, it doesn't
> > look like git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git
> > has been used in a while. Is there an alternate (preferred) path for
> > trivial patches?
> 
> Hmm...no idea why I missed it the first time around.  Applied now,

Maybe because I added you in the CC instead of TO? Sorry about that. Anyway,
that's cleaned up now (thanks to Joe's scripts).

> Applied now,
> apologies for the delay.

Thanks!
