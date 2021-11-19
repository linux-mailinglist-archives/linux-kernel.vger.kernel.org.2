Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CC6456696
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 00:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhKRXzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 18:55:41 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43805 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbhKRXzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 18:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637279560; x=1668815560;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qUcsz8KqhOp/gjsqitvhfTleG7RJhYZ1scDXRSPPpCM=;
  b=IF2lNY+Rp8Im2EkPO4OSvU2/GGDJ+crmOb0IyTtMsWsxkKIaCWr/UjOy
   dcn0098tOzkPZbQ5tipw/zEQxufJ3IPdwzNF9MWVmKPSFiTnH2izyE5NK
   RKbx0hYeq5SRU6HHawpUBzP+UAxgUJ/jc5pyXYrrTE3vtT3roCbQnkni5
   lHVqdLlb5rPR19AyL3+qyR9GjTww2PTpJQl5N7Wcy6unf3pNSOzdDREBf
   8s1WeXyqwSnIc0RhX6I/q1JQmmZGDO+EX71znS6xhzFwy5YEUkZA37+i1
   0I4n6tu2xX2gjNb06u5597afz5gGw54PBq5cwAw271HzLqxwzfEZSGLWR
   g==;
X-IronPort-AV: E=Sophos;i="5.87,246,1631548800"; 
   d="scan'208";a="187024360"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2021 07:52:40 +0800
IronPort-SDR: CqbWNmrXeperLG5l7kKjxfNzFlzCHUmquHmXNhLAkEP5tNCpowkTSnaIUsuL1f5nGtpKwB7lTD
 PxhURZwe3ldhE7VhYSlYYibwgt+AvpL2rVhHHulTdqI4xfUiG354qFyp8f44aajkgoIzpnYqJV
 xBliW4dYZJjnSj6z5z6YidySVd0mRCG3hjdkVZ4oqSwWFT+sL+DgioR6UYJVgkZzaoy7CoCg2j
 BefYY69XYlvT3lTwoLl2f1lFWcedbuMpoESq+2dQEPpp4hriisUXDce1u1iFqwXcAelm+mJy/s
 L0F7CWJMEeCs+Mub6hLgIyIB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 15:27:39 -0800
IronPort-SDR: 2Wr/YaUg+MIdEHqo1MJrlG+Jlu6oaRPCSF6mbky3ULo6z/Rrdh5d0MnfJqwX5rmkmqKcowkVvu
 ZuAZPtdwaKY4X1z/KRiNorWGylu0sYq7pi3P8o0q/2+RuapG1KRPj+jslIbbVCwZr8vqSJDqFw
 g2KXKj/9SUWzgJ4ygUbQNIQ24q+Sf8GHh4n8NC/C0e8kH5n61XSmDhJNsK8XUTUKnbyiFMlKBf
 hJyhLcYD+jEvAsmHNoXEEHihOSVdYmW2JWjHkB/OtJRlGYlblZDQe8bEogNRFyzDhACJAwfz9C
 rAc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 15:52:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HwGnM1PxSz1RtVn
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 15:52:39 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637279558; x=1639871559; bh=qUcsz8KqhOp/gjsqitvhfTleG7RJhYZ1scD
        XRSPPpCM=; b=BeRIXAqF40XcaJHtCOVXTHI97p/oRWZByu+B93Gwj/9Dyjlkxjj
        uz0iOtmWSFucnXWdA9r6WvlVn+pRXMhB3XzUtKffNPPGd5hMgq6r6HONwhgDr79k
        eFK6wqjf59r9C84weEAHFliyDBrm6pG+KBRF2g6kHS6adFGmw9oOSw+KUWAXQvYi
        9jyOk8jTFwCHN5NYwzD6blhTj98uaz9bRbRmtg/3DIzNY9p5slcblkC8KDqFjXus
        k380bNYTPEQF2ebm99DXMBS85mSFUVrH3T5wbosVFkUBGVT4pnB5/Z+BaHPef27G
        NMcCLcuPLsFC70+w+Gnm3J6MmrFHjO4yCwA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JlA34ohti5oB for <linux-kernel@vger.kernel.org>;
        Thu, 18 Nov 2021 15:52:38 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HwGnK5BFqz1RtVl;
        Thu, 18 Nov 2021 15:52:37 -0800 (PST)
Message-ID: <701e73f0-cc75-0e9a-de4e-1b949eb11fda@opensource.wdc.com>
Date:   Fri, 19 Nov 2021 08:52:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: [PATCH] sata_fsl: Use struct_group() for memcpy() region
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20211118183807.1283332-1-keescook@chromium.org>
 <0dd24142-a5e6-b146-9315-d2680ef4ed35@opensource.wdc.com>
 <202111181533.2D90E391@keescook>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <202111181533.2D90E391@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/19 8:39, Kees Cook wrote:
> On Fri, Nov 19, 2021 at 08:17:14AM +0900, Damien Le Moal wrote:
>> On 2021/11/19 3:38, Kees Cook wrote:
>>> In preparation for FORTIFY_SOURCE performing compile-time and run-time
>>> field bounds checking for memcpy(), memmove(), and memset(), avoid
>>> intentionally writing across neighboring fields.
>>>
>>> Use struct_group() in struct command_desc around members acmd and fill,
>>> so they can be referenced together. This will allow memset(), memcpy(),
>>> and sizeof() to more easily reason about sizes, improve readability,
>>> and avoid future warnings about writing beyond the end of acmd:
>>>
>>> In function 'fortify_memset_chk',
>>>     inlined from 'sata_fsl_qc_prep' at drivers/ata/sata_fsl.c:534:3:
>>> ./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
>>>   199 |    __write_overflow_field();
>>>       |    ^~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> This lacks some context with regard to FORTIFY_SOURCE and struct_group(). Is
>> that already in 5.16 ? It sounds like it is not. Do you want a ack ? Or do you
>> want me to queue this up for 5.17 ?
> 
> Ah yes, some details are here in the earlier "big" series cover letter
> here:
> https://lore.kernel.org/linux-hardening/20210818060533.3569517-1-keescook@chromium.org/
> 
> One of the requests from earlier review was to split it up for separate
> trees for the maintainers that wanted to take stuff via their trees
> directly.
> 
> The new helpers are landed as of v5.16-rc1, so it can go either way, but
> given that the merge window is closed, I would expect this to be for
> v5.17.
> 
> I am happy to to carry it in my fortify topic branch that I'm expecting
> to send for 5.17, but totally up to you. Some folks like to take these
> changes via their trees, others would rather not be bothered with it. :)

OK. Since it looks like the compilation warning will trigger only when your big
series land in 5.17, I will queue this in for-5.17 (still need to create than
one). Is it ok with you ?

> 
> Thanks!
> 
> -Kees
> 
>>
>> Cheers.
>>
>>> ---
>>>  drivers/ata/sata_fsl.c | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
>>> index e5838b23c9e0..fec3c9032606 100644
>>> --- a/drivers/ata/sata_fsl.c
>>> +++ b/drivers/ata/sata_fsl.c
>>> @@ -246,8 +246,10 @@ enum {
>>>  struct command_desc {
>>>  	u8 cfis[8 * 4];
>>>  	u8 sfis[8 * 4];
>>> -	u8 acmd[4 * 4];
>>> -	u8 fill[4 * 4];
>>> +	struct_group(cdb,
>>> +		u8 acmd[4 * 4];
>>> +		u8 fill[4 * 4];
>>> +	);
>>>  	u32 prdt[SATA_FSL_MAX_PRD_DIRECT * 4];
>>>  	u32 prdt_indirect[(SATA_FSL_MAX_PRD - SATA_FSL_MAX_PRD_DIRECT) * 4];
>>>  };
>>> @@ -531,8 +533,8 @@ static enum ata_completion_errors sata_fsl_qc_prep(struct ata_queued_cmd *qc)
>>>  	/* setup "ACMD - atapi command" in cmd. desc. if this is ATAPI cmd */
>>>  	if (ata_is_atapi(qc->tf.protocol)) {
>>>  		desc_info |= ATAPI_CMD;
>>> -		memset((void *)&cd->acmd, 0, 32);
>>> -		memcpy((void *)&cd->acmd, qc->cdb, qc->dev->cdb_len);
>>> +		memset(&cd->cdb, 0, sizeof(cd->cdb));
>>> +		memcpy(&cd->cdb, qc->cdb, qc->dev->cdb_len);
>>>  	}
>>>  
>>>  	if (qc->flags & ATA_QCFLAG_DMAMAP)
>>>
>>
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research
> 


-- 
Damien Le Moal
Western Digital Research
