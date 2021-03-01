Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6961D32A00D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575213AbhCBDyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:54:21 -0500
Received: from ms.lwn.net ([45.79.88.28]:43942 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241138AbhCAWLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:11:00 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 16C612B8;
        Mon,  1 Mar 2021 22:10:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 16C612B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614636612; bh=yhsYKg3F5vkp/usJaFgj0dWVeFOB/mpQy0OCAd71Tgo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bvhkFH5K06yNqBm5tI/4edwuNLKytFnv6A46tgnAlweahPILj5nZT+MYcsc5kjuFv
         AcKC5Xasv0xk4KDp60lZodN7ht5Y3rDggJXyF3hHiD43ZRRmuKnUTnvUziupUOAUuP
         kFZ4jmKfbuEwQjgiBKXxeOVQ4aWjZPKApkSuztfuta5M8CohSZDktwBIrL5a5QIcmb
         W9+8RkPZPlAMXfdNdr2IIagVE9lHOHCEmcz9zi4SrRb4+423xme3fcP6I2bieG9kf9
         +JXXLf8zg2w4UdVDwJ9KLl9QKjhxYNVrfYDIpjUkyY3s4WW+BVj1cz1DHUD2OUqW/+
         YGG1XLwoeAhAw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/submitting-patches: Extend commit message
 layout description
In-Reply-To: <20210215141949.GB21734@zn.tnic>
References: <20201217183756.GE23634@zn.tnic> <20210215141949.GB21734@zn.tnic>
Date:   Mon, 01 Mar 2021 15:10:11 -0700
Message-ID: <874khu34qk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> From: Borislav Petkov <bp@suse.de>
> Subject: [PATCH] Documentation/submitting-patches: Extend commit message layout description
>
> Add more blurb about the level of detail that should be contained in a
> patch's commit message. Extend and make more explicit what text should
> be added under the --- line. Extend examples and split into more easily
> palatable paragraphs.
>
> This has been partially carved out from a tip subsystem handbook
> patchset by Thomas Gleixner:
>
>   https://lkml.kernel.org/r/20181107171010.421878737@linutronix.de
>
> and incorporates follow-on comments.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>
> /me sends the next generic topic blurb.
>
>  Documentation/process/submitting-patches.rst | 89 ++++++++++++--------
>  1 file changed, 56 insertions(+), 33 deletions(-)

Applied, with one tweak:

> +If there are four patches in a patch series the individual patches may
> +be numbered like this: 1/4, 2/4, 3/4, 4/4. This assures that developers
> +understand the order in which the patches should be applied and that
> +they have reviewed or applied all of the patches in the patch series.
>  
>  A couple of example Subjects::
>  
>      Subject: [PATCH 2/5] ext2: improve scalability of bitmap searching
>      Subject: [PATCH v2 01/27] x86: fix eflags tracking
> +    Subject: [PATCH v2] sub/sys: Condensed patch summary
> +    Subject: [PATCH v2 M/N] sub/sys: Condensed patch summary

It's no longer "a couple" so I made this "Here are some good example
Subjects".

Thanks,

jon
