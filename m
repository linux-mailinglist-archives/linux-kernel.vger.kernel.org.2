Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ADA3507C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbhCaUDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:03:21 -0400
Received: from ms.lwn.net ([45.79.88.28]:48660 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236283AbhCaUCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:02:50 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9F9EB9A8;
        Wed, 31 Mar 2021 20:02:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9F9EB9A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1617220969; bh=O7nWcUNgLcAIWxeUj9Ev6r+Il17hVIy3TC911geK1OM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=d2S5DRmkCKiOie0iMIJhVMKCXnNYGiTr3E4+cvKyKtMwprvcY41RzG8tcIJXOe4ta
         rc5lD+HbRWVq9CPoHXYRVexQtCsqX1hqC+XXSrcof+2TV1UHXyqf+ODF4JTEc930CT
         Xiy9WfCpluAuAg/XsG8Ln4VyirfnWSQDEM8fIWQgR2CqPD/c0XZ8RJf7UKk0JZptSr
         pyuVxEzd405SqCv0y6syaFkzVcXFzLhRRRUN+k+yAQjS1/0yD+8M1a2pPCxt3GNdzj
         40gdiDEb5TqQM9kyB6Sw9v+ujnTIYWgp/opU7ylzxiuUp8kFwC06a0p6LlbAzH2xkI
         nhfPuUils7BCQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2 0/7] Fix some issues at get_abi.pl script
In-Reply-To: <cover.1616668017.git.mchehab+huawei@kernel.org>
References: <cover.1616668017.git.mchehab+huawei@kernel.org>
Date:   Wed, 31 Mar 2021 14:02:49 -0600
Message-ID: <87zgyjjdli.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> This series replace this patch:
> 	https://lore.kernel.org/linux-doc/20210324191722.08d352e4@coco.lan/T/#t
>
> It turns that there were multiple bugs at the get_abi.pl code that
> create cross-references.
>
> Patches 1 to 6 fix those issues, and should apply cleanly on the top of
> the docs tree (although I tested against next-20210323).
>
> Patch 7 is optional, and independent from the other patches. It is meant
> to be applied against akpm's tree.  It makes the description (IMHO) 
> clearer, while producing cross references for the two mentioned symbols.

I've gone ahead and applied the set, with the exception of #7 which
doesn't apply here.

Thanks,

jon
