Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FC63152FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhBIPmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:42:08 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:42872 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbhBIPmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:42:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0A8E56083276;
        Tue,  9 Feb 2021 16:41:19 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6X5LfEg7z8cH; Tue,  9 Feb 2021 16:41:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 91ADC6083272;
        Tue,  9 Feb 2021 16:41:18 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 72_y7wqJgWsi; Tue,  9 Feb 2021 16:41:18 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 62549608A38F;
        Tue,  9 Feb 2021 16:41:18 +0100 (CET)
Date:   Tue, 9 Feb 2021 16:41:18 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Luca Risolia <luca.risolia@studio.unibo.it>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Ron Minnich <rminnich@google.com>, sven <sven@narfation.org>
Message-ID: <443281182.378615.1612885278254.JavaMail.zimbra@nod.at>
In-Reply-To: <3a9c19cf-2c25-a3bf-a200-6d223952797a@studio.unibo.it>
References: <20210124232007.21639-1-richard@nod.at> <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com> <563952295.378372.1612881357746.JavaMail.zimbra@nod.at> <3a9c19cf-2c25-a3bf-a200-6d223952797a@studio.unibo.it>
Subject: Re: [fuse-devel] [PATCH 0/8] MUSE: Userspace backed MTD v3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: MUSE: Userspace backed MTD v3
Thread-Index: CNyuanlCgrWAfDgLZ61+F9X+2N1myA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> a bit OT probably: is there any chance for you to also implement mmap()
> for CUSE? That would be much appreciated.

What exactly do you have in mind? I wonder about the use case.
mmap() between a FUSE server and a client is more or less shared memory in userspace.

Thanks,
//richard
