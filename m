Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4208C34D1F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhC2N4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhC2N4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:56:42 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325EFC061574;
        Mon, 29 Mar 2021 06:56:40 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A17AE31A;
        Mon, 29 Mar 2021 13:56:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A17AE31A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1617026197; bh=wP5WqP7TpuMhuinSpqX6j4VTxGeZ7Yu9z1jrQzPzyi0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hVhTaW+qcOXhMUPdNSGEV54fHVH4+bhntN6Evj0LLSDi30TYZrzBoKHE/YgH61eP3
         4QinjQ4PRKjQUsTMlL0o3khU/W0PmTjsHRi6XLWWdEjUkYOrqs1miZMWJjZnHArjan
         sPvgW2jc1sULfLqbTIdrJSLvg5x3JHI+s/78CXEog3GUoiDl9p6HYk1BM7GQvJo1a5
         RZ6ry7BPfPO+CSrddzM0ykIWOQ6ZOHPot79Rt3N3s2XY5RzbtemN97E0FmlQZjOut0
         zMysbnKYsk39sICqO2HAaM5VxdhCYojBBU3W+8DeEn7bCZD+eniEanJ042GJOQQg5Z
         u/47nwgljIpiQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: add warning for comment not
 following kernel-doc syntax
In-Reply-To: <20210329092945.13152-1-yashsri421@gmail.com>
References: <20210329092945.13152-1-yashsri421@gmail.com>
Date:   Mon, 29 Mar 2021 07:56:37 -0600
Message-ID: <87czvit65m.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aditya Srivastava <yashsri421@gmail.com> writes:

> Currently, kernel-doc start parsing the comment as a kernel-doc comment if
> it starts with '/**', but does not take into account if the content inside
> the comment too, adheres with the expected format.
> This results in unexpected and unclear warnings for the user.
>
> E.g., running scripts/kernel-doc -none mm/memcontrol.c emits:
> "mm/memcontrol.c:961: warning: expecting prototype for do not fallback to current(). Prototype was for get_mem_cgroup_from_current() instead"
>
> Here kernel-doc parses the corresponding comment as a kernel-doc comment
> and expects prototype for it in the next lines, and as a result causing
> this warning.
>
> Provide a clearer warning message to the users regarding the same, if the
> content inside the comment does not follow the kernel-doc expected format.
>
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
>  scripts/kernel-doc | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

This is definitely a capability we want, but I really don't think that
we can turn it on by default - for now.  Experience shows that if you
create a blizzard of warnings, nobody sees any of them.  How many
warnings does this add to a full docs build?

For now I think we need a flag to turn this warning on, which perhaps
can be set for a W=1 build.

Thanks,

jon
