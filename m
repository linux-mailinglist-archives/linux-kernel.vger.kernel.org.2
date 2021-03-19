Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1974934231A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhCSRUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhCSRUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:20:19 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B4DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:20:18 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y1so12873603ljm.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BkRxICNeg5DYscXEGEcqd4ui8J4BudI3HPDlVjLS4/s=;
        b=guKEZmHG3VKWVbRkUkqS326KvwlSHdPvZzHa/1CkYDmr54RI3pXNEHVpEPJmaS3N3X
         /EqoPZGZMmv2p3unSm6MlDxz3VPHiDwoeGwoZtelQwb4N/q+by09AHLgY2aoyEtt8Far
         xcfp/7lRvIBDpORnuuQP/pZlLNDFxgj3WXCjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BkRxICNeg5DYscXEGEcqd4ui8J4BudI3HPDlVjLS4/s=;
        b=ALLbYRePzErNFmTNPXgjyFWGVfDTj1pXBOWTvyhoBaCccpAN5pFV8URn0phYbvL7e4
         uLEZnansA2oCqiWR2Qmj3PvZVyO12z5R1KY1ai6t9us/UVQQ0EPsB7jDUJusWK2u3RzZ
         eB3/rTuvfaOyARIeoyeklbavYBd3uCXlzhCEUYCQL1vmBE9d9+eHGqy0nvXnZJuxhINq
         3o/WuW7PcGZ0+AlFLRxi0o9WOoJ0Lbf5Fnvnr27Kwxt32q8LWTY4jwD4rI7WP1cUy7Dv
         Q2elLFnKThGMlsdYn5cASsBkUy3VYfJATCx8WorNrikgjYdC15AejZjzpykwiELghr5N
         g0CQ==
X-Gm-Message-State: AOAM5310ajbkGBzrwOAaxtBAFrv6pmT+F3LZhvNJWQQFymlkjZkC/jQP
        P8/YtbhcgQ1HTNanFzWy8C91rvy20Lf2Vg==
X-Google-Smtp-Source: ABdhPJybpQI8Ab731z6JvmYRHXmFP9oYK9Et54UFGxfsgftEog5/XbE/ASvEMOeFIPIrELM3XiOKMA==
X-Received: by 2002:a2e:85d5:: with SMTP id h21mr1586750ljj.20.1616174416850;
        Fri, 19 Mar 2021 10:20:16 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id f1sm854207ljk.126.2021.03.19.10.20.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 10:20:16 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id u4so12905998ljo.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:20:16 -0700 (PDT)
X-Received: by 2002:a05:6512:3ba9:: with SMTP id g41mr1318559lfv.421.1616174058718;
 Fri, 19 Mar 2021 10:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210319143452.25948-1-david@redhat.com>
In-Reply-To: <20210319143452.25948-1-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Mar 2021 10:14:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1HTbXkjdMYA4zADEiE8HwpZ0=uWy0ujZTJYVT-KCehQ@mail.gmail.com>
Message-ID: <CAHk-=wg1HTbXkjdMYA4zADEiE8HwpZ0=uWy0ujZTJYVT-KCehQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] drivers/char: remove /dev/kmem for good
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Chris Zankel <chris@zankel.net>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Hillf Danton <hdanton@sina.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jonas Bonn <jonas@southpole.se>,
        Jonathan Corbet <corbet@lwn.net>,
        Kairui Song <kasong@redhat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux API <linux-api@vger.kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Mackerras <paulus@samba.org>,
        "Pavel Machek (CIP)" <pavel@denx.de>, Pavel Machek <pavel@ucw.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Rich Felker <dalias@libc.org>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Theodore Dubois <tblodt@icloud.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        William Cohen <wcohen@redhat.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 7:35 AM David Hildenbrand <david@redhat.com> wrote:
>
> Let's start a discussion if /dev/kmem is worth keeping around and
> fixing/maintaining or if we should just remove it now for good.

I'll happily do this for the next merge window, but would really want
distros to confirm that they don't enable it.

I can confirm that it's certainly not enabled on any of the machines I
have, but..

             Linus
