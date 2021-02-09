Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36B4315462
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhBIQwV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Feb 2021 11:52:21 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:44164 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhBIQu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:50:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 493E46083270;
        Tue,  9 Feb 2021 17:50:13 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LgSQItoluF3W; Tue,  9 Feb 2021 17:50:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E8B21608A38F;
        Tue,  9 Feb 2021 17:50:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GB4FDVzrT0QH; Tue,  9 Feb 2021 17:50:12 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id B1F2F6083270;
        Tue,  9 Feb 2021 17:50:12 +0100 (CET)
Date:   Tue, 9 Feb 2021 17:50:12 +0100 (CET)
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
Message-ID: <492787386.378826.1612889412476.JavaMail.zimbra@nod.at>
In-Reply-To: <705c010b-653a-1dd0-87b9-f3cc83c21802@studio.unibo.it>
References: <20210124232007.21639-1-richard@nod.at> <3a9c19cf-2c25-a3bf-a200-6d223952797a@studio.unibo.it> <443281182.378615.1612885278254.JavaMail.zimbra@nod.at> <b2424246-d42b-d0bc-8951-8cefdf5b681d@studio.unibo.it> <1517729157.378701.1612886684264.JavaMail.zimbra@nod.at> <ad4fd822-016e-e11e-682c-077a1ced2a18@studio.unibo.it> <231074135.378774.1612888173941.JavaMail.zimbra@nod.at> <705c010b-653a-1dd0-87b9-f3cc83c21802@studio.unibo.it>
Subject: Re: [fuse-devel] [PATCH 0/8] MUSE: Userspace backed MTD v3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: MUSE: Userspace backed MTD v3
Thread-Index: q37PlZSRNO35cCN77UrdwzImPA2u1g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> On 09/02/21 17:29, Richard Weinberger wrote:
>> The mmap() call itself. Of course you need to touch code.
>> Maybe just cuse_lowlevel.c, maybe kernel too.
> 
> A patch had been submitted some years ago, more than once, asking for
> inclusion in the kernel, but facts are that at that time nobody in the
> FUSE group considered it. So much work and time lost, unfortunately.

Well, I think having a generic mmap() for CUSE is hard to achieve.

Thanks,
//richard
