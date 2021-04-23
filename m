Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA19369BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 23:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244177AbhDWVJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 17:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244204AbhDWVIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 17:08:43 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54072C06138E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 14:08:05 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id p12-20020a4a2f0c0000b02901ecdbb16887so4020687oop.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 14:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=A22TFll9Blm6PfGJntS755LasWSXUim+ApdH7q9KXpA=;
        b=R5TEIv7r4kLuU5GuMWuxRcVR6NDvYx2skoH8US3RTsgU/Fbp/2PVhgI2qB1oIuefno
         7jxT4w0OVfBtyKsNLQx3nU/NuBSntlMycnPfjjUb59ce/gDpthHN9M7whlXmWdynzzV4
         mE5U3vaTyTDVk98Qw56lnGFYnGuEwSIbthXUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A22TFll9Blm6PfGJntS755LasWSXUim+ApdH7q9KXpA=;
        b=ChmBZGpbtBixN6eHQJ4uBvsUb6rzBURF457k6/lEN5MQSmLNhd7NcY/x3+zDd4e9tG
         ABAFo2TIAfY/9PWnQYRlnOOgxU2USnS5wO7mAtJwHcO3wFXYk67JnZbYuJiVKBC4ZvDn
         Ndq2e/Th826pkghGt0xHLAjX4C2WrgWUCBK+wMZiIXjC/tGaxaTMbN08Hahjzac0+MlA
         iyT+WsfccBLQXS76PTfUi2bTIeKZUteSBYHInQO4P40GlQLUFgYwBYzKd0fJePCrWnzE
         ETroQsBRaFF7j7VJJ58ICXQCWuQOfrfugsTa6fVmTCwtLBz7rjmUn3ErWS50XaPkoVCm
         POSw==
X-Gm-Message-State: AOAM533Ry6GSpin6Qp7Jj/fo2zefNcjVf0zfhw5cXZmufc+5QQibCvZr
        U/UldqCcGHGS6gcXjd33RYgoug==
X-Google-Smtp-Source: ABdhPJzmW7K55h27yHhlG31k1T2j2EBi0KXXkEuGIYledi+3ZceYb0qhnae+2xECf/+H2U4zaV+zUA==
X-Received: by 2002:a4a:2f09:: with SMTP id p9mr4337857oop.70.1619212084733;
        Fri, 23 Apr 2021 14:08:04 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r19sm1482819oie.58.2021.04.23.14.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 14:08:04 -0700 (PDT)
Subject: Re: [PATCH] drivers: pnp: proc.c: Removed unnecessary varibles
To:     Anupama K Patil <anupamakpatil123@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam <developer@arusty.dev>, bkkarthik@pesu.pes.edu,
        gregkh@linuxfoundation.org, kernelnewbies@kernelnewbies.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210422180322.7wlyg63kv3n2k6id@ubuntu>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ea09f455-a00f-a13d-29d8-e3f9790dba56@linuxfoundation.org>
Date:   Fri, 23 Apr 2021 15:08:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210422180322.7wlyg63kv3n2k6id@ubuntu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/21 12:03 PM, Anupama K Patil wrote:
> de, e are two variables of the type 'struct proc_dir_entry'
> which can be removed to save memory. This also fixes a coding style
> issue reported by checkpatch where we are suggested to make assignment
> outside the if statement.
> 

Sounds like a reasonable change.

> Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> ---
>   drivers/pnp/isapnp/proc.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
> index 785a796430fa..1ae458c02656 100644
> --- a/drivers/pnp/isapnp/proc.c
> +++ b/drivers/pnp/isapnp/proc.c
> @@ -57,21 +57,20 @@ static const struct proc_ops isapnp_proc_bus_proc_ops = {
>   static int isapnp_proc_attach_device(struct pnp_dev *dev)
>   {
>   	struct pnp_card *bus = dev->card;
> -	struct proc_dir_entry *de, *e;
>   	char name[16];
>   
> -	if (!(de = bus->procdir)) {
> +	if (!bus->procdir) {
>   		sprintf(name, "%02x", bus->number);

It would make sense to change this to scnprintf()

> -		de = bus->procdir = proc_mkdir(name, isapnp_proc_bus_dir);
> -		if (!de)
> +		bus->procdir = proc_mkdir(name, isapnp_proc_bus_dir);
> +		if (!bus->procdir)
>   			return -ENOMEM;
>   	}
>   	sprintf(name, "%02x", dev->number);

It would make sense to change this to scnprintf()

> -	e = dev->procent = proc_create_data(name, S_IFREG | S_IRUGO, de,
> +	dev->procent = proc_create_data(name, S_IFREG | S_IRUGO, bus->procdir,
>   					    &isapnp_proc_bus_proc_ops, dev);
> -	if (!e)
> +	if (!dev->procent)
>   		return -ENOMEM;

Shouldn't the procdir be deleted when proc_create_data() fails?

> -	proc_set_size(e, 256);
> +	proc_set_size(dev->procent, 256);
>   	return 0;
>   }
>   
> 

Note that isapnp_proc_init() doesn't check isapnp_proc_attach_device()
return and handle errors and cleanup.

thanks,
-- Shuah


