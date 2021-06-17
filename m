Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B943ABC99
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhFQTXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbhFQTXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:23:14 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DFAC0611C0;
        Thu, 17 Jun 2021 12:20:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d:444a:d152:279d:1dbb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5ED319A9;
        Thu, 17 Jun 2021 19:20:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5ED319A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1623957646; bh=SmJbAchebxihD6wjv5xpN9vPNSutTDYjPCQvE9KHOGE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NmxXxKkYXwBe1LBX8EanWgeejVYK/l4gzsjSS6X/YSTLZq/A88loC8gfgYhd91NYx
         zZq/+LJdT+amMsQ+cKbQ8CF41JU1l/Kcb1ejNOr6FxLp63bg9vk8/VjwmMQOXQh2ZD
         btAJHhMLT2qd7YRRX8jJp4YWTxLXukMbHVRGWS9NylUaz67+nAeksAVqnHlGg1H0B+
         TBnVhuNP3rY1f3XgTwYVBRfRYNjH7KW2z6rXWkjsNXztSE1UMMwsLrf+1IWHBRSOla
         JdrcL8nuyAwGBgbj2kQQVkNUmAtX/BLyU4w9Bz0m9ujzoM1KPC/RrfvGsT4rGmmmRj
         aLxac/4SeGfeg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res@email.cn>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hu Haowen <src.res@email.cn>
Subject: Re: [PATCH] docs: add traditional Chinese translation for kernel
 Documentation
In-Reply-To: <20210607132414.44601-1-src.res@email.cn>
References: <20210607132414.44601-1-src.res@email.cn>
Date:   Thu, 17 Jun 2021 13:20:45 -0600
Message-ID: <87y2b8ti0i.fsf@meer.lwn.net>
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

A couple more questions...

This is a fair amount of material.  Do you intend to maintain it going
forward?  Kernel documentation can change rapidly, so that's a fair
amount of work...

[...]

> diff --git a/Documentation/translations/zh_TW/IRQ.txt b/Documentation/translations/zh_TW/IRQ.txt
> new file mode 100644
> index 000000000000..a1bd9bf9dc32
> --- /dev/null
> +++ b/Documentation/translations/zh_TW/IRQ.txt
> @@ -0,0 +1,41 @@
> +Chinese translated version of Documentation/core-api/irq/index.rst
> +
> +If you have any comment or update to the content, please contact the
> +original document maintainer directly.  However, if you have a problem
> +communicating in English you can also ask the Chinese maintainer for
> +help.  Contact the Chinese maintainer if this translation is outdated
> +or if there is a problem with the translation.
> +
> +Maintainer: Eric W. Biederman <ebiederman@xmission.com>
> +Traditional Chinese maintainer: Fu Wei <tekkamanninja@gmail.com>

Do I understand this to mean that this translation is not your work?  If
so, then this should come in as a separate patch from the person who did
the work or, at a bare minimum, this patch should include their signoff.

Thanks,

jon
