Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF813A5AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 01:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhFMXKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 19:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhFMXKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 19:10:44 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55001C061574;
        Sun, 13 Jun 2021 16:08:42 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E368F2C0;
        Sun, 13 Jun 2021 23:08:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E368F2C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1623625722; bh=k51POIycP/fPVGF3ducrjJZqURhI9g4BqolRe9WYpyA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UX2nsCQaU/JWPxE9E5TppRFstPn0i8kYzhzu3PDGuW4gS9h4kQfpZQaVfb0Tb9lR/
         m13gva+ksqP5QAKZ+Lp8PxmLqFiq2RHufT6/3YxMd+fOQEZs8F36/eOjZzfJYgoM3Z
         ljmBvFq1/xj9/xjTcA2VxbyDnEdGZ3aoEscenGIwisspahk72rFZv42OayDPvj3FEh
         d+lZbnRcifjWnTQIXcCJMkuUurmfSfNP1IRxelzT466vrOtV4khj+nzOs1oM4EzX76
         P92CvOFNPuXB3ax3LMAJ94sxHiDNV6nyAaiMaoaIp3pg2Zdd0VAuarkeuPT8lF6BJ6
         GwoUH/1ijtYHA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Llamas <cmllamas@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Carlos Llamas <cmllamas@google.com>
Subject: Re: [PATCH] docs: printk-formats: update size-casting examples
In-Reply-To: <20210609195058.3518943-1-cmllamas@google.com>
References: <20210609195058.3518943-1-cmllamas@google.com>
Date:   Sun, 13 Jun 2021 17:08:41 -0600
Message-ID: <87czspbbwm.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Llamas <cmllamas@google.com> writes:

> Since commit 72deb455b5ec ("block: remove CONFIG_LBDAF") sector_t and
> blkcnt_t types are no longer variable in size, making them unsuitable
> examples for casting to the largest possible type. This patch replaces
> such examples with cycles_t and blk_status_t types, whose sizes depend
> on architecture and config options respectively.
>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  Documentation/core-api/printk-formats.rst | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Applied, thanks.

jon
