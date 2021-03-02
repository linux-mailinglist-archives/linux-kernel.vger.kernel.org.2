Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E59532A695
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578608AbhCBPZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:25:35 -0500
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:51243 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347855AbhCBNCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:02:44 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4603e35c7631-91cc2; Tue, 02 Mar 2021 20:55:37 +0800 (CST)
X-RM-TRANSID: 2ee4603e35c7631-91cc2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.21.77] (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9603e35c7299-1c3fb;
        Tue, 02 Mar 2021 20:55:37 +0800 (CST)
X-RM-TRANSID: 2ee9603e35c7299-1c3fb
Subject: Re: [PATCH] ASoC: codec: Omit superfluous error message
 injz4760_codec_probe()
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20210302121148.28328-1-tangbin@cmss.chinamobile.com>
 <K2DCPQ.25EEALUNZ4K3@crapouillou.net>
From:   tangbin <tangbin@cmss.chinamobile.com>
Message-ID: <76c87931-094e-0804-9405-ad4841fae2d3@cmss.chinamobile.com>
Date:   Tue, 2 Mar 2021 20:55:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <K2DCPQ.25EEALUNZ4K3@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul:

On 2021/3/2 20:23, Paul Cercueil wrote:
> Hi Tang,
>
> Le mar. 2 mars 2021 à 20:11, Tang Bin <tangbin@cmss.chinamobile.com> a 
> écrit :
>> The function devm_platform_ioremap_resource has already contained error
>> message, so remove the redundant dev_err here.
>>
>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>> ---
>>  sound/soc/codecs/jz4760.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/sound/soc/codecs/jz4760.c b/sound/soc/codecs/jz4760.c
>> index e8f28ccc145a..c2d8a107f159 100644
>> --- a/sound/soc/codecs/jz4760.c
>> +++ b/sound/soc/codecs/jz4760.c
>> @@ -843,7 +843,6 @@ static int jz4760_codec_probe(struct 
>> platform_device *pdev)
>>      codec->base = devm_platform_ioremap_resource(pdev, 0);
>>      if (IS_ERR(codec->base)) {
>>          ret = PTR_ERR(codec->base);
>> -        dev_err(dev, "Failed to ioremap mmio memory: %d\n", ret);
>>          return ret;
>>      }
>
> Indeed, you are right.
>
> I guess you do this instead:
>
> if (IS_ERR(codec->base))
>    return PTR_ERR(codec->base);

Yes, I would have written it in your ways, but considered the variable 
"ret", I gave up, and just deleted dev_err().


Thanks

Tang Bin





