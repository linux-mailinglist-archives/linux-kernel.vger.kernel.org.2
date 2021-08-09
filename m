Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178323E4461
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhHILGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbhHILGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:06:36 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A132CC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:06:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g30so778666lfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IfogMY+NLTARcLYNo9bcsRcf3RuTvaw1mxTZ9TlX2NY=;
        b=RMbhx7C4L21TWi7DkxCwZK8CpONGkapgOKJwg7qQoJCiO+KSx3hdt4TS6gD+yIXNJH
         S2aL20E3CGBOJ3nAqxwgHM02/eKG4QGXjFJHq1e/N1hpCOWBvnok+FjzGLJEJU63x23c
         nY1CYKm5dKXXgz7tEGdzshCIO8kJ3dlobYPNV3ckq5DoJ3OyXBCvRbuw/qBDpQonKSX4
         sSuVcNB6Ejc6iDGrT/4zP1Ymgxf1/n/IcySW7mOHUWVCxd2agP9W9auOBqinOALbTmBB
         K/qJNp4TlsH8we8zr7sTuZp+YLc+qyG8UClmoND7uH5lPAvqNn4cRi+0auTUzUL0UaXP
         r+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IfogMY+NLTARcLYNo9bcsRcf3RuTvaw1mxTZ9TlX2NY=;
        b=GUW4cEYzC8GtzZ97NoIql122OBMHmI2Povw+jqozU/CUDMDPlVBUDcpbgjjH4jJK/W
         KbzsZAtnjk/RE74VNbArSHz0nkOE5wwD02R4H+18r0NtiAtFx0aMbpW4ZmMPhen9fnTJ
         RphRkjJETliyhGPRNb/sqQwNmU4pfzGdebGf0L5txaHRPi/CSPPx9MERjtznUgsuHJwz
         YNGpT6Pna6eVvvcIKsrxwBRe8sgEDkQo/zHYUXevY5vmNaTxEqkUTD3jN3/1UoYqvS6h
         +qB5L+uvsuaWPqnOwizOZjdtFL5poV6jUjS/wJT7n2hokn0zHe2ZCnWaON6SpSlElmHc
         wZFg==
X-Gm-Message-State: AOAM530lgZYPArpHn4RD78hFKA0+hdoHod1yFWZwbbi79240TahEUYcj
        pZqcq3AVLF96vKfeak/XZaVAdOZiVGrLww==
X-Google-Smtp-Source: ABdhPJxy9qTvOm17kWqndTZqEyjK0gHmuDSqGfSj+QBzX7J2HRsi7d27g0Wq16hf+kKZbuCGfTX1LQ==
X-Received: by 2002:a05:6512:3905:: with SMTP id a5mr16555249lfu.406.1628507173799;
        Mon, 09 Aug 2021 04:06:13 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.232])
        by smtp.gmail.com with ESMTPSA id c9sm1418981lfb.181.2021.08.09.04.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 04:06:13 -0700 (PDT)
Subject: Re: drivers/net/usb/pegasus.c:461:2: warning: Value stored to 'ret'
 is never read [clang-analyzer-deadcode.DeadStores]
To:     kernel test robot <rong.a.chen@intel.com>,
        Petko Manolov <petkan@nucleusys.com>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202108080902.ZhmxmJZr-lkp@intel.com>
 <28df02cc-8b34-3d4e-2ed6-30af0ff44a42@intel.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <94550f41-1204-8996-ef32-c25429481ceb@gmail.com>
Date:   Mon, 9 Aug 2021 14:06:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <28df02cc-8b34-3d4e-2ed6-30af0ff44a42@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/21 1:37 PM, kernel test robot wrote:
> 
> tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   85a90500f9a1717c4e142ce92e6c1cb1a339ec78
> commit: 8a160e2e9aeb8318159b48701ad8a6e22274372d net: usb: pegasus:
> Check the return value of get_geristers() and friends;
> date:   4 days ago
> :::::: branch date: 8 hours ago
> :::::: commit date: 4 days ago
> config: x86_64-randconfig-c001-20210808 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project
> 41a6b50c25961addc04438b567ee1f4ef9e40f98)
> reproduce (this is a W=1 build):
>           wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>           chmod +x ~/bin/make.cross
>           # install x86_64 cross compiling tool for clang build
>           # apt-get install binutils-x86-64-linux-gnu
>           #
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a160e2e9aeb8318159b48701ad8a6e22274372d
>           git remote add linus
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>           git fetch --no-tags linus master
>           git checkout 8a160e2e9aeb8318159b48701ad8a6e22274372d
>           # save the attached .config to linux build tree
>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> ARCH=x86_64 clang-analyzer
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Hi, @Petko!

For you not to scan all these warnings:

>>> drivers/net/usb/pegasus.c:461:2: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
>              ret = set_registers(pegasus, EthCtrl0, 3, data);
>              ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      drivers/net/usb/pegasus.c:461:2: note: Value stored to 'ret' is
> never read
>              ret = set_registers(pegasus, EthCtrl0, 3, data);
>              ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is the real bug, I think. Can be fixed like this:

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index 22353bab76c8..f2b8891c7b36 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -459,6 +459,8 @@ static int enable_net_traffic(struct net_device 
*dev, struct usb_device *usb)

  	memcpy(pegasus->eth_regs, data, sizeof(data));
  	ret = set_registers(pegasus, EthCtrl0, 3, data);
+	if (ret < 0)
+		goto fail;

  	if (usb_dev_id[pegasus->dev_index].vendor == VENDOR_LINKSYS ||
  	    usb_dev_id[pegasus->dev_index].vendor == VENDOR_LINKSYS2 ||


It was caused by our last refactoring: enable_net_traffic() now returns 
0 on success and this ret is never checked.


With regards,
Pavel Skripkin
