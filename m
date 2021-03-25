Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A144349873
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhCYRlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhCYRlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:41:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02D9C06174A;
        Thu, 25 Mar 2021 10:41:01 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 272F031A;
        Thu, 25 Mar 2021 17:41:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 272F031A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1616694061; bh=73hADQRfNTJx3OI1nRDly3n0w6QGMbqCZNtlNgHhqoU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YCqV3v33B3MmxOmAXWOl+4L94eU5mu1I7rz+Qv8wR4/b+xu8YnOHLajq/MqRJnJQM
         KNu6hM7jmoL1tqEaUhUBCZg9GSdBJxquzuzPvtTV65b3Rpsp0AGZZbvjEWmaaseTGW
         e8iYsmsfTeGIHNCkRI04aydMA4Afh6AEXmwjoRxY4Pm3Ett6Rq/pB4hqFdQFk2zREg
         3xzt/bexAcJFdYKXRaLTuKCXhh2JDNw0QLHAzJ3619oUeZ7Fg01QOkaFRt9xpCyh/a
         5uIeHTmdqAr872r7deYJsl6HyCtws9m3RYjSwbr6G5l3TNM1NzwZAFT5m0VbqivZ6z
         2r8qjbem28TlQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, walken@google.com,
        unixbhaskar@gmail.com, grandmaster@al2klimov.de,
        willy@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: Re: [PATCH] docs: rbtree.rst: Fix a typo
In-Reply-To: <20210324080046.20709-1-unixbhaskar@gmail.com>
References: <20210324080046.20709-1-unixbhaskar@gmail.com>
Date:   Thu, 25 Mar 2021 11:41:00 -0600
Message-ID: <87a6qr2ksz.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:

> s/maintanence/maintenance/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Documentation/core-api/rbtree.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

jon
