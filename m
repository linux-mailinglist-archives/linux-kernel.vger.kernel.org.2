Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E9145A12D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbhKWLVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:21:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:50475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233044AbhKWLVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637666282;
        bh=v9fmtfqFpWLetVfHAsYxm3tN/nAhvKj8KsPNVmOQsgU=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Txk3DquhW4wDaJLyYYY19AQSKjW74RgzDralL+1ZpBaJXJ6kbqevYBHApnfwrGJzq
         3949gHNDClGj72XV5Uc+Gb0DemhdvGwoqrVnUPESleytYJVGJ2uMVF0PmhEWP/k4Id
         oJNl5EJzNTuldgyOC1o6gph/QG89bSj67g7be7R8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.50]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QwW-1mfxIi1wne-011R5t; Tue, 23
 Nov 2021 12:18:02 +0100
Message-ID: <21c3489c7ce8342d392c08547a3222a9c289e9fc.camel@gmx.de>
Subject: Re: mm: LTP/memcg testcase regression induced by
 8cd7c588decf..66ce520bb7c2 series
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     lkml <linux-kernel@vger.kernel.org>
Date:   Tue, 23 Nov 2021 12:18:01 +0100
In-Reply-To: <20211123091304.GC3366@techsingularity.net>
References: <99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de>
         <20211123091304.GC3366@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XEFHFalrCVVntruBRqabWZ5cRGFKq4jgTybfHRi0bXDLoSBExSp
 bXowfG7wbd8KEdAmCEic5pQLV/5TmFSSuBbFN5HBCUudoHOH5rEiO1OO3PY+/n21EYDxLBH
 IJhqs+9rtHC8YPmy5eV4kbbnPoXAYHaXC5/dckmQM2Re9JUgxAAcwrhJBM/GKhe2pY39PLw
 UiA7UTUc1YaHRKbUegsYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZFfoiAEVQ+8=:Wz8gVMksgdJeoZIO5k7Ubj
 qq7r57a1XpetdjsvYFJMVh9SS2whbahRnhV3jojxHTgQynFjlkWqa1roHl5M3DqAUWHcyeOvq
 8ZXPXN1hw4TTWS8pWz7P+/3VvKOFGcT1CxDMarcHR48AQQ9BfvjwavklUrf/DAEJw9eLqDF4f
 Qr/+7arkF+RBH+0biLUJOkn/j/h1Ey7y6IcA8wyk3pViITfIc47krXZucVoSRkwPVKirR2DOm
 Mp32hHtxXc6GmafQbLz30DnlYR+PAAboBzSvtcp9nNaQaZv+3vItc0d8o2v75DVwp6Risxe0T
 sZ3cmV6EkMEf1I3knd1VOiEKAZHjeacNZqjO0xj+otq/eu+5xg4PuskqRdfABhWdhV0LASBG1
 riPjqYzEvSoU/1cHWkhiAyJHj3CtTv3/VIzvPQi709fMdOKJynWizus/1jVrnnZ+eB2t8N2BL
 F9oWcFBvebsfPhZSX75imYQACOcoZ0PYBrfq0acr+8iu1eLrKln5cpuIRLo5xzWGBYXx/hs88
 OJ0JEi2s6TjMGo7arL6prby7FtDZKLRfkGiQ7d5DWL1fCR6t2M/ipNDFwzSPn374jygMGhUHJ
 4naNz81PyvHdTKPwQXqhdoJBuE0Oqlb+Xjif5o84pn9xjOSa/P5ApKJX1Zgt3kvgwL3cVoJiP
 CeZzingzc/pI0R/zlbDYlj1cHNLYG2YwfRSFZ2SyLIh7pKmc+xkdTBPsJ4+9f1UF/1FmhHKiX
 a/jHhVd6MFTGWt18LZfEcevWeL/PSyT7rW47d1CnoI3CNi0Rk4+EXfbJuOnx00ioGM738tVBG
 bCxZtNHpVRXfuaVh6N3REv44epaV+lzBWK12fP46dUeMioolT0CqaMYTmynGyp0A8+Cc9iqCP
 VH30NSwqq4Q6TjlLY7EXmKwxBQ36XR4rRQ8AkMBEectpKQpIoliW8RVUPV2mx3ADZjc4AueM9
 XshtTLYyZUxpClSApdbtm0SUoadqja+Bb+jZ6rNOKunRrLwtTsBcZGj1E0ZcpWh5ZhfuoPeun
 oh9tkI3A5rrwKNifH/Jnrm0zdQw1nutFhUXZAhSZmryrmSVY/ak10+aquND6dIpSWIBWe0tPF
 yznJ2heGF6BMfQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-23 at 09:13 +0000, Mel Gorman wrote:
>
> I'll see can I reproduce this...

You likely already know this, but just in case, just plunk the below
into $LTPROOT/runtest/foo, and $LTPROOT/runltp -f foo.

#DESCRIPTION:Resource Management testing
memcg_regression        memcg_regression_test.sh

	-Mike
