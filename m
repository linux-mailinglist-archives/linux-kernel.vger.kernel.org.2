Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA50D45A92B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbhKWQsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239521AbhKWQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:48:11 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCABC0619FB
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 08:43:30 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r8so39953212wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 08:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5neTUk/m2vB9IAM6ngUOM8n9WDJP9MLnMLArs9XbOJw=;
        b=byZ3awxkiz9WIohcCKjZ1RnISSUcMbbjORpffVRhiL16M8lHM0gcLAtTQmRLqX06no
         DdO12YWQgz1/76uIN5xl2nZHAAKYBJxJ6rvsCvqaaBZGzBleDfSiCs27ZB07x2b/VyOw
         c9zAmfOhw/shuKl4ObBfeqlZQtsM4DL+NspZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5neTUk/m2vB9IAM6ngUOM8n9WDJP9MLnMLArs9XbOJw=;
        b=WGfYO1gjBstqR1LiL0g5dQqAzURzxzt32tOgVCO3Fpk8OsP6D8QXaSgCLHjmYXpCdc
         hiLpbnZVPx3mh2PhwRiLUJQD3FxUUvhDAsUeLtfrohaDJhOgIto7bKix4MDc//aeZ9/v
         OZLrhxQSAatQK/nLXy9VMnxwRCAALmUMDYoLL5vWlsRDG3xtLyKWa0x9wVba0IuBws8P
         TKSO9xFYJaSUxtItEXEkJzuG6eqncZGKoS5txPwriuqbvZSXhpgFcz7pkFoEfHfZKbm0
         wAOJyCOHWFilWtlMe6t52oKgB7DmcMS5F1XvXwOlTrt8H6XgwcRs/cu2lJTo1m+NKFhz
         LsPQ==
X-Gm-Message-State: AOAM531ZNmawL3twQow1D0qrR5PfJdUiRPl8BxEnDnY3kDYb25RKjt9C
        Tg+bU69rchbs7NwAR5stcxP+VGL26wH2c1vjYnjYFg==
X-Google-Smtp-Source: ABdhPJwzTM7lcjHa6kT/XkIFqyUhLvbfIVKMMsj5u/hKr4G+sFpnC60Aiu1g1tWSlFVoSzSbrQwFPZ0Me/zJiV4Yybs=
X-Received: by 2002:a5d:58fb:: with SMTP id f27mr9217095wrd.10.1637685808489;
 Tue, 23 Nov 2021 08:43:28 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLiXCmH+Ut8kf0DJe2Aonb11RJYeUmYQFsB=oSLbep+MdQ@mail.gmail.com>
In-Reply-To: <CAOuPNLiXCmH+Ut8kf0DJe2Aonb11RJYeUmYQFsB=oSLbep+MdQ@mail.gmail.com>
From:   Will Drewry <wad@chromium.org>
Date:   Tue, 23 Nov 2021 10:43:15 -0600
Message-ID: <CAAFS_9G_gQrBBJ2AWpwBWwZK41qiaFhBXy17XDeL7hOBxOvFeQ@mail.gmail.com>
Subject: Re: dm-verity: How to exactly use the dm-mod.create with
 verity-metadata append
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     dm-devel@redhat.com, helen.koike@collabora.com,
        Kees Cook <keescook@chromium.org>,
        enric.balletbo@collabora.com, snitzer@redhat.com, agk@redhat.com,
        open list <linux-kernel@vger.kernel.org>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 4:36 AM Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> Hi,
>
> For rootfs dm-verity I am trying to pass dm-mod.create from our
> bootloader but it seems not working for me.
> So, I need some guidance on the parameters that we pass here.
> The documentation also does not seem to help much.
>
> Kernel: 4.14 (with dm-init patch backported)
> Target: Arm-32 / NAND / Simple Busybox / Bootloader (edk2)
> Build: Ubuntu-18.04 / Yocto 2.6
>
> Steps I followed:
> 1) First I am trying to generate the root hash for our rootfs using
> the veritysetup command:
> $ ls -l system.img
> 64172032 ==> IMAGE_SIZE
> $ veritysetup format system.img dm-init-verity.img
> UUID:                   eca62b73-b66a-4249-834b-471e83fc382c
> Hash type:              1
> Data blocks:            15667
> Data block size:        4096
> Hash block size:        4096
> Hash algorithm:         sha256
> Salt:
> 8b66f42c07f576429109cf4e5d12ec072b23d242a9e653ac3423e49647339f5b
> Root hash:
> 10d9036f6efdd48dd49f09c8ece016a36a2c4d9a01a1f77f01485c65cf0e78af
>
> 2) Then I am trying to append the verity with the system image itself:
> $ cat dm-init-verity.img >> system.img
>
> 3) After that I am trying to pass dm-mod.create parameter like this:
> dm-mod.create=\"system,,,ro, 0 IMAGE_SIZE/512 verity 1
> /dev/ubiblock0_0 /dev/ubiblock0_0 4096 4096 DATA_BLOCKS 1 sha256
> 10d9036f6efdd48dd49f09c8ece016a36a2c4d9a01a1f77f01485c65cf0e78af
> 8b66f42c07f576429109cf4e5d12ec072b23d242a9e653ac3423e49647339f5b\"
>
> 4) The Kernel command line seems to be updated properly:
> [    0.000000] Kernel command line:.. rootfstype=squashfs
> ubi.mtd=40,0,30 ubi.block=0,0 root=/dev/ubiblock0_0
> dm-mod.create="system,,,ro, 0 125336 verity 1 /dev/ubiblock0_0
> /dev/ubiblock0_0 4096 4096 15667 1 sha256
> 10d9036f6efdd48dd49f09c8ece016a36a2c4d9a01a1f77f01485c65cf0e78af
> 8b66f42c07f576429109cf4e5d12ec072b23d242a9e653ac3423e49647339f5b" ....
>
> But it does not seem to work as expected.
> It gives below errors:
> ....
> [    4.747708] block ubiblock0_0: created from ubi0:0(system)
> [    4.752313] device-mapper: init: waiting for all devices to be
> available before creating mapped devices
> [    4.752313]
> [    4.766061] device-mapper: verity: sha256 using implementation
> "sha256-generic"
> [    4.776178] device-mapper: ioctl: dm-0 (system) is ready
> [    4.848886] md: Skipping autodetection of RAID arrays.
> (raid=autodetect will force)
> [    4.849288] VFS: Cannot open root device "ubiblock0_0" or
> unknown-block(252,0): error -16

I'd start with changing your root device to point to the device mapper
one you've just created.  E.g., root=/dev/dm-0  Then see how it goes
from there.

> ....
>
> I followed almost the same example from dm-init document:
> "verity":
>   dm-verity,,4,ro,
>     0 1638400 verity 1 8:1 8:2 4096 4096 204800 1 sha256
>     fb1a5a0f00deb908d8b53cb270858975e76cf64105d412ce764225d53b8f3cfd
>     51934789604d1b92399c52e7cb149d1b3a1b74bbbcb103b2a0aaacbed5c08584
>
> But this seems only refer to system and verity on a different blocks.
> I am not sure what parameter should be changed if my verity metadata
> is part of system image itself.
> Also, I don't know how 1638400;204800;1 is calculated here based on image size ?

It's the range of sectors covered by the device 0 to size_in_sectors:
  (data_blocks * block_size)/sector_size
  (15667 * 4096)/512
  125336
which you have in your entry already.

> So, people who have made this working successfully, please share the
> correct parameter to be used for the same block device.

hth,
will
