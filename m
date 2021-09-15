Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3561040C74F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhIOOVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:21:24 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:35467 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbhIOOVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:21:19 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N8GIa-1mvZHz3iDo-014A92 for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021
 16:19:59 +0200
Received: by mail-wm1-f50.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so4951647wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:19:59 -0700 (PDT)
X-Gm-Message-State: AOAM532WhDXrhJnlYjjy10Z76RYCJ1M2em6pRUXiJLQ1D8R+O1lVlsnh
        pGO8VrQaEKHQ1j7Mpdic/3OVtaVqWagseskltBA=
X-Google-Smtp-Source: ABdhPJz8J4pJD+afwfweySjUuRBGa8LE2pnN/Ho6Oq2xiKUYXAx1VWdT2VBNYglVJPI9KXcGv93s3eNUwo2NtweqBfs=
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr4757847wmp.173.1631715599598;
 Wed, 15 Sep 2021 07:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210914213532.396654-1-gascoar@gmail.com> <260b38b8-6f3f-f6cc-0388-09a269ead507@i2se.com>
 <d09502f2-84d2-839f-1350-ae7f248e5981@raspberrypi.com>
In-Reply-To: <d09502f2-84d2-839f-1350-ae7f248e5981@raspberrypi.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Sep 2021 16:19:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3HGm1cPo4sW9fOY4E8AN8yAq3tevXxU5m8bmtmsU8WKw@mail.gmail.com>
Message-ID: <CAK8P3a3HGm1cPo4sW9fOY4E8AN8yAq3tevXxU5m8bmtmsU8WKw@mail.gmail.com>
Subject: Re: [PATCH 1/8] staging: vchiq_arm: replace sleep() with usleep_range()
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Gaston Gonzalez <gascoar@gmail.com>,
        linux-staging@lists.linux.dev, gregkh <gregkh@linuxfoundation.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>, ojaswin98@gmail.com,
        Amarjargal Gundjalam <amarjargal16@gmail.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:L+ofbII3p2/T/1lYlMroQOLAhrLlzjCQ9vxgucNQ/daKiibn5Ff
 Rq17qeNBi1eYmg00eBqWiyLZjR27MfQoAPQ12/jthth3wZtDEOZi71iCKZfEEnljpGOzwrp
 Z1zZv5XHGX63zB9UM+9xVHO78a1l1dVIqGAHv5rePc5pf4jR/HXBe2GGFX0De0is0szmaWQ
 I6LAP2osynLfUe3Ft15zw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:M+LpcZn8iiQ=:VcjfrkdrQEEq1KGbugyelZ
 bn9jKDL/zjtRs3VjKKgVpsLP7mDbFqGman2v7cKyc0HY9NVuy5KWStjN4C/EW0YSaWqN2uRED
 k8cmpvdbILdoBsa+DPybAeOIysNz0UddU9RRXkvoTYHIUhA5FEVoI0vQFqVe54Mlql9J/PYea
 k3shewmIJTTWa3z/M5+pE7Jsd2zwrqt8AtRWPuMIdYvA7/8X6b7AeOu18LWo0FWJWGraJ47o3
 E15kFWVCkaE17kl5qixaj5aMVdhbgLDcM49TS38N9qjnYbVXJ8WnbTwM/wFb+LuqXJXsoN+ZT
 LNHK1h37zxwyG79SAwYkjfIK9xU9U6vDiyyXl3b3Ye5sYZNrYHpuBkxfjScrz2fcNNN0tH6ca
 VzjXi6AauGelBzZLYZpFr6J2qjaMw24Xmyz5kVxlnT78p1xrmeBgrpNPeaFnjMMB3+nYBA3Ni
 PEGssxQWEbnqMAeZm+hgbfHpTGvCIRGDgKyXsWWrh0WwXZFhN//7FKKE5R9ftoEsYoIofkS+R
 htN0CtebhpyLxdi94ne+qk81raafzDZAw9POPMbhoR1xCGFVYRMEhUt52DdwIFwd4pSZa64H9
 w8cDT14XxTiqs1iGYBtNodfb/t6sI3nR5RccMhaWeeFjpQkjkBzbsS+rUHOdJgwduweQq+LQv
 zU/HVjNUUwCob8s7U/GR2/IgG+qmz5y6J+qZKOUUlGrA9PylQDUG3wa4F+jSvVrxjDBq+wFO9
 qyVz25191XpRsId3Tf0SO1HFs+xtWEdQ9Z2gPTIz6xRhkNEB+uyNobtohwYPMJ8duIL7fLqKv
 /N1e1j0a8o/JMPAp7QxDbwXU1esN0H4F/tdMKQ1tLOk54g6KApU8jmyM/WvGBEglHUCTehNIf
 uP8Ow1IuPpCmqiddlfyw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 10:06 AM Phil Elwell <phil@raspberrypi.com> wrote:
>
> Hi Stefan,
>
> On 15/09/2021 06:21, Stefan Wahren wrote:
> > Hi,
> >
> > Am 14.09.21 um 23:35 schrieb Gaston Gonzalez:
> >> usleep_range() should be used instead of sleep() when sleepings range
> >> from 10 us to 20 ms, [1].
> >>
> >> Reported by checkpatch.pl
> >>
> >> [1] Documentation/timers/timers-howto.txt
> >> ---
> >>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> >> index b25369a13452..0214ae37e01f 100644
> >> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> >> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> >> @@ -824,7 +824,7 @@ vchiq_bulk_transmit(unsigned int handle, const void *data, unsigned int size,
> >>              if (status != VCHIQ_RETRY)
> >>                      break;
> >>
> >> -            msleep(1);
> >> +            usleep_range(1000, 1100);
> >
> > from my understanding the usage of usleep_range() and hrtimers isn't
> > necessary here. The intention is to sleep a little bit and not "exactly"
> > 1 ms.
> >
> > @Phil Elwell: what is your opinion?
>
> Exactly - the aim is just to stop it spinning.

This is usually a sign for something else being wrong in the thing it's
waiting for. I can see multiple 'return VCHIQ_RETRY' statements in
vchiq_bulk_transfer(), however these all happen when the task
has received a signal and wait_for_completion_interruptible()
or mutex_lock_killable() has returned an error.

I don't see why one of them would return on any signal and the other
one only fatal signals, as you usually want those conditions to be the
same, but in either case, the loop is broken because as soon as
you get a signal, those interfaces will keep returning the same error
and you can never break out of the loop any more.

I don't know how to properly fix it, but it's clear that vchiq_bulk_transmit()
needs to propagate the -EINTR or -ERESTSTARTSYS back to user space
to let the calling task handle the signal before retrying.

        Arnd
