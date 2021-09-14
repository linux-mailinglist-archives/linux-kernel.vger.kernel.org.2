Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C68140B97B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhINUwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbhINUwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:52:12 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6BBC061574;
        Tue, 14 Sep 2021 13:50:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AEA0E2C1;
        Tue, 14 Sep 2021 20:50:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AEA0E2C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1631652653; bh=1C1Lum1SJ8liV3Fk2FKIE54N6AIkTwNqtnJFFKjEs1Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=W98IYDdkY7yNcjoWpD0qh92VOblQdoSU8ry90boi4zCCKsq1kJ+rgx4va0VB6KT8t
         j3yBqeySZgdaG+tGC+HYYc3dSYSniWROOGqPwxMkuJldJjsAupsFMRJcUWSAWZrpJQ
         voeA3MLmfBLlzdfyJIHsTqhItsr9Ur5jPM75JIW6broYgfiArNaD1LLgEafZ0FsQds
         czXgOgMXdzs1Gc/wlHU+J0m5QTTLku8Ht4orMm/v1uNGusmPqSKwd9RvnlVidfHxBj
         Y6f7y0aA/OZd3tBok4XeF9fYDRkGuV/IU5Yvis5zoNGHR+wDKjJ4jKh2TdiaShEo9C
         LI+scrjijhkMg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>, Jens Axboe <axboe@kernel.dk>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH] docs: block: fix discard_max_bytes references
In-Reply-To: <20210910105142.2116749-1-steve@sk2.org>
References: <20210910105142.2116749-1-steve@sk2.org>
Date:   Tue, 14 Sep 2021 14:50:53 -0600
Message-ID: <87czpaev9u.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Kitt <steve@sk2.org> writes:

> When discard_max_hw_bytes was introduced, in commit 0034af036554
> ("block: make /sys/block/<dev>/queue/discard_max_bytes writeable"),
> the discard_max_bytes documentation section was renamed to
> discard_max_hw_bytes, but the references it contains to
> discard_max_bytes weren't updated.
>
> This patch refers to discard_max_hw_bytes instead. It also reflows the
> paragraph so that sentences end lines.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  Documentation/block/queue-sysfs.rst | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied, thanks.

jon
