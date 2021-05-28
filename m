Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6472C393F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhE1JK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhE1JKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:10:54 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FB1C0613ED;
        Fri, 28 May 2021 02:09:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so4161701wmk.0;
        Fri, 28 May 2021 02:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=sMSHq+umZzE3XCm8WFGhy8tszcRmNHLJp/XbtDNl2gM=;
        b=iLSHCIfYtpvNu+mmjCpLRw7Zr8Yy5cqFGVLfeRG17HK/ggdqc1QY5wiE0lyZoUI/gJ
         hZ6sWyKh1ngYopmcClgKY5/8zzHmaJQx2V+BquCAf2KEtG7w8HE3LBXzlOJp2AuiLVRH
         UYgmcDE/ZlQHqomON5ZEDozqkQifjbdn7QXrhxjjaM8gFjAyVimja4WS6JYTQjUg1zlT
         q/FUf4C4NTmhrmrPHO5IY5eiLz3wolaeDyjcGA6Aqq7A6SlrdREq3euyvsMzt7kUMaq2
         EZ77AFrxa7JWFOUZO4T08FxP/dMUmXg6eC0VS8c7PD6lJusMjEHN2IMfiokP7vFcDT0b
         5kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=sMSHq+umZzE3XCm8WFGhy8tszcRmNHLJp/XbtDNl2gM=;
        b=rBdGwJY4mUJIVsWIAk68vmgWLvdfgmj6oLDxMr4GdWhrKryrjXv6hr9YpSfYbAsFLx
         Prmu/3l+tBgwb+dbd7nRalAtRiNXCjfBSC+0H6mwn/nKZ6Oh22GjjPi0NxKb/J3Nh3rp
         cjbAGmXtCf33s41RFHCE6fTHPbkfRlJvvzN01l3D380mVXiP7/A/jpyITPptOi6a4TQT
         o0GUXF7LzoG1NG+YpvszyRTuCwNmn8BMPv8Dy1+NIY9K8T6L/2X91dHc5MJJ4Xo2gViX
         LSh9UTemmGuaoKliizeWrm6ckWKXiTkWs8mhQg0nRo4Pyy8yhx2KC+uUbdPvlNALgW8H
         OiAQ==
X-Gm-Message-State: AOAM5314S33vhUAiqCFc1uWXn9vczjDjsBBxjLYqnvM86DAQkEJzRhiy
        cFqPSob/2vVnKR2h8ces7lWV7309pF4=
X-Google-Smtp-Source: ABdhPJz4Lkxtd9X8inDqLggacXo3tIs3S9OZpddSW82trALuGFL5G4Vs5Zydzn79SJVBLXgadoyw1w==
X-Received: by 2002:a7b:ce8d:: with SMTP id q13mr6484003wmj.67.1622192958075;
        Fri, 28 May 2021 02:09:18 -0700 (PDT)
Received: from [89.139.227.208] (89-139-227-208.bb.netvision.net.il. [89.139.227.208])
        by smtp.gmail.com with ESMTPSA id z135sm433559wmc.26.2021.05.28.02.09.16
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 28 May 2021 02:09:17 -0700 (PDT)
Message-ID: <60B0B31A.7070301@gmail.com>
Date:   Fri, 28 May 2021 12:08:42 +0300
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 2/2] char: xillybus: Add driver for XillyUSB (Xillybus
 variant for USB)
References: <20210526100311.56327-1-eli.billauer@gmail.com> <20210526100311.56327-3-eli.billauer@gmail.com> <YK+Mlw0Tn7eGFPI2@kroah.com>
In-Reply-To: <YK+Mlw0Tn7eGFPI2@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/21 15:12, Greg KH wrote:
>> diff --git a/drivers/char/xillybus/Makefile b/drivers/char/xillybus/Makefile
>> >  index 591615264591..16f31d03209d 100644
>> >  --- a/drivers/char/xillybus/Makefile
>> >  +++ b/drivers/char/xillybus/Makefile
>> >  @@ -7,3 +7,4 @@ obj-$(CONFIG_XILLYBUS_CLASS)	+= xillybus_class.o
>> >    obj-$(CONFIG_XILLYBUS)		+= xillybus_core.o
>> >    obj-$(CONFIG_XILLYBUS_PCIE)	+= xillybus_pcie.o
>> >    obj-$(CONFIG_XILLYBUS_OF)	+= xillybus_of.o
>> >  +obj-$(CONFIG_XILLYUSB)		+= xillyusb.o
>>      
> This doesn't quite work.
>
> Even if I have not selected CONFIG_XILLYBUS I get asked aboug
> CONFIG_XILLYUSB.
The symbol tree is:

XILLYBUS_CLASS --+-- XILLYBUS --+-- XILLYBUS_PCIE
                  |              |
                  |              +-- XILLYBUS_OF
                  |
                  +-- XILLYUSB


Hence not selecting CONFIG_XILLYBUS doesn't eliminate CONFIG_XILLYUSB. 
The behavior you described is correct: CONFIG_XILLYUSB doesn't depend on 
CONFIG_XILLYBUS.

>   And if I say 'm' to CONFIG_XILLYUSB, nothing gets
> built.
>
>    
Sorry, my bad. The directory is currently invoked based upon 
CONFIG_XILLYBUS, which was correct before, but now it should be 
CONFIG_XILLYBUS_CLASS. I'll submit a patch fixing that promptly.

Plus another patch removing MODULE_VERSION() from all C files, per your 
earlier comment.

Thanks and regards,
    Eli
