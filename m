Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D40F386CEB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 00:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244704AbhEQW30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 18:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbhEQW3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 18:29:24 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE89C061573;
        Mon, 17 May 2021 15:28:06 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id m13so6066159qtk.13;
        Mon, 17 May 2021 15:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iE0dbBeK1QqUUcnXwRBryeGQetrBu6zwO6SXZxHOajw=;
        b=jGiLpgmRQJsTZAH1HSVpfL5JXB0nfp5ppg9gMsVuRHDXl61XjaunZAk7hMPIjCcycw
         xUkl/j0CyhjUsSNj+f8j0S9hnxeTVHccOKOL1UVD1EAbUFcUmpalgJa46HBeEkRF7Ryp
         ZWvrk+TXDEvoM15qxq4w5q8FHJS2YwUMg0AHiUi4ZJaNvdhkfHtZuOU0kB51Q98muc5f
         dHBPVE1s2FUM+k2ko9hP2bNMBkz9gLWF8v+D7MFD53pxaNgKxhV5WZEQMR6gQQ8xejYQ
         I6gTGlgs/5L7wBFSOQ9Sx0WEHK65iXGKap/tpd3b+vyFs1He+aZfZkPg6HcrRmZHOku7
         lzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iE0dbBeK1QqUUcnXwRBryeGQetrBu6zwO6SXZxHOajw=;
        b=GFz5Rs5PUpuL0zJs5w+sG4eKOKA4ik9FLxgNh1e36Mp8TK2hmoax7WXSSzZ0Pf95Uk
         5xx9dHYRKN+ytynUadbmmuY7CvKdZVnp4z00KEHL46ka3B117vMErj6UJdoGV1h5BIf2
         y5Oh9yNyeQGxXgX+2dgyCoZpG0HnNY8ghQZ2FnNgknpAxZaa2jvGiQD1wwGC1UXdEyww
         V5N9fJZzYvjUHTZ3FitbaudGV7ljWtlh4kbarsGN/GwBOr5F4B/FniE7/GJz7CGYd3MG
         GMEAIYwvq0rqVD2TgjTC37UYWwUT1uEmlFDmnR9MS94sIXhUpnLX6bP2JDIxbDrqfB+v
         4E9A==
X-Gm-Message-State: AOAM532Cl2v3+Yaz9Tsf7XQrNyZzQk1yN7yuLXhCzl9nSB8vlgfNLr8W
        UfOWdikQPPJbPcNEU/mY930quRHHt6Y=
X-Google-Smtp-Source: ABdhPJyMOPCEVFoERmTH8RI0ryotV5ILeGo+qmtm1wGU4HI+tM96pUrA5hMmnUIDr9ATk8/1PCO7Eg==
X-Received: by 2002:ac8:474c:: with SMTP id k12mr1706259qtp.377.1621290485822;
        Mon, 17 May 2021 15:28:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 19sm11621608qkn.111.2021.05.17.15.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 15:28:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon:q54sj108a2: the PMBUS_MFR_ID is actually 6 chars
 instead of 5
To:     Chu Lin <linchuyuan@google.com>, linchuyuan@gmail.com,
        jasonling@google.com, zhongqil@google.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210517222606.3457594-1-linchuyuan@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ff2e9bf6-f82b-01ce-6206-a9882d9d4a97@roeck-us.net>
Date:   Mon, 17 May 2021 15:28:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517222606.3457594-1-linchuyuan@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/21 3:26 PM, Chu Lin wrote:
> The PMBUS_MFR_ID block is actually 6 chars for q54sj108a2.
> /sys/bus/i2c/drivers/q54sj108a2_test# iotools smbus_read8 $BUS $ADDR 0x99
> 0x06
> 

What is the 6th character ? Should it be checked as well ?

> Tested: Devices are able to bind to the q54sj108a2 driver successfully.
> 
> Signed-off-by: Chu Lin <linchuyuan@google.com>
> ---
>   drivers/hwmon/pmbus/q54sj108a2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/q54sj108a2.c b/drivers/hwmon/pmbus/q54sj108a2.c
> index aec512766c31..0976268b2670 100644
> --- a/drivers/hwmon/pmbus/q54sj108a2.c
> +++ b/drivers/hwmon/pmbus/q54sj108a2.c
> @@ -299,7 +299,7 @@ static int q54sj108a2_probe(struct i2c_client *client)
>   		dev_err(&client->dev, "Failed to read Manufacturer ID\n");
>   		return ret;
>   	}
> -	if (ret != 5 || strncmp(buf, "DELTA", 5)) {
> +	if (ret != 6 || strncmp(buf, "DELTA", 5)) {
>   		buf[ret] = '\0';
>   		dev_err(dev, "Unsupported Manufacturer ID '%s'\n", buf);
>   		return -ENODEV;
> 

