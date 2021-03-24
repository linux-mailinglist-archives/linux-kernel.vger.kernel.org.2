Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9862B34858C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbhCXXup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbhCXXuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:50:16 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04C9C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:50:14 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id v26so97811iox.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tWobKMGywN9lDYnqfuiTkENNe/3dGwwygiSKXOJYwE4=;
        b=GsyGv4HFZeZhqfrxRLrVpErgSqZY8dpEvKhLp8XmfIzVf+d6wk24feKlpRNRdF8LM1
         njfdG81yjyK2ZVgmmjqVef4oYbxaBRfte1v3fMLJ3b4N5HCjLQCPyB3T/eNef2vgJeXV
         5rgimpDED7MXA27rUONVrs1rwX/O1M+fOI7Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tWobKMGywN9lDYnqfuiTkENNe/3dGwwygiSKXOJYwE4=;
        b=kUFUz3SMoSC+56dM17+IJscTJpefsSn3Z4SCHrTFBC5Ub8tjfdR06/hLcavHhYUZ3k
         9rEVbjLbeSFC/WJbj3eso29jF5rGiBGnaRZevpL38IWnd+9tyGkhzwv8lUlcbs6STD3S
         JPKjyDLKm1tJcdwCkpc/NfILZw5j3rEMjMvXjH+ecdAveIolcTAbS8vJEz7Q9PiKr5t4
         tSfOft1RBjADhMBEG8lFl/ujU8qvBU8310Z5x4NL0PwrI96JdWba5tLinPaxbDJgJ0QA
         ZmRp/mg5AVZ6nVwf6j6mrfHMmyt0+oAOAB6kff/c6gkavJsQD49Z1ls65sbTUXy9ydEw
         SErg==
X-Gm-Message-State: AOAM530bwk0KzlWCD4AAeDY5DiFnNN4b0lcSqwKFxz/Xk1qoZ8WyWRHg
        AHSiYHjZ2YUNueExxS/0Wt+ic8+fYsAXUw==
X-Google-Smtp-Source: ABdhPJxqNLQeDkhxT42wTCPy1WEM8ZlhY3+7fg5XgBECeWHnTQGPwmWrwA+WcJAmAcdAQ3rE3wUegw==
X-Received: by 2002:a05:6638:685:: with SMTP id i5mr5277100jab.109.1616629813977;
        Wed, 24 Mar 2021 16:50:13 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n11sm1740515ioa.34.2021.03.24.16.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 16:50:13 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] usbip: tools: add options and examples in man page
 related to device mode
To:     "Hongren Zheng (Zenithal)" <i@zenithal.me>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt mooney <mfm@muteddisk.com>, linux-usb@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <YFrdyKKx1nx8bktm@Sun>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e2af75d1-8102-b0d9-3eab-0124f6b4dbe2@linuxfoundation.org>
Date:   Wed, 24 Mar 2021 17:50:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFrdyKKx1nx8bktm@Sun>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 12:35 AM, Hongren Zheng (Zenithal) wrote:
> The commit e0546fd8b748 ("usbip: tools: Start using VUDC backend in
> usbip tools") implemented device mode for user space tools, however the
> corresponding options are not documented in man page.
> 
> This commit documents the options and provides examples on device mode.
> Also the command `usbip port` is documented.
> 
> Signed-off-by: Hongren Zheng <i@zenithal.me>
> ---
>   tools/usb/usbip/doc/usbip.8  | 42 +++++++++++++++++++++++++++++++++++-
>   tools/usb/usbip/doc/usbipd.8 | 26 ++++++++++++++++++++++
>   2 files changed, 67 insertions(+), 1 deletion(-)
> 
> PATCH v2:
>       Add signed-off-by line
> 
> PATCH v3:
>       Move patch changelog after the marker line
>       Remove nickname in signed-off-by line
> 
> PATCH v4:
>       Use commit short hash and message instead of long hash only when
>         referring to commit in the kernel
> 
> PATCH v5:
>      Add documentation of `usbip port` and its usage in examples
>      Add flow of detaching in examples
>      Rephrase some description and add punctuations
>      Fix typo of `usbip attach --ev-id` to `--dev-id`
> 
> diff --git a/tools/usb/usbip/doc/usbip.8 b/tools/usb/usbip/doc/usbip.8
> index a15d20063b98..1f26e4a00638 100644
> --- a/tools/usb/usbip/doc/usbip.8
> +++ b/tools/usb/usbip/doc/usbip.8
> @@ -49,10 +49,17 @@ then exit.
>   Attach a remote USB device.
>   .PP
>   
> +.HP
> +\fBattach\fR \-\-remote=<\fIhost\fR> \-\-device=<\fIdev_id\fR>
> +.IP
> +Attach a remote USB gadget.
> +Only used when the remote usbipd is in device mode.
> +.PP
> +
>   .HP
>   \fBdetach\fR \-\-port=<\fIport\fR>
>   .IP
> -Detach an imported USB device.
> +Detach an imported USB device/gadget.
>   .PP
>   
>   .HP
> @@ -73,12 +80,26 @@ Stop exporting a device so it can be used by a local driver.
>   List USB devices exported by a remote host.
>   .PP
>   
> +.HP
> +\fBlist\fR \-\-device
> +.IP
> +List USB gadgets of local usbip-vudc.
> +Only used when the local usbipd is in device mode.
> +Note that this can not list usbip-vudc USB gadgets of the remote device mode usbipd.
> +.PP
> +
>   .HP
>   \fBlist\fR \-\-local
>   .IP
>   List local USB devices.
>   .PP
>   
> +.HP
> +\fBport\fR
> +.IP
> +List imported devices/gadgets.
> +.PP
> +
>   
>   .SH EXAMPLES
>   
> @@ -90,8 +111,27 @@ List local USB devices.
>       client:# usbip attach --remote=server --busid=1-2
>           - Connect the remote USB device.
>   
> +    client:# usbip port
> +        - List imported devices/gadgets.
> +
>       client:# usbip detach --port=0
>           - Detach the usb device.
>   
> +The following example shows the usage of device mode
> +
> +    server:# usbip list --device
> +        - List gadgets exported by local usbipd server.
> +
> +    client:# modprobe vhci-hcd
> +
> +    client:# usbip attach --remote=server --device=usbip-vudc.0
> +        - Connect the remote USB gadget.
> +
> +    client:# usbip port
> +        - List imported devices/gadgets.
> +
> +    client:# usbip detach --port=0
> +        - Detach the usb gadget.
> +
>   .SH "SEE ALSO"
>   \fBusbipd\fP\fB(8)\fB\fP
> diff --git a/tools/usb/usbip/doc/usbipd.8 b/tools/usb/usbip/doc/usbipd.8
> index fb62a756893b..d974394f86a1 100644
> --- a/tools/usb/usbip/doc/usbipd.8
> +++ b/tools/usb/usbip/doc/usbipd.8
> @@ -29,6 +29,12 @@ Bind to IPv4. Default is both.
>   Bind to IPv6. Default is both.
>   .PP
>   
> +.HP
> +\fB\-e\fR, \fB\-\-device\fR
> +.IP
> +Run in device mode. Rather than drive an attached device, create a virtual UDC to bind gadgets to.
> +.PP
> +
>   .HP
>   \fB\-D\fR, \fB\-\-daemon\fR
>   .IP
> @@ -86,6 +92,26 @@ USB/IP client can connect and use exported devices.
>           - A usb device 1-2 is now exportable to other hosts!
>           - Use 'usbip unbind --busid=1-2' when you want to shutdown exporting and use the device locally.
>   
> +The following example shows the usage of device mode
> +
> +    server:# modprobe usbip-vudc
> +        - Use /sys/class/udc/ interface.
> +        - usbip-host is independent of this module.
> +
> +    server:# usbipd -e -D
> +        - Start usbip daemon in device mode.
> +
> +    server:# modprobe g_mass_storage file=/tmp/tmp.img
> +        - Bind a gadget to usbip-vudc.
> +        - in this example, a mass storage gadget is bound.
> +
> +    server:# usbip list --device
> +        - List gadgets exported by local usbipd server.
> +
> +    server:# modprobe -r g_mass_storage
> +        - Unbind a gadget from usbip-vudc.
> +        - in this example, the previous mass storage gadget is unbound.
> +
>   .SH "SEE ALSO"
>   \fBusbip\fP\fB(8)\fB\fP
>   
> 

Thank you. Looks good.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
