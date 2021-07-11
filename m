Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D173C4024
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 01:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhGKXtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 19:49:14 -0400
Received: from smtprelay0067.hostedemail.com ([216.40.44.67]:37796 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230014AbhGKXtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 19:49:13 -0400
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2031B2289C;
        Sun, 11 Jul 2021 23:46:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id D810E20D75C;
        Sun, 11 Jul 2021 23:46:23 +0000 (UTC)
Message-ID: <111b2612313dc85eb6cffb5ec93423e92aadef15.camel@perches.com>
Subject: Re: drm/amd/display: Simplify hdcp validate_bksv
From:   Joe Perches <joe@perches.com>
To:     kernel test robot <lkp@intel.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc:     kbuild-all@lists.01.org, Kees Cook <keescook@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 11 Jul 2021 16:46:22 -0700
In-Reply-To: <202107120638.fhBzNbDi-lkp@intel.com>
References: <d3a180c3dc8db68a25440edf466cfeddcaae5a64.camel@perches.com>
         <202107120638.fhBzNbDi-lkp@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: D810E20D75C
X-Spam-Status: No, score=-0.78
X-Stat-Signature: 4w3xb16q81jdos9h7m1m6o7oixokhp8p
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19RtmqfZkbsFeCZmvi7tQ9HuVjqDlNgdx4=
X-HE-Tag: 1626047183-174502
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-07-12 at 07:02 +0800, kernel test robot wrote:
> Hi Joe,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on drm-intel/for-linux-next]
> [also build test ERROR on drm-exynos/exynos-drm-next linus/master next-20210709]
> [cannot apply to kees/for-next/pstore tegra-drm/drm/tegra/for-next drm/drm-next v5.13]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Joe-Perches/drm-amd-display-Simplify-hdcp-validate_bksv/20210712-034708
> base:   git://anongit.freedesktop.org/drm-intel for-linux-next
> config: i386-randconfig-a003-20210712 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/66fae2c1becdcb71c95f2c6a6413de4dfe1deb51
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Joe-Perches/drm-amd-display-Simplify-hdcp-validate_bksv/20210712-034708
>         git checkout 66fae2c1becdcb71c95f2c6a6413de4dfe1deb51
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> > > ERROR: modpost: "__popcountdi2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

curious.

Anyone know why?


