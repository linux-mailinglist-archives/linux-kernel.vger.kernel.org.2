Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384ED44F0C0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 03:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhKMCQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 21:16:58 -0500
Received: from mout.gmx.net ([212.227.15.19]:59817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231618AbhKMCQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 21:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636769622;
        bh=TF1auNeXyQ/vVgA7rEfAoHjYQOhBDApJJemihsdWRsA=;
        h=X-UI-Sender-Class:From:To:CC:In-reply-to:Subject:Reply-to:
         References:Date;
        b=gbWWj1Wv538147jpKCJFlzBRkG1pi0pEJz142PLw7ad89iZMPo9dYWZR1sLYRdnmr
         CYpWGK55nmacWZ0/uXe0RrRq2pLlAllrQvsOPI7tk8PWdFOQllQigQNyKn6wQo8Em4
         Ejme7ixnI2SPMcsmIs1ccwBn7ExCtRiMrZWDlwmM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from corona.crabdance.com ([173.228.106.131]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MMGRA-1n1jEJ2jyQ-00JGi1; Sat, 13 Nov 2021 03:13:42 +0100
Received: by corona.crabdance.com (Postfix, from userid 1000)
        id 3CA4527F135; Fri, 12 Nov 2021 18:13:30 -0800 (PST)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     richard@nod.at
CC:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        sschaeck@cisco.com
In-reply-to: <2065858791.38760.1635277003599.JavaMail.zimbra@nod.at> (message
        from Richard Weinberger on Tue, 26 Oct 2021 21:36:43 +0200 (CEST))
Subject: Re: [PATCH v2] ubifs: ubifs to export filesystem error counters
Content-Type: text/plain
Reply-to: schaecsn@gmx.net
References: <20211010042239.2888-1-schaecsn@gmx.net> <2065858791.38760.1635277003599.JavaMail.zimbra@nod.at>
Message-Id: <20211113021330.3CA4527F135@corona.crabdance.com>
Date:   Fri, 12 Nov 2021 18:13:30 -0800 (PST)
X-Provags-ID: V03:K1:0qd41HjEcZBd+PnmoOlKHviqrjoKVBOiTJOM5tu1C6jSGxVvuVM
 hP09SQmQPn8ylbGNGnaJhuLlTeBzBcRL8Uo87l+m1qp84IyKoNP+O4aXDaKkXKo2GYtCkt9
 jB6zm92RzsxKP1sNwxLZEcbs6Y/E64d6J85UvQLAa8nWNw+e4G1L2HHx8Z3L9oGmd69KVO3
 8TjzLbVQ9zDsqRmHxhpsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:crHexG1+UvI=:D5ZXXgwgUp4EnCGmUM+z68
 8jM72AIGxp0fIN/KH7Cb7IqCaaG15ogjdmXqGFScWB7f8jeRd9LY/yzbHfuKbmrB1EsQ/lzNF
 0JNHDR/VSmoIeNWQzCpE0TbOa90rdPICn1JCBrFzOj89dVGWJQvNO6IgPZEXermfr2ow5o/Rc
 dzkuJKxobEVjPWt/RGiE33LiB9NmD8vV7eWEGhHR5dSKxgZ0thOctG9/Pe6u1hJ+EfIaesEtx
 qZ7BkYXYHZ6CSFwG3gyYT0Ugy3ivzxS5Ry/BLv4++mTa1lHJE+PT8NRoQ4HeFXDPy5BbN+LyK
 wPikUyMW9ZMfCTgn6u1MKNQTbIw7i0OuL8uRYEKtDd0IhHQIY2pzRWz6LxOZDtHGt8bmPHF8v
 cuMIB5miaC+F6r9AWOaZj4SZPxrCVry2cvasD02dYtjT0HYh1ZptHcCirQMZsvcgtizmrh+hd
 unlH/pk2Mb2yPWiBtZ8+DSo4tphW6tW+Y/1BZ0VNZjLOFtEBk6lBU0u6PF0rjOe3ttRKECJ8O
 DYUz/i59k/klgwBeQenZXBgHMU22RocHAw+XJwT2LLYoYFA1YMzKvoN9FGFkMEhV3vBm8JYzB
 0F9dehOuIfD84ejjXqDtPh9puYO7lbQ2ldNOcBSuoa/6iJoSIDN/6LM/WQ4CJslruBgT9/Ps/
 PuGst14lSVCHpgXCG1ocFJ6sQi5N6TIFnvUJHOVeEeDLqlXtyicijxG7CWOu43hAr0RSLgE0A
 aS6bXJ4M5eh/lv1BVvAL2B8wrATNEnnhWtwwBVQza7iXtoKLegc0HTSsKI6sP4sDb1yl5DZTN
 dBj0RAc9Hp0TZmTulQD0aBMjkTTqvxfsJ57wnPHDEKNnXPHuk0Nj81jhVEMQNlzcP/fQcmi9G
 /ZvU+HIU9h4Oka11A+Yk7qrRSFAlg0upfdJm4txQ/klO/sVLKZujI1r9CHT1oH/6JI9umJ0t7
 rB52QESr6k2fswMID8qpfw6EjnRabGiD5SKHm51UMeSLxtKtIHFDb1XTQUY1VgR51Ffz7cGLv
 dcBNBQbbLCpqwLb9YVXFZztDIc+lopztYtOB49PxFWeGOCSjPZKIAFF4rR4QlTSmX1mumyE+c
 WJGMb/qqZnbItM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Richard,

> > Not all ubifs filesystem errors are propagated to userspace.
> >
> > Export bad magic, bad node and crc errors via sysfs. This allows users=
pace
> > to notice filesystem errors:
> >
> > /sys/fs/ubifs/ubiX_Y/errors_magic
> > /sys/fs/ubifs/ubiX_Y/errors_node
> > /sys/fs/ubifs/ubiX_Y/errors_crc
> >
> > The counters are reset to 0 with a remount.
> >
> > Signed-off-by: Stefan Schaeckeler <sschaeck@cisco.com>
> > ---
> > Changes in v2:
> >  - merged sysfs.h header into ubifs.h.
> >  - io.c: wrapped incrementing error counters into new functions
> >    record_*_error().
> >  - sysfs.c: removed sysfs write callback for clearing stats.
> >  - sysfs.c: ubifs_sysfs_register(): free c->stats on error.
> >  - sysfs.c: ubifs_attr_show(): use sysfs_emit().
> >
> > fs/ubifs/Makefile |   2 +-
> > fs/ubifs/io.c     |  21 +++++++
> > fs/ubifs/super.c  |  16 ++++-
> > fs/ubifs/sysfs.c  | 153 ++++++++++++++++++++++++++++++++++++++++++++++
> > fs/ubifs/ubifs.h  |  35 +++++++++++
> > 5 files changed, 225 insertions(+), 2 deletions(-)
> > create mode 100644 fs/ubifs/sysfs.c
>
> Queued for 5.16.

The merge window for 5.16 is about to close. May I point out that, as far =
as I
can tell, you have not sent a pull request for ubifs, yet.

 Stefan
