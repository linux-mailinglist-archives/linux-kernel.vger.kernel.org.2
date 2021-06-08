Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8954A39F8EF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhFHOZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:25:11 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:41917 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbhFHOZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:25:10 -0400
Received: by mail-pg1-f169.google.com with SMTP id l184so1096087pgd.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 07:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BAmmwujFPDYuTf8Nk8r107UNyufgvunoQovoidHV4hs=;
        b=GN8FIpsvD34VDm3S1nG0nJU480AOWvpNxkyOgRQTMzWyT/DuARnYu5j11GhQAGBvut
         rqHlQkqMPMkS7gCLip5jbWkNUhzAVGywKNloNUKLLCbN2BIH4Yk65AR3IchCDk1iCqPK
         zQYCeu5XcRLOQj7ALaQSMHKlCorL1gVSXNFnuH7M3SR0LTJ/mtvCSXvC+MrUiF7et4d6
         it8qG7pteKSKLCVoYD+qzv6hHTDKpRUdddnqFCXlxbCvtTz/SamsJWutWEYl8T84tvCf
         3lJG3rm5EV80QJJZhlyV5hToED47Snh7Rm5AfmRAILLWK2XauenINtE8WmmT2lIYoUlN
         R6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BAmmwujFPDYuTf8Nk8r107UNyufgvunoQovoidHV4hs=;
        b=Clmnjs6nnhzHs4AcWjJejzGSKYMT8wQWV2xmcWFKrNwSov+7cXuYLEL/SNwGoKsH7C
         j1XCxfe+YhL/Z49wI8/36SIS1nLV7btE0UUPrnSo0vwqROwE4mLTCDYcnZa4lF0YRVSs
         a2htW90GukSccKpPlZ+olU6nTglyMmtEvYWWOUo3kiU4zLwetbXyOnCoANVMDbB0D7dI
         ZM9aQDOuFgoUX1ZXTdJV+4lRb2y+zXokwBiROK9EJXO3XK+STkEJGyXbeo6GEmO8YwyI
         3Ylj7gxJYArRe8BlD2BGBnyHIhEmFrc/aClwQIXwgadBzpsgSgOBLknp4q0R6N87/lQn
         e9uw==
X-Gm-Message-State: AOAM533xyfLp3qRRXm/hUGON1fM/MkVZiU15f135Xot3Pn2oRfcMGuMQ
        R5QKeYzb4sDVv651I1aGrRdC3SFTigw=
X-Google-Smtp-Source: ABdhPJw24v7KS/kRTltJouyO9S1Vv/mnP2U8zB2VYYXcKlY88wncI2V7FbjNqGlU5LTMUNWdgPlQsg==
X-Received: by 2002:a63:803:: with SMTP id 3mr22720865pgi.344.1623162122601;
        Tue, 08 Jun 2021 07:22:02 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g13sm2653318pfv.65.2021.06.08.07.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 07:22:02 -0700 (PDT)
Subject: Re: [GIT PULL 1/1] bcm2835-dt-next-2021-06-08
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20210608100543.691185-1-nsaenzju@redhat.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4f3bf1bb-1544-85f4-0539-033f36f86d19@gmail.com>
Date:   Tue, 8 Jun 2021 07:21:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210608100543.691185-1-nsaenzju@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 6/8/2021 3:05 AM, Nicolas Saenz Julienne wrote:
> Hi Florian,
> 
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> 
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2021-06-08
> 
> for you to fetch changes up to ca5909b7fa6af9c7b9a215a8708926e44345a220:
> 
>   arm64: dts: broadcom: Add reference to RPi 400 (2021-06-08 10:44:36 +0200)
> 
> ----------------------------------------------------------------

How about:

https://lore.kernel.org/linux-arm-kernel/1622981777-5023-5-git-send-email-stefan.wahren@i2se.com/

can you add this to this pull request?

> 
> - Fixup MMC node names
> - Fixup led node names
> - Introduce new devicetree file for Raspberry Pi 400
> - Fix issue with dwc2's FIFO's size
> - Add VEC compatible for bcm2711
> 
> ----------------------------------------------------------------
> Mateusz Kwiatkowski (1):
>       ARM: boot: dts: bcm2711: Add BCM2711 VEC compatible
> 
> Stefan Wahren (6):
>       Revert "ARM: dts: bcm283x: increase dwc2's RX FIFO size"
>       ARM: dts: bcm283x: Fix up MMC node names
>       ARM: dts: Move BCM2711 RPi specific into separate dtsi
>       ARM: dts: bcm283x: Fix up GPIO LED node names
>       ARM: dts: Add Raspberry Pi 400 support
>       arm64: dts: broadcom: Add reference to RPi 400
> 
>  arch/arm/boot/dts/Makefile                        |  1 +
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts             | 85 ++++-------------------
>  arch/arm/boot/dts/bcm2711-rpi-400.dts             | 45 ++++++++++++
>  arch/arm/boot/dts/bcm2711-rpi.dtsi                | 74 ++++++++++++++++++++
>  arch/arm/boot/dts/bcm2711.dtsi                    |  3 +-
>  arch/arm/boot/dts/bcm2835-rpi-a-plus.dts          |  4 +-
>  arch/arm/boot/dts/bcm2835-rpi-a.dts               |  2 +-
>  arch/arm/boot/dts/bcm2835-rpi-b-plus.dts          |  4 +-
>  arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts          |  2 +-
>  arch/arm/boot/dts/bcm2835-rpi-b.dts               |  2 +-
>  arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi            |  2 +-
>  arch/arm/boot/dts/bcm2835-rpi-zero-w.dts          |  2 +-
>  arch/arm/boot/dts/bcm2835-rpi-zero.dts            |  2 +-
>  arch/arm/boot/dts/bcm2835-rpi.dtsi                |  2 +-
>  arch/arm/boot/dts/bcm2836-rpi-2-b.dts             |  4 +-
>  arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts        |  4 +-
>  arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts        |  4 +-
>  arch/arm/boot/dts/bcm2837-rpi-3-b.dts             |  2 +-
>  arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi            |  2 +-
>  arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi        |  2 +-
>  arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi |  2 +-
>  arch/arm/boot/dts/bcm283x.dtsi                    |  2 +-
>  arch/arm64/boot/dts/broadcom/Makefile             |  3 +-
>  arch/arm64/boot/dts/broadcom/bcm2711-rpi-400.dts  |  2 +
>  24 files changed, 160 insertions(+), 97 deletions(-)
>  create mode 100644 arch/arm/boot/dts/bcm2711-rpi-400.dts
>  create mode 100644 arch/arm/boot/dts/bcm2711-rpi.dtsi
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-400.dts
> 

-- 
Florian
