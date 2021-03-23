Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC76346DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 00:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhCWXMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 19:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbhCWXMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 19:12:03 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AE6C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 16:12:03 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id j26so19528287iog.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0CTkCP7eh5JThTr8jIH1qDmyEvNCPXGfv16BaMHqRms=;
        b=G+HRAoEBftiZViB1W9yjFGzhCO8zCpuDbTwdqm/XGLcphKdTuhO8hpKuEGztPMNjH4
         BK78t12o0bz41KzLUGsF1JKgf6FIBd52ul0eqkkWTCrn/L2EpLbi+i1+Bz3XCdJDfQ7y
         tpFup7b1C+lZDCytyJMp9k7yDIH8uhiU213e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0CTkCP7eh5JThTr8jIH1qDmyEvNCPXGfv16BaMHqRms=;
        b=sFk5BDkNvfW8ClYOBTstIel8sv+5wUDteAVCxjbnWr2Pws5ohoKid3k/yu+zeyg52W
         0ayxNuQwwr8gicTLa+BDsYnDl2I02RbCFzFUsNAbTQH5lHG9w5PNH85HESuPq4xns5I4
         EBhhicYwr0Rbd8ZEIlE44se17w4uK4RCJJYdbAu+8S9MT7uXNYHcr4owp/43+zOr6AFu
         r1UQDrlUJcu2eqs2OCe2PhPOflwFwAR+hYFFYqoevseCwNQYnq96bRARifxnue/KLr/B
         ZGu3iPKJcRKbr5T7d1I56v3DtqEPjr4h+E3kzJLGnK2Zd6BAu/rlf9NJlqkgGkppP/4W
         4A9g==
X-Gm-Message-State: AOAM530nI094X3EQCfdLdAj7EYg/QuoAC6kIfHabiCRAniDqwMN4+aVa
        uW7fS1JV3Xsyt9akdHVGUKqzQ1S9EUANCw==
X-Google-Smtp-Source: ABdhPJz29DEstIzTa436eSM6a5JP0poV2ojeMgXtNVbPWeIgpc9a04FJlN+PpIQoOlkjEKxHHOFEVQ==
X-Received: by 2002:a05:6638:144e:: with SMTP id l14mr343367jad.76.1616541122241;
        Tue, 23 Mar 2021 16:12:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r3sm151608ilq.42.2021.03.23.16.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 16:12:01 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] usbip: tools: add options and examples in man page
 related to device mode
To:     "Hongren Zheng (Zenithal)" <i@zenithal.me>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt mooney <mfm@muteddisk.com>, linux-usb@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <YFnlUaF2njDjIhfM@Sun>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1a2c79b7-1cc0-9ddd-f2ec-fa7b222113ec@linuxfoundation.org>
Date:   Tue, 23 Mar 2021 17:12:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFnlUaF2njDjIhfM@Sun>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 6:55 AM, Hongren Zheng (Zenithal) wrote:
> The commit e0546fd8b748 ("usbip: tools: Start using VUDC backend in
> usbip tools") implemented device mode for user space tools, however the
> corresponding options are not documented in man page.
> 
> This commit documents the options and provides examples on device mode.
> 
> Signed-off-by: Hongren Zheng <i@zenithal.me>
> ---
>   tools/usb/usbip/doc/usbip.8  | 25 +++++++++++++++++++++++++
>   tools/usb/usbip/doc/usbipd.8 | 22 ++++++++++++++++++++++
>   2 files changed, 47 insertions(+)
> 
> PATCH v2:
>      Add signed-off-by line
> 
> PATCH v3:
>      Move patch changelog after the marker line
>      Remove nickname in signed-off-by line
> 
> PATCH v4:
>      Use commit short hash and message instead of long hash only when
>        referring to commit in the kernel
> 

Thank you for the patch. Please see comments below:

> diff --git a/tools/usb/usbip/doc/usbip.8 b/tools/usb/usbip/doc/usbip.8
> index a15d20063b98..385b0eda8746 100644
> --- a/tools/usb/usbip/doc/usbip.8
> +++ b/tools/usb/usbip/doc/usbip.8
> @@ -49,6 +49,13 @@ then exit.
>   Attach a remote USB device.
>   .PP
>   
> +.HP
> +\fBattach\fR \-\-remote=<\fIhost\fR> \-\-device=<\fdev_id\fR>
> +.IP
> +Attach a remote USB gadget.
> +Only used when the remote usbipd is in device mode.
> +.PP
> +
>   .HP
>   \fBdetach\fR \-\-port=<\fIport\fR>
>   .IP

This is a bit confusing. Please add a separate section for
Attach a remote USB gadget complete with attach and detach
instructions.

> @@ -73,6 +80,14 @@ Stop exporting a device so it can be used by a local driver.
>   List USB devices exported by a remote host.
>   .PP
>   
> +.HP
> +\fBlist\fR \-\-device
> +.IP
> +List USB gadgets of local usbip-vudc.
> +Only used when the local usbipd is in device mode.
> +This can not list usbip-vudc USB gadgets of the remote device mode usbipd.
> +.PP
> +
>   .HP
>   \fBlist\fR \-\-local
>   .IP
> @@ -93,5 +108,15 @@ List local USB devices.
>       client:# usbip detach --port=0
>           - Detach the usb device.
>   
> +The following example shows the use of device mode
> +
> +    server:# usbip list --device
> +        - Note this is the server side
> +
> +    client:# modprobe vhci-hcd
> +
> +    client:# usbip attach --remote=server --device=usbip-vudc.0
> +        - Connect the remote USB gadget
> +
>   .SH "SEE ALSO"
>   \fBusbipd\fP\fB(8)\fB\fP
> diff --git a/tools/usb/usbip/doc/usbipd.8 b/tools/usb/usbip/doc/usbipd.8
> index fb62a756893b..53c8d5792de6 100644
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
> @@ -86,6 +92,22 @@ USB/IP client can connect and use exported devices.
>           - A usb device 1-2 is now exportable to other hosts!
>           - Use 'usbip unbind --busid=1-2' when you want to shutdown exporting and use the device locally.
>   
> +The following example shows the use of device mode
> +
> +    server:# modprobe usbip-vudc
> +        - Use /sys/class/udc/ interface
> +        - usbip-host is independent of this module.
> +
> +    server:# usbipd -e -D
> +        - Start usbip daemon in device mode.
> +
> +    server:# modprobe g_mass_storage file=/tmp/tmp.img
> +        - Bind a gadget to usbip-vudc
> +        - in this example, a mass storage gadget is bound
> +
> +    server:# usbip list --device
> +        - Note this is the server side
> +
>   .SH "SEE ALSO"
>   \fBusbip\fP\fB(8)\fB\fP
>   
> 

thanks,
-- Shuah

