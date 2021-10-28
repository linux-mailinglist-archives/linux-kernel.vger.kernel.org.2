Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24D143E709
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhJ1RV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:21:59 -0400
Received: from klopfer.dv.fh-frankfurt.de ([194.95.81.200]:51450 "EHLO
        klopfer.dv.fh-frankfurt.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230174AbhJ1RV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fra-uas.de;
         s=klopfer; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hat62J85X62jvJyK19mkL5UpXeARlsuAMtNgM0cakMQ=; b=OrJ6bMhVdKX1MAe3VxVbggDFq0
        4Tp5eTficC9pu9CSecIgEDXEBC6tajmUKod4Dq1JZuAeg/RXmLOkO+4/s1JSKEBmje2yYfnumk52m
        dIap75HMWAIXGuxo+UhXi3ioTftNspnHu5i+pUJYEXLUkf/JNaw9UJVRskb/yMg7ygxVnnF2plY20
        3FlGoVKJO7ls3lRHgKcWAzIVTbqO0tkqivBK6+XNDbVXUdbEWwJeHUvJt6l3q4L4rO4ZyrVvtpwbl
        qk7pIwYiQYSUO5IXeh3nl0UYLlUi22cgl4ztmUZyyCUQERXhbJXULdrnigiVIEEqFNPoYQFtN4O3Q
        RGjNk02A==;
Received: from [10.5.14.51] (helo=webmail-se.frankfurt-university.de)
        by klopfer.dv.fh-frankfurt.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <ssivaraj@stud.fra-uas.de>)
        id 1mg93n-0007oW-Bz; Thu, 28 Oct 2021 19:19:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 28 Oct 2021 19:19:25 +0200
From:   Senthuran Sivarajah <ssivaraj@stud.fra-uas.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     vaibhav.sr@gmail.com, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: greybus: audio_codec: changed a void function to
 return 0
In-Reply-To: <YXrS9xwJf5AcBoFJ@kroah.com>
References: <20211028153808.9509-1-ssivaraj@stud.fra-uas.de>
 <YXrS9xwJf5AcBoFJ@kroah.com>
Message-ID: <d6841445416a5a4b5e51ba786a607e35@stud.fra-uas.de>
X-Sender: ssivaraj@stud.fra-uas.de
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

I've run the checkpatch.pl script on audio_code.c:
> ./scripts/checkpatch.pl --file --terse 
> drivers/staging/greybus/audio_codec.c

and got the following warning:
> drivers/staging/greybus/audio_codec.c:1032: WARNING: void function 
> return statements are not generally useful

As Brian wrote, we can either remove the return or leave it as is, so my 
"changes" can be ignored. This is not a coding style issue and I should 
have been more clear on the commit message. I apologize for the mistake.

Thank you and @Brian for taking the time to reply.

Kind regards,
Senthu

Am 28.10.2021 18:42, schrieb Greg KH:
> On Thu, Oct 28, 2021 at 05:38:08PM +0200, Senthu Sivarajah wrote:
>> From: Senthuran Sivarajah <ssivaraj@stud.fra-uas.de>
>> 
>> Fixed a coding style issue.
> 
> What coding style exactly?
> 
>> 
>> Signed-off-by: Senthuran Sivarajah <ssivaraj@stud.fra-uas.de>
>> 
>> ---
>>  drivers/staging/greybus/audio_codec.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/staging/greybus/audio_codec.c 
>> b/drivers/staging/greybus/audio_codec.c
>> index b589cf6b1d03..9f99862791dc 100644
>> --- a/drivers/staging/greybus/audio_codec.c
>> +++ b/drivers/staging/greybus/audio_codec.c
>> @@ -1028,7 +1028,7 @@ static int gbcodec_probe(struct 
>> snd_soc_component *comp)
>>  static void gbcodec_remove(struct snd_soc_component *comp)
>>  {
>>  	/* Empty function for now */
>> -	return;
>> +	return 0;
> 
> Did you build this change?
> 
> Exactly what tool reported a problem with this code and what was the
> exact error?
> 
> thanks,
> 
> greg k-h
