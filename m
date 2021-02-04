Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC90130FFA0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhBDVt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhBDVtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:49:02 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E39FC061786;
        Thu,  4 Feb 2021 13:48:22 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7800E4CD5;
        Thu,  4 Feb 2021 21:48:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7800E4CD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1612475302; bh=0Cefb0gsobi/X7QNTiuzllg5VsAycXRpNJvVDxfmWBY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NDUJ2y0AkrD5a+Fa7SKOVvGOCp8y1ZVJgeGENOY+X5LBKPP3YyjFQdg0pJm0+FReA
         RB/Zndnf9KWxYBr3/Nwx2pAdAiUszVklLAxJkrhdfg/ihibIix3JZm3ClY+VgdBa2j
         fT0iUJ/35jLwC/zMtcgxHA9GqULXjoKmBi83+OOPtxsvSeVpYh+WWtuU/7gooGvmKZ
         DQNJCZaiPuhiGkWhJDcIDPC+83kJ+NUblw4Adb9gdA5BtJRKq9Ry1wWhA1DLZKu77Q
         NDnOCo4DfwqG7+QsUMQ1kXiu9adWa4nn29oEVUPfQ/BZ3hBb+Vev83ig8ZCEmCynQ4
         DimHVOuVFFoYA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?Q?And?= =?utf-8?Q?r=C3=A9?= Almeida 
        <andrealmeid@collabora.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 1/2] docs: Make syscalls' helpers naming consistent
In-Reply-To: <20210130014547.123006-1-andrealmeid@collabora.com>
References: <20210130014547.123006-1-andrealmeid@collabora.com>
Date:   Thu, 04 Feb 2021 14:48:20 -0700
Message-ID: <874kirfqsb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andr=C3=A9 Almeida <andrealmeid@collabora.com> writes:

> The documentation explains the need to create internal syscalls' helpers,
> and that they should be called `kern_xyzzy()`. However, the comment at
> include/linux/syscall.h says that they should be named as
> `ksys_xyzzy()`, and so are all the helpers declared bellow it. Change the
> documentation to reflect this.
>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Fixes: 819671ff849b ("syscalls: define and explain goal to not call sysca=
lls in the kernel")
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
> ---
>  Documentation/process/adding-syscalls.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I've applied both patches thanks (also did s/syscall.h/syscalls.h in the
above changelog).

jon
