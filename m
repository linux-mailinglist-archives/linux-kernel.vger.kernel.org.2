Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDB03DBF0F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 21:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhG3Tej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 15:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhG3Tei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 15:34:38 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A71C061765;
        Fri, 30 Jul 2021 12:34:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 358222A0;
        Fri, 30 Jul 2021 19:34:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 358222A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1627673673; bh=NXFn2qrOpQssNUy6D827VdxWljfdtpOsIvk/raOWLIw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NVGsWJK0N0DJ1UzW9JU+CWpJgKX0zxRsR3AbLXo7nRvPLA3NUu6uuuEMmf61QQKSz
         RPKHcVMLplBMNzI7hlrysnOMUhEJUjIlXWJ+yIqlMKOreDpf9Jtvxztn+SE5vli3TF
         T3zcCYr3Pa1QZmGlJ9Or6b0Vp7qeQdj7SFvafAoZe5PIDs/ff30pyseSn5W5qyPpR0
         D8yuJ8b427A0cXxsUHoOor89gB89Ab9H+lw7Q1ItO61cMMtPYzrCzIT0aamlq7Y80m
         g+179Ulhy0YTMy0zKSSxeH6QB78GOs9qu/Cds8+mXZeLQ9WRvul/f3ALO+PUj/A3Xk
         sssVl5Wmb+5YQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res@email.cn>
Cc:     panyunwang849@gmail.com,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] docs: add traditional Chinese translation for
 kernel Documentation
In-Reply-To: <20210729155627.41744-1-src.res@email.cn>
References: <20210729155627.41744-1-src.res@email.cn>
Date:   Fri, 30 Jul 2021 13:34:32 -0600
Message-ID: <87a6m3a94n.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <src.res@email.cn> writes:

> Add traditional Chinese translation (zh_TW) for the Linux Kernel
> documentation with a series of translated files.
>
> Signed-off-by: Hu Haowen <src.res@email.cn>
> Reviewed-by: Pan Yunwang <panyunwang849@gmail.com>

OK, I have applied this set, thanks.

jon
