Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E939636DC3E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240435AbhD1PpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbhD1Pj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:39:26 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0362C061354
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 08:37:59 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id k25so63459331oic.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLEOlFo5zp9WVatlWokRO7XLf1rQZdLEFMPyIaFMtL4=;
        b=ZqonFTtUw99OuJ2hfDUb8RkfWD8kgdOUI9ehks1B6auTSR+M73KLdCqy9uNIiGL92z
         cvDvGSL0L1YTIOW6t3nShGPMrWGWqk1JoBQqq7yE7hXKaDd1iBmynnxjQwvdK58HgeCc
         1HtDCxXDEIvPNQslhUe1MdWOgGoq/6TGbptaB92U4GbqpfNHIqWL8cTM34jptB1Qdrnt
         WR7/vTe98aFqx4Vcyo0DHtPc0+Zf9OYiuS79JhUKltRWiImY7lTxJ+QPPo38487f+2wB
         rjoKsPKwSsbXW4S4H9lRL2GcHwAGdCwPpr77hNK8IqCaIrSGrHzh91Jf02qocJEuns/g
         hQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLEOlFo5zp9WVatlWokRO7XLf1rQZdLEFMPyIaFMtL4=;
        b=Y0VWqAdbvEyed8KTBK4AaeSizHPnm84wEVd8BV85z3cRxlPp3hZhsH6l2knyqSpADY
         IXYRIjY23LVDMb1GIo5VRxZ8jJ1mgsAc17O60dWRlI+DE1douMhEhjI6tejYqTuiGEah
         5Xt14u4z1bgWK+OfsOPuTkAbPPGx02JJx5dFatIDdDlWPz5MK1WjCovSTCaQrirBipTV
         OxtzWZ0ltbGoi/OP98+CEGs6cP7Z4KlZfGGjUPfG1T0mVtDE56tR0/Wgs1BuwFWvA26X
         xMlxrSMbM6OzuiBPOlj+iVpFce6K2npClO5m7TUtcOIJRhtQ7hshTmIZj2rZ/wcYJ04t
         fZ2A==
X-Gm-Message-State: AOAM532LuMJleX3l5/UkWqWVaEStLu4dmfpV/hxB0ZnD7rjy/70tL9Pd
        OFYGbPv/vsYoTpvlcgvJ7XfPJLPT9bOHFakRt/0wGg==
X-Google-Smtp-Source: ABdhPJxGOrqNk0Xk0VH1RsXq1v4lBe4McnXwsgMJTZwZB5AujhXvdBUIZFO77fJP4Bwlq/8UGv6W2E3xOiCeXu85HGw=
X-Received: by 2002:aca:5756:: with SMTP id l83mr3583333oib.90.1619624279060;
 Wed, 28 Apr 2021 08:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210428052725.530939-1-awill@google.com> <dd33cf8d3a78d60eebbb6f1be90cb7d3@walle.cc>
In-Reply-To: <dd33cf8d3a78d60eebbb6f1be90cb7d3@walle.cc>
From:   Alexander Williams <awill@google.com>
Date:   Wed, 28 Apr 2021 08:37:47 -0700
Message-ID: <CACqsJN-Vernbp5kJc+qZ6nUW50xPWz_9DznLDjtTu=btSra09Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] mtd: spi-nor: Export SFDP access to sysfs
To:     Michael Walle <michael@walle.cc>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 12:58 AM Michael Walle <michael@walle.cc> wrote:
>
> Hi Alexander,
>
> Am 2021-04-28 07:27, schrieb Alexander Williams:
> > Add the ability to specify a technology-specific attribute_group, and
> > expose the SFDP through spi-nor's private group. This enables user
> > space
> > to have full access to the contents of the SFDP, so all information is
> > available without regard for whether the kernel supports parsing it.
>
> Please see:
> https://lore.kernel.org/linux-mtd/20210318092406.5340-1-michael@walle.cc/

Thanks for the pointer! Sorry I didn't see that patch series already: My search
skills need some work... In any case, there's no good reason for me to duplicate
work.

I should probably comment on that series directly, but I'll note that one thing
I tried to do with the sysfs attributes here was avoid racing with user space.
The uevent is suppressed until all the related files are created in sysfs. See
http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/ for
Greg's explanation of a scenario.

- Alex
