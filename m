Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9622838CC45
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbhEURhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbhEURho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:37:44 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE2EC061574;
        Fri, 21 May 2021 10:36:20 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id o66-20020a4a44450000b029020d44dea886so4742271ooa.5;
        Fri, 21 May 2021 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=xsZwyz8bU4yD245jhx9rPS0/zoGZWsugEiI8VeaXwz4=;
        b=CTE2dQFpKlqhV9xA3GSGL8nDvpghVK9LimwK1q3I8P0dnbBZqSYYbFz55efe5eyVDt
         Qit5eNZ2mo8/DdfUIQtWsHmKZWItaKl9jpUZUxi5un1GFMYhTc7fb9BRsYpHaF8a1A7F
         gdnOzm3Vo8MRhsJtXus9p2hh6CGz1j/jQWGHew+EzO1DuP9nVxvKY2CQh99vvyU/uOwM
         yQlHV3e74CVYPd+P2IJrQbwbH8bynY9hHkGTlrHQ4ghvd9aZpKvOXlOvq8YGwb/LG7gM
         1EB5cyNm7AsaN15riAgXWNW/RJ4KC9uZHXb0KFLpfCw7Xm/mOA0LPg8vck01Yv4JoowH
         pNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=xsZwyz8bU4yD245jhx9rPS0/zoGZWsugEiI8VeaXwz4=;
        b=affS76SDUiYL/V3tkJKopggmoCc7wm7EKX+QgmUP2IHSbqRQqly5wd3KVDA3zVNsM9
         OBXujZ6y0NXcvECDZeW03/f2SewUHn7TwxqolXfkivBTeS5Rp3gBZOnr/9RkTbdTFaHV
         JZqGD6O2balA9Yu162iVLjC9Ule2PewQeH4vEd785J6wYNTOTqMamTJrp9byOC/yiPRG
         604cXdSaOCgwo6O2ddh6Jrje9QIUR4rxUWUDtBwng3yHI74FZOZqTXpR58uCVJGZtD/E
         5/nFl1VD3gdNm20hT5n73/Dc6nI3vNepi0L17SGqn4XTZSyudhBqb1q/8xPyg+x/IIIm
         KR/A==
X-Gm-Message-State: AOAM530dT9FuvPbY2o698GNQR3GlOB6jLxe8SQxQszoY/5v/IXwY/g3b
        kJtnx1P24XtA3tV6sAOMEA==
X-Google-Smtp-Source: ABdhPJzbCHFdLAdHPLmr/dH91nFshv8QRe7ey6knMySKTHguizVh3ISRUyFZezmXrFL/yp5yhV0qcQ==
X-Received: by 2002:a4a:c88f:: with SMTP id t15mr9071550ooq.84.1621618579446;
        Fri, 21 May 2021 10:36:19 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id f2sm1373733otp.77.2021.05.21.10.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 10:36:18 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:9c8f:21cb:3961:b550])
        by serve.minyard.net (Postfix) with ESMTPSA id 95ABE180105;
        Fri, 21 May 2021 17:36:17 +0000 (UTC)
Date:   Fri, 21 May 2021 12:36:16 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     openipmi-developer@lists.sourceforge.net, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, tmaimon77@gmail.com,
        linux-aspeed@lists.ozlabs.org, avifishman70@gmail.com,
        venture@google.com, linux-kernel@vger.kernel.org,
        tali.perry1@gmail.com, robh+dt@kernel.org,
        chiawei_wang@aspeedtech.com, linux-arm-kernel@lists.infradead.org,
        benjaminfair@google.com, arnd@arndb.de, zweiss@equinix.com
Subject: Re: [PATCH v3 00/16] ipmi: Allow raw access to KCS devices
Message-ID: <20210521173616.GK2921206@minyard.net>
Reply-To: minyard@acm.org
References: <20210510054213.1610760-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510054213.1610760-1-andrew@aj.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 03:11:57PM +0930, Andrew Jeffery wrote:
> Hello,
> 
> This is the 3rd spin of the series refactoring the keyboard-controller-style
> device drivers in the IPMI subsystem.

This is a nice set of cleanups outside of just allowing raw access.
I'll let you handle Zev's comments and a few of mine.

I almost hate to ask this, but would there be value in allowing the BT
driver to use this abstract interface?  Or maybe it would be just too
hard to get a common abstraction, more work than it's worth.  It's
surprising that more people don't want BT as it's vastly superior to
KCS.  Just a thought for now.  I guess there's SMIC, but hopefully
nobody wants that.

-corey

> 
> v2 can be found (in two parts because yay patch workflow mistakes) at:
> 
> Cover letter:
> https://lore.kernel.org/linux-arm-kernel/20210319061952.145040-1-andrew@aj.id.au/
> 
> Patches:
> https://lore.kernel.org/linux-arm-kernel/20210319062752.145730-1-andrew@aj.id.au/
> 
> Several significant changes in v3:
> 
> 1. The series is rebased onto v5.13-rc1
> 
> 2. v5.13-rc1 includes Chiawei's patches reworking the LPC devicetree bindings,
>    so they're no-longer required in the series.
> 
> 3. After some discussion with Arnd[1] and investigating the serio subsystem,
>    I've replaced the "raw" KCS driver (patch 16/21 in v2) with a serio adaptor
>    (patch 11/16 in this series). The adaptor allows us to take advantage of the
>    existing chardevs provided by serio.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/37e75b07-a5c6-422f-84b3-54f2bea0b917@www.fastmail.com/
> 
> Finally, I've also addressed Zev Weiss' review comments where I thought it was
> required. These comments covered a lot of minor issues across (almost) all the
> patches, so it's best to review from a clean slate rather than attempt to review
> the differences between spins.
> 
> Previously:
> 
> Changes in v2 include:
> 
> * A rebase onto v5.12-rc2
> * Incorporation of off-list feedback on SerIRQ configuration from
>   Chiawei
> * Further validation on hardware for ASPEED KCS devices 2, 3 and 4
> * Lifting the existing single-open constraint of the IPMI chardev
> * Fixes addressing Rob's feedback on the conversion of the ASPEED KCS
>   binding to dt-schema
> * Fixes addressing Rob's feedback on the new aspeed,lpc-interrupts
>   property definition for the ASPEED KCS binding
> 
> Please test and review!
> 
> Andrew
> 
> Andrew Jeffery (16):
>   ipmi: kcs_bmc_aspeed: Use of match data to extract KCS properties
>   ipmi: kcs_bmc: Make status update atomic
>   ipmi: kcs_bmc: Rename {read,write}_{status,data}() functions
>   ipmi: kcs_bmc: Split out kcs_bmc_cdev_ipmi
>   ipmi: kcs_bmc: Turn the driver data-structures inside-out
>   ipmi: kcs_bmc: Split headers into device and client
>   ipmi: kcs_bmc: Strip private client data from struct kcs_bmc
>   ipmi: kcs_bmc: Decouple the IPMI chardev from the core
>   ipmi: kcs_bmc: Allow clients to control KCS IRQ state
>   ipmi: kcs_bmc: Don't enforce single-open policy in the kernel
>   ipmi: kcs_bmc: Add serio adaptor
>   dt-bindings: ipmi: Convert ASPEED KCS binding to schema
>   dt-bindings: ipmi: Add optional SerIRQ property to ASPEED KCS devices
>   ipmi: kcs_bmc_aspeed: Implement KCS SerIRQ configuration
>   ipmi: kcs_bmc_aspeed: Fix IBFIE typo from datasheet
>   ipmi: kcs_bmc_aspeed: Optionally apply status address
> 
>  .../bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml | 106 +++
>  .../bindings/ipmi/aspeed-kcs-bmc.txt          |  33 -
>  drivers/char/ipmi/Kconfig                     |  27 +
>  drivers/char/ipmi/Makefile                    |   2 +
>  drivers/char/ipmi/kcs_bmc.c                   | 526 ++++-----------
>  drivers/char/ipmi/kcs_bmc.h                   |  92 +--
>  drivers/char/ipmi/kcs_bmc_aspeed.c            | 635 +++++++++++++-----
>  drivers/char/ipmi/kcs_bmc_cdev_ipmi.c         | 568 ++++++++++++++++
>  drivers/char/ipmi/kcs_bmc_client.h            |  48 ++
>  drivers/char/ipmi/kcs_bmc_device.h            |  22 +
>  drivers/char/ipmi/kcs_bmc_npcm7xx.c           |  94 ++-
>  drivers/char/ipmi/kcs_bmc_serio.c             | 151 +++++
>  12 files changed, 1582 insertions(+), 722 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt
>  create mode 100644 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
>  create mode 100644 drivers/char/ipmi/kcs_bmc_client.h
>  create mode 100644 drivers/char/ipmi/kcs_bmc_device.h
>  create mode 100644 drivers/char/ipmi/kcs_bmc_serio.c
> 
> -- 
> 2.27.0
> 
