Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF6E36F2E9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 01:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhD2Xk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 19:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD2XkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 19:40:25 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76F3C06138B;
        Thu, 29 Apr 2021 16:39:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1D0AC7F5;
        Thu, 29 Apr 2021 23:39:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1D0AC7F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1619739578; bh=+1o2wiVwhHr+5oxDNKCDjupCqR9q4KZCtA+XI9ideww=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=L6vgs2yfELlVPUdWwFYnsXqynUX4mbviLY7TT+71ptKDwCSv2fg80vKJ2PoWXtC0Z
         VxsgXqamjTAzKnOwvX3l/JT1FBnLtK8rrGke60SkeppesfrznUG7OhktCIT9f8h3fK
         Mgr1anGo8p3ZUlSyGnl/IbAKDUWjyRqpv33R8caAaF9aohe5cSK1lMmwYtvm1wLBic
         RgLv7MG0tj4qJkv7iB38LBzD19ZE/NBLjukadyie1SAxaaD+YvHQuWXL4uoi95l9OE
         ko6O+F9FdwQ7kVokKJt6PyCtA5HnuKCFsPABXfJBLfJDY90bVK3gH7cJyozpE4Z+xt
         91CqaT3Q7F8ww==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com, willy@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3] scripts: kernel-doc: reduce repeated regex expressions
 into variables
In-Reply-To: <20210429063729.8144-1-yashsri421@gmail.com>
References: <20210427165633.GA235567@casper.infradead.org>
 <20210429063729.8144-1-yashsri421@gmail.com>
Date:   Thu, 29 Apr 2021 17:39:37 -0600
Message-ID: <8735v8d5ja.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aditya Srivastava <yashsri421@gmail.com> writes:

> There are some regex expressions in the kernel-doc script, which are used
> repeatedly in the script.
>
> Reduce such expressions into variables, which can be used everywhere.
>
> A quick manual check found that no errors and warnings were added/removed
> in this process.
>
> Suggested-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> Changes in v3:
> - Remove variables for separate qualifiers in "sub dump_struct"
> - Make a common variable for all the qualifiers
> - Make $attribute global variable to use it at "sub check_sections" as well
>
> Changes in v2:
> - Rename $pointer_function to $function_pointer
> - Combine elsif-block expressions at "sub dump_function" into lesser regex expressions
> - Combine $prototype_end1,$prototype_end2 expressions into a common $prototype_end
>
>  scripts/kernel-doc | 71 ++++++++++++++++++++++------------------------
>  1 file changed, 34 insertions(+), 37 deletions(-)

So this looks good but ... it adds a warning to the build:

/stuff/k/git/kernel/Documentation/driver-api/media/v4l2-controls:823: ./include/media/v4l2-ctrls.h:964: WARNING: Invalid C declaration: Expected identifier in nested name. [error at 6]
  const * v4l2_ctrl_get_menu (u32 id)
  ------^

So it looks like something isn't being parsed quite identically?

Thanks,

jon
