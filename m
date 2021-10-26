Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D409243B5E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbhJZPn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbhJZPnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:43:39 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96DBC061767;
        Tue, 26 Oct 2021 08:41:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4A5C84B9E;
        Tue, 26 Oct 2021 15:41:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4A5C84B9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1635262871; bh=Qar+8vytJwRSlS0fY7aczsWVXmL+IR0XlsMwiepimE0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SawY5ut8Xw9PFarayg8ueip1N2VUP+dEm1IUFBnXVVaoR+06dRIP8OiilAZPdGDj9
         3LUEcJWexap2PY0THx+xyjqs2VkODs8y1OcyLcqvcCSSI6GxKmlVFYRfusH+6tyWjz
         WPZHQFiv9m7X6icSEAPSUPD1CkomRqCTZaJZyLhOAulCpPuqJMHxNXFHc4KbYqGWV7
         cYf6eYLoaf0pPrvtLtNWHmwOb3Wp2yP8I3DH6vZ8XqlSzok6lzOxgOzOys8M9N8cZ0
         krUgMq4Fbn+zAcLf0Ii3aWocMrCRpnHBWx7wQpInDb+AyLs7ikSWSuMs614703LaZg
         mtmIBqXRjk9QQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Trevor Woerner <twoerner@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Joe Perches <joe@perches.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] coding-style.rst: trivial: fix location of driver model
 macros
In-Reply-To: <CAHUNapQfFBcqrX7MvUvq8qbPgk2bPu-h3+9NxAUFpRtpOGFODw@mail.gmail.com>
References: <20210423184012.39300-1-twoerner@gmail.com>
 <CANiq72mUBh+76iy5uCAGHpKHDnTGRVyQduMngEWDMCF6kRySJA@mail.gmail.com>
 <CAHUNapQfFBcqrX7MvUvq8qbPgk2bPu-h3+9NxAUFpRtpOGFODw@mail.gmail.com>
Date:   Tue, 26 Oct 2021 09:41:10 -0600
Message-ID: <87a6ivg5ex.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trevor Woerner <twoerner@gmail.com> writes:

> ping?
>
> It doesn't look like this was picked up by trivial? Although, it doesn't
> look like git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git
> has been used in a while. Is there an alternate (preferred) path for
> trivial patches?

Hmm...no idea why I missed it the first time around.  Applied now,
apologies for the delay.

Thanks,

jon
