Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3204A3A88C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhFOStK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhFOStJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:49:09 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3968CC061574;
        Tue, 15 Jun 2021 11:47:03 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso15327514otj.4;
        Tue, 15 Jun 2021 11:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=M0jPcyN+0GksOscsUu1GV8Mpyh0R661ZmzEHh6E/AMs=;
        b=AkDl/pWCrmnX6WAe8kjc7Wu2g9cEQcW98r+hZ/47zJliuKZ3xPv4lrcY57XTWjjCPN
         TjDxOAuDg549gDq99JX8OINGoRcK9OMKQwzfF4EeKoPx+0wHS1mRdtircff8T97yLmkc
         Vz3ZGBcK/nrDKZg/iaRS6UurBkq7EnJqDlo8mgG8s5pSPB9dG8sia604BeCydvudAoPv
         qcb63CZN0VPQFmYzTsivOp3pohEJOvQJB6ZmSBWX/lxmFFm5R6W7LdFzgmp0ZKYeIEMQ
         TDWvaOEEqRlZflUBxRXidrsGv+QaNPpu+/aRnHiURxqxmURv04tQxyOUaTyA+AarqVIs
         ieNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=M0jPcyN+0GksOscsUu1GV8Mpyh0R661ZmzEHh6E/AMs=;
        b=fvzxlELhqMg8bsWGgZXb4j+K8KjVUzMgpZrQ7USfW2Kbq3iFU4nWCAJu96OWyOjywF
         N9Ry5n4K4CBolKyn+32OgLxQ6wM/YO7K9Dlfg0RAmw9VSHFTe8vJo/3RNG/FZYQS0CU8
         oNOQYqdiJQ4NrzNfvMhaOz7DGjD3DegcSVTpdkagRBbpGv2FX6bGF2gseCpmX0RMqN75
         PS5pdch3q4JrcOZP85aTq/5qbqMmGo3wbJF732Ev4JU/9HtDDRUGK6K/rjbajHY6kG4K
         pYW715E5TH/Y5Dpe7trrkZztM0mByA1Fpy3cf64wHRKoqCDMuQ19XzUL5/fiFN/rgNJj
         be3A==
X-Gm-Message-State: AOAM533u6cBAsctwZfRsTJGcdwRANnlTlOL861ysgf8KBdFpxS8OUeTX
        5i0N7U6yUKGe2m+et91E8w==
X-Google-Smtp-Source: ABdhPJxQ9rkGnGivDEkuBfraFu5hFHW+Mr+Pxscs4LsNz+yhlOVsSAou40KfWpqyzu7Hu5pbUpQVVw==
X-Received: by 2002:a9d:6a03:: with SMTP id g3mr502028otn.189.1623782821114;
        Tue, 15 Jun 2021 11:47:01 -0700 (PDT)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id r1sm4355328oth.19.2021.06.15.11.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 11:47:00 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:50dd:ab38:f475:bd86])
        by serve.minyard.net (Postfix) with ESMTPSA id 258ED180293;
        Tue, 15 Jun 2021 18:46:59 +0000 (UTC)
Date:   Tue, 15 Jun 2021 13:46:57 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     openipmi-developer@lists.sourceforge.net, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, tmaimon77@gmail.com,
        linux-aspeed@lists.ozlabs.org, avifishman70@gmail.com,
        venture@google.com, linux-kernel@vger.kernel.org,
        tali.perry1@gmail.com, robh+dt@kernel.org,
        chiawei_wang@aspeedtech.com, linux-arm-kernel@lists.infradead.org,
        benjaminfair@google.com, arnd@arndb.de, zweiss@equinix.com,
        joel@jms.id.au, KWLIU@nuvoton.com
Subject: Re: [PATCH v4 00/16] ipmi: Allow raw access to KCS devices
Message-ID: <20210615184657.GF2921206@minyard.net>
Reply-To: minyard@acm.org
References: <20210608104757.582199-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608104757.582199-1-andrew@aj.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 08:17:41PM +0930, Andrew Jeffery wrote:
> 
> Hello,
> 
> This is the 4th spin of the series refactoring the keyboard-controller-style
> device drivers in the IPMI subsystem.

Ok, no comments and everything looks good, I have this queued for the
next Linux release.

Thanks,

-corey

> 
> v3 can be found at:
> 
> https://lore.kernel.org/lkml/20210510054213.1610760-1-andrew@aj.id.au/
> 
> v4:
> 
> * Makes kcs_bmc_add_device() return an error if no client successfully
>   initialised with respect to the binding of the device driver
> * Retains the existing single-open semantics (v3 allowed multiple-open)
> * Fixes the OBE macro for the NPCM7xx KCS driver
> * Cleans up Yoda-style masks (mask constant on the LHS rather than RHS)
> * Cleans up includes in kcs_bmc_client.h
> * Adds some comments to the SerIO adapter to clarify object lifetimes
> 
> Previously:
> 
> Changes in v3:
> 
> * The series was rebased onto v5.13-rc1
> * v5.13-rc1 includes Chiawei's patches reworking the LPC devicetree bindings,
>   so they're no-longer required in the series.
> * After some discussion with Arnd[1] and investigating the serio subsystem,
>   I've replaced the "raw" KCS driver (patch 16/21 in v2) with a serio adaptor
>   (patch 11/16 in this series). The adaptor allows us to take advantage of the
>   existing chardevs provided by serio.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/37e75b07-a5c6-422f-84b3-54f2bea0b917@www.fastmail.com/
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
>   ipmi: kcs_bmc: Enable IBF on open
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
>  drivers/char/ipmi/kcs_bmc.c                   | 523 ++++-----------
>  drivers/char/ipmi/kcs_bmc.h                   |  92 +--
>  drivers/char/ipmi/kcs_bmc_aspeed.c            | 633 +++++++++++++-----
>  drivers/char/ipmi/kcs_bmc_cdev_ipmi.c         | 568 ++++++++++++++++
>  drivers/char/ipmi/kcs_bmc_client.h            |  45 ++
>  drivers/char/ipmi/kcs_bmc_device.h            |  22 +
>  drivers/char/ipmi/kcs_bmc_npcm7xx.c           |  92 ++-
>  drivers/char/ipmi/kcs_bmc_serio.c             | 157 +++++
>  12 files changed, 1594 insertions(+), 706 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt
>  create mode 100644 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
>  create mode 100644 drivers/char/ipmi/kcs_bmc_client.h
>  create mode 100644 drivers/char/ipmi/kcs_bmc_device.h
>  create mode 100644 drivers/char/ipmi/kcs_bmc_serio.c
> 
> -- 
> 2.30.2
> 
