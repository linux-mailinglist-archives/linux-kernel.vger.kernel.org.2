Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F6E347F02
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbhCXRM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbhCXRMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:12:39 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEE9C061763;
        Wed, 24 Mar 2021 10:12:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4156A380;
        Wed, 24 Mar 2021 17:12:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4156A380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1616605958; bh=BlmsETjY3d55KM0BBCtU0LhNFCRLCNUIeVyS6+Soa88=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VeiE2kfViAVhaef6m1712dyj5J7l5sbH2WPyqgc+Z04ilYKfeL/tUXhqtx4IE3KN3
         TcU1gsha0XOc7QparWNJNtX/6z2TBzyWJJxwgZhWzB0tFJI/YgYPR72mtw7jJDqmfp
         kNRM38dr4NuBy/q3LcBh0J6aS3wUqiQ2e3ACgNMxAUCJHyLB0ey2e7l7dVtZt/acxt
         rofNYG5pXW7FKD0BzTUiy1u2ifjapG1Fc8bLPDRGF4qevL92gZfnD+lydeXcOmOXtQ
         3wiC7bBPNkZT/94Jkgf9K2BeQ6vwTcnGF16PA7lfn7e2b0dFCl0YvU5+HKcey6Rgsr
         cKn7D4vH2xrrA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Finn Behrens <me@kloenk.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] script: get_abi.pl: escape "<" and ">" characters
In-Reply-To: <e02449ee86d89cd45313627b52500a6892ea37ae.1616605512.git.mchehab+huawei@kernel.org>
References: <20210317142238.228fb1e8@coco.lan>
 <e02449ee86d89cd45313627b52500a6892ea37ae.1616605512.git.mchehab+huawei@kernel.org>
Date:   Wed, 24 Mar 2021 11:12:37 -0600
Message-ID: <87sg4kcw6y.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> After merging the akpm-current tree, today's linux-next build (htmldocs)
> produced this warning:
>
> 	Documentation/ABI/testing/sysfs-kernel-mm-cma:2: WARNING: Inline interpreted text or phrase reference start-string without end-string.
>
> Introduced by commit 439d477342a3 ("mm: cma: support sysfs")
>
> As pointed by Jonathan, the problem is this text in
> sysfs-kernel-mm-cma:
>
> 	Each CMA heap subdirectory (that is, each
> 	/sys/kernel/mm/cma/<cma-heap-name> directory) contains the
> 	following items:
>
> Is not parsed well, becase the major/minor signs need to be
> escaped, when converted into cross-references.

Sorry, I kind of dropped the ball on this, and everything else really; a
bit of a challenging time here.

This makes the warning go away, but I have to wonder if it's the right
fix - wouldn't it be better to avoid trying to create a cross-reference
entirely in cases where it clearly won't work?  Or am I missing
something here?

Thanks,

jon
