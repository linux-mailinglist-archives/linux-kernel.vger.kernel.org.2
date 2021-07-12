Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9208D3C5DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhGLN4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 09:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbhGLN4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:56:23 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04185C0613E8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:53:35 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s23so9706484oij.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i7eZqw3VK48fXp1V6gxKXjUX2GxPTkcSqKCBvzAMuLk=;
        b=V2F+UeXpIVaN6HYwWJK5dlVHWJpM4l3unMnSCtpEBkDvLNzTXfEkwFfDAJSfIhtsPD
         sWhM4zm3Jlzr7amgM4Q6SybN+yopDDsYHTxJpmpuRduc5UAb3Tgygn4qAqAYpu80zgfB
         juXhOtN9viEnZNXBAmNnEQikq7dzhvDdbx31BLg8mjzQUf0GoEON/mS1k6bXvfr7hgT7
         wT7W2ULH2zKlKmPqkSFHoN0YDkGoIJBBamS/tf0E3VT5Dfnu2lMgJXJ2o392i4gd7qnI
         SRw1fFJfK85ChfJgS1asq7vhsf59hMc3N8aIj3Wnjy38C9KO3BBN+gLZrLd+slQarUcR
         PJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i7eZqw3VK48fXp1V6gxKXjUX2GxPTkcSqKCBvzAMuLk=;
        b=etRo54UtB/SGJZP7VnW5Yqy9h4AKwGPeV/0mvm8+Nibz84AUOBANje1fBQqs5KLEaM
         yog+yms47lOVKi4gdlJimMBRhkwgwmsXXmJJ4quGGha3CcClxqD6KVBLhgiYdXe8urGz
         Oe+lek2lIw1EjGZIpaO0axHTgs8V1GbqBLpupiHZ5FffN8RRf5M79ryN/7o0I7CsVEsM
         ftHEq4Enoa+P4zgHAs3SMfUZgHbddnToAPRsa18TWtWKcxMaDama8wDiVA+kEYgWAqBC
         8F8XbUlEsfPnjcnaNQPsBJVBLAso+lWecAqLjJIyPhuzo8lhqTReabPKjvQjb/kc9yUG
         FN0Q==
X-Gm-Message-State: AOAM530MwsonHdqDQnVzFMigOZ5pbA6PmeJOgV9e3KDcZ7y0SJiNxXax
        kSZ2metYUq9tS2K3BAmlk2s=
X-Google-Smtp-Source: ABdhPJzunBxof4TSDHcXtTIM1aYLpuX82jCqav9dNaWifoKCeOeRn07rOnbedXIlQ3qDSRtayBggow==
X-Received: by 2002:aca:4f53:: with SMTP id d80mr10516410oib.111.1626098014435;
        Mon, 12 Jul 2021 06:53:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t21sm3114623otl.29.2021.07.12.06.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 06:53:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: Linux 5.14-rc1
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
References: <CAHk-=wjB5XBk4obhMPfrU3mnOakV9VgHAYOo-ZGJnB2X0DnBWA@mail.gmail.com>
 <20210712015619.GA3547193@roeck-us.net> <20210712041423.GA97217@roeck-us.net>
 <20210712052046.GB8042@lst.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0cf6d000-f886-4e99-2e80-78da4ae9367d@roeck-us.net>
Date:   Mon, 12 Jul 2021 06:53:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210712052046.GB8042@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/21 10:20 PM, Christoph Hellwig wrote:
> On Sun, Jul 11, 2021 at 09:14:23PM -0700, Guenter Roeck wrote:
>> My guess was correct. Bisect points to the above commit. Bisect log as well
>> as complete backtrace and example qemu command attached.
>>
>> Copying Christoph and Jens.
> 
> This should fіx it:
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 6d2d63629a90..b8d55af763f9 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -98,11 +98,7 @@ MODULE_ALIAS_SCSI_DEVICE(TYPE_MOD);
>   MODULE_ALIAS_SCSI_DEVICE(TYPE_RBC);
>   MODULE_ALIAS_SCSI_DEVICE(TYPE_ZBC);
>   
> -#if !defined(CONFIG_DEBUG_BLOCK_EXT_DEVT)
>   #define SD_MINORS	16
> -#else
> -#define SD_MINORS	0
> -#endif
>   
>   static void sd_config_discard(struct scsi_disk *, unsigned int);
>   static void sd_config_write_same(struct scsi_disk *);
> 

Yes, that fixes the problem for me.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter
