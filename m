Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFD93D15DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbhGURXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39648 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235047AbhGURXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626890660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZqMoH0NfRKP6LtHMVfDps44O1mHFK/T4CYKvyVvbWLE=;
        b=EnhorfWV4O221cJnLkA3YeeMy1HE9Po9yVSlWr4KNeuSw8xSphi9bmJuXZ6qFx+rOezbxd
        Yi9eicb86WtVQGinFTwaZROpjfDsJ/m6UxdcFCTVMQYlIw8+dq3BBwdkAhefa/DUO7Xufq
        q93EADDH2AweYktHZwxKEZzQgNUvkxo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-wHId96QxNB6sLTea2mwUMA-1; Wed, 21 Jul 2021 14:04:19 -0400
X-MC-Unique: wHId96QxNB6sLTea2mwUMA-1
Received: by mail-wm1-f72.google.com with SMTP id j11-20020a05600c410bb02902278758ab90so823wmi.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 11:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZqMoH0NfRKP6LtHMVfDps44O1mHFK/T4CYKvyVvbWLE=;
        b=rfmMaAhPXjXwXTn3Z5fAsK2wzsJ1YNScsJeqgssb93CFwvVAoYkDvcOOH4Pyvmi4QN
         06JShO4CjL9CCIA53FYPsrAeUzGYvgD+XLspTG65uYEs0rIkvs0KXQfxWy0XKEymJ3Be
         xMwJ2S2i89TQZg9O+xheLZJmsY9t6FQNkEfl8fs+cOnwCxDcn8y222ZlZmTqDNfmTH6+
         SrMVk+5UO10v74nmX8Z64sYB0iqwadGs7Yb5Zz+mZvUoLtrtysw0tWjgf3CLKiI2zUib
         +crP6MN0rEs+HP65+7L2LCQUm0X3LbzsynYKuH7I6wf8gcj6CmODMe6mXRqwuP3VVob+
         jm9A==
X-Gm-Message-State: AOAM533+N0pt5KJiTmMJi1HfmbEQmBfGTFNsuVZLhKCRKPAkqh1SG78X
        j8eVsYspkVWyMssJ/NYJDW/Bt9ZjzBVDy+3vr7C42K6eARpguX7d4BTn2SI92d15ieUBD+R+EdX
        ChgRkhmEXJYO+rdvgT0tFDergRwUIMTD8Yf4xIWj9OMcHSgfM/E179FSds5uDP2TLUsWwnof6/i
        Y=
X-Received: by 2002:a05:600c:2dd0:: with SMTP id e16mr39305073wmh.85.1626890657478;
        Wed, 21 Jul 2021 11:04:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxmq4lWpNSkSi2Tsr8EMFmrJ9sUy8w3N88dVgXV8AyLLpJWZtjjrCKO6FtmU4pymaxlvhNnA==
X-Received: by 2002:a05:600c:2dd0:: with SMTP id e16mr39305039wmh.85.1626890657221;
        Wed, 21 Jul 2021 11:04:17 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id v2sm28003315wro.48.2021.07.21.11.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 11:04:16 -0700 (PDT)
Subject: Re: [drm-drm-misc:drm-misc-next 1/2] undefined reference to
 `screen_info'
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202107212028.p9mTHgcu-lkp@intel.com>
 <daa6e212-9e66-e551-948f-0a3c59cafd9f@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <8458a6f8-0f51-d099-37cd-7cdfc85bbd8f@redhat.com>
Date:   Wed, 21 Jul 2021 20:04:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <daa6e212-9e66-e551-948f-0a3c59cafd9f@suse.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 7/21/21 8:01 PM, Thomas Zimmermann wrote:
> Hi
> 
> Am 21.07.21 um 14:44 schrieb kernel test robot:
>> tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
>> head:   8633ef82f101c040427b57d4df7b706261420b94
>> commit: d391c58271072d0b0fad93c82018d495b2633448 [1/2] drivers/firmware: move x86 Generic System Framebuffers support
>> config: parisc-randconfig-r025-20210720 (attached as .config)
>> compiler: hppa64-linux-gcc (GCC) 10.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          git remote add drm-drm-misc git://anongit.freedesktop.org/drm/drm-misc
>>          git fetch --no-tags drm-drm-misc drm-misc-next
>>          git checkout d391c58271072d0b0fad93c82018d495b2633448
>>          # save the attached .config to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     hppa64-linux-ld: drivers/firmware/sysfb.o: in function `sysfb_init':
>>>> (.init.text+0x8): undefined reference to `screen_info'
>>>> hppa64-linux-ld: (.init.text+0xc): undefined reference to `screen_info'
> 
> This could be related to the recent rework of the system-framebuffer 
> code. I think the config has to be updated to select SYSFB and 
> SYSFB_SIMPLEFB. [1]
> 

Yes, it is. I've already answered to another similar report:

https://lkml.org/lkml/2021/7/21/575

I will propose a fix soon.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

