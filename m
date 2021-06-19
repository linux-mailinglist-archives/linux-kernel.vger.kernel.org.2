Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70FE3AD890
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 10:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhFSIG4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Jun 2021 04:06:56 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:53332 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhFSIGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 04:06:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D950560A59C4;
        Sat, 19 Jun 2021 10:04:42 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ofoIBr20udHR; Sat, 19 Jun 2021 10:04:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 75FB560A59D3;
        Sat, 19 Jun 2021 10:04:42 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0_5-Fm-U75b0; Sat, 19 Jun 2021 10:04:42 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0D9BF60A59C4;
        Sat, 19 Jun 2021 10:04:42 +0200 (CEST)
Date:   Sat, 19 Jun 2021 10:04:41 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     anton ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Wan Jiabing <wanjiabing@vivo.com>, Jeff Dike <jdike@addtoit.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Corey Minyard <cminyard@mvista.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <653435823.132192.1624089881861.JavaMail.zimbra@nod.at>
In-Reply-To: <4320e0ea-1339-e2c1-03c0-271dbcd6e22d@cambridgegreys.com>
References: <20210619020301.77672-1-wanjiabing@vivo.com> <4320e0ea-1339-e2c1-03c0-271dbcd6e22d@cambridgegreys.com>
Subject: Re: [PATCH] um: remove unneeded semicolon in um_arch.c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove unneeded semicolon in um_arch.c
Thread-Index: 5dmVC/7fLFn0pliU7qn0muN46wzeWA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anton,

----- Ursprüngliche Mail -----
> Thanks.
> 
> I do not think the patch which introduces this ([v7,1/3] um: Add support
> for host CPU flags and alignment) has been merged yet. I do not see it
> in the tree as of this morning.
> 
> I can see that it is already marked as done in patchwork so it is on its
> way.
> 
> Richard, what do you want me to do - reissue a fixed one or we should
> accept the fix once the original is merged?

I have just applied the fix to UML's next tree. :-)

Thanks,
//richard
