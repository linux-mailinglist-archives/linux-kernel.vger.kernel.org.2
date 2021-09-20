Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE0741289A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 23:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhITWBT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Sep 2021 18:01:19 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:35604 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhITV7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 17:59:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 769BC6169BCC;
        Mon, 20 Sep 2021 23:57:50 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0AvcPrvAVW6r; Mon, 20 Sep 2021 23:57:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EDA726169BC6;
        Mon, 20 Sep 2021 23:57:49 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DNIdiH7vl84a; Mon, 20 Sep 2021 23:57:49 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C555E6108471;
        Mon, 20 Sep 2021 23:57:49 +0200 (CEST)
Date:   Mon, 20 Sep 2021 23:57:49 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     schaecsn@gmx.net
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <160773399.91203.1632175069460.JavaMail.zimbra@nod.at>
In-Reply-To: <20210920024824.9E053899858@corona.crabdance.com>
References: <20210907214034.11676-1-schaecsn@gmx.net> <20210920024824.9E053899858@corona.crabdance.com>
Subject: Re: [PATCH 0/1] ubifs: ubifs to export filesystem error counters
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF92 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: ubifs to export filesystem error counters
Thread-Index: NK3hz+wHsV+cRgdZv72uXipe7rZn/w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

----- Ursprüngliche Mail -----
> Von: "Stefan Schaeckeler" <schaecsn@gmx.net>
> An: "richard" <richard@nod.at>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> Gesendet: Montag, 20. September 2021 04:48:24
> Betreff: Re: [PATCH 0/1] ubifs: ubifs to export filesystem error counters

> Hello mtd/ubifs,
> 
> I just want to check back on what you think about having a sysfs for ubifs and
> starting with these three callbacks
> 
> /sys/fs/ubifs/ubiX_Y/errors_magic
> /sys/fs/ubifs/ubiX_Y/errors_node
> /sys/fs/ubifs/ubiX_Y/errors_crc

I didn't have a chance to review your changes to far but in general I like the idea
if exposing such an interface.
Sorry for being a slow maintainer.

Thanks,
//richard
