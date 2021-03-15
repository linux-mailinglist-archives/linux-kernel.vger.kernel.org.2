Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544F833C744
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhCOT7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbhCOT6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:58:50 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED4EC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:58:50 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EA6602C4;
        Mon, 15 Mar 2021 19:58:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EA6602C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1615838330; bh=RmlSWDLligJdwr7tDaNy2kWKhHfrAveo2WXurLzUQFU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TimRqRDoxn6OFiaK9R2uPRk40l/KZjKgw7jLuQShx5eTZa+UkZXJMWQsIdr+tG1tN
         53mvka3oOJn8cdNL5buo+2IKaivrkzzkbhQAdzKUmMTdys+RstVBmBApvQnjRGl9QS
         aJ284LeIYnZDoeg8z35k3eQzt+vtUZ05szTxBAATTCVXdYh8GEQB+XpUBsVdbyAiJK
         6ep4DQHJlt418B+nDWz5r6BU7mmz+ciZll/cprPbfBJL0YDAZ8jgNUEE0oYO8XoGz+
         KFRNXdKlb5j8yfG46WM9mjK8nRMRuJPSSg6fXEZ9WRB4/H9E3uUZCpQdblxdAFe7Oj
         4ssfIz9mKu5Aw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>
Subject: Re: [PATCH] docs: don't include Documentation/Kconfig twice
In-Reply-To: <20210307140018.757576-1-slyfox@gentoo.org>
References: <20210307140018.757576-1-slyfox@gentoo.org>
Date:   Mon, 15 Mar 2021 13:58:49 -0600
Message-ID: <87czw01952.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergei Trofimovich <slyfox@gentoo.org> writes:

> Before the change there were two inclusions of Documentation/Kconfig:
>     lib/Kconfig.debug:source "Documentation/Kconfig"
>     Kconfig: source "Documentation/Kconfig"
>
> Kconfig also included 'source "lib/Kconfig.debug"'.
>
> Noticed as two 'make menuconfig' entries in both top level menu
> and in 'Kernel hacking' menu. The patch keeps entries only in
> 'Kernel hacking'.
>
> CC: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> CC: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
>  Kconfig | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Kconfig b/Kconfig
> index 745bc773f567..97ed6389c921 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -28,5 +28,3 @@ source "crypto/Kconfig"
>  source "lib/Kconfig"
>  
>  source "lib/Kconfig.debug"
> -
> -source "Documentation/Kconfig"
> -- 
> 2.30.1

I agree with not including it twice.  Under "kernel hacking" seems like
the wrong place to keep it, though.  There's a lot more than kernel
hacking in the kernel docs, I don't think we should bury it in quite
that way.  So I'd delete the other one.

Thanks,

jon
