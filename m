Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FF33C6CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 11:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbhGMJNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 05:13:44 -0400
Received: from mx.ungleich.ch ([185.203.112.16]:46610 "EHLO smtp.ungleich.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234702AbhGMJNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 05:13:41 -0400
Received: from nb3.localdomain (localhost [IPv6:::1])
        by smtp.ungleich.ch (Postfix) with ESMTP id 7B4561FE49;
        Tue, 13 Jul 2021 11:10:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ungleich.ch; s=mail;
        t=1626167446; bh=sj+8AfqXxmO5yIytfx3JedpkU6nycxD2GiwxOs6smQQ=;
        h=References:From:To:Cc:Subject:In-reply-to:Date:From;
        b=NE+4V1o/Gy3GeTRvM2MMuUpHrFU6+xcmUN/CW8oX4wFKc2tbR68EpHgD4aSbop5gl
         ukdmVxN2OVhUKARmE9dVfyn1mcqiuBSAg2ZBeqQ0fxLfvfWmGY/VwqiOt0Hk/UOVXc
         MdhtnhlA18X4QszY+YFJl/yPWF9sy1Xm+IIoaA47+STk/3byTv8xnE8IfCeBkPLY+4
         iH5Kbo8H5NC1wwUYvG8i6nzUYDUb7bzLN2QKq3RIM/yyfupTB9P7SfQ+NbMZUt+Wod
         MGnPr/nVQp8kW/x3g5SmtVAXl37ZRytefIVKOXr0NE6e+vQc/6L9FTlnKn1KYMye20
         Ne/ixfweuzNqw==
Received: by nb3.localdomain (Postfix, from userid 1000)
        id 98E6014C0431; Tue, 13 Jul 2021 11:11:33 +0200 (CEST)
References: <alpine.LRH.2.02.2107120957300.14207@file01.intranet.prod.int.rdu2.redhat.com>
 <YOyGrUvA4LjydcP3@kroah.com>
 <alpine.LRH.2.02.2107121502380.8445@file01.intranet.prod.int.rdu2.redhat.com>
 <YOyVH3qD9O3qsNUL@kroah.com>
 <alpine.LRH.2.02.2107121528270.11724@file01.intranet.prod.int.rdu2.redhat.com>
 <87tukzgrkg.fsf@ungleich.ch>
 <alpine.LRH.2.02.2107130454430.3795@file01.intranet.prod.int.rdu2.redhat.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Nico Schottelius <nico.schottelius@ungleich.ch>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Nico Schottelius <nico-linuxsetlocalversion@schottelius.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scripts/setlocalversion: fix a bug when LOCALVERSION
 is empty
In-reply-to: <alpine.LRH.2.02.2107130454430.3795@file01.intranet.prod.int.rdu2.redhat.com>
Date:   Tue, 13 Jul 2021 11:11:33 +0200
Message-ID: <87r1g2h92y.fsf@ungleich.ch>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Mikulas Patocka <mpatocka@redhat.com> writes:
> I set LOCALVERSION to an empty string (with "export LOCALVERSION="). This
> prevented the kernel from adding a "+" sign to the kernel version. Since
> the commit 042da426f8eb, it no longer works and the kernel adds a "+" sign
> if LOCALVERSION is set and empty.
>
> If you don't like "if [ "${LOCALVERSION+set}" != "set" ]", then please
> provide some other way how to test if the variable is set.

I fail to see the problem you are solving, as that case works exactly
like I wrote in my last mail:

[11:09:03] nb3:~$ export LOCALVERSION=; [ -z "${LOCALVERSION}" ] && echo unset
unset
[11:09:27] nb3:~$ echo $BASH_VERSION
5.1.8(1)-release

Did you try that in your environment?


--
Sustainable and modern Infrastructures by ungleich.ch
