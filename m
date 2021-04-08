Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A847D358B9F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhDHRpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:45:47 -0400
Received: from ms.lwn.net ([45.79.88.28]:57350 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232476AbhDHRpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:45:43 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D173C52B9;
        Thu,  8 Apr 2021 17:45:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D173C52B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1617903931; bh=TN0oOAljQXzB5TwAzx7+quOJJGM5b2954LTU89BVn9M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rHeNODPjX0tiSC5souhBIW2Td7nAUEwYLCOT9gxZOhJLFEqymTtCOlbcCQRAp8r7y
         Tf0jSqbIu/sumi650FAPyDm9rPsXgQItjy8Rvjg1kWzRhXzON2uuyU3Xu6NQnQnNXd
         Uz1UNUtOTV3fEffQTs2bvdq0+XZ7wLXh2Jx1B79j+vDT6Yrm/y7NmTqQGBhgscyUnN
         ZECxdLVNnQY1it4jWIgV13syMrwOGpwm7tGaYi8HplSZ6RKkVaFbdS/CEjRDativuj
         vTo/hmbHkb1QPLSH+daB/TcctmJeSt6yZeWoOAQGZ16bzXmXof0ELdUJaP93MkYuh0
         zmc8y+B1kZBig==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wu XiangCheng <bobwxc@email.cn>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alex Shi <alexs@kernel.org>
Cc:     Harry Wei <harryxiyou@gmail.com>, Weiwei Jia <harrynjit@gmail.com>,
        Fu Wei <wefu@redhat.com>, Li Yang <leoyang.li@nxp.com>,
        Linux-Doc <linux-doc@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] doc/zh_CN: Clean zh_CN translation maintainer
In-Reply-To: <20210329151551.GA10901@mipc>
References: <20210329151551.GA10901@mipc>
Date:   Thu, 08 Apr 2021 11:45:30 -0600
Message-ID: <87wntcy8jp.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wu XiangCheng <bobwxc@email.cn> writes:

> Remove Harry Wei and <xiyoulinuxkernelgroup@googlegroups.com> from
> MAINTAINERS Chinese Translation.
>
> According to git logs, Harry Wei (aka WeiWei Jia)
> * last submitted at 2012-05-07
> commit a9e73211fb0f ("Fix a mistake sentence in the file 'Documentation/zh_CN/magic-number.txt'")
> * last Reviewed-by at 2016-02-16
> commit 45c73ea7a785 ("Documentation: Chinese translation of arm64/silicon-errata.txt")
> * last Signed-off-by at 2019-03-13 (pick by Alex Shi)
> commit 95dcdb6e125f ("docs/zh_CN: rename magic-numbers as rst doc")
>
> According to mail list archives, Harry Wei
> * last replied at 2016-02-15
> <https://lore.kernel.org/lkml/CAD+1EGPFdoD7HHZYfEWVvmesXXG27n=6KmEZ8=B6nrvb+oaLZA@mail.gmail.com/>
> * last appeared at 2018-05-12
> <https://lore.kernel.org/lkml/CA+scX6kYH8Y9_f1PLcMHG-MD9bhXgd4gGpkJanjzvwwj9L=aOQ@mail.gmail.com/>
>
> He/She did not maintain zh_CN translations for a long time.
> <xiyoulinuxkernelgroup@googlegroups.com> is a maillist for Linux group of
> Xi'an University of Posts and Telecommunications, not special for zh_CN
> translation work.
>
> Anyway, many thanks him/her and Xiyou for their contributions to the early
> Chinese translation work!
>
> Signed-off-by: Wu XiangCheng <bobwxc@email.cn>

I've applied this, thanks.

jon
