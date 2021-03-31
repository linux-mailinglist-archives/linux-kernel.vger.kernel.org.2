Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6A4350840
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbhCaUck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbhCaUcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:32:23 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CF6C061574;
        Wed, 31 Mar 2021 13:32:22 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A1D73867;
        Wed, 31 Mar 2021 20:32:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A1D73867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1617222742; bh=v0IjrHFfqIojGkegIjX604oY9b4ajeeSp2r4MVDSf5o=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=bd2NSRJpfuxiltCZ+FWzuWKuS2/usGxc+jCiI8vrDLg8TjF/cP16aGt7u5xgtK1eN
         2ShSe1PS2dSsgKAE3q7qTsHj/ArnUEl1fWfLOSqzxcWqNt2hcLTlNlf3mLHH2W9MVP
         XEncQGMq2Qt2zI6ePuIpD7edrEf/HpBBbc5Me7CFxjYZNWrar6JW/aCA53tpFIHtiO
         tMw60jXVnCrJCy/8+ht6B3XBxqAQs/sLmGLAEGA1i0IMZ+w9LTVJRtEYYWXpcmN1Bl
         Ul/CdNGCKKHk3s/QgUJ5KqdnR2j0xkv9pb/maCyVpZltzf2XFVGY1IJtihr7OQ+JGd
         d/WyddbSU1AcQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wang Qing <wangqing@vivo.com>, Wang Qing <wangqing@vivo.com>,
        Joe Perches <joe@perches.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: admin-guide: remove explanation of "watchdog/%u"
In-Reply-To: <1615801744-31548-1-git-send-email-wangqing@vivo.com>
References: <1615801744-31548-1-git-send-email-wangqing@vivo.com>
Date:   Wed, 31 Mar 2021 14:32:22 -0600
Message-ID: <87mtujjc89.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang Qing <wangqing@vivo.com> writes:

> "watchdog/%u" threads has be replaced by cpu_stop_work, 
> which will mislead the reader.
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  .../admin-guide/kernel-per-CPU-kthreads.rst          | 20 --------------------
>  1 file changed, 20 deletions(-)

Applied, thanks.

jon
