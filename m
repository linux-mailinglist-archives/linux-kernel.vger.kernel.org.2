Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33877386E6E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 02:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345095AbhERApi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 20:45:38 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.66]:47055 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239766AbhERAph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 20:45:37 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 2D8BC8764
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 19:44:19 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id inqNl3WsWAEP6inqNlfmvc; Mon, 17 May 2021 19:44:19 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ntIjWUeieD6no0ScsLxmjaMZDC0tgIU+DCAcElh/j7Q=; b=DSMoMuzmFrPUYVup8/IMDKgr4F
        AfsVeWIHwxHgK2BHdih+dJLSfhfzItbVqanhEXlfEbgGPTsaA4oJX/6UVeEp1e4VB+lKyjeZWoKBc
        fonRipP/4TotITPG2NCCNunjCg3dXx6MDet4M8jEns1395mwOOqMPp6366tyAo5Vytv16ztPLOoqv
        8SgyJw8VGEMl6kFsCZogBqMttOld8Ceg9RHZYhF9AzaVw4da9AUcWT/Wr0NMTaPpTyYBlFTjg5sKf
        0jxu9jAGH+1ovi9qjrxhNw7ze67V3+YtSfNyiKZfi6h3IG6HsrrtVu4MTJgYKGGXnGQ4S67yEB/4T
        ycOaPUIA==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:53506 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1linqK-002kab-Oa; Mon, 17 May 2021 19:44:16 -0500
Subject: Re: [PATCH RESEND][next] hwmon: (corsair-cpro) Fix fall-through
 warnings for Clang
To:     Marius Zachmann <mail@mariuszachmann.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210305095359.GA141682@embeddedor> <107682713.BXpLqza3Di@marius>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <d3f05bf0-886d-ae74-4189-00a69c8387fc@embeddedor.com>
Date:   Mon, 17 May 2021 19:44:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <107682713.BXpLqza3Di@marius>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1linqK-002kab-Oa
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:53506
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 69
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

If you don't mind, I'm taking this in my -next[1] branch for v5.14.

Thanks
--
Gustavo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp

On 3/6/21 04:39, Marius Zachmann wrote:
> On 06.03.21 at 10:53:59 CET, Gustavo A. R. Silva wrote
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>> by explicitly adding a break statement instead of letting the code fall
>> through to the next case.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Acked-by: Marius Zachmann <mail@mariuszachmann.de>
> 
>> ---
>>  drivers/hwmon/corsair-cpro.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
>> index 591929ec217a..fa6aa4fc8b52 100644
>> --- a/drivers/hwmon/corsair-cpro.c
>> +++ b/drivers/hwmon/corsair-cpro.c
>> @@ -310,6 +310,7 @@ static int ccp_write(struct device *dev, enum hwmon_sensor_types type,
>>  		default:
>>  			break;
>>  		}
>> +		break;
>>  	default:
>>  		break;
>>  	}
>>
> 
> 
> 
> 
