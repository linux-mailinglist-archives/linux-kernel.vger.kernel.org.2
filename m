Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39786305695
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbhA0JNu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Jan 2021 04:13:50 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:48506 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234958AbhA0JG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:06:59 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07828137|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00286547-0.0055064-0.991628;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.JR1zvmq_1611738375;
Received: from 30.225.212.56(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.JR1zvmq_1611738375)
          by smtp.aliyun-inc.com(10.147.43.230);
          Wed, 27 Jan 2021 17:06:15 +0800
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1] csky: use free_initmem_default() in free_initmem()
From:   Guo Ren <ren_guo@c-sky.com>
In-Reply-To: <fb51bf47-a6ab-1a5a-60cf-0ec375a9511a@redhat.com>
Date:   Wed, 27 Jan 2021 17:06:15 +0800
Cc:     Guo Ren <guoren@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-csky@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <9EBAE2A9-F06F-4198-BEF2-30A1A24F3796@c-sky.com>
References: <20210126181420.19223-1-david@redhat.com>
 <20210126182648.GR6332@kernel.org>
 <CAJF2gTRsqZ4DTvZm2V9VRKP_f6u-p5aupCjrvuGy_7m8tiQQVQ@mail.gmail.com>
 <fb51bf47-a6ab-1a5a-60cf-0ec375a9511a@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,


> 在 2021年1月27日，下午4:49，David Hildenbrand <david@redhat.com> 写道：
> 
> On 27.01.21 08:52, Guo Ren wrote:
>> Thx Mike,
> 
> Thanks for triggering a build/test! I'd be curious if there is an easy way to trigger this myself (I assume, fork csky buildroot on gitlab, reroute CSKY kernel repo, adjust CSKY_LINUX_NEXT_VERSION); if so, it would be worth documenting - thanks!
> 

1. You can just simple fork our project, and enable your gitlab share-runner.
2. Modify https://gitlab.com/c-sky/buildroot/-/blob/master/package/csky-arch/csky-arch.mk
Line 28: CSKY_ARCH_SITE = $(call github,c-sky,csky-linux,$(CSKY_ARCH_VERSION)) to your own forked our kernel repo
Line 49: CSKY_LINUX_NEXT_VERSION	= f0bbf052ae463b3802f1c7ba36b36da2f54945f2 change the version as you want

You also need to remove some unused entries in .gitlab.yml.


> Thanks Mike for the valuable links :) For now I was only relying on cross-compilers as shipped by Fedora, now I can upgrade my cross-build environment :)
> 
>> It's under test:
>> https://gitlab.com/c-sky/buildroot/-/pipelines/247353584
>> kernel:
>> https://github.com/c-sky/csky-linux/commit/9d986b01feb991ded3fb8c1f8153a0c80ea84b9c
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb



Best Regards
  Guo Ren
