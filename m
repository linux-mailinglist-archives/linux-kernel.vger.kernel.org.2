Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9616137938B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhEJQRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:17:48 -0400
Received: from mailfilter06-out40.webhostingserver.nl ([195.211.73.79]:57633
        "EHLO mailfilter06-out40.webhostingserver.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231443AbhEJQRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exalondelft.nl; s=whs1;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=xQVqOe2YfwU7nf8E0VSAtMJ1Dn5xLDeGT6F0ClGgcEM=;
        b=Tgretv5cPYHF/UGtI6y1LfWgp4MGq3J3k7E48Jf0vtCQ+KCoEJP9rLaYFKXjGCsHutpGcpqgSl++v
         kdsxkSGK1Y42AVqW5g/54Ih4WK2tnPKNDyYuLQQuCgG35qpQV3oWGA7X/wmYLULYKNcn+JfGOaEwYG
         iWWke6hN319SttTI66U765XfVoQ/gJkvFt8ECuS8RtbgtDYBXXd6QkTsH35BJOUA7hyUn8pzw4GW+t
         jMwIrCtCHN8IEVXO0dS5/XfhAWk39dvD/5Iref6sDO8Whjz6uZal2OSqNriLQ8mRkM2l+UX7JANdzw
         eYXV//YSVQq3P4sfWrii5L3/uWEMb7Q==
X-Halon-ID: 14ddcd32-b1ab-11eb-894f-001a4a4cb958
Received: from s188.webhostingserver.nl (s188.webhostingserver.nl [141.138.168.133])
        by mailfilter06.webhostingserver.nl (Halon) with ESMTPSA
        id 14ddcd32-b1ab-11eb-894f-001a4a4cb958;
        Mon, 10 May 2021 18:16:31 +0200 (CEST)
Received: from [2001:981:6fec:1:706e:68b:b43f:ea3]
        by s188.webhostingserver.nl with esmtpa (Exim 4.94.2)
        (envelope-from <ftoth@exalondelft.nl>)
        id 1lg8a7-00EG6P-2G; Mon, 10 May 2021 18:16:31 +0200
Subject: Re: [PATCH v2 1/1] usb: dwc3: pci: Enable usb2-gadget-lpm-disable for
 Intel Merrifield
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20210425195452.94143-1-ftoth@exalondelft.nl>
 <YJkp2ZfhB717CmT7@kroah.com>
From:   Ferry Toth <ftoth@exalondelft.nl>
Message-ID: <bb96ef4c-9cdf-c2d9-ab45-cc718aa30ddc@exalondelft.nl>
Date:   Mon, 10 May 2021 18:16:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJkp2ZfhB717CmT7@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Op 10-05-2021 om 14:40 schreef Greg Kroah-Hartman:
> On Sun, Apr 25, 2021 at 09:54:52PM +0200, Ferry Toth wrote:
>> On Intel Merrifield LPM is causing the host to reset port after a timeout.
>> By disabling LPM entirely this is prevented.
>>
>> Fixes: 066c09593454 ("usb: dwc3: pci: Enable extcon driver for Intel Merrifield")
>> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> ---
>>   drivers/usb/dwc3/dwc3-pci.c | 1 +
>>   1 file changed, 1 insertion(+)
> What changed from v1?  Always put that below the --- line.
>
Yes, my bad, sorry.

In the above text "is causing host" was change to "is causing the host".

Thanks for adding into your usb-linus branch anyway.

