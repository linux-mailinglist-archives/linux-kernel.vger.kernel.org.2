Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B332345DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhCWMG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhCWMGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:06:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613B0C061574;
        Tue, 23 Mar 2021 05:06:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso10702852wmi.0;
        Tue, 23 Mar 2021 05:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=5A3Ab9JEMCBsRsVxBrOyI0S/pK42lF/JqjHO5w3aGMA=;
        b=mEmHuF/RZWbCfJmjbVmbCzY01R+08VE/tgHr7Dyq27bbbbB0r5YVPHDBUxqTAE2uIr
         4oFMfxkaLmG5y/Oo/hks9aWr9YJ6kywfiHGVtAOLl8PeK5QhU/p8t6A+45K+kGdjSNyZ
         nZWwSuxkacvG6k6k40SYzJBJjEefGT34keGKNWcNP7ou4PbbSkGIy/iatetXDHC9vydX
         NhIgCMRgklOUsnJDe2TGqwwHBjXlhNlJ/HcusmzwQq03EBSmU5a4Iz9+x4XDXujSbh3g
         nIkhDgp1p4BJ5NkkwrsTJ/NQW6lzkzWDcjA70ML+V9XkJ5cwc3naLsCBYlY8PjOFfSue
         mY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=5A3Ab9JEMCBsRsVxBrOyI0S/pK42lF/JqjHO5w3aGMA=;
        b=MEXgbSd6S+gQE3BbX3tuVARFMQEVsXmHixWlUNh3hNt4/f0zoIQ81vwI5b4IpIWgOV
         JtE0E98DoURSJUtPt+l13xgJBQN2vx5fGx3r8IEPJ2XvgMpibBZvQjyRME1Tb1aj7B+z
         5hWK8FzophSBme6GF0YLYlMk82PD45clgIqFTTgXgYDLfm2qQ9nG34w+DR7A5NGVoIOm
         V3IAgQtfa01rlBowTfgiJ04GITlX45VGX/Td0amKREhPCwFW0I7jYDxjjehCkE1MV2aE
         nFC9+/cONan75Lkwe0aExupcKGsM8n3Hi5Dugz0kfsiSDlyN9yIa0GTu+0UXqcdXcDQm
         csQA==
X-Gm-Message-State: AOAM531umrQR/3QEiSJ8was5q/qhM09SCp21t08SSjStUIXaxRQj8hRG
        2flhzvaaEj3vkOvJdW1D+FW1gHimnkrDEQ==
X-Google-Smtp-Source: ABdhPJwTexvTC/0ftGktlFifpBfSPbyVrg40L1J1SkxHp/hIEMcszPKeXblNA/eb9Dwauj4YIcR12g==
X-Received: by 2002:a7b:c316:: with SMTP id k22mr3013565wmj.176.1616501167141;
        Tue, 23 Mar 2021 05:06:07 -0700 (PDT)
Received: from [93.173.65.134] (93-173-65-134.bb.netvision.net.il. [93.173.65.134])
        by smtp.gmail.com with ESMTPSA id u23sm2532725wmn.26.2021.03.23.05.06.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 23 Mar 2021 05:06:06 -0700 (PDT)
Message-ID: <6059D983.5080306@gmail.com>
Date:   Tue, 23 Mar 2021 14:05:23 +0200
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     devel@driverdev.osuosl.org, dan.carpenter@oracle.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH v4 1/2] char: xillybus: Move class-related functions to
 new xillybus_class.c
References: <20210311095033.20956-1-eli.billauer@gmail.com> <20210311095033.20956-2-eli.billauer@gmail.com> <YFc65bvAN3/ZNsww@kroah.com> <6058792C.90801@gmail.com> <YFh7dlY9cntgoLXD@kroah.com>
In-Reply-To: <YFh7dlY9cntgoLXD@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/21 13:11, Greg KH wrote:
>
>> XILLYBUS and XILLYBUS_PCIE are currently enabled as M in several Linux
>> distributions. Making them depend on, rather than select XILLYBUS_CLASS is
>> likely to disable the driver in those distributions.
>>      
> That's not an issue here, depends-on will allow those distros to also
> enable this option.
>
> But wait, why is this a separate option at all?  Shouldn't the class
> code just be part of the "core" XILLYBUS code anyway?
>
>    
I'll try to explain the whole picture:

            XILLYBUS_CLASS
               /        \
              |          |
          XILLYBUS   XILLYUSB
       /           \
      |             |
XILLYBUS_PCIE  XILLYBUS_OF

XILLYBUS_CLASS is new and common to all drivers in this group.

XILLYBUS is for drivers based upon memory registers + DMA-based 
interfaces, and it's combined with XILLYBUS_PCIE and/or XILLYBUS_OF. 
XILLYUSB is for the USB variant only.

Or a more detailed, bottom-up outline:

* CONFIG_XILLYBUS_PCIE -> xillybus_pcie.c: Functions related to PCIe.
* CONFIG_XILLYBUS_OF -> xillybus_of.c: Functions related to Xillybus as 
a peripheral on an FPGA / Processor combo chip.
* CONFIG_XILLYBUS -> xillybus_core.c: Functions that are common to the 
two above, mainly access to the peripheral with memory-mapped registers 
and DMA.
* CONFIG_XILLYUSB -> xillyusb.c: The driver for the USB variant, 
accesses the peripheral through the USB framework.
* CONFIG_XILLYBUS_CLASS -> xillybus_class.c: The new module, which 
contains the class and API parts that would otherwise appear both in 
xillybus_core.c and xillyusb.c. Contains utility functions for the two 
latter.

Because XILLYBUS_CLASS is new and "N" by default, making a "depends on" 
relationship means that "make olddefconfig" silently turns off 
CONFIG_XILLYBUS and CONFIG_XILLYBUS_PCIE. That's a bug: Adding a new 
driver shouldn't change anything in the existing configuration.

That's why I had the "select XILLYBUS_CLASS" to begin with: It ensures a 
smooth transition on a kernel upgrade, by adding XILLYBUS_CLASS to 
kernels that had CONFIG_XILLYBUS enabled. Is there another way to 
prevent the said bug, without "select"?

Thanks and regards,
    Eli
