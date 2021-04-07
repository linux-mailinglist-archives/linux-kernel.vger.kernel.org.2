Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B8A356406
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244690AbhDGGfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:35:15 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:33703 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhDGGfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:35:14 -0400
X-Originating-IP: 82.65.183.113
Received: from [172.16.5.113] (82-65-183-113.subs.proxad.net [82.65.183.113])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 82B662000A;
        Wed,  7 Apr 2021 06:35:03 +0000 (UTC)
Subject: Re: [PATCH] driver: of: Properly truncate command line if too long
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210316193820.3137-1-alex@ghiti.fr>
 <CAHp75VfqztgEcs8wVD7k=F-cmXsVFN=_KTgcRq5+=HpjAJCZPQ@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <3bd1df97-9633-a8cd-291c-906b8574565d@ghiti.fr>
Date:   Wed, 7 Apr 2021 02:35:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfqztgEcs8wVD7k=F-cmXsVFN=_KTgcRq5+=HpjAJCZPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Le 4/6/21 à 6:56 PM, Andy Shevchenko a écrit :
> 
> 
> On Tuesday, March 16, 2021, Alexandre Ghiti <alex@ghiti.fr 
> <mailto:alex@ghiti.fr>> wrote:
> 
>     In case the command line given by the user is too long, warn about it
>     and truncate it to the last full argument.
> 
>     This is what efi already does in commit 80b1bfe1cb2f ("efi/libstub:
>     Don't parse overlong command lines").
> 
>     Reported-by: Dmitry Vyukov <dvyukov@google.com
>     <mailto:dvyukov@google.com>>
>     Signed-off-by: Alexandre Ghiti <alex@ghiti.fr <mailto:alex@ghiti.fr>>
>     ---
>       drivers/of/fdt.c | 21 ++++++++++++++++++++-
>       1 file changed, 20 insertions(+), 1 deletion(-)
> 
>     diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>     index dcc1dd96911a..de4c6f9bac39 100644
>     --- a/drivers/of/fdt.c
>     +++ b/drivers/of/fdt.c
>     @@ -25,6 +25,7 @@
>       #include <linux/serial_core.h>
>       #include <linux/sysfs.h>
>       #include <linux/random.h>
>     +#include <linux/ctype.h>
> 
>       #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>       #include <asm/page.h>
>     @@ -1050,9 +1051,27 @@ int __init early_init_dt_scan_chosen(unsigned
>     long node, const char *uname,
> 
>              /* Retrieve command line */
>              p = of_get_flat_dt_prop(node, "bootargs", &l);
>     -       if (p != NULL && l > 0)
>     +       if (p != NULL && l > 0) {
>                      strlcpy(data, p, min(l, COMMAND_LINE_SIZE));
> 
>     +               /*
>     +                * If the given command line size is larger than
>     +                * COMMAND_LINE_SIZE, truncate it to the last complete
>     +                * parameter.
>     +                */
>     +               if (l > COMMAND_LINE_SIZE) {
>     +                       char *cmd_p = (char *)data +
>     COMMAND_LINE_SIZE - 1;
>     +
>     +                       while (!isspace(*cmd_p))
>     +                               cmd_p--;
> 
> 
> Shouldn’t you check for cmd_p being always bigger than or equal to data?

Yes you're right.

> 
>     +
>     +                       *cmd_p = '\0';
>     +
>     +                       pr_err("Command line is too long: truncated
>     to %d bytes\n",
>     +                              (int)(cmd_p - (char *)data + 1));
> 
> 
> Do you really need that casting?

No, I can use %td to print a pointer difference.

I'll send a v2.

Thanks,

Alex

> 
>     +               }
>     +       }
>     +
>              /*
>               * CONFIG_CMDLINE is meant to be a default in case nothing else
>               * managed to set the command line, unless CONFIG_CMDLINE_FORCE
>     -- 
>     2.20.1
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
