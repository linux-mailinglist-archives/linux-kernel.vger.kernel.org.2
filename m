Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFF53B2245
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 23:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFWVQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 17:16:58 -0400
Received: from ciao.gmane.io ([116.202.254.214]:46402 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhFWVQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 17:16:56 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jun 2021 17:16:55 EDT
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1lwA7o-0008Qs-HV
        for linux-kernel@vger.kernel.org; Wed, 23 Jun 2021 23:09:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: da7219: Fix an out-of-bound read in an error
 handling path
Date:   Wed, 23 Jun 2021 23:09:26 +0200
Message-ID: <dccc9e1a-5463-17ee-cd7c-fc407a470b09@wanadoo.fr>
References: <4fdde55198294a07f04933f7cef937fcb654c901.1624425670.git.christophe.jaillet@wanadoo.fr>
 <20210623094655.GB2116@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Cc:     alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20210623094655.GB2116@kadam>
Content-Language: en-US
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/06/2021 à 11:46, Dan Carpenter a écrit :
> On Wed, Jun 23, 2021 at 07:22:45AM +0200, Christophe JAILLET wrote:
>> If 'of_clk_add_hw_provider()' fails, the previous 'for' loop will have
>> run completely and 'i' is know to be 'DA7219_DAI_NUM_CLKS'.
>>
>> In such a case, there will be an out-of-bounds access when using
>> 'da7219->dai_clks_lookup[i]' and '&da7219->dai_clks_hw[i]'.
>>
>> To avoid that, add a new label, 'err_free_all', which set the expected
>> value of 'i' in such a case.
>>
>> Fixes: 78013a1cf297 ("ASoC: da7219: Fix clock handling around codec level probe")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   sound/soc/codecs/da7219.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
>> index 13009d08b09a..1e8b491d1fd3 100644
>> --- a/sound/soc/codecs/da7219.c
>> +++ b/sound/soc/codecs/da7219.c
>> @@ -2204,12 +2204,14 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
>>   					     da7219->clk_hw_data);
>>   		if (ret) {
>>   			dev_err(dev, "Failed to register clock provider\n");
>> -			goto err;
>> +			goto err_free_all;
>>   		}
>>   	}
>>   
>>   	return 0;
>>   
>> +err_free_all:
>> +	i = DA7219_DAI_NUM_CLKS - 1;
>>   err:
>>   	do {
>>   		if (da7219->dai_clks_lookup[i])
> 
> This do while statement is wrong and it leads to potentially calling
> clk_hw_unregister() on clks that haven't been registered.

Obviously right.

Thanks for the review Dan.
I'll send a v2 in the coming days.

CJ
> 
> I think that calling clk_hw_unregister() on unregistered clocks is
> supposed to okay but I found a case where it leads to a WARN_ON()
> (Nothing else harmful).  It's in __clk_register() if the alloc_clk()
> fails:
> 
> 	hw->clk = alloc_clk(core, NULL, NULL);
>          if (IS_ERR(hw->clk)) {
>                  ret = PTR_ERR(hw->clk);
>                  goto fail_create_clk;  // <- forgot to set hw->clk = NULL
>          }
> 
> The better way to handle errors from loops is to clean up partial
> iterations before doing the goto.  So add a clk_hw_unregister() if the
> dai_clk_lookup = clkdev_hw_create() assignment fails.  Then use a
> while (--i >= 0) loop in the unwind section:
> 
> err_free_all:
> 	i = DA7219_DAI_NUM_CLKS;
> err:
> 	while (--i >= 0) {
> 
> regards,
> dan carpenter
> 
> 


