Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760C93373E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhCKN24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:28:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233608AbhCKN2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:28:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CE9765019;
        Thu, 11 Mar 2021 13:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615469301;
        bh=W5NWfVys3KLJrGONFLWQnhsx9yWRyW+yAlxtZ5I/LII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g9Qgjsy7SRA9vTd3Vf5RmWaAwNm/ExZ/3j7VaQhlFQs8c/Rz1k3hkAv3H5rfT9sgn
         NVBGbJfrQjs5V1mxmOO1XFGnuLjGZfco7pJuaSjI4/q7IKi++FQX4NyTsUne6AbutD
         nSg53h0dKoAj8CXDPU7SVlsLwXe+tb0xMiokPqgV7SHViU/PvXXRWaJqXEH9U0zS/v
         xJ4psuf8LExbcYDiyjiTF34m7zGhKcfPx4TM23B4uQ7bBVYEkuX0Pjs2CnSppPbP7r
         /qGJ0OrxsM+aOl3ozdeA9fEjGnDfyTtZXQBYbY7YT0hY2wYeADduaahPGNDYZQFYYm
         1h2AYLzKaobDw==
Date:   Thu, 11 Mar 2021 14:28:14 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 2/2] modules: add CONFIG_MODPROBE_PATH
Message-ID: <YEoa7kbjrCFJUsEF@gunter>
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-3-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210309211700.2011017-3-linux@rasmusvillemoes.dk>
X-OS:   Linux gunter 5.11.2-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Rasmus Villemoes [09/03/21 22:17 +0100]:
>Allow the developer to specifiy the initial value of the
>modprobe_path[] string. This can be used to set it to the empty string
>initially, thus effectively disabling request_module() during early
>boot until userspace writes a new value via the
>/proc/sys/kernel/modprobe interface. [1]
>
>When building a custom kernel (often for an embedded target), it's
>normal to build everything into the kernel that is needed for booting,
>and indeed the initramfs often contains no modules at all, so every
>such request_module() done before userspace init has mounted the real
>rootfs is a waste of time.
>
>This is particularly useful when combined with the previous patch,
>which allowed the initramfs to be unpacked asynchronously - for that
>to work, it had to make any usermodehelper call wait for the unpacking
>to finish before attempting to invoke the userspace helper. By
>eliminating all such (known-to-be-futile) calls of usermodehelper, the
>initramfs unpacking and the {device,late}_initcalls can proceed in
>parallel for much longer.
>
>For a relatively slow ppc board I'm working on, the two patches
>combined lead to 0.2s faster boot - but more importantly, the fact
>that the initramfs unpacking proceeds completely in the background
>while devices get probed means I get to handle the gpio watchdog in
>time without getting reset.
>
>[1] __request_module() already has an early -ENOENT return when
>modprobe_path is the empty string.
>
>Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Jessica Yu <jeyu@kernel.org>

Thanks!
