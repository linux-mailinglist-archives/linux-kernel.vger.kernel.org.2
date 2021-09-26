Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D50418783
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 10:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhIZIqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 04:46:45 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:60653 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhIZIqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 04:46:43 -0400
Date:   Sun, 26 Sep 2021 08:44:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1632645904;
        bh=qMCepfy0EOxS5z5FPguGeC8cRl3hAlRCyYPW4sTI8do=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=DEH97cS7Z2pv9MgVRZy1o7uAVIQQiXIhe+fbaLjjfbfqDJui9Rawvg24C4LJ5/tJi
         xgHXwlfe0DMkCyS4a1j4yssRFKX/aleENjYmUxhDEbIq4+GU1E5/QT4qZKj2PYqj+8
         yTInJbFXfvIwgb8imkGZODrQ/BzkXdqc1wBNJ5fk=
To:     Aditya Garg <gargaditya08@live.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCH] Urgent bug fix causing Apple SSDs to not work.
Message-ID: <4dae80c3-034c-617b-c766-1858d6ee1220@protonmail.com>
In-Reply-To: <PNZPR01MB4415986CC44AACC100AD1189B8A69@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
References: <PNZPR01MB4415600ACD3C8D9944F15058B8A59@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM> <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com> <20210925195425.GB116968@dhcp-10-100-145-180.wdc.com> <7e75e292-3073-f1f9-287a-badf92c8e4e8@grimberg.me> <PNZPR01MB4415F5304CAA1A83442549DBB8A69@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM> <PNZPR01MB4415986CC44AACC100AD1189B8A69@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/9/21 18:07, Aditya Garg wrote:
> I checked out the proposal sent by Orlando Chamberlain to replace=20
> NVME_QUIRK_SHARED_TAGS , by NVME_QUIRK_SHARED_TAGS | given in the patch o=
n=20
> http://lists.infradead.org/pipermail/linux-nvme/2021-September/027665.htm=
l=20
> <http://lists.infradead.org/pipermail/linux-nvme/2021-September/027665.ht=
ml>.=20
> The , still causes panics to the T2 as described before. In the case of |=
, the=20
> kernel boots correctly without panicking the T2, but in case we are havin=
g Linux=20
> on an External Drive, which is my case, then the internal SSD doesn't see=
m to be=20
> recognised at all. I've tested the patch on 5.14.7. A screenshot of the G=
NOME=20
> Disks utility has been attached along with this mail.

I had some issues with the patch not applying automatically as I mixed up t=
abs and spaces,
(due to me copying stuff directly out of vim), so I had issues with getting=
 patches to apply
automatically. I've checked that this file https://github.com/Redecorating/=
mbp-16.1-linux-wifi/blob/anbox-bt/1001-apple-t2-disable-nvme-gen-counter-qu=
irk.patch
applies correctly for me (and github ci), so can you see if it still doesn'=
t work with that?

