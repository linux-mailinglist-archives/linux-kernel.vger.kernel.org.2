Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E783C34DC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 16:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhGJOlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 10:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhGJOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 10:41:37 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9064C0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 07:38:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l24so18699833edr.11
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZLoQmYLa1jX8pdeGvFrIDZUoXKb5O+vukZVoByivin0=;
        b=SabWOnhl8687BOXpyM3cqd6Rb0rmeMI5vq/Ac/d1HE9WsS4sZL3GLiZcgNr8arIftQ
         KlEjOYdz7RUMMzy78Zh1B3covmuxlvC5PKKHp2l5xssnnFjU/tha+8ESiNthXS2SjiBb
         +/68tRhZXLalBMDBB6T81h0QDZzCyUbOFI8rHaRvfKzKTw7PGWLway2P774mX++t8qp+
         jJSHWMN0wMK1Z34tNVYV6aoBh907htjF9r+zM0LOf7w63j5iS7lyjtGuV+Ip259+tAVn
         9LVolHmzG7BQrsKsX/YsAxKzDehVaCfw7yFEQFh/NuZ1MQVgIT1/8U5yH685rFYusZfg
         yR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZLoQmYLa1jX8pdeGvFrIDZUoXKb5O+vukZVoByivin0=;
        b=FQF90RjF8xxH6mVbVAACLqWegrwLHhLa6G57usDGMMoKVdmV5gtBC3H3p56QFg+1RL
         iqM5FR2YiFlLjDTnovoMHRYFMW6awxdBZTKjPEUHCrt9DUIJBy+I0XI6vOChKdsNmvmJ
         ZXEWRTkaKFQe+OWoXhvLA3EKG55eYmfLmL5A9g/GXvEc0QeTDMmiEe4lC11xhcETVIQb
         Pd8J4W1k6arK4ZY452VMTAAR+CShTS2aJfJX63LZTDZfz8EDxcnCfCidG+vDeu5kdh+J
         RbmFKuWWC5PshuxpHUGP+FOcxLy1WdT/5e1HbbuXYbqogv55OHTAlrhFNQsYs1M3dCcw
         2BWg==
X-Gm-Message-State: AOAM530s9ncPBGbDqC//yCAHBPQXLVHxPXo6fgRNUB5IHPwCiWzUt4MW
        E/c8EVIG+EAiOu1BzU3ksCkmbA+vsRg=
X-Google-Smtp-Source: ABdhPJzNrmDpFePtHAb8Ut8Ciz2NTnJggSxrqI4C0Qnqs2RMadFKLr9pvePS5S3fKokf2TaF0hQ1GA==
X-Received: by 2002:aa7:dbc3:: with SMTP id v3mr54670139edt.63.1625927930041;
        Sat, 10 Jul 2021 07:38:50 -0700 (PDT)
Received: from linux.local (host-79-27-97-200.retail.telecomitalia.it. [79.27.97.200])
        by smtp.gmail.com with ESMTPSA id i6sm3849701ejr.68.2021.07.10.07.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 07:38:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, fabioaiuto83@gmail.com
Subject: Re: [PATCH] staging: rtl8188eu: Replace a custom function with crc32_le()
Date:   Sat, 10 Jul 2021 16:38:47 +0200
Message-ID: <1790135.9ZQ2ZFNHWj@linux.local>
In-Reply-To: <202107100829.RxcC1tei-lkp@intel.com>
References: <20210701133809.26534-1-fmdefrancesco@gmail.com> <202107100829.RxcC1tei-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, July 10, 2021 2:25:12 AM CEST kernel test robot wrote:
> Hi "Fabio,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on staging/staging-testing]
> 
> url:   
> https://github.com/0day-ci/linux/commits/Fabio-M-De-Francesco/staging-rtl8188eu-Replace
> -a-custom-function-with-crc32_le/20210701-213922 base:  
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> 77ad1f0e99bd00af024e650b862cfda3137af660 config: powerpc64-randconfig-
s032-20210709

[CUT]

> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> drivers/staging/rtl8188eu/core/rtw_security.c:597:58: sparse: sparse: 
incorrect type
> >> in assignment (different base types) @@     expected restricted __le32 
[usertype] @@
> >>     got unsigned int @@
>    drivers/staging/rtl8188eu/core/rtw_security.c:597:58: sparse:     
expected restricted
> __le32 [usertype] drivers/staging/rtl8188eu/core/rtw_security.c:597:58: 
sparse:     got
> unsigned int drivers/staging/rtl8188eu/core/rtw_security.c:604:58: sparse: 
sparse:
> incorrect type in assignment (different base types) @@     expected 
restricted __le32
> [usertype] @@     got unsigned int @@
> drivers/staging/rtl8188eu/core/rtw_security.c:604:58: sparse:     expected 
restricted
> __le32 [usertype] drivers/staging/rtl8188eu/core/rtw_security.c:604:58: 
sparse:     got
> unsigned int drivers/staging/rtl8188eu/core/rtw_security.c:671:42: sparse: 
sparse:
> incorrect type in assignment (different base types) @@     expected 
restricted __le32
> [usertype] @@     got unsigned int @@
> drivers/staging/rtl8188eu/core/rtw_security.c:671:42: sparse:     expected 
restricted
> __le32 [usertype] drivers/staging/rtl8188eu/core/rtw_security.c:671:42: 
sparse:     got
> unsigned int

[CUT]

I suppose that these warnings are false positives for the reasons explained in 
my patch.

Furthermore, I found a commit by Fabio Aiuto <fabioaiuto83@gmail.com> that, as 
far as I understand, do the same changes and that has been accepted by Greg K-
H and merged in his tree: b97fad10de387c09ae46f607955c7237afa96654. So, I 
think there one reason more to suspect of false positives.

I'd appreciate comments on this topic.

Thanks,

Fabio



