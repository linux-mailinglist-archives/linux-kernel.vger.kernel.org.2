Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1D53D8A52
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhG1JKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:10:40 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:47555 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230520AbhG1JKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:10:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UhEfyol_1627463435;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UhEfyol_1627463435)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 28 Jul 2021 17:10:36 +0800
Subject: Re: [PATCH] virtio-console: avoid DMA from vmalloc area
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Amit Shah <amit@kernel.org>, gregkh <gregkh@linuxfoundation.org>,
        Omar Sandoval <osandov@fb.com>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20210727131217.15092-1-xianting.tian@linux.alibaba.com>
 <CAK8P3a15ykABd61Rad5iaZtGN=-+Guk0CNyCMK3XD7TgubG7hg@mail.gmail.com>
 <be29127d-8cec-c7b8-ac96-4da94198dc03@linux.alibaba.com>
 <CAK8P3a1O02Ho2dM3F+bUXf9Ze8uRKYzY5fFmRGpszUXg_nrH4w@mail.gmail.com>
 <0d03a42b-b46c-408f-17a4-b6c094c0c29e@linux.alibaba.com>
 <CAK8P3a2Hde16rbUPAwvtY7t+uE7C4jM8_pQCqTLj=-d4=T2MSg@mail.gmail.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <d3760b84-82b6-d8e1-0fed-dc494d226f3f@linux.alibaba.com>
Date:   Wed, 28 Jul 2021 17:10:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2Hde16rbUPAwvtY7t+uE7C4jM8_pQCqTLj=-d4=T2MSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/28 下午5:01, Arnd Bergmann 写道:
> On Wed, Jul 28, 2021 at 10:28 AM Xianting Tian
> <xianting.tian@linux.alibaba.com> wrote:
>> 在 2021/7/28 下午3:25, Arnd Bergmann 写道:
>>
>> I checked several hvc backends, like drivers/tty/hvc/hvc_riscv_sbi.c,
>> drivers/tty/hvc/hvc_iucv.c, drivers/tty/hvc/hvc_rtas.c, they don't use dma.
>>
>> I not finished all hvc backends check yet. But I think even if all hvc
>> backends don't use dma currently, it is still possible that the hvc
>> backend using dma will be added in the furture.
>>
>> So I agree with you it should better be fixed in the hvc framework,
>> solve the issue in the first place.
> Ok, sounds good to me, no need to check more backends then.
> I see the hvc-console driver is listed as 'Odd Fixes' in the maintainer
> list, with nobody assigned other than the ppc kernel list (added to Cc).
>
> Once you come up with a fix in hvc_console.c, please send that to the
> tty maintainers, the ppc list and me, and I'll review it.
OK, thanks, I will submit the patch ASAP :)
>
>          Arnd
