Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AAB315360
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbhBIQFc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Feb 2021 11:05:32 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:43352 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhBIQF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:05:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D8CA36083276;
        Tue,  9 Feb 2021 17:04:44 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pxadgr_i0awx; Tue,  9 Feb 2021 17:04:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 850A76083272;
        Tue,  9 Feb 2021 17:04:44 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5xN4CfVrl8hV; Tue,  9 Feb 2021 17:04:44 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5DDC3608A38F;
        Tue,  9 Feb 2021 17:04:44 +0100 (CET)
Date:   Tue, 9 Feb 2021 17:04:44 +0100 (CET)
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
Message-ID: <1517729157.378701.1612886684264.JavaMail.zimbra@nod.at>
In-Reply-To: <b2424246-d42b-d0bc-8951-8cefdf5b681d@studio.unibo.it>
References: <20210124232007.21639-1-richard@nod.at> <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com> <563952295.378372.1612881357746.JavaMail.zimbra@nod.at> <3a9c19cf-2c25-a3bf-a200-6d223952797a@studio.unibo.it> <443281182.378615.1612885278254.JavaMail.zimbra@nod.at> <b2424246-d42b-d0bc-8951-8cefdf5b681d@studio.unibo.it>
Subject: Re: [fuse-devel] [PATCH 0/8] MUSE: Userspace backed MTD v3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: MUSE: Userspace backed MTD v3
Thread-Index: f2FpF8PjrUPpHHP0V+KyAUAhV15RfQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> for example, many existing video applications use mmap() to map the
> device memory to userspace memory. Adding support for mmap() to CUSE
> would allow these apps to work without any modifications with CUSE-based
>   device drivers other than kernel drivers.

So you want to access device memory via CUSE?
We have plenty of mechanisms in Linux to allow userspace accessing device memory.
E.g. /dev/mem, UIO, VFIO.

A simple (but ugly!) approach would be redirecting mmap() requests on CUSE devices to /dev/mem.
hmm?

Thanks,
//richard
