Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C69F30655D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 21:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhA0Ur1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Jan 2021 15:47:27 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:41476 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbhA0UrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:47:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 78CDF61D8A8E;
        Wed, 27 Jan 2021 21:46:42 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vdBZFFYqQkLv; Wed, 27 Jan 2021 21:46:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A4ED961D8A97;
        Wed, 27 Jan 2021 21:46:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id p5INWvL6CD1R; Wed, 27 Jan 2021 21:46:40 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 79A2E61D8A8E;
        Wed, 27 Jan 2021 21:46:40 +0100 (CET)
Date:   Wed, 27 Jan 2021 21:46:40 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <9732911.325628.1611780400338.JavaMail.zimbra@nod.at>
In-Reply-To: <20210127200319.662842-1-tomas.winkler@intel.com>
References: <20210127200319.662842-1-tomas.winkler@intel.com>
Subject: Re: [PATCH] mtd: use refcount to prevent corruption
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: use refcount to prevent corruption
Thread-Index: r0YCwcJ7fDRcCCdg7evH/Zy4+yWw0g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas,

----- Ursprüngliche Mail -----
> Von: "Tomas Winkler" <tomas.winkler@intel.com>
> An: "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>,
> "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> CC: "Tomas Winkler" <tomas.winkler@intel.com>
> Gesendet: Mittwoch, 27. Januar 2021 21:03:19
> Betreff: [PATCH] mtd: use refcount to prevent corruption

> When underlying device is removed mtd core will crash
> in case user space is still holding an open handle to a mtd device node.
> A proper refcounting is needed so device is release only when a
> partition has no active users. The current simple counter is not
> sufficient.

Can you please explain a little more what devices are involved?
Does it implement _get_device() and _put_device()?

Thanks,
//richard
