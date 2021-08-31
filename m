Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA773FCABD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbhHaPZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 11:25:07 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53726 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbhHaPZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 11:25:06 -0400
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17VFO9XU065984;
        Wed, 1 Sep 2021 00:24:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Wed, 01 Sep 2021 00:24:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17VFO3bt065891
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 1 Sep 2021 00:24:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] fbmem: don't allow too huge resolutions
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        syzbot <syzbot+04168c8063cfdde1db5e@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin King <colin.king@canonical.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Randy Dunlap <rdunlap@infradead.org>
References: <000000000000815b9605c70e74f8@google.com>
 <131b24e5-ee31-6f7b-42b4-c34583711913@infradead.org>
 <2fccb5d3-191c-924e-159f-1c9d423e282f@i-love.sakura.ne.jp>
 <339bfb21-8e80-c7d9-46dd-c416f87c50c0@infradead.org>
 <535e404d-03bf-8e7a-b296-132a2a98c599@i-love.sakura.ne.jp>
 <CAMuHMdWX7s63X_zR9329canbQkPGBVxZNG4O+_=jUut60aGR9g@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5c6d2b95-31d7-0d59-5e62-2593d9a0e1fe@i-love.sakura.ne.jp>
Date:   Wed, 1 Sep 2021 00:23:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWX7s63X_zR9329canbQkPGBVxZNG4O+_=jUut60aGR9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/08/31 15:48, Geert Uytterhoeven wrote:
> Furthermore, this restricts the virtual frame buffer size on 64-bit,
> too, while graphics cards can have much more than 4 GiB of RAM.

Excuse me, but do you mean that some hardware allows allocating more than
UINT_MAX bytes of memory for kernel frame buffer drivers?

> IMHO that should be fixed in vga16fb, too.

According to https://elixir.bootlin.com/linux/v5.14/A/ident/fb_check_var , 
there are 89 files. Randomly picking up drivers/video/fbdev/udlfb.c as
an example. dlfb_is_valid_mode() from dlfb_ops_check_var() is doing

  if (mode->xres * mode->yres > dlfb->sku_pixel_limit)
    return 0;
  return 1;

where max dlfb->sku_pixel_limit seems to be 2048 * 1152 but I think we need
same overflow check. I want to avoid patching individual modules if possible.
That depends on whether some hardware needs to allocate more than UINT_MAX
bytes of memory.

