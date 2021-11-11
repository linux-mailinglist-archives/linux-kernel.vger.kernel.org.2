Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1151C44D481
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhKKKBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 05:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhKKKBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 05:01:06 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC53C061766;
        Thu, 11 Nov 2021 01:58:17 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ml6qU-0006ei-Sn; Thu, 11 Nov 2021 10:58:14 +0100
Message-ID: <23b693d5-0335-8f42-a206-65e170ab6e52@leemhuis.info>
Date:   Thu, 11 Nov 2021 10:58:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] fbdev: Prevent probing generic drivers if a FB is already
 registered
Content-Language: en-BS
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20211111092053.1328304-1-javierm@redhat.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20211111092053.1328304-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1636624697;2c1c1e15;
X-HE-SMSGID: 1ml6qU-0006ei-Sn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.21 10:20, Javier Martinez Canillas wrote:
> The efifb and simplefb drivers just render to a pre-allocated frame buffer
> and rely on the display hardware being initialized before the kernel boots.
> 
> But if another driver already probed correctly and registered a fbdev, the
> generic drivers shouldn't be probed since an actual driver for the display
> hardware is already present.
> 
> Reported-by: Ilya Trukhanov <lahvuun@gmail.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

TLDR: Javier, in case you need to send an improved patch, could you
please add this before the 'Reported-by:'

Link: https://lore.kernel.org/r/20211110200253.rfudkt3edbd3nsyj@lahvuun/

And if the patch is already good to go: could the subsystem maintainer
please add it when applying?


Long story: hi, this is your Linux kernel regression tracker speaking.
Thanks for working on a fix for a regression I'm keeping an eye on.

There is one small detail that could be improved: the commit message
would benefit from a link to the regression report, for reasons
explained in Documentation/process/submitting-patches.rst. To quote:

```
If related discussions or any other background information behind the
change can be found on the web, add 'Link:' tags pointing to it. In case
your patch fixes a bug, for example, add a tag with a URL referencing
the report in the mailing list archives or a bug tracker;
```

This concept is old, but the text was reworked recently to make this use
case for the Link: tag clearer. For details see:
https://git.kernel.org/linus/1f57bd42b77c

Yes, that "Link:" is not really crucial; but it's good to have if
someone needs to look into the backstory of this change sometime in the
future. But I care for a different reason. I'm tracking this regression
(and others) with regzbot, my Linux kernel regression tracking bot. This
bot will notice if a patch with a Link: tag to a tracked regression gets
posted and record that, which allowed anyone looking into the regression
to quickly gasp the current status from regzbot's webui
(https://linux-regtracking.leemhuis.info/regzbot ) or its reports. The
bot will also notice if a commit with a Link: tag to a regression report
is applied by Linus and then automatically mark the regression as
resolved then.

IOW: this tag makes my life a regression tracker a lot easier, as I
otherwise have to tell regzbot manually about the fix. ;-)

Ciao, Thorsten (while carrying his Linux kernel regression tracker hat)

#regzbot ^backmonitor
https://lore.kernel.org/r/20211110200253.rfudkt3edbd3nsyj@lahvuun/
