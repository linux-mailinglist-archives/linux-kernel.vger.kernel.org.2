Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D54D30AC25
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhBAP6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhBAP6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:58:43 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D76CC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 07:58:03 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id z6so17080732wrq.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=QqxA3UTXwWM1rUS5ffJhVzREVnA5BJx0q4tUTFRKoM8=;
        b=kyo3wi6MCZj3B2NQKJ4i+pexIGgnQWvXYw3xxq9aEzGH0EsgBM/IpZiFINHxSi0tXK
         liS5oWpsY/703lZ3Q0CpSg4jRDkBpdS94doz/AWvMnPB/fcXvULpVseeFpNACzOsU83/
         WrJcg8B7E0lRVdeCmwShfLtH5eW6lfbSwiJsXQk4ydAEBNvOI80kZPzhS2IFezA91DLC
         x20jguhVA3XDNUnMDP3U4Bzb5IyAt5CpmJ75WuvlglzKrnlMg/nbsnvr1wvdXiLzOF36
         IGauz+jbN/NZNbrylj8UvqiaCBwE4qTrTYUHqidEp3TVbWFRMdY34fuYmXTNPy+GlLAY
         JR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=QqxA3UTXwWM1rUS5ffJhVzREVnA5BJx0q4tUTFRKoM8=;
        b=H2nknqv5ZRG9fQ+AiH6UEwjPnnVhOsjgFDP1cn4mnBO5lP/hRCi5gnlJ46/bl2zGHH
         vu8bU8X0DcSObNQXX8ZtQO52CB9HidOLOPvnoRP1nr41kadNF16YwqVu5f+nW0PVf7VY
         LB4gIhYrbVriqSUufVKaiEGprcXj1KPglpSwGeNmrD41YwDCdLwYTTQ7tZ9fWNJMbsEr
         ffdtbZ7wY22A8/xF6aMPmZ4MaRGNszgLIg2Wq3jXMIBZbit7bK6Jez7L3dej5kImhNzv
         vtSLHMn7khKDwsl/Coe6EoyTOPMTOfVPsCZU5/+dzZTX2GAGFJxyxUoTgeMw0j7/58P7
         9HeQ==
X-Gm-Message-State: AOAM530YZeUNPsMBuc4dcm6REHg5Fp9EJbMC/erHI4msAM9Wj787taeg
        Sh2RSbHdtPkxM9VPV0j3etA=
X-Google-Smtp-Source: ABdhPJwnqvkE4L37/BEtcwMEvCDsVRHxb7EDsSwV9RMIgSyKjUrHU18On1XlgoerptZTuG/vi1kW9w==
X-Received: by 2002:a5d:49cf:: with SMTP id t15mr18426983wrs.217.1612195082337;
        Mon, 01 Feb 2021 07:58:02 -0800 (PST)
Received: from [89.139.43.22] (89-139-43-22.bb.netvision.net.il. [89.139.43.22])
        by smtp.gmail.com with ESMTPSA id w4sm7718016wrt.69.2021.02.01.07.58.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 01 Feb 2021 07:58:01 -0800 (PST)
Message-ID: <601824B6.60803@gmail.com>
Date:   Mon, 01 Feb 2021 17:56:38 +0200
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] char: xillybus: Add driver for XillyUSB (Xillybus
 variant for USB)
References: <20210201141651.62853-1-eli.billauer@gmail.com> <YBgPcX0J5m0bkhuA@kroah.com>
In-Reply-To: <YBgPcX0J5m0bkhuA@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Greg.

On 01/02/21 16:25, Greg KH wrote:
> As this has nothing to do with the existing XillyBus code, and you
> aren't doing anything "fancy" with the character device nodes, why does
> this need to be a kernel driver at all?  Why can't you just use libusb
> and talk to the device directly from userspace with no kernel driver
> needed?
>    
That's actually what I did in my first attempt.

However in order to provide the same API as the existing Xillybus 
driver, this driver must present some kind of device files.

Named pipes aren't sufficient, among others because closing a Xillybus 
device file is something that the hardware is informed about 
immediately. Also, when a device file is opened for write, the close() 
call should not return until all data has arrived to hardware (per 
existing API). This can't be guaranteed with named pipes.

So a user-space driver needs to rely on CUSE. Which I wasted two months 
on before realizing it's not stable enough to rely upon. My whines on 
CUSE can be found in my blog:

http://billauer.co.il/blog/2020/02/linux-cuse-fuse-libfuse-crash/
> And always cc:linux-usb@vger.kernel.org  when submitting a USB driver so
> that the developers there can review it.
>    
Sorry, I wasn't aware of that. Will resend this patch with this list 
cc'ed shortly.

Thanks,
    Eli

