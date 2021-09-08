Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17D6403A8C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348588AbhIHNYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:24:53 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:50160 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbhIHNYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:24:52 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNxTh-002IXA-72; Wed, 08 Sep 2021 13:19:01 +0000
Date:   Wed, 8 Sep 2021 13:19:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Martin Sebor <msebor@gcc.gnu.org>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
Message-ID: <YTi4RdEFfa7m/ufD@zeniv-ca.linux.org.uk>
References: <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net>
 <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210906234921.GA1394069@roeck-us.net>
 <20210908042838.GA2585993@roeck-us.net>
 <YThAgIhKPQZq5UZn@zeniv-ca.linux.org.uk>
 <f4817c3d-c051-4030-e9ca-ea8b3f846119@roeck-us.net>
 <CAMuHMdWhzL+aWosce71Xm-7dKsgXFyL42tQ2gV2HyEZp5r0N7A@mail.gmail.com>
 <CAK8P3a3yJHvJaFHUh2+5GPm2n_g9gSfX2rFbrSLzDt6yC4eDog@mail.gmail.com>
 <23b3a9ab-7205-9f4e-9425-17506aec3170@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23b3a9ab-7205-9f4e-9425-17506aec3170@roeck-us.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 05:42:30AM -0700, Guenter Roeck wrote:

> Oddly enough, a memcpy on the 'rtc' variable doesn't fail,
> neither with nor without volatile. Something else is going on.

While we are at it, would memcpy_fromio() complain?  Seeing that
this is what's really intended there...
