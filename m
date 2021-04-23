Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4166369083
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241832AbhDWKqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhDWKqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:46:20 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C19C061574;
        Fri, 23 Apr 2021 03:45:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 4so16970043lfp.11;
        Fri, 23 Apr 2021 03:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TgFjxtYsOVaP6v4PMZp8irtY/yFk5woDCqAeiCFqABA=;
        b=dPWtMidHtJu/eQ7X+GMrm8eY6cIAu28zOaBEA0d3WhtJ630XTxz/F1si9qzLMJHyG/
         hWZjePMhtoigzpcf55ecqAtJmDbEQUIGFZm4CZYbpRJvR6ehddDWWL9cvB7Y2osTZyVs
         1d3GIe/jyMetbl3liuB/IDuGoHaaM1ncGwjQEED08omLCh0S9wA785smoM5hmFfON8jq
         kM/Dhaqq5HJFosb4yvo4F7pOAtlz8ZwEjW94C5a2IYyOAdoB9N8jprhABxW8X2mVl2lg
         HJc0/A5nX1i+7MWdHiPNth6Nohuk1csOl/wAD1XaqIPxaLYpp7m+aKemnGq+Mdruix67
         rGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=TgFjxtYsOVaP6v4PMZp8irtY/yFk5woDCqAeiCFqABA=;
        b=NnkIfdifIn/GeG8fw5mRJDj7B4c6WfjUA74kxjkj8AS8/iiN2zeXtfgxIWf60oM+IS
         Im2FfJ/mo7Mid1m3GMyeE3XqY4nAmiEo8y2C3LX7CPb9OELs1VyXYe7dTajHssLqJMh3
         /ZxEtVXHZXnjJV98VBcQEwO07fkJQYD4wD5X3kc4MXht4vcUp9MOTiMF+J8tkfLOtRZ4
         oGXqazJa+zy1KB9nMnOmqHgTzJ+2s/58Hx+wJUydtZhqGm2dFNNQwLFbHgUWWVo8y2xr
         t6knmknwxtZApYi7m2+DD7QK5mbbiRgnDL/IcjE8HkmL705FLmd6xbvlrkpBccias5CE
         bjpw==
X-Gm-Message-State: AOAM531bhQ6AX7rQFrFgSTNojnvUS5kpLbA+0nxbZ4GWnFsA0sZci2z5
        40swAQREoyyo+L5InVyi4HnGgBLF/6A=
X-Google-Smtp-Source: ABdhPJx4pt/zKtSwBTkr28o85OGy0iMHjelM1jfbr/K3643b8l/4aWyywGt6IMkkyHH0FRidibW/TQ==
X-Received: by 2002:ac2:5682:: with SMTP id 2mr2287134lfr.524.1619174742625;
        Fri, 23 Apr 2021 03:45:42 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id y8sm514938lfe.259.2021.04.23.03.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 03:45:41 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Dan Carpenter' <dan.carpenter@oracle.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        Jae Hyun Yoo <jae.hyun.yoo@intel.com>,
        "John Wang" <wangzhiqiang.bj@bytedance.com>,
        Brad Bishop <bradleyb@fuzziesquirrel.com>,
        Patrick Venture <venture@google.com>,
        "Benjamin Fair" <benjaminfair@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Lippert <rlippert@google.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] soc: aspeed: fix a ternary sign expansion bug
References: <YIE90PSXsMTa2Y8n@mwanda>
        <59596244622c4a15ac8cc0747332d0be@AcuMS.aculab.com>
Date:   Fri, 23 Apr 2021 13:45:40 +0300
In-Reply-To: <59596244622c4a15ac8cc0747332d0be@AcuMS.aculab.com> (David
        Laight's message of "Thu, 22 Apr 2021 16:21:40 +0000")
Message-ID: <877dktuvmz.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> writes:

> From: Dan Carpenter
>> Sent: 22 April 2021 10:12
>> 
>> The intent here was to return negative error codes but it actually
>> returns positive values.  The problem is that type promotion with
>> ternary operations is quite complicated.
>> 
>> "ret" is an int.  "copied" is a u32.  And the snoop_file_read() function
>> returns long.  What happens is that "ret" is cast to u32 and becomes
>> positive then it's cast to long and it's still positive.
>> 
>> Fix this by removing the ternary so that "ret" is type promoted directly
>> to long.
>> 
>> Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
>> index 210455efb321..eceeaf8dfbeb 100644
>> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
>> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
>> @@ -94,8 +94,10 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
>>  			return -EINTR;
>>  	}
>>  	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
>> +	if (ret)
>> +		return ret;
>> 
>> -	return ret ? ret : copied;
>> +	return copied;
>
> I wonder if changing it to:
> 	return ret ? ret + 0L : copied;
>
> Might make people think in the future and not convert it back
> as an 'optimisation'.

It rather made me think: "what the heck is going on here?!"

Shouldn't it better be:

 	return ret ? ret : (long)copied;

or even:

        return ret ?: (long)copied;

?

-- Sergey Organov
