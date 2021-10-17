Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6226D4308B5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245668AbhJQMgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:36:09 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:15111
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242197AbhJQMgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:36:09 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Adpz58asSHLVfAgw7szFQVONF7skD7NV00zEX?=
 =?us-ascii?q?/kB9WHVpm6yj+vxG+85rrSMc6QxhIU3J+7i7VpVoJEm8yXcb2+ks1NuZLWrbUQ?=
 =?us-ascii?q?iTXedfBOnZslnd8kTFn4Y3v8sOT0EUMqyUMbEVt7eZ3OD1KadG/DHAmprY/9s3?=
 =?us-ascii?q?qB1WPHpXgy4M1XYIe3WmO3wzYhJHC94YLfOnl7V6jgvlQG8QaMujAHkDQqzsm/?=
 =?us-ascii?q?3n/aiWHSIuNlof8w+Jgiqv6LnmVz6i/jlbfQ9u7N4ZgBX4eyqQ3NTTjxh+8G6j?=
 =?us-ascii?q?61Pu?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="396163947"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 14:33:57 +0200
Date:   Sun, 17 Oct 2021 14:33:57 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Stefan Wahren <stefan.wahren@i2se.com>
cc:     Kushal-kothari <kushalkothari285@gmail.com>,
        linux-arm-kernel@lists.infradead.org, mike.rapoport@gmail.com,
        kushalkothari2850@gmail.com, outreachy-kernel@googlegroups.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, nsaenz@kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2] staging: vc04_services: replace msleep() by
 usleep_range()
In-Reply-To: <83076fd7-3183-5665-a9df-63a0b7e13c3f@i2se.com>
Message-ID: <alpine.DEB.2.22.394.2110171433141.3026@hadrien>
References: <20211017092900.134752-1-kushalkothari285@gmail.com> <83076fd7-3183-5665-a9df-63a0b7e13c3f@i2se.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Oct 2021, Stefan Wahren wrote:

> Hi,
>
> Am 17.10.21 um 11:29 schrieb Kushal-kothari:
> > Fixed the warning:-msleep < 20ms can sleep for up to 20ms by replacing
> > msleep(unsigned long msecs) by usleep_range(unsigned long min, unsigned long max)
> > in usecs as msleep(1ms~20ms) can sleep for upto 20 ms.
> >
> > Signed-off-by: Kushal-kothari <kushalkothari285@gmail.com>
> > ---
> >
> > Changes from v1: Reword both the subject and the log message.
> >
> >  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > index 6fbafdfe340f..80a7898c5331 100644
> > --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > @@ -857,7 +857,7 @@ vchiq_bulk_transmit(unsigned int handle, const void *data, unsigned int size,
> >  		if (status != VCHIQ_RETRY)
> >  			break;
> >
> > -		msleep(1);
> > +		usleep_range(1000, 2000);
>
> there was a recent discussion about this checkpatch warning [1]

Should there be a comment about it?

julia

>
> Best regards
>
> [1]
> https://lore.kernel.org/linux-staging/260b38b8-6f3f-f6cc-0388-09a269ead507@i2se.com/
>
>
