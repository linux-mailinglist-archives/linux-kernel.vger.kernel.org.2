Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256B739D247
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 01:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhFFXsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 19:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhFFXsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 19:48:11 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E45C061766;
        Sun,  6 Jun 2021 16:46:21 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 04FE7C01F; Mon,  7 Jun 2021 01:46:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1623023177; bh=a1qmuhTbRMTd0aB2zPF4gCLCyeO0G69jA1FO5xmsoZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cXg3tGONFF3FcCFKwnO09YbIhoCamqTIDbMo1s5z9NcDdQ3OghvCZdNQ3JP+zr9PX
         51ojzcpz9HAKKiHZMSg6qu5g61yUvfWYX8CVt5lJY67MpbMBnSL+lP4BdgtsyvxTzu
         bwNGXPo5u71LI6dPuiZU6Qw0AyvzLdjGeNuH3j8vwRK2nUEVHktA5FGQlUxCAjnpgm
         HIzv7GlyEFk3qfjTXDlzlN3pRIDUZfE4TS4UZXRqrkYH9eP6Ih+9gqsApB7xMWVU29
         NYTmmmJTgxyuxkLV96Dv7YhlCPxPzLN3ZppVlTYblEPWJ0v+NB3pyjU10Y3yJgfmEb
         tsAJKcfUzRF7A==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id DB4DCC009;
        Mon,  7 Jun 2021 01:46:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1623023176; bh=a1qmuhTbRMTd0aB2zPF4gCLCyeO0G69jA1FO5xmsoZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmGfezxeJxwOv5BqY9/PwoWrqOmWeXpy4pgg8FwqU8JyewqKx7hNYFUMDHz3YoPh8
         1jpdGB/jSDuHGZ9dUe1d6LIKlSLIzLEn5Znd4VvwmlymnEsDgxDL5HSGjlF/bo40uz
         2cIZsnL4VrqetV5fK193sTj9TgYCYi/0D3cefGZSEmTMLdnM1mYlYZdCzbGz1ogZ18
         zLKyCNgQQlMCP7zgq0+K60q9QLjcB/3vXroyZP1OKHDnotfyvNVOfWXDtkDqJ7wbOy
         nKj9b1Y5Xxe3Zke07nBZD57v7smNkhuT8caOzTTRBvBVU3uUi7tWHQR/yA6DN3JqNW
         x02F9A+nqxh2w==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 38eba9d2;
        Sun, 6 Jun 2021 23:46:10 +0000 (UTC)
Date:   Mon, 7 Jun 2021 08:45:55 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH v3 0/3] 9p: add support for root file systems
Message-ID: <YL1eM+mzjuggDvqp@codewreck.org>
References: <20210606230922.77268-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210606230922.77268-1-changbin.du@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changbin Du wrote on Mon, Jun 07, 2021 at 07:09:19AM +0800:
> Just like cifs and nfs, this short series enables rootfs support for 9p.
> Bellow is an example which mounts v9fs with tag 'r' as rootfs in qemu
> guest via virtio transport.
> 
>   $ qemu-system-x86_64 -enable-kvm -cpu host -m 1024 \
>         -virtfs local,path=$rootfs_dir,mount_tag=r,security_model=passthrough,id=r \
>         -kernel /path/to/linux/arch/x86/boot/bzImage -nographic \
>         -append "root=/dev/v9fs v9fsroot=r,trans=virtio rw console=ttyS0 3"

Thanks for rebasing -- I haven't forgotten, just been otherwise busy.

Will make time for this and the netfs rework over the next couple of
weeks.


Just a couple of notes:

linux-fsdevel@vger is still not in Cc of the patches, and they weren't
for any other version except for one of my replies, so it might be worth
resending just for them as it touches do_mounts.c / root_dev.h


>  MAINTAINERS                                 |  8 ++-

I don't think it's worth adding yourself as MAINTAINERS for this, will
likely strip it out (I know I'm the one who asked for your help if
people have problems with this, but we should keep contacts simple)
I'll forward you requests when they come if it's not trivial and you're
not subscribed to the v9fs-developer@sf list

-- 
Dominique
