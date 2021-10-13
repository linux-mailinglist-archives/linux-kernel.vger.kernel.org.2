Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F8142B0E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhJMAUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhJMAUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:20:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432D6C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 17:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ENilPhVukyFHnaY/AS4Gv9gS6lt1d3pyM/7jv2Mwtjk=; b=2VH1yhUPmD350CsU5wiq7buw/p
        3+/I3Vrba/5ao8UVg5IUHvg8tIrvux3NQziCz1oJ+vt/SGbyGUD4dgKB1AL9Y+DJIccz8RPi5MRMj
        o6hK+/HiwD87sREpNPzEtFmVNTIyTM4qTnshLC/nxeZRCj/qFUDflhW4PvheNbQWnlG+tESmNhL3y
        LaOVoX9zYbt/GX0oE+cjV2RLZUItUj3TWQCnHJuBZ4i49zMYlRp+VWAR+OmiOUbTi1JkKNjxLTOae
        3i0nvWRv7KvMw5YUDsKPQMImhyTwZJcDMi1jm5JISSJyVOmGazP8jZK8VJjfTKk3bPQXQPHcRQIq3
        Wfo6iMoQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maRyb-00EMA4-OG; Wed, 13 Oct 2021 00:18:33 +0000
Subject: Re: [PATCH] init: Make unknown command line param message clearer
To:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     akpm@linux-foundation.org, bp@suse.de, linux-kernel@vger.kernel.org
References: <20211012213523.39801-1-ahalaney@redhat.com>
 <20211012200106.1afdbb0b@gandalf.local.home>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <87853d4f-d6f8-1d58-1a07-c8232dae87fd@infradead.org>
Date:   Tue, 12 Oct 2021 17:18:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012200106.1afdbb0b@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/21 5:01 PM, Steven Rostedt wrote:
> On Tue, 12 Oct 2021 16:35:23 -0500
> Andrew Halaney <ahalaney@redhat.com> wrote:
> 
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -925,6 +925,10 @@ static void __init print_unknown_bootoptions(void)
>>   	for (p = &envp_init[2]; *p; p++)
>>   		end += sprintf(end, " %s", *p);
>>   
>> +	pr_notice("The kernel command line has unknown parameters. They are either\n");
>> +	pr_notice("misspelled, not valid for the current kernel configuration,\n");
>> +	pr_notice("or are meant for init but are not after the '--' delineator. They will\n");
>> +	pr_notice("be passed to init along with those after '--' on the command line.\n");
>>   	pr_notice("Unknown command line parameters:%s\n", unknown_options);
>>   	memblock_free(unknown_options, len);
> 
> What about just changing it to simply say:
> 
> 	pr_notice("Unknown kernel command line parameters "%s", will be	passed to user space.\n",
> 		  unknown_options);
> 

Yes, that's much more palatable.

thanks.
-- 
~Randy
