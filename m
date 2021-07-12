Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7033C63BB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbhGLTbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhGLTbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:31:02 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D925C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:28:14 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id m14-20020a4a240e0000b029025e4d9b0a3dso1879581oof.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ANu+4hZqIsYH8jIAo9U6luSzmuVo1SKhi3SkPBbrNDQ=;
        b=gHf6ITmAtUxf8kS9llwSieAwCO9Q19NFfwQJO6Gt3XTuI02jB/9gzoobfD4XznGlKI
         gVDXDAPjTH2i2gKwGrmkKHQvlnW2iP0Kxs6aaMyv7iQABOwIezP/snk0CnhhHKiOAmhR
         Y1IaHY7Cl3aTTLGa+uwhm5pKIAxlE0babG0UhA1SwgEMgVe9NL/xL2xsAOQh6JIPmmQe
         YeyPtB5iMsqaPIsDyiHcsyZz47o9scKjlJzZdO9Mtyw8ZuOXcaJsO90q5vcT37HK6gup
         GkVGXDomf2azC8mngch2cXL/BaCn4LgagwCQXpsIqeuY1TbAHA4RUYU9lXjTjrzkLRlv
         U1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ANu+4hZqIsYH8jIAo9U6luSzmuVo1SKhi3SkPBbrNDQ=;
        b=ojdAfoI3stn0rgcnXjlaSyGkiK2bV2Z/5qoK3eVhn6T01ybySL+LX1KQtkKQs7rpOp
         pC1AjzvchRRYqy1yMPCZopJh5jP0y8L2eZ0ktV/oOZHuCipe22Tz6UKp5RAoQ0C8HWC6
         82tolpB4/I2dAhuAzZbSBsSGIQC6BldytjZ1Pw61VDQZOezW/fnwJJmLOzGcxhMI7XQ9
         1h2+yq7MzRl4C3mlvND6cWM9vBoUPblM+6NjLIAONdGrYY8464yGHtXyNdWOQtojAk5Y
         d829sz8sgFTHWgD/MTLqq2b+4bbw16vVCQtbBz1JRJcEjkYmvXKC5WOgkKF+YIuNWQ3z
         PcSw==
X-Gm-Message-State: AOAM531dXbi5MoxYGa+VT0kHzHw9feXksNZ7lRu38k/ZlDDRQ6LJCAZL
        TSwUK7wiJuoQMum0p/rdh+s=
X-Google-Smtp-Source: ABdhPJzGz/oCw9eTayVXI0oCyFEUvbhkcdm8PAVdvaFS3btdDW6++fulMq0migiEnor4tMtASfPjrQ==
X-Received: by 2002:a4a:9e02:: with SMTP id t2mr575362ook.73.1626118093414;
        Mon, 12 Jul 2021 12:28:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w13sm975452oia.1.2021.07.12.12.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 12:28:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: Linux 5.14-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
References: <CAHk-=wjB5XBk4obhMPfrU3mnOakV9VgHAYOo-ZGJnB2X0DnBWA@mail.gmail.com>
 <20210712015619.GA3547193@roeck-us.net> <20210712041423.GA97217@roeck-us.net>
 <20210712052046.GB8042@lst.de>
 <0cf6d000-f886-4e99-2e80-78da4ae9367d@roeck-us.net>
 <CAHk-=wjkQb8DzNg-qAWKWFAS-3Uy-4BUYR0ympb_W-Om=TabNg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2c03b355-86dd-1fa6-dbaf-5857f4a45a66@roeck-us.net>
Date:   Mon, 12 Jul 2021 12:28:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjkQb8DzNg-qAWKWFAS-3Uy-4BUYR0ympb_W-Om=TabNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/21 12:03 PM, Linus Torvalds wrote:
> On Mon, Jul 12, 2021 at 6:53 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 7/11/21 10:20 PM, Christoph Hellwig wrote:
>>>
>>> This should fіx it:
>>>
>>> -#if !defined(CONFIG_DEBUG_BLOCK_EXT_DEVT)
>>>    #define SD_MINORS   16
>>> -#else
>>> -#define SD_MINORS    0
>>> -#endif
>>>
>>>    static void sd_config_discard(struct scsi_disk *, unsigned int);
>>>    static void sd_config_write_same(struct scsi_disk *);
>>>
>>
>> Yes, that fixes the problem for me.
>>
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thanks for reporting and testing.
> 
> Christoph, can I get that as a proper patch with a commit message?
> 

Christoph already sent it:

https://patchwork.kernel.org/project/linux-block/patch/20210712155001.125632-1-hch@lst.de/

Guenter
