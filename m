Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA07325759
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhBYUMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhBYUMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:12:02 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115F7C06174A;
        Thu, 25 Feb 2021 12:11:22 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BE2E57DE;
        Thu, 25 Feb 2021 20:11:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BE2E57DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614283881; bh=x+UiLAWpiYh0JD6ayrWflGl7JaEf/FYymNi0YrQd/yI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rg/v8AsQN0nMNsV9KO33qUv48CzJKIGJsMW+J00ZYp0zUbuhM3A9HBV08CkRx4cEE
         CvarbNPxZhHtVHK4/25TaqqsDks8jDj7M4MAKvIjIxq6UqTJ6dqFBP8zgxxIaijGtH
         BYaaV1EFzbOezQH4fdhUdX5Q/X3pWVOBVjatdJgXwy6JErlH099MkzRPGauPqzvWoW
         vOqyq+oyMDz+PJRGYKkVrztgaRus8D22sv8dbJ9t1T+69qX8/tXaiIDw8/qCXL8Pml
         Zb1tacAxoN2vF4TLbXWA+kxKmh6o0Fj4YRf9cJluDH0/fnnLCA2k1t2AFr7xTuRu75
         EfETD6Npv4Yyg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH -next] docs: proc.rst: fix indentation warning
In-Reply-To: <20210223060418.21443-1-rdunlap@infradead.org>
References: <20210223060418.21443-1-rdunlap@infradead.org>
Date:   Thu, 25 Feb 2021 13:11:21 -0700
Message-ID: <87v9afc3h2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Fix indentation snafu in proc.rst as reported by Stephen.
>
> next-20210219/Documentation/filesystems/proc.rst:697: WARNING: Unexpected indentation.
>
> Fixes: 93ea4a0b8fce ("Documentation: proc.rst: add more about the 6 fields in loadavg")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
> shame on me.
>
>  Documentation/filesystems/proc.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

jon
