Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299D9322101
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 21:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhBVU4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 15:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhBVU4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 15:56:49 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177F2C061574;
        Mon, 22 Feb 2021 12:56:09 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 18C4A30D;
        Mon, 22 Feb 2021 20:56:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 18C4A30D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614027366; bh=vMLcCi4PrG8SXWx7/K5Xu2YTts+/CmoqiQsCqcA47l8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=q+hDG9flwz7SORD9vBTR30R0M1+UuM5Ldk4ebZQHNM2Efmxknb4em4cz3ZJ3iP+qC
         JODD+4CJ10OkpyAFmQBcso5Qo0xZNyQ4RdZGGVQl1KsxZcDPla6x21VD8P27K1xbqg
         o+rngdd08ppH/vrns8Xzkmsx1ao92CD+wk/3+mqq0wSwja3D91k67D3G5MuPCUSAJ/
         dBacFNY99Z2CGNAKLt8gZ1Ql3p8xIiAi7WoElxGBS/SwVy5EYM8YKunRFvLxwAaymS
         IQGnJtgerSmx94xtYi9tmTa7/dvpbWfQ4LHg9V60wNRGwqq3+rkEbwmIfmLiNrrLmN
         ijPmxlvhjiHbQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH -next] Documentation: proc.rst: add more about the 6
 fields in loadavg
In-Reply-To: <20210222034729.22350-1-rdunlap@infradead.org>
References: <20210222034729.22350-1-rdunlap@infradead.org>
Date:   Mon, 22 Feb 2021 13:56:05 -0700
Message-ID: <87k0qzlt3u.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Address Jon's feedback on the previous patch by adding info about
> field separators in the /proc/loadavg file.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/filesystems/proc.rst |    4 ++++
>  1 file changed, 4 insertions(+)
>
> --- linux-next-20210219.orig/Documentation/filesystems/proc.rst
> +++ linux-next-20210219/Documentation/filesystems/proc.rst
> @@ -691,6 +691,10 @@ files are there, and which are missing.
>                  number of processes currently runnable (running or on ready queue);
>                  total number of processes in system;
>                  last pid created.
> +                All fields are separated by one space except "number of
> +                processes currently runnable" and "total number of processes
> +                in system", which are separated by a slash ('/'). Example:
> +                  0.61 0.61 0.55 3/828 22084
>   locks        Kernel locks

Applied, thanks.

jon
