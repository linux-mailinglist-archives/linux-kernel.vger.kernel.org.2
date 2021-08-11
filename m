Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3892B3E902D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbhHKMJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:09:28 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:44180 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbhHKMJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:09:26 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16113bdd84ea-643d2; Wed, 11 Aug 2021 20:09:00 +0800 (CST)
X-RM-TRANSID: 2ee16113bdd84ea-643d2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.26.114] (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36113bdda490-3ef9f;
        Wed, 11 Aug 2021 20:09:00 +0800 (CST)
X-RM-TRANSID: 2ee36113bdda490-3ef9f
Subject: Re: [PATCH] ASoC: stm32: spdifrx: Delete unnecessary check in
 theprobe function
To:     Mark Brown <broonie@kernel.org>
Cc:     olivier.moysan@foss.st.com, arnaud.pouliquen@foss.st.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
References: <20210811115523.17232-1-tangbin@cmss.chinamobile.com>
 <20210811115846.GC4167@sirena.org.uk>
From:   tangbin <tangbin@cmss.chinamobile.com>
Message-ID: <7ddb13ee-2ca6-bf8d-2a83-9896d29176c5@cmss.chinamobile.com>
Date:   Wed, 11 Aug 2021 20:09:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210811115846.GC4167@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark:

On 2021/8/11 19:58, Mark Brown wrote:
> On Wed, Aug 11, 2021 at 07:55:23PM +0800, Tang Bin wrote:
>> The function stm32_spdifrx_parse_of() is only called by the function
>> stm32_spdifrx_probe(), and the probe function is only called with
>> an openfirmware platform device. Therefore there is no need to check
>> the device_node in probe function.
> What is the benefit of not doing the check?  It seems like reasonable
> defensive programming.

I think it's unnecessary, because we all know than the probe function is 
only trigger if

the device and the driver matches, and the trigger mode is just Device 
Tree. So the device_node

must be exist in the probe function if it works. That's the reason why I 
think it's redundant.

Thanks

Tang Bin



