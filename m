Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BF138B3CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbhETP55 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 May 2021 11:57:57 -0400
Received: from smtprelay0246.hostedemail.com ([216.40.44.246]:52480 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231582AbhETP5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 11:57:53 -0400
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 May 2021 11:57:53 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id F26E3800ABA6
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 15:47:17 +0000 (UTC)
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 8EFAA1010BB17;
        Thu, 20 May 2021 15:47:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 2A9A11124F6;
        Thu, 20 May 2021 15:47:16 +0000 (UTC)
Date:   Thu, 20 May 2021 11:47:13 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <20210520230738.605c92033e16c13b86f7c99c@kernel.org>
References: <162087519356.442660.11385099982318160180.stgit@devnote2> <20210520230738.605c92033e16c13b86f7c99c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] tools/bootconfig: Fix a build error accroding to undefined fallthrough
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
From:   Steven Rostedt <rostedt@goodmis.org>
Message-ID: <F1DB079A-8194-41E3-BF15-EB6F5A23CDF7@goodmis.org>
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 2A9A11124F6
X-Spam-Status: No, score=-2.90
X-Stat-Signature: kjrfuswdaxrgkhnsdb7cdgncqjg4ywrf
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Ud9GppCbbC+zxXoclE4XRdhM4dsCMVIE=
X-HE-Tag: 1621525636-495137
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, I have it cued up too. Can it wait till next week?

--Steve


On May 20, 2021 10:07:38 AM EDT, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>Hi Steve,
>
>Can you pick at least this fix since it is a critical bug?
>
>Thank you,
>
>On Thu, 13 May 2021 12:06:33 +0900
>Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
>> Since the "fallthrough" is defined only in the kernel, building
>> lib/bootconfig.c as a part of user-space tools causes a build
>> error.
>> 
>> Add a dummy fallthrough to avoid the build error.
>> 
>> Cc: stable@vger.kernel.org
>> Fixes: 4c1ca831adb1 ("Revert "lib: Revert use of fallthrough
>pseudo-keyword in lib/"")
>> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>> ---
>>  tools/bootconfig/include/linux/bootconfig.h |    4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/tools/bootconfig/include/linux/bootconfig.h
>b/tools/bootconfig/include/linux/bootconfig.h
>> index 078cbd2ba651..de7f30f99af3 100644
>> --- a/tools/bootconfig/include/linux/bootconfig.h
>> +++ b/tools/bootconfig/include/linux/bootconfig.h
>> @@ -4,4 +4,8 @@
>>  
>>  #include "../../../../include/linux/bootconfig.h"
>>  
>> +#ifndef fallthrough
>> +# define fallthrough
>> +#endif
>> +
>>  #endif
>> 

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity and top posting.
