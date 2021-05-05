Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2983749F1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 23:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhEEVNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 17:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhEEVNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 17:13:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EA8C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 14:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=aatIOcd/9Qfch1UdmPFCdSQtQdfk677TNemZY5NUQmk=; b=deTAqKoAnD0+7Fx9sHPUqz7+vK
        GU4GDlOcZN6uxQUMW602detcFi1s5+lMn1kyyqJH7ncogZU1lioLvoY4kcU41wbrIWOexsAgCs44O
        qW4cyB1rmkYr8vTP2lTPE/Nz/H2u8fx3/6fMDQYy3KUtixayULNzCTOStN56YrRFU4JLU/Qx5gNxe
        JMxpNd0297fknSVyTvBloD+z7njrrk9XTYwUvXua+IHFDWZ/7DGcJCtqsFumOXg35F2O5RItd5Hfc
        Cc/znHG/XGZ1LjkC9/osWGQKQkUkwwggXTht8xUmxnSnA/qvka1YL/rSAbe2Q1jTVb/d2jSKgyDUL
        /Z553wEw==;
Received: from [2601:1c0:6280:3f0::7376]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leOnE-000v1G-AK; Wed, 05 May 2021 21:11:01 +0000
Subject: Re: [PATCH] Fixed typos in all directories of Documentation/ABI/
To:     Carlos Bilbao <bilbao@vt.edu>, corbet@lwn.net, hdegoede@redhat.com,
        mchehab+huawei@kernel.org, Jonathan.Cameron@huawei.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
References: <2219636.ElGaqSPkdT@iron-maiden>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <de6f22e2-3f3c-0ce3-a73d-fb881646f1e8@infradead.org>
Date:   Wed, 5 May 2021 14:10:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <2219636.ElGaqSPkdT@iron-maiden>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/21 1:43 PM, Carlos Bilbao wrote:
> Fix the following typos in the Documentation/ABI/ directory:
> 
> - In file obsolete/sysfs-cpuidle, change "obselete" for "obsolete".
> 
> - In file removed/sysfs-kernel-uids, change "propotional" for "proportional".
> 
> - In directory stable/, fix the following words: "associtated" for "associated",
>   "hexidecimal" for "hexadecimal", "vlue" for "value", "csed" for "caused" and 
>   "wrtie" for "write". This updates a total of five files.
> 
> - In directory testing/, fix the following words: "subystem" for "subsystem", 
>   isochrnous" for "isochronous", "Desctiptors" for "Descriptors", "picutre" for 
>   "picture", "capture" for "capture", "occured" for "ocurred", "connnected" for 
>   "connected","agressively" for "aggressively","manufacturee" for "manufacturer"
>   and "transaction" for "transaction" and "malformatted" for "malformed". This 
>   updates a total of ten files.
> 
> Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
> ---
>  Documentation/ABI/obsolete/sysfs-cpuidle            | 2 +-
>  Documentation/ABI/removed/sysfs-kernel-uids         | 2 +-
>  Documentation/ABI/stable/sysfs-bus-vmbus            | 4 ++--
>  Documentation/ABI/stable/sysfs-bus-xen-backend      | 2 +-
>  Documentation/ABI/stable/sysfs-class-infiniband     | 2 +-
>  Documentation/ABI/stable/sysfs-driver-dma-idxd      | 2 +-
>  Documentation/ABI/stable/sysfs-driver-mlxreg-io     | 4 ++--
>  Documentation/ABI/testing/configfs-iio              | 2 +-
>  Documentation/ABI/testing/configfs-most             | 8 ++++----
>  Documentation/ABI/testing/configfs-usb-gadget       | 2 +-
>  Documentation/ABI/testing/configfs-usb-gadget-uvc   | 4 ++--
>  Documentation/ABI/testing/debugfs-driver-genwqe     | 2 +-
>  Documentation/ABI/testing/debugfs-driver-habanalabs | 2 +-
>  Documentation/ABI/testing/sysfs-bus-fsi             | 2 +-
>  Documentation/ABI/testing/sysfs-bus-pci             | 2 +-
>  Documentation/ABI/testing/sysfs-driver-ufs          | 4 ++--
>  Documentation/ABI/testing/sysfs-fs-f2fs             | 2 +-
>  17 files changed, 24 insertions(+), 24 deletions(-)
> 

Hi--

> diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
> index 42599d9fa161..f2bcb719f1d9 100644
> --- a/Documentation/ABI/stable/sysfs-bus-vmbus
> +++ b/Documentation/ABI/stable/sysfs-bus-vmbus
> @@ -61,13 +61,13 @@ Date:		September. 2017
>  KernelVersion:	4.14
>  Contact:	Stephen Hemminger <sthemmin@microsoft.com>
>  Description:	Directory for per-channel information
> -		NN is the VMBUS relid associtated with the channel.
> +		NN is the VMBUS relid associated with the channel.

ack.

>  
>  What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/cpu
>  Date:		September. 2017
>  KernelVersion:	4.14
>  Contact:	Stephen Hemminger <sthemmin@microsoft.com>
> -Description:	VCPU (sub)channel is affinitized to
> +Description:	PCP (sub)channel is affinitized to

Stephen- comment here?

>  Users:		tools/hv/lsvmbus and other debugging tools
>  
>  What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/in_mask


> diff --git a/Documentation/ABI/stable/sysfs-class-infiniband b/Documentation/ABI/stable/sysfs-class-infiniband
> index 348c4ac803ad..bbaa7bab8af4 100644
> --- a/Documentation/ABI/stable/sysfs-class-infiniband
> +++ b/Documentation/ABI/stable/sysfs-class-infiniband
> @@ -140,7 +140,7 @@ Description:
>  		by LocalPhyErrors
>  
>  		excessive_buffer_overrun_errors: (RO) This counter, indicates an
> -		input buffer overrun. It indicates possible misconfiguration of

Above is correct AFAIK although my 3 quick dictionary searches didn't find it
spelled either of those ways. :)

> +		input buffer overrun. It indicates possible missconfiguration of
>  		a port, either by the Subnet Manager (SM) or by user
>  		intervention. It can also indicate hardware issues or extremely
>  		poor link signal integrity


codespell find 4 problems here (in ABI/testing):

$ codespell sysfs-devices-system-cpu
sysfs-devices-system-cpu:100: internel  ==> internal
sysfs-devices-system-cpu:283: specificed  ==> specified
sysfs-devices-system-cpu:298: beyound  ==> beyond
sysfs-devices-system-cpu:535: Symetric  ==> Symmetric


Would you mind adding those to your patch?


thanks.
-- 
~Randy

