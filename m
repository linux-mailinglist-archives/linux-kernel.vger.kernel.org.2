Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1100745663C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 00:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhKRXLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 18:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhKRXLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 18:11:30 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F4DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 15:08:29 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id r26so17777296oiw.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 15:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pmCu9COc1pWaYRUVj52qJ3fL6u90fsV4q8bFRcC0CE4=;
        b=LGy5ljPFT5L6X3AraG7oxFPAZC7+PhKyE4d+l67ld6wBZ6fUxye4MFWSwBQYAjVBki
         PJVHyLdrtienL7hcilNDEBSjWAej1HqgBEuDa+XXvT4FQzd51uNCke0X1xAoB4q7s2Tc
         RiXHmpFeBV9mJYtmlpuJoQmyoSeGpnrlduYlRSw3reKFoGKGKA6aDlnJBTkXfv7Erfu+
         T8UbmO6EaoLRVwvl+278FgITNN76UMZ56v8wYv4zuLSGS6a5wi6/RGuG3Xd8tppTAgdC
         3sHB88LkV4lcSG0xRz0ukAE5UvrZ1slOffilL9+h/+fhSNi3hdYO3dr4fiULHxBQ0oez
         7HOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pmCu9COc1pWaYRUVj52qJ3fL6u90fsV4q8bFRcC0CE4=;
        b=UJzC4o382alfavHM2+sYbZSlvNpv6vavviNXME5TmtQ3K31Z/sl1dDkLZwpaPb4cik
         RRY0QMwsc/2rm6TfoRRLXVrkiJRCu1aMVes0IN8TYLF0jRHJ0uQiPgWXou26LAfVYd7o
         YxaYN/LlvwSJZd2GrO39OC4Smh19p0jqUEr/HMY3LR7AiCX10b+pPC7AQkLn0QHdnH1q
         7WXfQ/1NJN8b/jPkxpStPDSAP6wVJ8CdtmaYZ1RjubR+Rqf3TDqrd6zI39UWArnbJc8C
         RHTkhFrgqp9ADhhZlCYz/jDjxTRBcGLPl78KqnuJrMMAhzs4N/qlW6f3D5GoyTtkVcdK
         OAxw==
X-Gm-Message-State: AOAM53396rKnNNcMFJH4WiQ7nM3TQX4pOieg+gLQXMKOYyS405kwdqKV
        Z2hSgQYJ2gl9jylnwfvigx0m2Pdm8tI=
X-Google-Smtp-Source: ABdhPJy8D9/79xRpKX9aS7CibK+UdACaHPV8juKUjfXDtID186geF/p9qhOWZK9TQvgA0VgT4nsN8A==
X-Received: by 2002:a05:6808:2181:: with SMTP id be1mr606253oib.147.1637276909061;
        Thu, 18 Nov 2021 15:08:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bi20sm297318oib.29.2021.11.18.15.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 15:08:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Nov 2021 15:08:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: Linux 5.16-rc1
Message-ID: <20211118230826.GA3427600@roeck-us.net>
References: <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
 <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net>
 <87a6i4miwu.fsf@mpe.ellerman.id.au>
 <CAMuHMdVrpQJKKzpxrKKCCD_2+DzAvgFW+jsjPdR9JhBYeRgvNw@mail.gmail.com>
 <8D79B547-D606-4975-A79A-AEA65684F3A0@tuxera.com>
 <CAHk-=wgvzH=BaFg+kiWk1DXGLNELSmPS2VWcgSSmW5Y6vz-v_A@mail.gmail.com>
 <E1EED1BE-A0F0-4EFA-86A6-CF721E194CDC@tuxera.com>
 <CAHk-=wjoQYuOfhsiPXUvFbUbSd5iHmmoRHMP+zv+bzHKkWqAyA@mail.gmail.com>
 <20211118212349.GA3424901@roeck-us.net>
 <CAHk-=wiNX2vr4JA=d5xr_2iwp+vSD62rze3gsxh5NwbiRuKbQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiNX2vr4JA=d5xr_2iwp+vSD62rze3gsxh5NwbiRuKbQQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 02:34:51PM -0800, Linus Torvalds wrote:
> On Thu, Nov 18, 2021 at 1:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Like this ?
> 
> Ugh. Yes. Like that.
> 
> But now I have to go dig my eyes out with a rusty spoon and try to
> forget I ever saw that thing.
> 
> Because a thing of beauty it ain't.
> 
Hah.

> I would still hope somebody comes up with something prettier.
> 

It doesn't really have to be that fancy, but I suspect we'll end up
with something along that line. Kconfig doesn't support arithmetik,
so

config PAGE_SIZE
	int
	default 1 << PAGE_SHIFT

doesn't work, requiring the complex defaults.

Also,

	depends on !PAGE_SIZE || PAGE_SIZE < xxx

doesn't work either, making something like HAVE_PAGE_SIZE mandatory
unless PAGE_SIZE is made available for all architectures, which seems
excessive.

Of course,
	depends on !PPC
would be the simple solution.

Guenter
