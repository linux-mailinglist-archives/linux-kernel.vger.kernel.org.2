Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582DC3065DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhA0VSm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Jan 2021 16:18:42 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:42390 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344101AbhA0VSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:18:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 86D24625DE1E;
        Wed, 27 Jan 2021 22:17:51 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 79ZlmV87B62C; Wed, 27 Jan 2021 22:17:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 244DB625DE1C;
        Wed, 27 Jan 2021 22:17:51 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pgoXEc18aL20; Wed, 27 Jan 2021 22:17:51 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id F3E4E625DE1E;
        Wed, 27 Jan 2021 22:17:50 +0100 (CET)
Date:   Wed, 27 Jan 2021 22:17:50 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1776363776.325713.1611782270873.JavaMail.zimbra@nod.at>
In-Reply-To: <c8d0f22c5fdf443cb8dda1f996b148d9@intel.com>
References: <20210127200319.662842-1-tomas.winkler@intel.com> <9732911.325628.1611780400338.JavaMail.zimbra@nod.at> <c8d0f22c5fdf443cb8dda1f996b148d9@intel.com>
Subject: Re: [PATCH] mtd: use refcount to prevent corruption
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: use refcount to prevent corruption
Thread-Index: AQHW9OeD00Da249Jw0qJn6+VIZAeUao7z7AAgAAh5BBxoBSOfA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
>> > When underlying device is removed mtd core will crash in case user
>> > space is still holding an open handle to a mtd device node.
>> > A proper refcounting is needed so device is release only when a
>> > partition has no active users. The current simple counter is not
>> > sufficient.
>> 
>> Can you please explain a little more what devices are involved?
>> Does it implement _get_device() and _put_device()?
> No this is not connected to those handlers of the underlying device and those
> won't help.
> I have a spi device provided by MFD framework so it can go away anytime.

Can it go away physically or just in software?

Usually the pattern is that you make sure in the device driver that nobody
can orphan the MTD while it is in use.
e.g. drivers/mtd/ubi/gluebi.c does so. In _get_device() it grabs a reference on the
underlying UBI volume to make sure it cannot go away while the MTD (on top of UBI)
is in use.

Thanks,
//richard
