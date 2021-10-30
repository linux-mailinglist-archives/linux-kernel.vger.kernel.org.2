Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A28A4408EB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 15:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhJ3NGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 09:06:34 -0400
Received: from foss.arm.com ([217.140.110.172]:45132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhJ3NGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 09:06:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B73B21FB;
        Sat, 30 Oct 2021 06:04:02 -0700 (PDT)
Received: from bogus (unknown [10.57.46.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7757C3F5A1;
        Sat, 30 Oct 2021 06:04:01 -0700 (PDT)
Date:   Sat, 30 Oct 2021 14:03:58 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [sudeep-holla:v5.15/pcc_type3 15/16]
 drivers/acpi/pcc_opregion.c:30:2: error: implicit declaration of function
 'acpi_ut_status_exit'
Message-ID: <20211030130358.yvbw5lr5rfw5ysnh@bogus>
References: <202110300935.QtWwtS7u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110300935.QtWwtS7u-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Sat, Oct 30, 2021 at 09:53:44AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git v5.15/pcc_type3
> head:   e658e18863fdb31547d280d6446d97b986a66a6a
> commit: 53fb88f932935375cd221ddbac3d9b7751718005 [15/16] ACPI: Add support for PCC opregion
> config: i386-randconfig-c001-20211029 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5db7568a6a1fcb408eb8988abdaff2a225a8eb72)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/commit/?id=53fb88f932935375cd221ddbac3d9b7751718005
>         git remote add sudeep-holla https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
>         git fetch --no-tags sudeep-holla v5.15/pcc_type3
>         git checkout 53fb88f932935375cd221ddbac3d9b7751718005
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
>

Please ignore this, a hack got pushed to the git repo by mistake.

-- 
Regards,
Sudeep
