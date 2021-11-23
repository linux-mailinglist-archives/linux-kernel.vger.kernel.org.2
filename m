Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A2345A053
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhKWKje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbhKWKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:39:29 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AABFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 02:36:21 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t5so90436256edd.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 02:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VQJ6CdunLhhxPVsr+8Cb/isFyJRrndJrABiFEBMcKdE=;
        b=jmG4Dpgy1S0rdWm3cDyYXHjS7JxV+1jgTO7W/rD7hi4d3XQTI/QksfZOZS25tuulAt
         s8GiMNDODWnPyrJ6GQ1f/iq+FPXeakqz6viQ0BS69cMznVnZikGE/YoXlDXSBvc1p1Fr
         cfdl/8iPTtOuNkGS1rKZSOwpydu549qLJNP7ljLzain2mAzh/cerkDyKbceVy/7jf1zh
         cctFuKRumBUSr7Wsv38ZIVoxoYTblch+cN1TZ9tkd8S00CkbIV7pbwU8CZpUamPk2Y0R
         zCZXtwIMP8439lRvUmyzmNxetOAM+XGwVYmb5xSnuE6xWCxX8zFNOq6/s/TQ/+WiL67a
         arzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VQJ6CdunLhhxPVsr+8Cb/isFyJRrndJrABiFEBMcKdE=;
        b=kzgAYxS/L23U8WEO8+tr4cH89RQfNRakiXsVOR7vcCeGhkyw5ipAvt4vN7PKz1sBfL
         nB6oMWpIuhMrLKEsmmlyxYVZASZu6dVo8Iz2WXatu8uCpRy6xNYsBruloAB4jC9LkkrY
         IVP9sipEQmydVaCNkC0k7670FoWrLrqK3cQIzTnaSlhU2Ft3+bv6USr18o4BiU8B/58f
         feLDTYJY7Rv2VM8LNQLaCxD/UBE48WoX8MG71q/U8II+J4ArCjeqXJSRXpUdTlfx89BC
         i4hkIletngd8RAZPgF4M/Lhn22gwMtf4P1+Et/Dllp/p+ZNb6VEfIBzP8T1aCnUFncQB
         QLFg==
X-Gm-Message-State: AOAM53399BSMtWWvxTqkRL6xQalOGG7hLUZ7iSA3+tnA5GF5IEjB2yH9
        2xqvdjHCuBHz4+KkVpPvEsJZeAr1MDSt5wUkHRg=
X-Google-Smtp-Source: ABdhPJzm3DTP1MZxdqjayOarBF034HP+d2wEyoI39+wkYagw7aqD/G2MHVKA5OJDylJTzwPzGPBa9/0UiuRqo+uiYbE=
X-Received: by 2002:a17:906:b084:: with SMTP id x4mr6307130ejy.214.1637663779673;
 Tue, 23 Nov 2021 02:36:19 -0800 (PST)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 23 Nov 2021 16:06:08 +0530
Message-ID: <CAOuPNLiXCmH+Ut8kf0DJe2Aonb11RJYeUmYQFsB=oSLbep+MdQ@mail.gmail.com>
Subject: dm-verity: How to exactly use the dm-mod.create with verity-metadata append
To:     dm-devel@redhat.com, helen.koike@collabora.com, wad@chromium.org,
        Kees Cook <keescook@chromium.org>,
        enric.balletbo@collabora.com, snitzer@redhat.com, agk@redhat.com
Cc:     open list <linux-kernel@vger.kernel.org>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For rootfs dm-verity I am trying to pass dm-mod.create from our
bootloader but it seems not working for me.
So, I need some guidance on the parameters that we pass here.
The documentation also does not seem to help much.

Kernel: 4.14 (with dm-init patch backported)
Target: Arm-32 / NAND / Simple Busybox / Bootloader (edk2)
Build: Ubuntu-18.04 / Yocto 2.6

Steps I followed:
1) First I am trying to generate the root hash for our rootfs using
the veritysetup command:
$ ls -l system.img
64172032 ==> IMAGE_SIZE
$ veritysetup format system.img dm-init-verity.img
UUID:                   eca62b73-b66a-4249-834b-471e83fc382c
Hash type:              1
Data blocks:            15667
Data block size:        4096
Hash block size:        4096
Hash algorithm:         sha256
Salt:
8b66f42c07f576429109cf4e5d12ec072b23d242a9e653ac3423e49647339f5b
Root hash:
10d9036f6efdd48dd49f09c8ece016a36a2c4d9a01a1f77f01485c65cf0e78af

2) Then I am trying to append the verity with the system image itself:
$ cat dm-init-verity.img >> system.img

3) After that I am trying to pass dm-mod.create parameter like this:
dm-mod.create=\"system,,,ro, 0 IMAGE_SIZE/512 verity 1
/dev/ubiblock0_0 /dev/ubiblock0_0 4096 4096 DATA_BLOCKS 1 sha256
10d9036f6efdd48dd49f09c8ece016a36a2c4d9a01a1f77f01485c65cf0e78af
8b66f42c07f576429109cf4e5d12ec072b23d242a9e653ac3423e49647339f5b\"

4) The Kernel command line seems to be updated properly:
[    0.000000] Kernel command line:.. rootfstype=squashfs
ubi.mtd=40,0,30 ubi.block=0,0 root=/dev/ubiblock0_0
dm-mod.create="system,,,ro, 0 125336 verity 1 /dev/ubiblock0_0
/dev/ubiblock0_0 4096 4096 15667 1 sha256
10d9036f6efdd48dd49f09c8ece016a36a2c4d9a01a1f77f01485c65cf0e78af
8b66f42c07f576429109cf4e5d12ec072b23d242a9e653ac3423e49647339f5b" ....

But it does not seem to work as expected.
It gives below errors:
....
[    4.747708] block ubiblock0_0: created from ubi0:0(system)
[    4.752313] device-mapper: init: waiting for all devices to be
available before creating mapped devices
[    4.752313]
[    4.766061] device-mapper: verity: sha256 using implementation
"sha256-generic"
[    4.776178] device-mapper: ioctl: dm-0 (system) is ready
[    4.848886] md: Skipping autodetection of RAID arrays.
(raid=autodetect will force)
[    4.849288] VFS: Cannot open root device "ubiblock0_0" or
unknown-block(252,0): error -16
....

I followed almost the same example from dm-init document:
"verity":
  dm-verity,,4,ro,
    0 1638400 verity 1 8:1 8:2 4096 4096 204800 1 sha256
    fb1a5a0f00deb908d8b53cb270858975e76cf64105d412ce764225d53b8f3cfd
    51934789604d1b92399c52e7cb149d1b3a1b74bbbcb103b2a0aaacbed5c08584

But this seems only refer to system and verity on a different blocks.
I am not sure what parameter should be changed if my verity metadata
is part of system image itself.
Also, I don't know how 1638400;204800;1 is calculated here based on image size ?

So, people who have made this working successfully, please share the
correct parameter to be used for the same block device.

Thanks,
Pintu
