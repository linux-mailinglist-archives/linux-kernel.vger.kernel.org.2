Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934FD428D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbhJKMyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231628AbhJKMya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633956750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QaBIGi0oAdZ+bifrwuDRXIfKMEk3gl8Olbtkp3fD4yo=;
        b=Ueb4M5mgDIay4NONC0vG78zIpshGS1cd5NJg4fUhHR/JUBohHMzu4EkLoaPTZ9gKZVfsDf
        rlzt5go5p9nySIB87/BpK8i/Je7ZQcwG3oiqb+LATi8hdmr4nWaiJNCPw+BKsHEb075EwB
        13eXv4gczxBsz+mYFpE9bwk/E0QBZZI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-b5WvMYTUNt2eRmI9IH4L2g-1; Mon, 11 Oct 2021 08:52:27 -0400
X-MC-Unique: b5WvMYTUNt2eRmI9IH4L2g-1
Received: by mail-ed1-f69.google.com with SMTP id x5-20020a50f185000000b003db0f796903so15777095edl.18
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 05:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QaBIGi0oAdZ+bifrwuDRXIfKMEk3gl8Olbtkp3fD4yo=;
        b=VLFA/aMB/jColaMBF+If9mp/sQP5zRC1IBaTRHpZKatl1OGKeXOcZqD59USx0ebYz+
         0iAn44Vz0uPDiprjESuxYivWU7ASiF4ayU5LkBk5rhq6w5X1ryODMocqVXIQXWmcLCPA
         3AEtgoxWZpu3RQh2MO6ogo2tVVjUwSEevoI/dCzP+jFFubwO2fv/o1+96AcvMPPXhwpT
         mDpsdv7X5yxLxsbYYv8NAl/6KLT+TpN23p6k1wQ4ORV3/Qi/5He1vQRrhqvBRlXvNTrF
         sjZJswW47rajBS9AjBXPKq6pI4szUMAwP3KFnH3u186NaWprM8CVBPG/vGPRn6s1bx7S
         PwRg==
X-Gm-Message-State: AOAM532eJILxKT9FBuw3V788S2LVzcX2mBOR++AEN6sUpv5Zp7XflKWP
        RBnCX3JlzI9hYIHiOnxwDsglaHoixtzSXDt7Hcp/zeWDltejX2CUChOv76y78RlSb2mj9nJH7r2
        tXD8gzVMyIne3QyxF1bj+W673CJ0+znJZ1eT24bZb7WwlmR1XcK8bJZgXnnbV5VYgcZW12c2F9P
        Lu
X-Received: by 2002:a17:906:b00c:: with SMTP id v12mr25574527ejy.222.1633956745636;
        Mon, 11 Oct 2021 05:52:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuB4IMrDwLNLmZu6++TamTcz3ffKC3IdkeBOEaxJk43O3zJ6vyUZCqDugm3PErNzR6Spdtkg==
X-Received: by 2002:a17:906:b00c:: with SMTP id v12mr25574491ejy.222.1633956745398;
        Mon, 11 Oct 2021 05:52:25 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id t20sm3469789ejc.105.2021.10.11.05.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 05:52:25 -0700 (PDT)
Subject: Re: [PATCH 2/7] ABI: sysfs-platform-dell-privacy-wmi: correct ABI
 entries
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Perry Yuan <perry_yuan@dell.com>,
        linux-kernel@vger.kernel.org
References: <cover.1632740376.git.mchehab+huawei@kernel.org>
 <42846621fdf2bf206feb114d06b14cbc47475fb5.1632740376.git.mchehab+huawei@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5e4e394d-6005-e784-9e45-610ab66ce331@redhat.com>
Date:   Mon, 11 Oct 2021 14:52:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <42846621fdf2bf206feb114d06b14cbc47475fb5.1632740376.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/27/21 1:10 PM, Mauro Carvalho Chehab wrote:
> As described at Documentation/ABI/README doesn't contain an
> Attribute: field.
> 
> The way sysfs ABI is supposed to work is that each different
> attribute would have a separate file. So, the right way to
> map this would be like:
> 
> 	/sys/.../dell_privacy_supported_type/mic_mute
> 	/sys/.../dell_privacy_supported_type/camera_shutter
> 
> 	/sys/.../dell_privacy_current_state/mic_mute
> 	/sys/.../dell_privacy_current_state/camera_shutter
> 
> However, it seems to late to fix that, as this was merged already on
> Kernel 5.13, and a change right now would be a regression.
> 
> So, instead, let's at least fix the entry to match the expected
> format.
> 
> While here, fix the format of the contact, which is not a valid
> e-mail URL.
> 
> This should also fix the current warnings produced when building the
> docs:
> 
> 	Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi:35: WARNING: Unexpected indentation.
> 	Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi:2: WARNING: Unexpected indentation.
> 
> Fixes: 8af9fa37b8a3 ("platform/x86: dell-privacy: Add support for Dell hardware privacy")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
> 
> See [PATCH 0/7] at: https://lore.kernel.org/all/cover.1632740376.git.mchehab+huawei@kernel.org/T/#t
> 
>  .../testing/sysfs-platform-dell-privacy-wmi   | 60 ++++++++++++-------
>  1 file changed, 38 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi b/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
> index 7f9e18705861..1f1f274a6979 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
> @@ -1,55 +1,71 @@
>  What:		/sys/bus/wmi/devices/6932965F-1671-4CEB-B988-D3AB0A901919/dell_privacy_supported_type
>  Date:		Apr 2021
>  KernelVersion:	5.13
> -Contact:	"perry.yuan@dell.com>"
> +Contact:	"<perry.yuan@dell.com>"
>  Description:
>  		Display which dell hardware level privacy devices are supported
>  		“Dell Privacy” is a set of HW, FW, and SW features to enhance
>  		Dell’s commitment to platform privacy for MIC, Camera, and
>  		ePrivacy screens.
>  		The supported hardware privacy devices are:
> -Attributes:
> -		Microphone Mute:
> +
> +		Attributes:
> +			Microphone Mute:
>  				Identifies the local microphone can be muted by hardware, no applications
>  				is available to capture system mic sound
>  
> -		Camera Shutter:
> +			Camera Shutter:
>  				Identifies camera shutter controlled by hardware, which is a micromechanical
>  				shutter assembly that is built onto the camera module to block capturing images
>  				from outside the laptop
>  
> -		supported:
> +		Values:
> +
> +			supported:
>  				The privacy device is supported by this system
>  
> -		unsupported:
> +			unsupported:
>  				The privacy device is not supported on this system
>  
> -		For example to check which privacy devices are supported:
> +		For example to check which privacy devices are supported::
>  
> -		# cat /sys/bus/wmi/drivers/dell-privacy/6932965F-1671-4CEB-B988-D3AB0A901919/dell_privacy_supported_type
> -		[Microphone Mute] [supported]
> -		[Camera Shutter] [supported]
> -		[ePrivacy Screen] [unsupported]
> +		    # cat /sys/bus/wmi/drivers/dell-privacy/6932965F-1671-4CEB-B988-D3AB0A901919/dell_privacy_supported_type
> +		    [Microphone Mute] [supported]
> +		    [Camera Shutter] [supported]
> +		    [ePrivacy Screen] [unsupported]
>  
>  What:		/sys/bus/wmi/devices/6932965F-1671-4CEB-B988-D3AB0A901919/dell_privacy_current_state
>  Date:		Apr 2021
>  KernelVersion:	5.13
> -Contact:	"perry.yuan@dell.com>"
> +Contact:	"<perry.yuan@dell.com>"
>  Description:
>  		Allow user space to check current dell privacy device state.
>  		Describes the Device State class exposed by BIOS which can be
>  		consumed by various applications interested in knowing the Privacy
>  		feature capabilities
> -Attributes:
> -		muted:
> -			Identifies the privacy device is turned off and cannot send stream to OS applications
>  
> -		unmuted:
> -			Identifies the privacy device is turned on ,audio or camera driver can get
> -			stream from mic and camera module to OS applications
> +		Attributes:
> +			Microphone:
> +				Identifies the local microphone can be muted by hardware, no applications
> +				is available to capture system mic sound
>  
> -		For example to check all supported current privacy device states:
> +			Camera Shutter:
> +				Identifies camera shutter controlled by hardware, which is a micromechanical
> +				shutter assembly that is built onto the camera module to block capturing images
> +				from outside the laptop
>  
> -		# cat /sys/bus/wmi/drivers/dell-privacy/6932965F-1671-4CEB-B988-D3AB0A901919/dell_privacy_current_state
> -		[Microphone] [unmuted]
> -		[Camera Shutter] [unmuted]
> +		Values:
> +			muted:
> +				Identifies the privacy device is turned off
> +				and cannot send stream to OS applications
> +
> +			unmuted:
> +				Identifies the privacy device is turned on,
> +				audio or camera driver can get stream from mic
> +				and camera module to OS applications
> +
> +		For example to check all supported current privacy device states::
> +
> +		    # cat /sys/bus/wmi/drivers/dell-privacy/6932965F-1671-4CEB-B988-D3AB0A901919/dell_privacy_current_state
> +		    [Microphone] [unmuted]
> +		    [Camera Shutter] [unmuted]
> 

