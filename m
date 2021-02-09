Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E4B3152C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhBIP0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbhBIPXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:23:34 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EA1C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 07:22:53 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id s17so6017277vsn.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 07:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCZz97uzCHGddkBTReOyagy60zeLzzCF1I6wRGccqhE=;
        b=DrGLXzDh3hkpXg9djEHKfEhye/AVp2sQm27tEP3KeWlb8f5B0Nwq7pfOpmCMi27AGG
         cT3f98YOQIj82GzIR7WKpE0qSo/tNcRAJhGVThQAGzoMebMIAEfoYr5PV7i1CPoYFxrm
         xA3xvwJFDKHwYFPCjP7VvoVrWLCnNMFsPj45A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCZz97uzCHGddkBTReOyagy60zeLzzCF1I6wRGccqhE=;
        b=mAMiGqiWzRhbMe69jvzBn3HhEM8oFuo732bU8aa8Ete6HCIV0gKDF6Bu7qa+26daEm
         L8lFE8xHhWHZpu7ZBGc5oqZCe+jb1xvf1THzIxTB3raSCWAl1L5lhKKmkYAHgjgYCC2s
         QfnadOR5ePfs0Dy01OfZm4FaFCle7RN2yh6ZUJ4xyQKWjrs12ZCWtxtLtLcabAhdHaEp
         3DfkPbYET2cdlULpOoYq5WSqkl7ESz2I6yPZy5Hvy8mPEC5p5cqQIW1Lch56GeVpufNG
         VRuMZL9DVEGpETxjiClaC3XlOq/HMdminl5sDO9h4n1pY+OyjnU/ZVzDgdcSTSW5ArUr
         /BmQ==
X-Gm-Message-State: AOAM531gQVG5uUnlX+xDZrnt1oRkRG4t9XhOLx8kDWX3PJaBJ21pdYqz
        O9snXC+6BItKjM2hys6fwe4hXIJznEKeBzjDUQMgkw==
X-Google-Smtp-Source: ABdhPJyQaaW8l0xGMipKjEWaPlZilec/uO/KyZ287BqbXRG1zNpFaUAXEASIAMSauQrZVVkhPozcrTic5kP1jEc0OlQ=
X-Received: by 2002:a67:a404:: with SMTP id n4mr13411993vse.0.1612884172982;
 Tue, 09 Feb 2021 07:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20210124232007.21639-1-richard@nod.at> <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com>
 <563952295.378372.1612881357746.JavaMail.zimbra@nod.at> <3a9c19cf-2c25-a3bf-a200-6d223952797a@studio.unibo.it>
In-Reply-To: <3a9c19cf-2c25-a3bf-a200-6d223952797a@studio.unibo.it>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 9 Feb 2021 16:22:42 +0100
Message-ID: <CAJfpegv5zG0ixRrf-nauHkG-36C34xVO5jN_GX=3f4JamnRfwA@mail.gmail.com>
Subject: Re: [fuse-devel] [PATCH 0/8] MUSE: Userspace backed MTD v3
To:     Luca Risolia <luca.risolia@studio.unibo.it>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Ron Minnich <rminnich@google.com>, sven@narfation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 4:10 PM Luca Risolia
<luca.risolia@studio.unibo.it> wrote:
>
> Hi guys,
>
> a bit OT probably: is there any chance for you to also implement mmap()
> for CUSE? That would be much appreciated.

That's an old one.

No, I don't have plans, but patches are welcome, of course.

Thanks,
Miklos
