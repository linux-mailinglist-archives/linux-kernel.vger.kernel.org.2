Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89958375343
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 13:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhEFL4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 07:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhEFL4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 07:56:48 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A25C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 04:55:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z6so5308683wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 04:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gDqY6Wm/vZlz9V2q3RUMuSorzrRpkJy7OXAMktCuQ74=;
        b=DZUsC5k2YKg2G+As0+ed2vnc4JhTjGccbDuzCfcfuqhwYSets+ThU/JGUoGnn73nRw
         9iRWCElTYuDBsyLq7W/KZ0v+fLBm3yObHiIf67G05kuYo2SG6peQiKgnIdN1WX5g0RTX
         3zwUFx5j2h3H6lAVqda7NmREnlYmFL5n1hTcVu5V5fYK4v38MkXJtgPUCra/EuLndEgA
         amU/N3Q4N6V3Yb4OgidFxFuafgkHSmSWS+ewWZFvGT+gWlcI2Dx9KlRROSCR7EwHcjVQ
         TtFX8/xlaz7PcGDiBpIVyB5FJhsjFkoYp0wv5yyajUAutGfO+Qyw8/dNo8leoSTNMVFL
         pN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gDqY6Wm/vZlz9V2q3RUMuSorzrRpkJy7OXAMktCuQ74=;
        b=GSUF3/M1pV3SWpSOPMy5nmiJ4TbLWOLHT2YoJUQX8OflpWMVtk4GEJAjwYOV52/h8O
         DFSnKWCnryNUo5XAmDfCm4GMJsaB0NExPL3rGV2Fm7MMiR6hudV9UdOp1V6fq5RyPSh8
         V+rSLj476S+bAU0aOtaaBflZU/4eiGIpX8jz3ZX4kfLQMI1zqMDJTOs1jkPCoav4bCBx
         SGou4gY5kj8mN7Qam4VTwmiML4pqs/atwfrEQPwobBmXkknYEAYZO+OcoNBC/e+Qpxgo
         gQEl39VmutfdlQDJqbDd2/90NRP7PzUkPZIRS1GZPK8YIxMNYxOnCeJxASHGyP8jxUzH
         nrjA==
X-Gm-Message-State: AOAM531EQMZAMvPy2d++UV4KIf54gypyx8JURkFWIPYU2McGMgash7Fx
        YMjKd6XoOdjF/sTDpammXyM=
X-Google-Smtp-Source: ABdhPJwVCAKsjzewcpmn6JVFJPzi6LaWLRouM5HEPtHw4z/A4YC2XF/zv9s+iMuRVGNPmx3R8xgdxw==
X-Received: by 2002:adf:f50f:: with SMTP id q15mr4455250wro.279.1620302149427;
        Thu, 06 May 2021 04:55:49 -0700 (PDT)
Received: from michael-VirtualBox (cbl217-132-244-50.bb.netvision.net.il. [217.132.244.50])
        by smtp.gmail.com with ESMTPSA id l18sm4023264wrt.97.2021.05.06.04.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 04:55:48 -0700 (PDT)
Date:   Thu, 6 May 2021 14:55:46 +0300
From:   Michael Zaidman <michael.zaidman@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        Jiri Kosina <jikos@kernel.org>,
        Michael Zaidman <michael.zaidman@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: drivers/hid/hid-ft260.c:794:44: warning: format specifies type
 'short' but the argument has type 'int'
Message-ID: <20210506115546.GA1745@michael-VirtualBox>
References: <202105060637.LeEC6ztp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105060637.LeEC6ztp-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 06:47:46AM +0800, kernel test robot wrote:
> 
>    drivers/hid/hid-ft260.c:515:59: warning: variable 'len' is uninitialized when used here [-Wuninitialized]
>                    hid_err(hdev, "%s: unsupported wr len: %d\n", __func__, len);
>                                                                            ^~~
>    include/linux/hid.h:1190:30: note: expanded from macro 'hid_err'
>            dev_err(&(hid)->dev, fmt, ##__VA_ARGS__)
>                                        ^~~~~~~~~~~
>    include/linux/dev_printk.h:112:32: note: expanded from macro 'dev_err'
>            _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                                          ^~~~~~~~~~~
>    drivers/hid/hid-ft260.c:507:9: note: initialize the variable 'len' to silence this warning
>            int len, ret;
>                   ^
>                    = 0

This warning has already been found and fixed by Dan Carpenter in
the "HID: ft260: fix an error message in ft260_i2c_write_read()" commit
on March 18, 2021.

