Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEC331AE3C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 23:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhBMWBt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 13 Feb 2021 17:01:49 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:43748 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhBMWBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 17:01:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A3C726089E03;
        Sat, 13 Feb 2021 23:01:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rfBklMJXd1Ph; Sat, 13 Feb 2021 23:01:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5A8FA6074009;
        Sat, 13 Feb 2021 23:01:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HnNK8I15Gyfa; Sat, 13 Feb 2021 23:01:04 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 39A476089E03;
        Sat, 13 Feb 2021 23:01:04 +0100 (CET)
Date:   Sat, 13 Feb 2021 23:01:04 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Juergen Borleis <jbe@pengutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        kernel <kernel@pengutronix.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <205753680.392561.1613253664135.JavaMail.zimbra@nod.at>
In-Reply-To: <CAHp75VdJZUd6YoJ26jw0oAEQ0-k6AVXBqzVhs3oFy5+mZXiSjw@mail.gmail.com>
References: <20210202124838.30805-1-jbe@pengutronix.de> <CAHp75VfwD25Vfb_81eoZDG=GktSdiROtg7=2tPMDMV8k2iqdag@mail.gmail.com> <2022320545.389724.1613165655531.JavaMail.zimbra@nod.at> <CAHp75VdJZUd6YoJ26jw0oAEQ0-k6AVXBqzVhs3oFy5+mZXiSjw@mail.gmail.com>
Subject: Re: [PATCH] fs: ubifs: set s_uuid in super block to support ima/evm
 uuid options
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: set s_uuid in super block to support ima/evm uuid options
Thread-Index: ie37LadzhlxH0LWvJBRqlvqvABdvrw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
>> Hmm, I didn't know that helper.
>> The only user in fs/ seems to be zonefs, all other filesystems do a plain
>> memcpy().

>> Do you want me do a patch that converts all users in fs/ to import_uuid()?
> Not sure about all fs, but in new code, like here I think it makes sense. Also
> check export_uuid() and uuid_copy().

Okay. I've dropped the patch from linux-next.
Juergen, please address Andy's comments and resend.

Thanks,
//richard
