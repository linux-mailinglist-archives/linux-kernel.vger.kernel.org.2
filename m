Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61D6419D35
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbhI0RqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbhI0RqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:46:19 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D5CC01A663;
        Mon, 27 Sep 2021 10:28:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 34C3C844;
        Mon, 27 Sep 2021 17:28:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 34C3C844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1632763689; bh=45hZSbsa3yYyifWoK+L948iiVd5+eLEbaofCHJJzdjw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Lr+nDOPS5+Pb5/Gj99ApmZvr08iNfiiqUtqtRvG5rAPDz0E9wR1S0Gb+SmErDxL+D
         hkCYVsmJWScGMyXSF/Y9xZ3bTa5lRPmBoZ1PnLq/UJpAxOgWxzL0jJN61sb/Wle0jQ
         v8WPSLv74h80dZ2Q2kmHuzGRxQBhCnkXeYSPUt7L47WbxRp+iIpth+e9CCfPc4niGm
         m5uwslEo0f66JLLJGCogf/Orgoa8sDULAokaCwWmQdfcCbPj2Xd2hLuZ1pGOTtrqzg
         IQPRVImIv475jAlEkkz/v7fo2Ig0ZppQNdwhTbhO+TA7R2j/mdlzEOVGsb0ffM+z/X
         tw5qsWFtY+YlA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>,
        akpm@linux-foundation.org, peterx@redhat.com, david@redhat.com,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     ivan.teterevkov@nutanix.com, florian.schmidt@nutanix.com,
        carl.waldspurger@nutanix.com, jonathan.davies@nutanix.com,
        chris.riches@nutanix.com,
        Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
Subject: Re: [PATCH v3 0/1] Documenting shmem as an exception case for the
 pagemap
In-Reply-To: <20210923064618.157046-1-tiberiu.georgescu@nutanix.com>
References: <20210923064618.157046-1-tiberiu.georgescu@nutanix.com>
Date:   Mon, 27 Sep 2021 11:28:08 -0600
Message-ID: <87o88ehqs7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com> writes:

> This patch follows the discussions on previous documentation patch threads
> [1][2]. It presents the exception case of shared memory management from the
> pagemap's point of view. It briefly describes what is missing, why it is
> missing and alternatives to the pagemap for page info retrieval in user
> space.
>
> In short, the kernel does not keep track of PTEs for swapped out shared
> pages within the processes that references them. Thus, the proc/pid/pagemap
> tool cannot print the swap destination of the shared memory pages, instead
> setting the pagemap entry to zero for both non-allocated and swapped out
> pages. This can create confusion for users who need information on swapped
> out pages.
>
> The reasons why maintaining the PTEs of all swapped out shared pages among
> all processes while maintaining similar performance is not a trivial task,
> or a desirable change, have been discussed extensively [1][3][4][5]. There
> are also arguments for why this arguably missing information should
> eventually be exposed to the user in either a future pagemap patch, or by
> an alternative tool.
>
> [1]: https://marc.info/?m=162878395426774
> [2]: https://lore.kernel.org/lkml/20210920164931.175411-1-tiberiu.georgescu@nutanix.com/
> [3]: https://lore.kernel.org/lkml/20210730160826.63785-1-tiberiu.georgescu@nutanix.com/
> [4]: https://lore.kernel.org/lkml/20210807032521.7591-1-peterx@redhat.com/
> [5]: https://lore.kernel.org/lkml/20210715201651.212134-1-peterx@redhat.com/
>
> Tiberiu A Georgescu (1):
>   Documentation: update pagemap with shmem exceptions
>
>  Documentation/admin-guide/mm/pagemap.rst | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Applied, thanks.

jon
