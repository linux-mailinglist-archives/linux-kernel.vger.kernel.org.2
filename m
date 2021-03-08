Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1818D331B1E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 00:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhCHXw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 18:52:56 -0500
Received: from ms.lwn.net ([45.79.88.28]:36860 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230512AbhCHXw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 18:52:27 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8905531A;
        Mon,  8 Mar 2021 23:52:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8905531A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1615247547; bh=xycfLJzH7pyVas2pNH0j+dx9g9bv6bAMeFDksMNb4Uc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OvY6G/WUvcr+5e7M4xo/eAnb2UeGdKtAJCIOB+Ep2KvkIqB722yBgRhHgfKImretx
         JZMnj9AXBbIvSsc02Ojls+pm/hqBnRbjYi7xOpZi245LLrJtOEPEuAI+IKyGttphLJ
         KLneNYEhvSJH5c01/Wpk4JbnKpeyRyncUUJDa+OugeEx6mxiQxXdLGeQZRnxE5bMQQ
         BL8hW5HsBzTfH4BhXhEDUpmHI9B8bTbkfLErwR6mrmBz0qTvu34zzNeNbXxgc+WhA8
         cIhBHCVcC32POwCErCVTTTyL8rUPTAZHbf+Ss95KbGQ4OCSSjH2f7SzzF0k8/QIolf
         aH0/J0jKE3zgA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, willy@infradead.org
Subject: Re: [RFC v2] scripts: kernel-doc: fix attribute capture in function
 parsing
In-Reply-To: <20210306113510.31023-1-yashsri421@gmail.com>
References: <CAKXUXMwoYa6xbCsqnUYL5uSA71h_3xV7-8erF6XTpmkck8ozaw@mail.gmail.com>
 <20210306113510.31023-1-yashsri421@gmail.com>
Date:   Mon, 08 Mar 2021 16:52:27 -0700
Message-ID: <8735x56w5g.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aditya Srivastava <yashsri421@gmail.com> writes:

> Currently, kernel-doc warns for function prototype parsing on the
> presence of attributes "__attribute_const__" and "__flatten" in the
> definition.
>
> There are 166 occurrences in ~70 files in the kernel tree for
> "__attribute_const__" and 5 occurrences in 4 files for "__flatten".
>
> Out of 166, there are 3 occurrences in three different files with
> "__attribute_const__" and a preceding kernel-doc; and, 1 occurrence in
> ./mm/percpu.c for "__flatten" with a preceding kernel-doc. All other
> occurrences have no preceding kernel-doc.
>
> Add support for  "__attribute_const__" and "__flatten" attributes.
>
> A quick evaluation by running 'kernel-doc -none' on kernel-tree reveals
> that no additional warning or error has been added or removed by the fix.
>
> Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> Changes in v2:
> - Remove "__attribute_const__" from the $return_type capture regex and add to the substituting ones.
> - Add support for "__flatten" attribute
> - Modify commit message
>
>  scripts/kernel-doc | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

jon
