Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D448B3EC937
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 15:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbhHONEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 09:04:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:44263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235540AbhHONEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 09:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629032616;
        bh=nDBvIVcTGEEglcl8qJRL54FMpJmSkZMNNPSxNjHoks0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=E2DxYj/xc9M7vgSZSZcXstyx/Cf3aB9bveGfA5NaErNU2Ww+XKg9XdyuIiVO4tEU3
         5t5sPsEFO17JRbCeVqc7Lu5GKjMYfU/sYnuGElthYPOajOSvnVnBqLwOKSmJ3JHGs+
         GuXTcUXCmCdQY7kr4/pmjGaNOVqXdBI95wb4jbfk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.48.238]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9X9-1mNoVN15Kz-0095Zd; Sun, 15
 Aug 2021 15:03:36 +0200
Message-ID: <7ad059482e56e88bfbe13830cfa06dffee9d071f.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.14-rc5-rt8
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Clark Williams <williams@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Date:   Sun, 15 Aug 2021 15:03:35 +0200
In-Reply-To: <c92fc2cb-03cd-d6a2-fb4a-7bc33e94e391@suse.cz>
References: <20210810163731.2qvfuhenolq2gdlv@linutronix.de>
         <20210812151803.52f84aaf@theseus.lan>
         <5f0c793d-5084-4607-8475-209fa7310ba2@suse.cz>
         <20210812162448.26274298@theseus.lan>
         <bb98b54c-6d88-2a56-4998-51a304c19e8c@suse.cz>
         <20210812164440.0426d8b7@theseus.lan>
         <96ceab8e-4bf9-147a-e931-848676003c3f@suse.cz>
         <5dbf6cf9e82ef15ce0febf070608da2d5b128763.camel@gmx.de>
         <c92fc2cb-03cd-d6a2-fb4a-7bc33e94e391@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aVzwj+nSWqOJH4r4cbOSgXuNepnwo2OErAwZJY+5a48pTOOUu1m
 QGVbrBHx5Ik2+hgrXbZcsi7muNMh4NwrgDrpBvsB9YYbUfmGD/72JKJAyKJVIaV43eOpR88
 9RocKTO1sUGCHERAfobK1iy1q9quwDy7CGRNDLNgSSHe61DJoIN0E+ORaF7o1OnFV5i8dn/
 1zc0Pk2Y3ceCjj14mVmmA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9uHtR7yuSuc=:/9g06wZwyujvjVpilcGuCS
 Y8ag9TB8gL5eMROe9OwEb67ArtwGv4+Vr2EOFJf5ne34jtVCtIVJsNsVsGrAONbpvW4OHyolM
 hk8yYfR9lP3zx4ZaD04MvPcvQvkNMg9ylTyRV2+N2wads4X9efcxe3nmhLs8x7xCLm9xzYvVd
 KDOpE35Dvp5FPt3W6cr15otkzqn1Nt0Ss5zNj4y5GOQPGoiny6VmLEGWt3xZC8GmgyXlA93M2
 gWTrtocrT3bSX0tlEWFTtwIexy1KJfh8uaiLJNUgpbTLPJZ2tgjiTIRP7To20w3DOEDW5JDOf
 or+yU/Zmog4KxPeovATfDuHvtNJqlQ7bWpx9bDID/bpVVFCTg6jpRtAEYEeblNUCwvxhPL+2k
 i7IOsQm0fOgFABoFqvHBJPwFDDNs+eCFU3Y87XrTc7afLqlbrhwBJsTUFHOR/LL6kDWU5IQj0
 niCHVJwgUIYCdtFA3n00PecP+H1j/x8X9aafmu3mPETAKCjLYry67Et79m2Qpt/ucnZouTVdq
 tnoZARoP02zYP3MP/1nBZaQA6bN/d8E6AP3890RFm1qQ+4alliT7gK0AXhzaR4ANRBXU1hEGX
 DczOCPt/CNiXvX08+4FZgKS8ugN+hAjV2jrHhySaqAHoCwBSLjTsnWIsgBGHDFBPvuubNlSmg
 InNRG9YnULpumhMpXC9YQ2UstOo3y4MJpIwDFIspNcJl32zd0vSkifs+aIkXcF/K1FXvSq6vn
 S+ovcg4Cx39qrLlxjox1Laz67C1WfLYlK6MQOW+RWFfSsyttywrheDLw0RSVhfbZSSZNXJkc5
 Z135ZsczMA7BItVRayY4ZfUMYYKkQpn3XC6/vOKcTz1EGmwIkxYAvrndBnOCVIvM82bSFIz/m
 nt5Rdh4OLId1ArK/CtheDKwZdfEYtgBZqQX9BESD3UMSYIheqAYHtR4Pdq6gWBuLnGs7gls70
 URPdEc6cpil7JbZzHJWsmd05wj82+Pg2tJIl1DO8AcYorIuOFz0LzK6nomlm1Mo3TYaXfpoZE
 Et76f4j863fOOSN/mJhjcxxSgK0PKaHdBSzaVu5p5XPWYubvg1NgF2wSgxblfJAUc/v5QY0K1
 uDyyeTPLdnspk12I+3SW5KiCuV+xgyuR/uW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-08-15 at 11:35 +0200, Vlastimil Babka wrote:
> On 8/15/21 6:17 AM, Mike Galbraith wrote:
> > On Sat, 2021-08-14 at 21:08 +0200, Vlastimil Babka wrote:
> > >
> > > Aha! That's helpful. Hopefully it's just a small issue where we
> > > opportunistically test flags on a page that's protected by the local
> > > lock we didn't take yet, and I didn't realize there's the VM_BUG_ON
> > > which can trigger if our page went away (which we would have realize=
d
> > > after taking the lock).
> >
> > Speaking of optimistic peeking perhaps going badly, why is the below
> > not true?=C2=A0 There's protection against ->partial going disappearin=
g
> > during a preemption... but can't it just as easily appear, so where is
> > that protection?
>
> If it appears, it appears, we don't care, we just leave it there and
> won't use it.
>
> > If the other side of that window is safe, it could use a comment so
> > dummies reading this code don't end up asking mm folks why the heck
> > they don't just take the darn lock and be done with it instead of tap
> > dancing all around thething :)
>
> Well, with your patch, ->partial might appear just after the unlock, so
> does that really change anything?

Viewed from pov consumption is optional, it makes sense.

	-Mike



