Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B2B31A6F5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhBLVfL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 12 Feb 2021 16:35:11 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:44796 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhBLVe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:34:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 06EBA6074007;
        Fri, 12 Feb 2021 22:34:16 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JxTK92jQMiKS; Fri, 12 Feb 2021 22:34:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B61FF6074009;
        Fri, 12 Feb 2021 22:34:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PiaCTGFa5zf1; Fri, 12 Feb 2021 22:34:15 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 96E216074007;
        Fri, 12 Feb 2021 22:34:15 +0100 (CET)
Date:   Fri, 12 Feb 2021 22:34:15 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Juergen Borleis <jbe@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        kernel <kernel@pengutronix.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <2022320545.389724.1613165655531.JavaMail.zimbra@nod.at>
In-Reply-To: <CAHp75VfwD25Vfb_81eoZDG=GktSdiROtg7=2tPMDMV8k2iqdag@mail.gmail.com>
References: <20210202124838.30805-1-jbe@pengutronix.de> <CAHp75VfwD25Vfb_81eoZDG=GktSdiROtg7=2tPMDMV8k2iqdag@mail.gmail.com>
Subject: Re: [PATCH] fs: ubifs: set s_uuid in super block to support ima/evm
 uuid options
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: set s_uuid in super block to support ima/evm uuid options
Thread-Index: UM/rSZ/B5fIVI3kknwppOQ4RboI4wA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,

----- Ursprüngliche Mail -----
>> + memcpy(&sb->s_uuid, &c->uuid, sizeof(c->
> Shouldn’t it be `import_uuid()`?

Hmm, I didn't know that helper.
The only user in fs/ seems to be zonefs, all other filesystems do a plain memcpy().

Do you want me do a patch that converts all users in fs/ to import_uuid()?

Thanks,
//richard
