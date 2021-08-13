Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C313EBC22
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhHMSgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhHMSgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:36:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664CCC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 11:35:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so17196264pjl.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kmQGD78Kcw/811yn6mUH04KRF7g+1f/MA8JMyFARSp8=;
        b=fYjRhvBx6STv2QBZ5CbB6ZRNsAObsuvKnveDQqyzBeyf3TOZQt+D6z10IMnbFszOLD
         QUNrOtfby3KNd9WrMmUKjCXqEf8eZ7OpGQEb4W6pzRd364n60aedEJtfET8IS22P5UPr
         lmXsEmYknMPWq5efDpQ8pJOIWx3KqJIeIAUTOLQEjW38F9Ile6Dy3trMG6cwzR1t3ugh
         9go6mbsUHAfYdCVgVsRNwpo1lfihXHwZT9Uer3ps9rVWLKF8CFENGS/Axq4kfo1rqJik
         TA5nBZcv826SkE3xW0p2hdtXo8eYYx9/ekOpeMTAlFwa2nDvx4k3mHC5TTSkcwlfYCpj
         1M4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kmQGD78Kcw/811yn6mUH04KRF7g+1f/MA8JMyFARSp8=;
        b=aiTA8sx4hcJh5k893RlK2l/A2fqco39O0U6qOA/Wo8y6+3XKa6IH8olL9giMXLl+KG
         xh6AWEsVh9H1Bw1bllCT6WMYmBZMkHygrHsIRa7UsA72SnNandf9lIuWgnPtvAyu/pPn
         49Iu53u5NdlbhFP4rw8W3z+wPczqiRe+0mL4LQqNrV1LNyGW8xScsg4mwTX9AVOhLgsr
         1i2f0NQg/MkTOYJDr9o41sHAv6NzB/uipRTeCKUN9AZSaIqiKXG/MXUFl9HzFoY3GLG0
         HgJBhYdWimn4NcunnyLPsWqfO3AMF7+2cvA/7rkX+01/0Sk3NAcgtS6/Vixj4SZLKTH1
         EYag==
X-Gm-Message-State: AOAM532yQaD/mIs+RlyR0dRXAt1Pm3qYZe6HBDwVIaKTtgw1Rk6BRVx5
        Nrb8PJVDHiWRGNqyKWokaDg=
X-Google-Smtp-Source: ABdhPJx3JDx6ePZBFHYocj6ckhh1x+sga4Ijv8RnrIzugNAfXq9reF3IdPBtXiWW04kzeewAoosHqA==
X-Received: by 2002:a63:de56:: with SMTP id y22mr1388284pgi.157.1628879756728;
        Fri, 13 Aug 2021 11:35:56 -0700 (PDT)
Received: from [192.168.1.38] (bb42-60-144-185.singnet.com.sg. [42.60.144.185])
        by smtp.gmail.com with ESMTPSA id d5sm2485792pju.28.2021.08.13.11.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 11:35:56 -0700 (PDT)
Subject: Re: [PATCH] tty: Fix data race between tiocsti() and flush_to_ldisc()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        syzbot+97388eb9d31b997fe1d0@syzkaller.appspotmail.com
References: <20210807190513.3810821-1-phind.uet@gmail.com>
 <YRYgSZwivcPPMhrS@kroah.com>
From:   Phi Nguyen <phind.uet@gmail.com>
Message-ID: <7323d825-f596-223b-a063-7539a6a57107@gmail.com>
Date:   Sat, 14 Aug 2021 02:35:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRYgSZwivcPPMhrS@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/2021 3:33 PM, Greg KH wrote:
>>
>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>> Reported-by: syzbot+97388eb9d31b997fe1d0@syzkaller.appspotmail.com
>> ---
>>   drivers/tty/tty_io.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
>> index e8532006e960..746fe13a2054 100644
>> --- a/drivers/tty/tty_io.c
>> +++ b/drivers/tty/tty_io.c
>> @@ -2307,8 +2307,10 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
>>   	ld = tty_ldisc_ref_wait(tty);
>>   	if (!ld)
>>   		return -EIO;
>> +	tty_buffer_lock_exclusive(tty->port);
>>   	if (ld->ops->receive_buf)
>>   		ld->ops->receive_buf(tty, &ch, &mbz, 1);
>> +	tty_buffer_unlock_exclusive(tty->port);
> 
> Did this fix the syzbot reported issue?
> 
> thanks,
> 
> greg k-h
> Yes, this fixed the syzbot reported issue.

The lock is grabbed in flush_to_ldisc() and paste_selection().
Actually, I follow the document in tty_buffer.c, where it say the 
callers to receive_buff() other than flush_to_ldisc() need to exclude 
the kworker from concurrent use of the line discipline.

And function tiocsti() has the following comment:
/* FIXME: may race normal receive processing */
that why I add lock in this function.

BR,
Phi.
