Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2B93D562E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhGZI3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhGZI3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:29:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7504BC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:09:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r2so10215873wrl.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+AcqB0958jGsOXDZx27sAA/ukJDZf/SFq9TF4TS8BCY=;
        b=gIijk6aM6Lo892hY96ec26mDicS8lhx5VHfxgRrfyWeYUWJT9xFRIelVV/wKcqLz0Y
         d47OPIgpLa4fAxiPTcAzM7HuwlP3QHMTe5nAxRG7q0j4RZWJ/Vly3XVE0TuiIeqiJ+Gu
         RGivqn7HRZ3GldWK6UslOtZ8g45kTMEWypEgA++OgGHUDhLtSRcuWJci4/RlQu70WErH
         4Ukfl69A0Sz22KGCKlV5VP/r0nLVPEfaB3YasPwcr23VLr17jKXVDzUtXO5e4Csgyoc9
         4qF4OOXL85KHipNah8oyPc81jwSy7DZY8QXlXAbJ3qlKPPjOfEq4de5TcwluiG+gssFb
         nPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+AcqB0958jGsOXDZx27sAA/ukJDZf/SFq9TF4TS8BCY=;
        b=MDZGfkUZlig6yGltQTPFWJ/6aSkiEnDKri8W1ri4iCjGQhDZyJAmSrONS3ZEumQfbN
         hoNJYBNm65eqG8DbNDRYh+apihiQ+Vans5ivr31TlFyOFOn+sKLyyxdDH8Blj+vs5Y+K
         p9mrGvIiaNBOBVMia+tZ7xiUgVPfQNpVKDsqya12wGCVw66iRyC5qe7eUVsYpxb912CD
         +cQCYdHCtjNbejKOokFq7vNXATP5zJ36IwJniV3kAw+3uTYUSAqG2tYpRcOAJEoqSvPi
         58Xk7RA7zSxOV/2//ljZyVx0rsw4Y2CLgtGUn0TYToSBTU1fSGA9AcoMsWUdIAklHTvB
         odrA==
X-Gm-Message-State: AOAM532TKaKazLSQSMtC+qknPwRVbkFewprbPTkK0pwXS3wVkE1PudX5
        QgHbRVxadafMs9Rqk4RIKU4=
X-Google-Smtp-Source: ABdhPJzhGfsBJrr+AQ00H6iEbN0suiaxsu2wbNV9/DShrm6d+gRzDDUlw7/seOmyCdP81adagqTH6w==
X-Received: by 2002:a5d:640f:: with SMTP id z15mr10144708wru.325.1627290580388;
        Mon, 26 Jul 2021 02:09:40 -0700 (PDT)
Received: from michael-VirtualBox ([31.168.255.170])
        by smtp.gmail.com with ESMTPSA id s13sm6446487wmc.47.2021.07.26.02.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 02:09:39 -0700 (PDT)
Date:   Mon, 26 Jul 2021 12:09:37 +0300
From:   Michael Zaidman <michael.zaidman@gmail.com>
To:     kernel test robot <lkp@intel.com>, Jiri Kosina <jkosina@suse.cz>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/hid/hid-ft260.c:794:44: warning: format specifies type
 'short' but the argument has type 'int'
Message-ID: <20210726090937.GA46429@michael-VirtualBox>
References: <202107261104.ChOSQbNQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107261104.ChOSQbNQ-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 11:07:07AM +0800, kernel test robot wrote:
> Hi Michael,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ff1176468d368232b684f75e82563369208bc371
> commit: 6a82582d9fa438045191074856f47165334f2777 HID: ft260: add usb hid to i2c host bridge driver
> date:   4 months ago
> config: arm64-randconfig-r022-20210726 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project c63dbd850182797bc4b76124d08e1c320ab2365d)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6a82582d9fa438045191074856f47165334f2777
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 6a82582d9fa438045191074856f47165334f2777
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
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
> >> drivers/hid/hid-ft260.c:794:44: warning: format specifies type 'short' but the argument has type 'int' [-Wformat]
>            return scnprintf(buf, PAGE_SIZE, "%hi\n", le16_to_cpu(*field));
>                                              ~~~     ^~~~~~~~~~~~~~~~~~~
>                                              %i
>    include/linux/byteorder/generic.h:91:21: note: expanded from macro 'le16_to_cpu'
>    #define le16_to_cpu __le16_to_cpu
>                        ^
>    include/uapi/linux/byteorder/big_endian.h:36:26: note: expanded from macro '__le16_to_cpu'
>    #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
>                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/uapi/linux/swab.h:105:2: note: expanded from macro '__swab16'
>            (__builtin_constant_p((__u16)(x)) ?     \
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    2 warnings generated.
> 
> 
> vim +794 drivers/hid/hid-ft260.c
> 
>    784	
>    785	static int ft260_word_show(struct hid_device *hdev, int id, u8 *cfg, int len,
>    786				   u16 *field, u8 *buf)
>    787	{
>    788		int ret;
>    789	
>    790		ret = ft260_hid_feature_report_get(hdev, id, cfg, len);
>    791		if (ret != len && ret >= 0)
>    792			return -EIO;
>    793	
>  > 794		return scnprintf(buf, PAGE_SIZE, "%hi\n", le16_to_cpu(*field));
>    795	}
>    796	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

The fix was discussed and submitted on May 10 in this commit
https://patchwork.kernel.org/project/linux-input/patch/20210510163428.2415-1-michael.zaidman@gmail.com/
But I see that it was not taken into v5.13.
Jiri, could you please comment?

Thanks,
Michael

