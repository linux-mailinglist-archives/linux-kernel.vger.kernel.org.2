Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19FC43BB0C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbhJZTjL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Oct 2021 15:39:11 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:58762 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbhJZTjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:39:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6AC6361EAE61;
        Tue, 26 Oct 2021 21:36:44 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7wGUL2xiZPGU; Tue, 26 Oct 2021 21:36:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EA44561EAE60;
        Tue, 26 Oct 2021 21:36:43 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QBTsJ4QC7-1X; Tue, 26 Oct 2021 21:36:43 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C1881608890D;
        Tue, 26 Oct 2021 21:36:43 +0200 (CEST)
Date:   Tue, 26 Oct 2021 21:36:43 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     schaecsn <schaecsn@gmx.net>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefan Schaeckeler <sschaeck@cisco.com>
Message-ID: <2065858791.38760.1635277003599.JavaMail.zimbra@nod.at>
In-Reply-To: <20211010042239.2888-1-schaecsn@gmx.net>
References: <20211010042239.2888-1-schaecsn@gmx.net>
Subject: Re: [PATCH v2] ubifs: ubifs to export filesystem error counters
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF93 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: ubifs to export filesystem error counters
Thread-Index: aM4D8UF/9n8qFEnXdnQOShonLtWUPw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan,

----- Ursprüngliche Mail -----
> Von: "schaecsn" <schaecsn@gmx.net>
> An: "richard" <richard@nod.at>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> CC: "schaecsn" <schaecsn@gmx.net>, "Stefan Schaeckeler" <sschaeck@cisco.com>
> Gesendet: Sonntag, 10. Oktober 2021 06:22:39
> Betreff: [PATCH v2] ubifs: ubifs to export filesystem error counters

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
> Changes in v2:
>  - merged sysfs.h header into ubifs.h.
>  - io.c: wrapped incrementing error counters into new functions
>    record_*_error().
>  - sysfs.c: removed sysfs write callback for clearing stats.
>  - sysfs.c: ubifs_sysfs_register(): free c->stats on error.
>  - sysfs.c: ubifs_attr_show(): use sysfs_emit().
> 
> fs/ubifs/Makefile |   2 +-
> fs/ubifs/io.c     |  21 +++++++
> fs/ubifs/super.c  |  16 ++++-
> fs/ubifs/sysfs.c  | 153 ++++++++++++++++++++++++++++++++++++++++++++++
> fs/ubifs/ubifs.h  |  35 +++++++++++
> 5 files changed, 225 insertions(+), 2 deletions(-)
> create mode 100644 fs/ubifs/sysfs.c

Queued for 5.16.

I just noticed forgot to request sysfs documentation in Documentation/ABI/.
Can you please send a followup patch?

Thanks,
//richard
