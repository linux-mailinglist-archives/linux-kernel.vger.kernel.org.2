Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10D9368BD0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 06:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbhDWEFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 00:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbhDWEFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 00:05:36 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDB3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 21:05:01 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i190so33213492pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 21:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=7Rh+WfQ9nmhLJIbX/qHrwtB7uwRLAG3DJAvNQ+dZ+7g=;
        b=Ub15tQB101oEHSFzEmqO7wllIPI2WrpNCQmK6PJCvxrojxfRtzsDhvK8dlq+Hd0gWS
         ZB+7xQd91WbaIm7Rxwvs0ddDa76hD/WnkTH+OasC2b1/TQ4r4q/xS8h7qruLxUwEdoQ9
         H8WwXKlwNO5Y1qXB/CDOEAnYv43LRlSEqpCnOKh2D98+VpFeSTBXYBfz+HTOQNLNYUKo
         bRf1CHQ5dQpj4Xp4LMz/XKXuqN7OYvbce5wou/P6axtQzWroRv5iMLniuq8K70OYcwXq
         n3I03vddAgSbSOxVZl8kXKyivdmBvPAp3rH5bqdKCSeWSIf25XnwN68ZERbnDV01Uz/V
         yEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7Rh+WfQ9nmhLJIbX/qHrwtB7uwRLAG3DJAvNQ+dZ+7g=;
        b=hxBjalIznZOKtMy0EKCA1lGGeuzvesScYhmxYW/ufRCqfkpY4HB/S4H+iDSd8gRYDx
         yF/X9NZkFUcrw7C5x6HFJgF48+xhdklWUwzlzMahE2dcelo+1SYnRjjxE1Qf/Tjg9+sF
         g8Z1zPjY9XGWTr4AOTCtPFWT6Nv+22/9bTiB7dN+Q7aDFc+SroQVr5fQRo2bbFxypSGk
         HPLXBWD9LO1570OIWuapyGmUinRzyDixZkW+iiuQyAzDVK8uEwhSEqrwBuf4seq/4Ho9
         LCtVzrlaD4R6WHeg1vSZAj9fBM7K/Eia/GPjtQ7LHWKPz3A7rstE6aYuPixI4LlAc7NO
         Miww==
X-Gm-Message-State: AOAM532tqWePDrntgqVdpT9DYUNTV+LLoTNo02ECagOqsGgbsH1QkMxM
        MWPqkHV7emiht8zxtWhD/Ppqfg==
X-Google-Smtp-Source: ABdhPJwDLp+YvfT3vTkhJex/w3eRTBqZI1Ia9lVMKJXAdp2qBrW9O9ciqokATghsElA1I98nn/iaPw==
X-Received: by 2002:a63:231c:: with SMTP id j28mr1884713pgj.165.1619150700460;
        Thu, 22 Apr 2021 21:05:00 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t15sm3413859pgh.33.2021.04.22.21.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 21:04:59 -0700 (PDT)
Date:   Thu, 22 Apr 2021 21:04:59 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 21:04:58 PDT (-0700)
Subject:     Re: [PATCH v4 1/2] binfmt_flat: allow not offsetting data start
In-Reply-To: <BL0PR04MB651434FAFF5566A575FDBE76E7469@BL0PR04MB6514.namprd04.prod.outlook.com>
CC:     gerg@linux-m68k.org, uclinux-dev@uclinux.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <Anup.Patel@wdc.com>, Christoph Hellwig <hch@lst.de>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Message-ID: <mhng-5208d0c7-acc3-48ac-823d-ffef9f1123e0@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2021 05:00:32 PDT (-0700), Damien Le Moal wrote:
>> On 2021/04/18 11:38, Greg Ungerer wrote:
>> 
>> 
>> On 17/4/21 2:54 pm, Damien Le Moal wrote:
>>> On 2021/04/17 13:52, Greg Ungerer wrote:
>>>>
>>>> On 17/4/21 11:10 am, Damien Le Moal wrote:
>>>>> Commit 2217b9826246 ("binfmt_flat: revert "binfmt_flat: don't offset
>>>>> the data start"") restored offsetting the start of the data section by
>>>>> a number of words defined by MAX_SHARED_LIBS. As a result, since
>>>>> MAX_SHARED_LIBS is never 0, a gap between the text and data sections
>>>>> always exists. For architectures which cannot support a such gap
>>>>> between the text and data sections (e.g. riscv nommu), flat binary
>>>>> programs cannot be executed.
>>>>>
>>>>> To allow an architecture to request no data start offset to allow for
>>>>> contiguous text and data sections for binaries flagged with
>>>>> FLAT_FLAG_RAM, introduce the new config option
>>>>> CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET. Using this new option, the
>>>>> macro DATA_START_OFFSET_WORDS is conditionally defined in binfmt_flat.c
>>>>> to MAX_SHARED_LIBS for architectures tolerating or needing the data
>>>>> start offset (CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET disabled case)
>>>>> and to 0 when CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET is enabled.
>>>>> DATA_START_OFFSET_WORDS is used in load_flat_file() to calculate the
>>>>> data section length and start position.
>>>>>
>>>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>>>>> ---
>>>>>    fs/Kconfig.binfmt |  3 +++
>>>>>    fs/binfmt_flat.c  | 19 ++++++++++++++-----
>>>>>    2 files changed, 17 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
>>>>> index c6f1c8c1934e..06fb7a93a1bd 100644
>>>>> --- a/fs/Kconfig.binfmt
>>>>> +++ b/fs/Kconfig.binfmt
>>>>> @@ -112,6 +112,9 @@ config BINFMT_FLAT_ARGVP_ENVP_ON_STACK
>>>>>    config BINFMT_FLAT_OLD_ALWAYS_RAM
>>>>>    	bool
>>>>>    
>>>>> +config BINFMT_FLAT_NO_DATA_START_OFFSET
>>>>> +	bool
>>>>> +
>>>>>    config BINFMT_FLAT_OLD
>>>>>    	bool "Enable support for very old legacy flat binaries"
>>>>>    	depends on BINFMT_FLAT
>>>>> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
>>>>> index b9c658e0548e..1dc68dfba3e0 100644
>>>>> --- a/fs/binfmt_flat.c
>>>>> +++ b/fs/binfmt_flat.c
>>>>> @@ -74,6 +74,12 @@
>>>>>    #define	MAX_SHARED_LIBS			(1)
>>>>>    #endif
>>>>>    
>>>>> +#ifdef CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET
>>>>> +#define DATA_START_OFFSET_WORDS		(0)
>>>>> +#else
>>>>> +#define DATA_START_OFFSET_WORDS		(MAX_SHARED_LIBS)
>>>>> +#endif
>>>>> +
>>>>>    struct lib_info {
>>>>>    	struct {
>>>>>    		unsigned long start_code;		/* Start of text segment */
>>>>> @@ -560,6 +566,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>>>>>    	 * it all together.
>>>>>    	 */
>>>>>    	if (!IS_ENABLED(CONFIG_MMU) && !(flags & (FLAT_FLAG_RAM|FLAT_FLAG_GZIP))) {
>>>>> +
>>>>
>>>> Random white space change...
>>>> Don't worry about re-spinning though, I will just edit this chunk out.
>>>
>>> Oops. Sorry about that. I should have better checked :)
>>>
>>>>
>>>>
>>>>>    		/*
>>>>>    		 * this should give us a ROM ptr,  but if it doesn't we don't
>>>>>    		 * really care
>>>>> @@ -576,7 +583,8 @@ static int load_flat_file(struct linux_binprm *bprm,
>>>>>    			goto err;
>>>>>    		}
>>>>>    
>>>>> -		len = data_len + extra + MAX_SHARED_LIBS * sizeof(unsigned long);
>>>>> +		len = data_len + extra +
>>>>> +			DATA_START_OFFSET_WORDS * sizeof(unsigned long);
>>>>>    		len = PAGE_ALIGN(len);
>>>>>    		realdatastart = vm_mmap(NULL, 0, len,
>>>>>    			PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 0);
>>>>> @@ -591,7 +599,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>>>>>    			goto err;
>>>>>    		}
>>>>>    		datapos = ALIGN(realdatastart +
>>>>> -				MAX_SHARED_LIBS * sizeof(unsigned long),
>>>>> +				DATA_START_OFFSET_WORDS * sizeof(unsigned long),
>>>>>    				FLAT_DATA_ALIGN);
>>>>>    
>>>>>    		pr_debug("Allocated data+bss+stack (%u bytes): %lx\n",
>>>>> @@ -622,7 +630,8 @@ static int load_flat_file(struct linux_binprm *bprm,
>>>>>    		memp_size = len;
>>>>>    	} else {
>>>>>    
>>>>> -		len = text_len + data_len + extra + MAX_SHARED_LIBS * sizeof(u32);
>>>>> +		len = text_len + data_len + extra +
>>>>> +			DATA_START_OFFSET_WORDS * sizeof(u32);
>>>>>    		len = PAGE_ALIGN(len);
>>>>>    		textpos = vm_mmap(NULL, 0, len,
>>>>>    			PROT_READ | PROT_EXEC | PROT_WRITE, MAP_PRIVATE, 0);
>>>>> @@ -638,7 +647,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>>>>>    
>>>>>    		realdatastart = textpos + ntohl(hdr->data_start);
>>>>>    		datapos = ALIGN(realdatastart +
>>>>> -				MAX_SHARED_LIBS * sizeof(u32),
>>>>> +				DATA_START_OFFSET_WORDS * sizeof(u32),
>>>>>    				FLAT_DATA_ALIGN);
>>>>>    
>>>>>    		reloc = (__be32 __user *)
>>>>> @@ -714,7 +723,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>>>>>    			ret = result;
>>>>>    			pr_err("Unable to read code+data+bss, errno %d\n", ret);
>>>>>    			vm_munmap(textpos, text_len + data_len + extra +
>>>>> -				MAX_SHARED_LIBS * sizeof(u32));
>>>>> +				  DATA_START_OFFSET_WORDS * sizeof(u32));
>>>>>    			goto err;
>>>>>    		}
>>>>>    	}
>>>>>
>>>>
>>>> Thanks, otherwise looks good.
>>>>
>>>> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
>>>>
>>>> I will push this into my m68knommu tree, for-next branch.
>>>> I just carry the flat format changes in that tree now to make my life easier.
>>>
>>> Great. Thanks !
>>> Are you taking both patches or should Plamer take the riscv Kconfig change
>>> through his tree ?
>> 
>> I am happy to take both.
>> Palmer?
>
>Palmer,
>
>Ping !

I already Ack'd it, in the thread where we couldn't find the maintainer.  
Keeping these togther is fine with me, and it seems easiest.

>
>
>-- 
>Damien Le Moal
>Western Digital Research
>
