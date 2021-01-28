Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F04F307028
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhA1Hu0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Jan 2021 02:50:26 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:59074 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhA1Hr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:47:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D1B596074005;
        Thu, 28 Jan 2021 08:47:11 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2I6E_uKbcIlQ; Thu, 28 Jan 2021 08:47:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7917B6074007;
        Thu, 28 Jan 2021 08:47:11 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gwvr2wLtfqUm; Thu, 28 Jan 2021 08:47:11 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 582B36074005;
        Thu, 28 Jan 2021 08:47:11 +0100 (CET)
Date:   Thu, 28 Jan 2021 08:47:11 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1665542284.336646.1611820031174.JavaMail.zimbra@nod.at>
In-Reply-To: <a6cb6eb10bbb48989d3a9e087951e50e@intel.com>
References: <20210127200319.662842-1-tomas.winkler@intel.com> <9732911.325628.1611780400338.JavaMail.zimbra@nod.at> <c8d0f22c5fdf443cb8dda1f996b148d9@intel.com> <1776363776.325713.1611782270873.JavaMail.zimbra@nod.at> <a6cb6eb10bbb48989d3a9e087951e50e@intel.com>
Subject: Re: [PATCH] mtd: use refcount to prevent corruption
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: use refcount to prevent corruption
Thread-Index: AQHW9OeD00Da249Jw0qJn6+VIZAeUao7z7AAgAAh5BBxoBSOfPxzntFAEGBJdu8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas,

----- Ursprüngliche Mail -----
>> >> Can you please explain a little more what devices are involved?
>> >> Does it implement _get_device() and _put_device()?
>> > No this is not connected to those handlers of the underlying device
>> > and those won't help.
>> > I have a spi device provided by MFD framework so it can go away anytime.
>> 
>> Can it go away physically or just in software?
> Software, but since this is mfd it's basically hotplug. The kernel is crashing
> when I simulate hardware failure.
>> 
>> Usually the pattern is that you make sure in the device driver that nobody can
>> orphan the MTD while it is in use.
>> e.g. drivers/mtd/ubi/gluebi.c does so. In _get_device() it grabs a reference on
>> the underlying UBI volume to make sure it cannot go away while the MTD (on
>> top of UBI) is in use.
> 
> I can try that if it helps, because we are simulating possible lower level
> crash.
> In an case I believe that the proper refcouting is much more robust solution,
> than the current one.
> I'd appreciate if someone can review the actual implementation.

This happens right now, I try to understand why exactly the current way is not
good in enough. :-)

Your approach makes sure that the MTD itself does not go away while it has users but
how does this help in the case where the underlying MFD just vanishes?
The MTD can be in use and the MFD can go away while e.g. mtd_read() or such
takes place.

Thanks,
//richard
