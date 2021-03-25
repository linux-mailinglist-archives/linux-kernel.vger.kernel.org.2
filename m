Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8412B3498D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCYR53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:57:29 -0400
Received: from ms.lwn.net ([45.79.88.28]:45092 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhCYR5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:57:02 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 535256A2;
        Thu, 25 Mar 2021 17:57:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 535256A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1616695022; bh=yeEA3l06qlC6l30C1E9Uq5HCWKl9+nik4n17LBkoWyQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NJ2IV830oOhY0bldr3HdsthczGADNjQiEVmLT+vIsyzQctzMpBHHYaij+YrArZGQn
         p56PEmyuKeFyei6Rr/jRgA68Knp1Q+xE2LvuJesK3gakulxNFeAgoMG6uZ7A1N899r
         5F+TiRjCYO9s61izH+UhMrZfNwtRr+xBheiXNZRGat4VzJuMB7K0963jZssGaYt2L5
         Fem4eUe5PSnCzjQ2IzEhc3+cv6SSxPaHIrgyMJEH/Sya1s96FG+jt1levJh/+A559q
         uB/ANnYYxUxjLwPZ5zAZs++4DAOihThIr9EVY6nRTafDCMjTBR8ToyU0xZ4Djb85a3
         a2JTXGpid1eXw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, unixbhaskar@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: Re: [PATCH] docs: sphinx:  Trivial fix of a typo in the file
 rstFlatTable.py
In-Reply-To: <20210317102056.3003768-1-unixbhaskar@gmail.com>
References: <20210317102056.3003768-1-unixbhaskar@gmail.com>
Date:   Thu, 25 Mar 2021 11:57:01 -0600
Message-ID: <877dlv15hu.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:

> s/buidler/builder/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Documentation/sphinx/rstFlatTable.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/sphinx/rstFlatTable.py b/Documentation/sphinx/rstFlatTable.py
> index a3eea0bbe6ba..1d2b9be6b6c5 100755
> --- a/Documentation/sphinx/rstFlatTable.py
> +++ b/Documentation/sphinx/rstFlatTable.py
> @@ -161,7 +161,7 @@ class ListTableBuilder(object):
>          for colwidth in colwidths:
>              colspec = nodes.colspec(colwidth=colwidth)
>              # FIXME: It seems, that the stub method only works well in the
> -            # absence of rowspan (observed by the html buidler, the docutils-xml
> +            # absence of rowspan (observed by the html builder, the docutils-xml
>              # build seems OK).  This is not extraordinary, because there exists
>              # no table directive (except *this* flat-table) which allows to
>              # define coexistent of rowspan and stubs (there was no use-case
> --

This was fixed in your previous patch from March 2.  Bhaskar, please
slow down a bit and try not to create needless work for the recipients
of your patches, OK?

Thanks,

jon
