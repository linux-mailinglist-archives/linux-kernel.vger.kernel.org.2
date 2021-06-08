Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2E839EBE7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 04:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhFHC10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 22:27:26 -0400
Received: from mail.loongson.cn ([114.242.206.163]:55698 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230396AbhFHC1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 22:27:25 -0400
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx70D21L5gI8QMAA--.14079S3;
        Tue, 08 Jun 2021 10:24:55 +0800 (CST)
Subject: Re: [PATCH] drm/radeon: Always call radeon_suspend_kms() in
 radeon_pci_shutdown()
To:     Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <1623068820-2479-1-git-send-email-yangtiezhu@loongson.cn>
 <0d1b517f-797f-e87d-4edd-8474b16993ed@amd.com>
 <CADnq5_PvZRu0h60dn-=4v0aXBOaNy=s0KjmeuSndDzU3C8qFog@mail.gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <31de1f2e-5030-3a01-782b-df659d0d2869@loongson.cn>
Date:   Tue, 8 Jun 2021 10:24:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_PvZRu0h60dn-=4v0aXBOaNy=s0KjmeuSndDzU3C8qFog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx70D21L5gI8QMAA--.14079S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWrAr45Xr13Ww43WF47CFg_yoW5XF4kpr
        ZxKwsrKwn3KrWYka47ArW7Xry5A34rGay8XryUKw4Du398Grs3ZFnIqFy5ArWv9rWSqF10
        vF4kWwnxuF1rCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
        6cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUomiiDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2021 09:42 PM, Alex Deucher wrote:
> On Mon, Jun 7, 2021 at 8:30 AM Christian König <christian.koenig@amd.com> wrote:
>> Am 07.06.21 um 14:27 schrieb Tiezhu Yang:
>>> radeon_suspend_kms() puts the hw in the suspend state (all asics),
>>> it should always call radeon_suspend_kms() in radeon_pci_shutdown(),
>>> this is a normal cleanup process to avoid more operations on radeon,
>>> just remove #ifdef CONFIG_PPC64 and the related comments.
>> Well NAK.
>>
>> Alex knows more about the details but suspending should not be part of
>> the pci shotdown process at all.
>>
>> We just add that here to enforce a GPU reset on PPC64 boards for some
>> reason.
> Everything in the comment still applies.
>
> Alex

Hi Alex and Christian,

Thanks for your quick reply. What do you think of the following changes?
If it is OK, I will send v2. If no, please ignore it.

Any comments will be much appreciated.

Thanks,
Tiezhu


Subject: [PATCH] drm/radeon: Call radeon_suspend_kms() in
  radeon_pci_shutdown() for Loongson64

On the Loongson64 platform used with Radeon GPU, shutdown or reboot failed
when console=tty is in the boot cmdline.

radeon_suspend_kms() puts the hw in the suspend state, especially set fb
state as FBINFO_STATE_SUSPENDED:

     if (fbcon) {
         console_lock();
         radeon_fbdev_set_suspend(rdev, 1);
         console_unlock();
     }

Then avoid to do any more fb operations in the related functions:

     if (p->state != FBINFO_STATE_RUNNING)
         return;

So call radeon_suspend_kms() in radeon_pci_shutdown() for Loongson64 to fix
this issue, it looks like some kind of workaround like powerpc.

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
  drivers/gpu/drm/radeon/radeon_drv.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c 
b/drivers/gpu/drm/radeon/radeon_drv.c
index efeb115..daabbf5 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -386,13 +386,13 @@ radeon_pci_shutdown(struct pci_dev *pdev)
      if (radeon_device_is_virtual())
          radeon_pci_remove(pdev);

-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC64) || defined(CONFIG_MACH_LOONGSON64)
      /*
       * Some adapters need to be suspended before a
       * shutdown occurs in order to prevent an error
-     * during kexec.
-     * Make this power specific becauase it breaks
-     * some non-power boards.
+     * during kexec, shutdown or reboot.
+     * Make this power and Loongson specific becauase
+     * it breaks some other boards.
       */
      radeon_suspend_kms(pci_get_drvdata(pdev), true, true, false);
  #endif
-- 
2.1.0

