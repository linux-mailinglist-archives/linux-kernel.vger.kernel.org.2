Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2200243C821
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 12:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbhJ0K4h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Oct 2021 06:56:37 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:40956 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhJ0K4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 06:56:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DBBAC60A59CB;
        Wed, 27 Oct 2021 12:54:09 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jAtqK5-KKcxu; Wed, 27 Oct 2021 12:54:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3B85160A59CC;
        Wed, 27 Oct 2021 12:54:09 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4VSet6S7aa7W; Wed, 27 Oct 2021 12:54:09 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1737160A59CB;
        Wed, 27 Oct 2021 12:54:09 +0200 (CEST)
Date:   Wed, 27 Oct 2021 12:54:09 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     shiva linuxworks <shiva.linuxworks@gmail.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Message-ID: <771780049.41543.1635332049033.JavaMail.zimbra@nod.at>
In-Reply-To: <20211027103352.8879-1-sshivamurthy@micron.com>
References: <20211027103352.8879-1-sshivamurthy@micron.com>
Subject: Re: [PATCH 0/4] enabling Advanced protection and security features
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF93 (Linux)/8.8.12_GA_3809)
Thread-Topic: enabling Advanced protection and security features
Thread-Index: e9NOfgAgmG4FgeEzOITeky2aCvZksw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "shiva linuxworks" <shiva.linuxworks@gmail.com>
> An: "Tudor Ambarus" <tudor.ambarus@microchip.com>, "Michael Walle" <michael@walle.cc>, "Pratyush Yadav"
> <p.yadav@ti.com>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>, "Vignesh Raghavendra"
> <vigneshr@ti.com>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "Shivamurthy Shastri"
> <sshivamurthy@micron.com>
> Gesendet: Mittwoch, 27. Oktober 2021 12:33:48
> Betreff: [PATCH 0/4] enabling Advanced protection and security features

> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 
> Standard protection features in SPI NOR flashes are legacy and offer a
> simple way to protect the memory array against accidental or unwanted
> modification of its content.
> 
> These patches enable the support for advanced sector protection which
> protects memory from accidentally corrupting code and data stored, and
> it also prevents malicious attacks that could intentionally modify the
> code or data stored in the memory.
> 
> Micron Flashes offer some of the advanced protection methods using
> volatile lock bits, non-volatile lock bits, global freeze bits, and
> password.

Can you please point us to the technical documentation of these features?
I'm especially interested in the password feature.

Thanks,
//richard
