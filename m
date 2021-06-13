Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA903A5ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 01:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhFMXDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 19:03:33 -0400
Received: from ms.lwn.net ([45.79.88.28]:41562 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232181AbhFMXDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 19:03:31 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 88AFF2C0;
        Sun, 13 Jun 2021 23:01:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 88AFF2C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1623625289; bh=HWkZpAy5GiOoN68yg+PWLteE0HW8b27h8nvWJlsf8eA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EiHDn/sLws+3m2QZ+U59ozfFVdCtGEVSsiPlJgpORScQp/CQYsbcvmkKihOE4c6hi
         HTj79QzErZBrQkypZBXm501SlJWCk/DgDcEQLsPT393snleeN8SX85Ced8/2ws9EVX
         WUZdn3UC8NTFrv3yek6HZ57M9JMkXBM3GU2qjQP9bXSjwxfzsmdQmAriGhgF5AzJpw
         P90ZV6ESrjSmpzWCbbYqhcI9Wnhni8JEIkwM8sv3b21Ff84+5yy+zCdT7KgidFp2cs
         aALXTNOvilkxMqwClOG7rs7DiIu6FSEOklaRsRfbv1dsh6XAe2xvSPS43ISUYje1IU
         QZRvnw/Fi4Bwg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Colin King <colin.king@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: Fix "the the" in a message in kernel-chktaint
In-Reply-To: <20210613202059.80403-1-colin.king@canonical.com>
References: <20210613202059.80403-1-colin.king@canonical.com>
Date:   Sun, 13 Jun 2021 17:01:29 -0600
Message-ID: <87sg1lbc8m.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> writes:

> From: Colin Ian King <colin.king@canonical.com>
>
> There is a double "the" in a message in kernel-chktaint, fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/debugging/kernel-chktaint | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
> index 719f18b1edf0..f1af27ce9f20 100755
> --- a/tools/debugging/kernel-chktaint
> +++ b/tools/debugging/kernel-chktaint
> @@ -196,7 +196,7 @@ else
>  fi
>  
>  echo "For a more detailed explanation of the various taint flags see"
> -echo " Documentation/admin-guide/tainted-kernels.rst in the the Linux kernel sources"
> +echo " Documentation/admin-guide/tainted-kernels.rst in the Linux kernel sources"

Applied, thanks.

jon
