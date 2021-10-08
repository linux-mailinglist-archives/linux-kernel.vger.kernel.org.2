Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE158426CF6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242670AbhJHOvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242653AbhJHOvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:51:01 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362EEC061570;
        Fri,  8 Oct 2021 07:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=lDYealiGwCfGhnUjQxhwCrhKF71tF0EdyyqmS3JralE=; b=MQ/ur5714X8wgHkyaFcOrEtZ68
        mOclgYFkO/tIMw/vXCnrOx+QSYFBrc+pfcNGZmzYi3tDpw0URTaTHt6/nfDQXSFiJKbI9a8dIGaSJ
        ieGfhf0vIu3aRIGPCie+/X3a5idq0aL4qOeZ1nlJm/7phxI8Nw9tW7Ovml3SPN0A+EBDijUxPHUEd
        OPuhrwST+OHxmoXR4e6NRCjE0goQoj3LmS3/ut0XzuTJviyRX3sdDm7EUL/gym3YzhLx2GYZmBZvA
        07V6sdx6h8/q4rjiG4uPjsHPhHU7Q7Cd7Qbm535zQbh/Ptw/CkYxlHQJ7LD+f6vOhBednYnDwaqIj
        K0PCb70g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYrBF-0039E0-QZ; Fri, 08 Oct 2021 14:49:01 +0000
Subject: Re: [PATCH] platform: dell: all DELL_WMI driver options depend on
 DELL_WMI
To:     linux-kernel@vger.kernel.org
Cc:     Perry Yuan <Perry.Yuan@dell.com>, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
References: <20210927205354.19342-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <79b874ba-7d69-7dff-69d3-f09b4e0f2b39@infradead.org>
Date:   Fri, 8 Oct 2021 07:49:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210927205354.19342-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Still seeing this build error in linux-next, so the patch
is still needed...

On 9/27/21 1:53 PM, Randy Dunlap wrote:
> A randconfig or a user can set/enable DELL_WMI_PRIVACY even when
> DELL_WMI is not enabled. This leads to a build error in
> dell-laptop.o:
> 
> ld: drivers/platform/x86/dell/dell-laptop.o: in function `dell_init':
> dell-laptop.c:(.init.text+0x719): undefined reference to `dell_privacy_has_mic_mute'
> 
> Fix this by enclosing the DELL_WMI driver options inside a
> if DELL_WMI / endif bracket.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Perry Yuan <Perry.Yuan@dell.com>
> Cc: Dell.Client.Kernel@dell.com
> Cc: platform-driver-x86@vger.kernel.org
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <mgross@linux.intel.com>
> ---
> Found in linux-next, applies to mainline.
> 
> The last time that I sent a patch to Perry Yuan (about 2 weeks ago),
> it bounced...
> 
>   drivers/platform/x86/dell/Kconfig |    4 ++++
>   1 file changed, 4 insertions(+)
> 
> --- linux-next-20210927.orig/drivers/platform/x86/dell/Kconfig
> +++ linux-next-20210927/drivers/platform/x86/dell/Kconfig
> @@ -164,6 +164,8 @@ config DELL_WMI
>   	  To compile this driver as a module, choose M here: the module will
>   	  be called dell-wmi.
>   
> +if DELL_WMI
> +
>   config DELL_WMI_PRIVACY
>   	bool "Dell WMI Hardware Privacy Support"
>   	depends on LEDS_TRIGGER_AUDIO = y || DELL_WMI = LEDS_TRIGGER_AUDIO
> @@ -198,6 +200,8 @@ config DELL_WMI_LED
>   	  This adds support for the Latitude 2100 and similar
>   	  notebooks that have an external LED.
>   
> +endif # DELL_WMI
> +
>   config DELL_WMI_SYSMAN
>   	tristate "Dell WMI-based Systems management driver"
>   	default m
> 


-- 
~Randy
