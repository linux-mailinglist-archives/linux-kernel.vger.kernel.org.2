Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5183613D2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 23:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbhDOVBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 17:01:01 -0400
Received: from ms.lwn.net ([45.79.88.28]:58512 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235150AbhDOVBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 17:01:00 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DE32580F;
        Thu, 15 Apr 2021 21:00:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DE32580F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1618520437; bh=2+CbRqv7ZlMu8naopkm6fMmoTFHR31mRq856qSvT7ZU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RclVygl+v6fqaVf6vYW9hHwIBsFBdMBsvx3vPHTqEk9Lx05Ra9EWYrh0oO35Crk9c
         82BCWpa163fU3ShVC1sf/sbA6d2wLn+o0Zi/amPDIBoYVctNX5zWzYcy7lTyZT1VZE
         +UZu9AowboURV8/QinqKc9ZNQmWWA/FtRvjJzMXfiMbCYZQe+EmsrHmM/g3oC06Y0d
         huVVEwtwYdEU1g/jua4PXXWPQYdXcJqY0IkhhRtJ1LoUWbM5Nv74kLhr76Jfz30OZM
         Cpt6Bt3ZouvB9zUkS+Nky+sDX2ljCLRa5CUPCR07bC0IdJ89OBNnOivRepEe4K4d8i
         O/6XEgYg2fVOw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wu XiangCheng <bobwxc@email.cn>
Cc:     Alex Shi <alexs@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tsugikazu Shibata <tshibata@ab.jp.nec.com>,
        SeongJae Park <sjpark@amazon.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/2] Add a new translation tool scripts/trslt.py
In-Reply-To: <cover.1618208899.git.bobwxc@email.cn>
References: <cover.1618208899.git.bobwxc@email.cn>
Date:   Thu, 15 Apr 2021 15:00:36 -0600
Message-ID: <871rbbi7pn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wu XiangCheng <bobwxc@email.cn> writes:

> Hi all,
>
> This set of patches aim to add a new translation tool - trslt.py, which
> can control the transltions version corresponding to source files.
>
> For a long time, kernel documentation translations lacks a way to control the
> version corresponding to the source files. If you translate a file and then
> someone updates the source file, there will be a problem. It's hard to know
> which version the existing translation corresponds to, and even harder to sync
> them. 
>
> The common way now is to check the date, but this is not exactly accurate,
> especially for documents that are often updated. And some translators write 
> corresponding commit ID in the commit log for reference, it is a good way, 
> but still a little troublesome.
>
> Thus, the purpose of ``trslt.py`` is to add a new annotating tag to the file
> to indicate corresponding version of the source file::
>
> .. translation_origin_commit: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
>
> The script will automatically copy file and generate tag when creating new
> translation, and give update suggestions based on those tags when updating
> translations.
>
> More details please read doc in [Patch 2/2].

So, like Federico, I'm unconvinced about putting this into the
translated text itself.  This is metadata, and I'd put it with the rest
of the metadata.  My own suggestion would be a tag like:

  Translates: 6161a4b18a66 ("docs: reporting-issues: make people CC the regressions list")

It would be an analogue to the Fixes tag in this regard; you could have
more than one of them if need be.

I'm not sure we really need a script in the kernel tree for this; it
seems like what you really want is some sort of git commit hook.  That
said, if you come up with something useful, we can certainly find a
place for it.

Thanks,

jon
