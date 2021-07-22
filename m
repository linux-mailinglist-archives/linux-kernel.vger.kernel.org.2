Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC783D1D25
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 06:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhGVEIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 00:08:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbhGVEIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 00:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626929350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Gfbbbw8GCy88nvueDyxwio6t6BetITjaO/VJvP2t3I=;
        b=Wryf2km50lX5pxrhqsKx3gwju0jBjA/BPWaahrF4hD6u95qiRS1uY7jpn25IQHKlCx102+
        mPUj+6otBvBK1bQuxdAHNGwhckJpW42KSUGSk9mWi88qe+daCQjTvc0IvHdaxC+/Fh76Cs
        4D580yg2ngfSHVChqugW2jRvscbYaP4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-X25irm0RPneerzVaAgEBqw-1; Thu, 22 Jul 2021 00:49:08 -0400
X-MC-Unique: X25irm0RPneerzVaAgEBqw-1
Received: by mail-wr1-f70.google.com with SMTP id r9-20020a5d49890000b02901524df25ad7so1948828wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 21:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Gfbbbw8GCy88nvueDyxwio6t6BetITjaO/VJvP2t3I=;
        b=XyV9LKDuaFF1hfsi4qfQ5nIWVAzeQ7TBmS1d6M/nmbTKaWvaplMiHS4GoEq+6xm+Lp
         TSDpmhrkQNdwsU7rH4QRsPx7zX6KTKKr/jKR55bCsVlbZcVjAOxua+BEvV2Xj8ABu965
         f9bx23SsjC8HPwFOHdjmL9yCLaZQQ0UQqYySIGRcHhEITcDeYQsW8RUoTJYt7ftFzqg4
         vIbRwWQEMAsNBydo7baIKU1krMAtg01kXaYNJqCybr7dWJ78C2gPDsv1k9c/nCy4wgtm
         RABNUQBn4JyKF9NQE908oF6A5BZWatqUL3z6QathNFPFwjIylJQWtdNnC6l3mBU+a2i4
         urtQ==
X-Gm-Message-State: AOAM531LDXQRVreH659m+l38wQM2Zm2jm9OSTS/6SER6Da3t7Y0lkTfv
        /bWkNNADGAIPuSrFmZL5dXJfmnNPQ/vvR5ceETQp2pGcJcGw2EzqlsrhVsCESJgx4+ys40cQjar
        OBRfIg+zUyUd3gafCKO+HjCiIWkUZ7wiA37iS3K189VnHZ1mMQxLWLB1dBtD2QtMwCbi+PConkp
        A=
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr45715429wrs.187.1626929347335;
        Wed, 21 Jul 2021 21:49:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLqRxim7uNM+lMdIE0/W8UuBefKz6alb+zheNc9UB0PUqG9KCXZKdp6eEKKtEdDB/8JMUaTw==
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr45715409wrs.187.1626929347100;
        Wed, 21 Jul 2021 21:49:07 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id l22sm1533224wmp.41.2021.07.21.21.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 21:49:06 -0700 (PDT)
Subject: Re: [drm-drm-misc:drm-misc-next 1/2] undefined reference to
 `screen_info'
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202107212028.p9mTHgcu-lkp@intel.com>
 <daa6e212-9e66-e551-948f-0a3c59cafd9f@suse.de>
 <8458a6f8-0f51-d099-37cd-7cdfc85bbd8f@redhat.com>
Message-ID: <d1152ce5-90a8-0ca4-74ff-1cf96c1213ec@redhat.com>
Date:   Thu, 22 Jul 2021 06:49:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8458a6f8-0f51-d099-37cd-7cdfc85bbd8f@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/21 8:04 PM, Javier Martinez Canillas wrote:
> Hello Thomas,
> 
> On 7/21/21 8:01 PM, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 21.07.21 um 14:44 schrieb kernel test robot:
>>> tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
>>> head:   8633ef82f101c040427b57d4df7b706261420b94
>>> commit: d391c58271072d0b0fad93c82018d495b2633448 [1/2] drivers/firmware: move x86 Generic System Framebuffers support
>>> config: parisc-randconfig-r025-20210720 (attached as .config)
>>> compiler: hppa64-linux-gcc (GCC) 10.3.0
>>> reproduce (this is a W=1 build):
>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          git remote add drm-drm-misc git://anongit.freedesktop.org/drm/drm-misc
>>>          git fetch --no-tags drm-drm-misc drm-misc-next
>>>          git checkout d391c58271072d0b0fad93c82018d495b2633448
>>>          # save the attached .config to linux build tree
>>>          mkdir build_dir
>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>     hppa64-linux-ld: drivers/firmware/sysfb.o: in function `sysfb_init':
>>>>> (.init.text+0x8): undefined reference to `screen_info'
>>>>> hppa64-linux-ld: (.init.text+0xc): undefined reference to `screen_info'
>>
>> This could be related to the recent rework of the system-framebuffer 
>> code. I think the config has to be updated to select SYSFB and 
>> SYSFB_SIMPLEFB. [1]
>>
> 
> Yes, it is. I've already answered to another similar report:
> 
> https://lkml.org/lkml/2021/7/21/575
> 
> I will propose a fix soon.
>

Posted https://lore.kernel.org/patchwork/patch/1465623/ that should solve
this issue and others reported by the kernel test robot.

I've tested that with this patch, the option it's correctly enabled for
x86, arm64 and riscv while not enabled on the problematic architectures.

This should be merged in drm-misc-next as well. Sorry for missing before
that would cause issues on some architectures.

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat

