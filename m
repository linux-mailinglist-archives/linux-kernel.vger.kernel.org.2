Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6E432811E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbhCAOlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbhCAOlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:41:22 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A2AC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:40:41 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hs11so28646588ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVVBUJ75xHBEk5qyQn3Xf4S3QyZMI9CdpTctwGu75EM=;
        b=j9ASSF6odpol7YQ+cwgBHF4thZQTO17O6g4YkepShvXcYU+YwwCGbE97nEk0Wya1zD
         hxnTIT03M2iUIzRNcjm6FdHYOhwU0M8PO+YY9oUBDltEZNGWoGM/jUAQUnhFZ5eLO5VF
         gMgYl+Qmqbo6gxE0kS1Rjozao27JrR5nCStWUyIfZz60+cL7r4T4oBE3ZKnNPYdXaiAE
         VqhUPuKtbewug89zDLb4feHmgFGnfUWx2EGyYogJeZ/ojIXbl4wPkcf5Kpn1r7CTNM0v
         qI3lUaoLrdBTFkU4zU7VNofXwhl3VqZhivDmAR5K0Pb5iQWbMJlUJd3hy4oRplfoRpn6
         YTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVVBUJ75xHBEk5qyQn3Xf4S3QyZMI9CdpTctwGu75EM=;
        b=g4oSF3mSqG/mBC09VPr2IyiKbrioHFtx5wn3IQpGKkGn0mkGz0v/ufUE3L2+oYhguu
         vLUE9t1Q+RX63EsvY1+y/0mvFvDdOnHIZoOtGBErbGR5GDo/4RQYSkv5zyYXwebZHHeM
         5WzIgxDDjQNuru842eDmdQeIjN65Niy9dV+cDgrLz574ICacLgkA3McHxZH531SbcZC8
         EQTducSVNxeVvoB+au3wsVxD+yzJaarFdujO+EExr0O/uhAA1zLCS+6cjYkw8+Q3x87s
         67bItYvPockqsILxuQw/D592UaLveqE07R9444539ILLrwscZxTOApGaJcPdWm3rw7Zl
         YbLw==
X-Gm-Message-State: AOAM530Uu1mbzqWqLh+S4LxHDbapPetmuI1LDh4nlm8GLKAEo8hLXQ00
        IJE7vyL8AvnAsBpqCTOObnw+pgLFhFg2UQ4gr+cA3z7/wRf2
X-Google-Smtp-Source: ABdhPJzg507CF+cb05KnYkYY9ytVN+T13YzJcNieXsLvtKP8j4OTzaetWoeVWgVjKqarwzmRTir/LlIJP6mW7/9Nxi8=
X-Received: by 2002:a17:906:3b84:: with SMTP id u4mr16070980ejf.431.1614609640223;
 Mon, 01 Mar 2021 06:40:40 -0800 (PST)
MIME-Version: 1.0
References: <202102100211.hNoYGjub-lkp@intel.com> <CAHC9VhRidm6WXr9T+dGG_hZjeS+cKaVkMic_cNJMG-CRqyoSVA@mail.gmail.com>
 <20210301060822.GA21746@shbuild999.sh.intel.com>
In-Reply-To: <20210301060822.GA21746@shbuild999.sh.intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Mar 2021 09:40:29 -0500
Message-ID: <CAHC9VhT9Mzocw3w6JfHbvqm4=7wWodbrdAA4BoOU2VqGHavZBQ@mail.gmail.com>
Subject: Re: [linux-next:master 5983/6048] h8300-linux-ld: section .data VMA
 overlaps section __kcrctab VMA
To:     Feng Tang <feng.tang@intel.com>
Cc:     lkp <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 1:08 AM Feng Tang <feng.tang@intel.com> wrote:
>
> Hi Paul,
>
> On Wed, Feb 10, 2021 at 02:21:41AM +0800, Paul Moore wrote:
> > On Tue, Feb 9, 2021 at 1:09 PM kernel test robot <lkp@intel.com> wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > > head:   59fa6a163ffabc1bf25c5e0e33899e268a96d3cc
> > > commit: 77d8143a5290b38e3331f61f55c0b682699884bc [5983/6048] Merge remote-tracking branch 'selinux/next'
> > > config: h8300-randconfig-r005-20210209 (attached as .config)
> > > compiler: h8300-linux-gcc (GCC) 9.3.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=77d8143a5290b38e3331f61f55c0b682699884bc
> > >         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > >         git fetch --no-tags linux-next master
> > >         git checkout 77d8143a5290b38e3331f61f55c0b682699884bc
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=h8300
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    h8300-linux-ld: section .init.text LMA [0000000000430360,00000000004479a1] overlaps section .data LMA [000000000041868c,00000000004489eb]
> > > >> h8300-linux-ld: section .data VMA [0000000000400000,000000000043035f] overlaps section __kcrctab VMA [00000000003fdd74,000000000040007b]
> > > >> h8300-linux-ld: section __kcrctab_gpl VMA [000000000040007c,00000000004025a7] overlaps section .data VMA [0000000000400000,000000000043035f]
> > >    h8300-linux-ld: arch/h8300/kernel/entry.o: in function `resume_kernel':
> > >    (.text+0x29a): undefined reference to `TI_PRE_COUNT'
> >
> > This really doesn't look like something caused by SELinux ...
>
> No, this is not related with SELinux, sorry for the false alarm.

Thanks for confirming this and providing an explanation of the root cause.

-- 
paul moore
www.paul-moore.com
