Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EE943DBCB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhJ1HSq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Oct 2021 03:18:46 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:51558 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhJ1HSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:18:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 21E8261EAE61;
        Thu, 28 Oct 2021 09:16:17 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JFCI-lQ7V8jh; Thu, 28 Oct 2021 09:16:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AEB6760F6B63;
        Thu, 28 Oct 2021 09:16:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EdzS24WRludn; Thu, 28 Oct 2021 09:16:16 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8900E61EAE61;
        Thu, 28 Oct 2021 09:16:16 +0200 (CEST)
Date:   Thu, 28 Oct 2021 09:16:16 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     schaecsn <schaecsn@gmx.net>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefan Schaeckeler <sschaeck@cisco.com>
Message-ID: <791707806.43634.1635405376333.JavaMail.zimbra@nod.at>
In-Reply-To: <20211028062124.12539-1-schaecsn@gmx.net>
References: <20211028062124.12539-1-schaecsn@gmx.net>
Subject: Re: [PATCH v3] ubifs: ubifs to export filesystem error counters
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF93 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: ubifs to export filesystem error counters
Thread-Index: GOJMgSWITBfEasKolYQiwLcyBXA7+Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan,

----- Ursprüngliche Mail -----
> Von: "schaecsn" <schaecsn@gmx.net>
> An: "richard" <richard@nod.at>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> CC: "Stefan Schaeckeler" <sschaeck@cisco.com>
> Gesendet: Donnerstag, 28. Oktober 2021 08:21:24
> Betreff: [PATCH v3] ubifs: ubifs to export filesystem error counters

> From: Stefan Schaeckeler <sschaeck@cisco.com>
> 
> Not all ubifs filesystem errors are propagated to userspace.
> 
> Export bad magic, bad node and crc errors via sysfs. This allows userspace
> to notice filesystem errors:
> 
> /sys/fs/ubifs/ubiX_Y/errors_magic
> /sys/fs/ubifs/ubiX_Y/errors_node
> /sys/fs/ubifs/ubiX_Y/errors_crc
> 
> The counters are reset to 0 with a remount.
> 
> Signed-off-by: Stefan Schaeckeler <sschaeck@cisco.com>
> ---
> Changes in v3:
>  - Added Documentation/ABI/testing/sysfs-fs-ubifs
>  - Added Documentation/ABI/testing/sysfs-fs-ubifs to MAINTAINERS

I asked for just the Documentation. v2 of your patch is already in linux-next. :-)

Thanks,
//richard
