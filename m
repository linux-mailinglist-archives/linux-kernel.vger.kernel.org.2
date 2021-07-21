Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166903D1196
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 16:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbhGUOEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36369 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232977AbhGUOEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626878716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bi83+pMn2EM7Jf6IheSLOvkh5RLIZq18EkMqBfUIdaU=;
        b=JpYlaR7X2bgZKOQgggSdgc9+6hAcO5D1eAIjtWE0g9iaQIXm4grkZw2JT9U2fvV7PCLog6
        6awED2F5sxlBAtEeI136HdEtZklwfCftwEIlbjr111f8TJH6qkkUuKOBc//jVyasMSrmvm
        /6IjS0Hh9Ys0HXfO4VnB/+ULf5hjsek=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-h2lVYRghPwKhcr7RrrYdbA-1; Wed, 21 Jul 2021 10:45:15 -0400
X-MC-Unique: h2lVYRghPwKhcr7RrrYdbA-1
Received: by mail-wm1-f70.google.com with SMTP id o21-20020a05600c4fd5b029023448cbd285so658168wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 07:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bi83+pMn2EM7Jf6IheSLOvkh5RLIZq18EkMqBfUIdaU=;
        b=UgwovBi/5RP77yMdD2WjU4E6l+ahUf0URWL/tdM1dvjD4M13QQ7uBDYN2/+S209FLu
         56YOMI28gnpwC78PvBxyppbcRvTaXbVNpN6W98tUOY6vkuy/zH3Dcj1naNU2bXA9JBSX
         vd/DbgI6J8SFfN24ySn3nWfWdM6FLzmASST0XuAhr2JuJq/1wQBDt9A3N+owQAXu7piV
         LqRu8cGe9Y13iZ1i2qLnxtYm6MqpQUKDzaDsgooRYNqfIGXWdQwr/qUT6zRZ9mMtvVC+
         uXGOx0T+a6XwDL9E3xSg1glqGoNITT7NxWJnIifQS4ImxNHlUk9MyH9L+woh+HEsv6E7
         0WWA==
X-Gm-Message-State: AOAM532C2GXFJqCXh1xfdOtd/B4Ih4i6b5A/OEO3mCweR4ERl15msy3Q
        uVTfEAXcrFQt5LIhcOYKsOP1DfQsWeflpaqRVBhgADhBhYpNarWJPugUMv9P+RTRu2n1xVoXV/F
        iv+rIeJyEW3W+/E3I8ZYPePUF
X-Received: by 2002:a05:600c:198a:: with SMTP id t10mr4451570wmq.32.1626878713896;
        Wed, 21 Jul 2021 07:45:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoyKCFUi8BeAwkjDrhalMlOXUsLIw0gn1PWPDKRsjXVihZLlq6jUd/AXZ3Sphn18EM6Hu7Bw==
X-Received: by 2002:a05:600c:198a:: with SMTP id t10mr4451551wmq.32.1626878713642;
        Wed, 21 Jul 2021 07:45:13 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id m32sm122922wms.23.2021.07.21.07.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 07:45:13 -0700 (PDT)
Subject: Re: [drm-drm-misc:drm-misc-next 1/2] hppa-linux-ld: undefined
 reference to `screen_info'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <202107212128.dNkuzyKl-lkp@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <aa045f6a-5f99-48e6-b073-c55500411893@redhat.com>
Date:   Wed, 21 Jul 2021 16:45:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202107212128.dNkuzyKl-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the report.

On 7/21/21 3:13 PM, kernel test robot wrote:
> tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
> head:   8633ef82f101c040427b57d4df7b706261420b94
> commit: d391c58271072d0b0fad93c82018d495b2633448 [1/2] drivers/firmware: move x86 Generic System Framebuffers support
> config: parisc-randconfig-r021-20210720 (attached as .config)
> compiler: hppa-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git remote add drm-drm-misc git://anongit.freedesktop.org/drm/drm-misc
>         git fetch --no-tags drm-drm-misc drm-misc-next
>         git checkout d391c58271072d0b0fad93c82018d495b2633448
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    hppa-linux-ld: drivers/firmware/sysfb.o: in function `sysfb_init':
>    (.init.text+0x24): undefined reference to `screen_info'
>>> hppa-linux-ld: (.init.text+0x28): undefined reference to `screen_info'
>

Apparently not all architectures define a screen_info, this was reported for
parisc but it's also true for other arches: arc, m68k, microblaze, openrisc
and s390.

The Kconfig symbol is built when COMPILE_TEST is enabled, but that shouldn't
be done for this reason and instead only built for the arches that need it:

config SYSFB
        bool
        default y
        depends on X86 || ARM || ARM64 || RISCV || COMPILE_TEST

I'll post a patch later. 

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

