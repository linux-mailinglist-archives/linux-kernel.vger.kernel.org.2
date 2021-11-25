Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DDD45E01E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbhKYSCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 13:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347878AbhKYSAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 13:00:43 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3DEC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:51:36 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x6so28585929edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iptSVGzbMcAeJvQpIm3YmgtiZkGGvvz55c0vj1Foiuc=;
        b=dobk2Oq5vHaj1niq3kcifUjg47+LgcMUvSLmqbQgNFPanVl+pP/PbENNx4kzsbLEJ3
         od1HjRefpF/x5gKVfM0bVaAQlz/UYeHA8U7U0Rmy8p3tQoi/xuqm6pRjz95sTnC6PyP4
         InVVRht5958TaO/8VSoY75xmrKGJS49ubeLUbMzWrTjSQsvrLiObrjOJ/U4o1T6L0jdR
         f8l3Py0/sOY/urB+X+KrnlZL3PUQV9Fxk+PHYFzzK/dpQW4MBegSpfDzKo5r/o8bVgjG
         pIKZgbZBsvkXrEZAo2el0NThrf+V0LwfUZEx/hhpTtC3ZxYJjY/LeRvknQNJTvC8hZH9
         4Npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iptSVGzbMcAeJvQpIm3YmgtiZkGGvvz55c0vj1Foiuc=;
        b=cmKfdRW5vY9mbc+KNy05VNKiUAlOcYM6PcHuJvNv7xxxttv4KqwthBq+nzC4cDRJPN
         EFFWxqTZmUW8ND2xIO8FidMZ3vnB6AjlaWL6YfvuDv8CbJJREcfCnWMw1n/J1LP6ldId
         cxM1Y65GRnYffXGq+o4ojm8ol7Ebe7JtECySh697acRD3Hc20AXHTCtT6XvGGtvDjAZQ
         4m9ITZr0gEWScYuEeP99cn8F2kZWdPqNhlEZeFUR77d4DrNxXapR21JiBbxFFVeIb0oH
         P9xLImSPPDT1mbEUpN6UsKxuz9LDosIPYMhxqhspgxLj71EO3ko1Qx3IpFi59dKx3xjb
         wbtw==
X-Gm-Message-State: AOAM532OdvJW1sYv+4iIL9lt19aIgDSFRa0j4n2LkUzbQlH2JZy1JI3w
        xOJ/dOz7h0J+bcpU91z0HwTLC74lv3R39keD1Kg=
X-Google-Smtp-Source: ABdhPJwdKZ10P/lr8q1OTFlZXjNlS8gl8JmeliCgmLg1BMFnFyc0ZdjgrhjrH1gwJ97jJuZrcxwVRH80zZGl4YjlBQc=
X-Received: by 2002:a50:da0a:: with SMTP id z10mr40028540edj.95.1637862695046;
 Thu, 25 Nov 2021 09:51:35 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLiXCmH+Ut8kf0DJe2Aonb11RJYeUmYQFsB=oSLbep+MdQ@mail.gmail.com>
 <CAAFS_9G_gQrBBJ2AWpwBWwZK41qiaFhBXy17XDeL7hOBxOvFeQ@mail.gmail.com>
In-Reply-To: <CAAFS_9G_gQrBBJ2AWpwBWwZK41qiaFhBXy17XDeL7hOBxOvFeQ@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Thu, 25 Nov 2021 23:21:23 +0530
Message-ID: <CAOuPNLghnx3gRCSyjBhw1O5Ux+vwuyxhfrAo1eUmGR85zhsbvg@mail.gmail.com>
Subject: Re: dm-verity: How to exactly use the dm-mod.create with
 verity-metadata append
To:     Will Drewry <wad@chromium.org>
Cc:     dm-devel@redhat.com, helen.koike@collabora.com,
        Kees Cook <keescook@chromium.org>,
        enric.balletbo@collabora.com, snitzer@redhat.com, agk@redhat.com,
        open list <linux-kernel@vger.kernel.org>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 at 22:13, Will Drewry <wad@chromium.org> wrote:
>
> On Tue, Nov 23, 2021 at 4:36 AM Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > Hi,
> >
> > For rootfs dm-verity I am trying to pass dm-mod.create from our
> > bootloader but it seems not working for me.
> > So, I need some guidance on the parameters that we pass here.
> > The documentation also does not seem to help much.
> >
> > Kernel: 4.14 (with dm-init patch backported)
> > Target: Arm-32 / NAND / Simple Busybox / Bootloader (edk2)
> > Build: Ubuntu-18.04 / Yocto 2.6
> >
> > Steps I followed:
> > 1) First I am trying to generate the root hash for our rootfs using
> > the veritysetup command:
> > $ ls -l system.img
> > 64172032 ==> IMAGE_SIZE
> > $ veritysetup format system.img dm-init-verity.img
> > UUID:                   eca62b73-b66a-4249-834b-471e83fc382c
> > Hash type:              1
> > Data blocks:            15667
> > Data block size:        4096
> > Hash block size:        4096
> > Hash algorithm:         sha256
> > Salt:
> > 8b66f42c07f576429109cf4e5d12ec072b23d242a9e653ac3423e49647339f5b
> > Root hash:
> > 10d9036f6efdd48dd49f09c8ece016a36a2c4d9a01a1f77f01485c65cf0e78af
> >
> > 2) Then I am trying to append the verity with the system image itself:
> > $ cat dm-init-verity.img >> system.img
> >
> > 3) After that I am trying to pass dm-mod.create parameter like this:
> > dm-mod.create=\"system,,,ro, 0 IMAGE_SIZE/512 verity 1
> > /dev/ubiblock0_0 /dev/ubiblock0_0 4096 4096 DATA_BLOCKS 1 sha256
> > 10d9036f6efdd48dd49f09c8ece016a36a2c4d9a01a1f77f01485c65cf0e78af
> > 8b66f42c07f576429109cf4e5d12ec072b23d242a9e653ac3423e49647339f5b\"
> >
> > 4) The Kernel command line seems to be updated properly:
> > [    0.000000] Kernel command line:.. rootfstype=squashfs
> > ubi.mtd=40,0,30 ubi.block=0,0 root=/dev/ubiblock0_0
> > dm-mod.create="system,,,ro, 0 125336 verity 1 /dev/ubiblock0_0
> > /dev/ubiblock0_0 4096 4096 15667 1 sha256
> > 10d9036f6efdd48dd49f09c8ece016a36a2c4d9a01a1f77f01485c65cf0e78af
> > 8b66f42c07f576429109cf4e5d12ec072b23d242a9e653ac3423e49647339f5b" ....
> >
> > But it does not seem to work as expected.
> > It gives below errors:
> > ....
> > [    4.747708] block ubiblock0_0: created from ubi0:0(system)
> > [    4.752313] device-mapper: init: waiting for all devices to be
> > available before creating mapped devices
> > [    4.752313]
> > [    4.766061] device-mapper: verity: sha256 using implementation
> > "sha256-generic"
> > [    4.776178] device-mapper: ioctl: dm-0 (system) is ready
> > [    4.848886] md: Skipping autodetection of RAID arrays.
> > (raid=autodetect will force)
> > [    4.849288] VFS: Cannot open root device "ubiblock0_0" or
> > unknown-block(252,0): error -16
>
> I'd start with changing your root device to point to the device mapper
> one you've just created.  E.g., root=/dev/dm-0  Then see how it goes
> from there.

Yes I tried this already but it seems the problem was something else.

> >
> > I followed almost the same example from dm-init document:
> > "verity":
> >   dm-verity,,4,ro,
> >     0 1638400 verity 1 8:1 8:2 4096 4096 204800 1 sha256
> >     fb1a5a0f00deb908d8b53cb270858975e76cf64105d412ce764225d53b8f3cfd
> >     51934789604d1b92399c52e7cb149d1b3a1b74bbbcb103b2a0aaacbed5c08584
> >
> > But this seems only refer to system and verity on a different blocks.
> > I am not sure what parameter should be changed if my verity metadata
> > is part of system image itself.
> > Also, I don't know how 1638400;204800;1 is calculated here based on image size ?
>
> It's the range of sectors covered by the device 0 to size_in_sectors:
>   (data_blocks * block_size)/sector_size
>   (15667 * 4096)/512
>   125336
> which you have in your entry already.
>

Now I made it working using both dmsetup first and then using
dm-mod.create with the same parameters.
There is slightly a different step when appending metadata to the
system image itself.
First, we need to adjust the hash offset for metadata location.
Then we need to specify the offset in terms of number of blocks. This
is still fine.
But the problem is to specify the hash_start which is (number of blocks + 1).

So, I used like this:
veritysetup format --hash-offset=<image size> system.img system.img
(The metadata will be appended automatically at the end of system.img)
This will give the data blocks as well.
dm-mod.create=\"system,,,ro, 0 125336 verity 1 /dev/ubiblock0_0
/dev/ubiblock0_0 4096 4096 15667 15668 sha256
39438d7915f2af8532752d78ce0cc08dc9d23b9e7176518310bc65de5c226c7d
56413cf91ccc9e32ec5b2d36b54e61114ab92a345d8547a194fc86ff4437896c\"

So, this worked for me.

Thank you so much!

Regards,
Pintu
