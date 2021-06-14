Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846D43A5B45
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 03:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhFNBL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 21:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbhFNBL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 21:11:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30D6C061574;
        Sun, 13 Jun 2021 18:09:41 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y15so9337602pfl.4;
        Sun, 13 Jun 2021 18:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lfTRNFalgvE8W3BaBubJpxlJYdBX6Ni/M9RnLGhDGdg=;
        b=giJUOc64A/HReLaviyDuLGgkjEioiHD2twGRkxCH2mil9TuqvPeHO8TPDcMQ3LUbT7
         xJA7Jozne4xmbp/w3x68hJ/5VyG/u/3TfbBTeRqEuU335lR7KTMDYoRDIDGaIm/28JMO
         fzI6R38pdIBZo6Xv3uU13gxuzQvLcEMMlfekdSOe2HOk6wSR3ZzG55RYaVaKCD/3xRWT
         WNiFFUleWT83HkijsPXrc6vgjgkz+XOzeQRY6wEYN6bMKtBR51hLBcTHZwWVsrZdBSKU
         1tVH1T4KDxLoyBk1RFZ/6ZHd7OVBi1vN6jI96lGEGNU5bhzlKiy2958fW2BSQQun3pug
         fbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lfTRNFalgvE8W3BaBubJpxlJYdBX6Ni/M9RnLGhDGdg=;
        b=qMjS+567kRE8ath1u7eGUexIjbIJeNUvdj3Snq+g15E0YxQ0RP5d6fUX8/A4PZAutd
         qITZ0tqWE3pVJRAFDnsZ41sLMlrR7yAS6zWORc2w2L9xeKjqdBUe6aLH5S08o1q6t7va
         HAZxedVroTPZC7LB4s9u/fDpxyWY3CwudN5oqyvcE94UqcKVzwKoGWfA60sGmZqmturC
         /KOCuQR9TIdNQ6El5RfvabxuSed061/XlZ0u7Bn+c0HkW59KmVOyHK1/zHzSL/rmId1N
         ot+Gvk/kNgc1gV9T5QDwLrboc1DpFLbbzh5w0KsxHAcsK3D174in0dHcJ+biTFH9Zqds
         zyPg==
X-Gm-Message-State: AOAM531oEryIDIO4OeS58hi3FCeDwh5Ngdnr03eOqTBFlkzelp5jNHlJ
        HQ0+nEe/va12zqskVsir+64=
X-Google-Smtp-Source: ABdhPJyXxemMmvRcWWFjy/8zrZR5cT5hqRdDgziWJi6fwTFTllyV7zTq3nilU3KOGZZEE747GyXaig==
X-Received: by 2002:a63:5f46:: with SMTP id t67mr14925506pgb.37.1623632980544;
        Sun, 13 Jun 2021 18:09:40 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id t1sm10303269pjs.20.2021.06.13.18.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 18:09:39 -0700 (PDT)
Date:   Mon, 14 Jun 2021 09:09:29 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        kbuild-all@lists.01.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH v3 1/3] 9p: add support for root file systems
Message-ID: <20210614010929.mwvmpdy3dv7k2xnh@mail.google.com>
References: <20210606230922.77268-2-changbin.du@gmail.com>
 <202106070913.SLIBAxBQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106070913.SLIBAxBQ-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 09:06:54AM +0800, kernel test robot wrote:
> Hi Changbin,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on lwn/docs-next]
> [also build test WARNING on linus/master v5.13-rc5 next-20210604]
> [cannot apply to v9fs/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Changbin-Du/9p-add-support-for-root-file-systems/20210607-071229
> base:   git://git.lwn.net/linux-2.6 docs-next
> config: arm-allyesconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/96098f751038703cc0fda4f018236d240a86930d
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Changbin-Du/9p-add-support-for-root-file-systems/20210607-071229
>         git checkout 96098f751038703cc0fda4f018236d240a86930d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> fs/9p/v9fsroot.c:53:12: warning: no previous prototype for 'v9fs_root_data' [-Wmissing-prototypes]
>       53 | int __init v9fs_root_data(char **dev, char **opts)
>          |            ^~~~~~~~~~~~~~
>
This just follows the existing rootfs support manner. This function doesn't have
a dedicated header file to place. So I think we can ignore this warning.

> 
> vim +/v9fs_root_data +53 fs/9p/v9fsroot.c
> 
>     52	
>   > 53	int __init v9fs_root_data(char **dev, char **opts)
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Cheers,
Changbin Du
