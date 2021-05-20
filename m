Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D559B389E72
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 08:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhETG7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 02:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhETG7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 02:59:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CA5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 23:57:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o127so8477832wmo.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 23:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=h0fXYIN2E5J54+ZmwB3JHOzFpG3abb+viSfy+a5rRgw=;
        b=kYsHClz4ZtHy58wi/PZc8Bs4XDjVdchu3qYDz74eF+jeJ1IcvezLu7xBX3SUAex/Fr
         WRUwd9s2agikUezDuM7gyKY2QxMlrLnZTlsDcy1M4boya7xjTOK59F46hBC+jvIwWu0d
         DFOLKIjh5BIRKyLLbT3RC4x+k/ZXWrPBdTtqfwz1EhkqD0TTzux7YHxOCCWkc6zKwQHo
         gc8B8Yq5nFGgMo+tad28yqUrL4ZTghKDfSsJrZxgEALJ6dXRavaUnUTCWklWorJuFaga
         ocs1ZtX9yll7uVmZyp6noJWyThvG6AQmR8evtXzzvXuPzyxSjT6YhKwQsjXcrv0cFjY9
         /FjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=h0fXYIN2E5J54+ZmwB3JHOzFpG3abb+viSfy+a5rRgw=;
        b=Mq7UgZo1UYqy/gHWjO4m8uV6fWKthz+HZQ/hVEPZMh5e/Qdtm3xmyRRzqDfXu/WVb2
         jlXIpen9jO/BIF6iJxJC5jiI0yaSsXE0zypvzZUh9hjFa6y+84rmz6GRhHAP239VuP38
         Fy0DvH5BuGPq5dF7oidMYj/qA2GKBsE0DOe2/tF4o0Mld+bCiOZt6V9uTeNMBDz04dCG
         oGt9EL2iGqqVPGRCOkJt2re4a2rR1tPLKVxVHYm+QztpBcMyvul3CRv7b5i8jI83cXMj
         x+GpfJHZFDdDPT9in70e/VJVIVnB0obvyu+rvB21h+uj0+MSzexWShpXqUq6bcQA/pI8
         nEaw==
X-Gm-Message-State: AOAM530n0CpGsyFS3QPhpqKW3fLm11wFp0PhDffDnZ+eAENtfWJ1PaUI
        dlkk6OopTOYHsmSXQ/nIRL2/ZA==
X-Google-Smtp-Source: ABdhPJwfHhX3Uc2t1nICQjEObP1SNmCR/vpanAyfFKJX+C5RLOD3pJjV/DqCSibv78lHl+kI5oJEjA==
X-Received: by 2002:a1c:9dc3:: with SMTP id g186mr2053326wme.47.1621493860351;
        Wed, 19 May 2021 23:57:40 -0700 (PDT)
Received: from localhost ([2a01:cb19:826e:8e00:a45f:260c:febd:73ce])
        by smtp.gmail.com with ESMTPSA id w12sm1928423wrt.16.2021.05.19.23.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 23:57:39 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     kernel test robot <lkp@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kbuild-all@lists.01.org, Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Input: mtk-pmic-keys - add support for MT6358
In-Reply-To: <202105200248.VC2Rdk6B-lkp@intel.com>
References: <20210512152648.39961-4-mkorpershoek@baylibre.com>
 <202105200248.VC2Rdk6B-lkp@intel.com>
Date:   Thu, 20 May 2021 08:57:38 +0200
Message-ID: <87sg2h28pp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot <lkp@intel.com> writes:

> Hi Mattijs,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on input/next]
> [also build test ERROR on v5.13-rc2 next-20210519]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Mattijs-Korpershoek/input-MT6358-PMIC-button-support/20210513-001558
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> config: s390-randconfig-r014-20210519 (attached as .config)
> compiler: s390-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/74aae2763d0c259046aa7079a46ba0dfe1995e37
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Mattijs-Korpershoek/input-MT6358-PMIC-button-support/20210513-001558
>         git checkout 74aae2763d0c259046aa7079a46ba0dfe1995e37
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>>> drivers/input/keyboard/mtk-pmic-keys.c:80:22: error: 'MT6358_TOPSTATUS' undeclared here (not in a function); did you mean 'MT6397_OCSTATUS0'?
>       80 |   MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
>          |                      ^~~~~~~~~~~~~~~~
>    drivers/input/keyboard/mtk-pmic-keys.c:47:14: note: in definition of macro 'MTK_PMIC_KEYS_REGS'
>       47 |  .deb_reg  = _deb_reg,  \
>          |              ^~~~~~~~
>>> drivers/input/keyboard/mtk-pmic-keys.c:85:18: error: 'MT6358_TOP_RST_MISC' undeclared here (not in a function); did you mean 'MT6397_TOP_RST_MISC'?
>       85 |  .pmic_rst_reg = MT6358_TOP_RST_MISC,
>          |                  ^~~~~~~~~~~~~~~~~~~
>          |                  MT6397_TOP_RST_MISC
This build failure is expected.
As written in the cover letter, this depends on [1]

[1] has been applied to the mfd tree but it's not part of v5.13-rc2

[1] https://lore.kernel.org/r/20210506094116.638527-1-mkorpershoek@baylibre.com

>
>
> vim +80 drivers/input/keyboard/mtk-pmic-keys.c
>
>     77	
>     78	static const struct mtk_pmic_regs mt6358_regs = {
>     79		.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
>   > 80			MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
>     81			0x2, MT6358_PSC_TOP_INT_CON0, 0x5),
>     82		.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
>     83			MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
>     84			0x8, MT6358_PSC_TOP_INT_CON0, 0xa),
>   > 85		.pmic_rst_reg = MT6358_TOP_RST_MISC,
>     86	};
>     87	
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
