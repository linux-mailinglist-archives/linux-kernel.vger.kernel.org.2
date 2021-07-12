Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488E23C601B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhGLQIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhGLQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:08:38 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F141C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 09:05:50 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E946A36E;
        Mon, 12 Jul 2021 16:05:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E946A36E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1626105950; bh=TafaVXndhioe+5wNe0f31f9U9xi2mdBOCKLIVRZb7+0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cwH7XY4+vXLWZbSe8VuJhduLLmg9ndjjgMhswsgwRV8uup1wOcGrI6d4Ym0t+PwWp
         HfiP86LxvPS5WH00AnkQJp83aF7JlqXlO5oTDgeohWg3dbV7d20vWrO82sQZfXzdrS
         cF9bCgrpAw8Yn1H/Zc0629XMhJJ/1fWSmtCCKzg+P3J9SsPhEfCDppvfDWosWPThe5
         YdpN44c3ht19X2uBtun9p0ed1edXaakrsRJM77Zl+7lFljtO2B2q8ds6vywX+1QVdD
         3Y0bdNWOzVbwzbEfZmVDrxdYzaJ/v2geOgZsUZX97DkXBu8LvnCY/GNMUMlIPzPtJb
         fCc7Un+dBesyg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/features: Add THREAD_INFO_IN_TASK feature
 matrix
In-Reply-To: <YN2nhV5F0hBVNPuX@gmail.com>
References: <YN2nhV5F0hBVNPuX@gmail.com>
Date:   Mon, 12 Jul 2021 10:05:49 -0600
Message-ID: <87lf6bqzz6.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:

> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  .../core/thread-info-in-task/arch-support.txt      | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Applied, thanks.

jon
