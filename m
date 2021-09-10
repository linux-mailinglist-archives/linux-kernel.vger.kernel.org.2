Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8134072E5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 23:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhIJVYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 17:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbhIJVYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 17:24:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3F0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 14:23:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 17so2991453pgp.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=trDFq8Ihp9877WBkIxRTD2acuMGz2fcK4NhLKwWvL10=;
        b=d1s020d+asw/iimvSx4hnlFqWqE5tvz3y1GGpqhZkuHpm3Z/m99NHq5qeoZ7ToKAkH
         e+GmzyjIZnt/WzTeoSnG84AVeoD8zzaf65vbhwYW3NUGH5pLmcwZpXgpKNNA91wbcv7g
         g3xdOjgv3hIt4kdNpw9OUqReA69RLRLByIWzUMHWkPaSMb3TiK6enLEOsU7pbwhaYYOK
         3YHtV17AWi/s1ZELiEJu2R7sl6Km3MaVGyg7O4MSzU+byZ6bzPPTapdyhsO4qffDuDCd
         JRU55f99gswzK0tO+ULbP+/aPGGOXk6s9t73Eic6vBLM7JVnxq9VIPCCPUhyBAodhebk
         TlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=trDFq8Ihp9877WBkIxRTD2acuMGz2fcK4NhLKwWvL10=;
        b=qNLdiCb726uGz2HBWxPRZyyIj+ArJUdo+QgKwthXuWrpDJXv5u1rX14MRlj5mtnys+
         WqrDSGqQD8TztFO0btgt7FYn6RHX674Ka8yAm92Ya67RdjV+9wUHmwnsAqGQ2AJY1aIt
         Jcuwic4zeOMuypgUCcAB6ihozpynfAN00kcZTN+3QExrLdwPW/odHlI/JCE6qgEKc8rO
         QOdjb7IcFwwtPtjc+LUvzhz//cVXjEcvhhV6AMFw1T6IXcHi2ZijbeZWkrjfegnKLZdI
         WfygKOc8hHQ4/G4z0xTHpTppkD97oKbUnVpToE6FHqGn1Kzd9d6eP6C8hSKHQO/PDA1U
         mIPg==
X-Gm-Message-State: AOAM532bXwbmcPZF49u9qcshJx1tLz/eMB0vLXrvqbKda0isXsNA2e3v
        SgyPy6ChF/aYqdkkI8SHt6EeK4hnWSE/IQkzvnwwCA==
X-Google-Smtp-Source: ABdhPJypBYX1sIb2vk0UJuTbH5dnqE1iazgiMlrcQF+29xcumhioqyQwCkTKNV2E1BMsvnwpk/oQHwpdCOa8E5QGVJE=
X-Received: by 2002:a05:6a00:164c:b0:434:a68b:326a with SMTP id
 m12-20020a056a00164c00b00434a68b326amr5161002pfc.63.1631309007854; Fri, 10
 Sep 2021 14:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <6A72EAE4-A0F7-4CD2-89BB-36A8F4A7D321@internode.on.net>
In-Reply-To: <6A72EAE4-A0F7-4CD2-89BB-36A8F4A7D321@internode.on.net>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 10 Sep 2021 14:23:16 -0700
Message-ID: <CAFd5g46N6PuOrEyaqK4jRx1_NyVqgtPWvRc2=8vQ8xu2iS3Low@mail.gmail.com>
Subject: Re: After KUnit update for Linux 5.15-rc1 - unable to share VFAT
 filesystem via samba
To:     Arthur Marsh <arthur.marsh@internode.on.net>,
        David Gow <davidgow@google.com>
Cc:     skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+David Gow - just FYI since you are the only KUnit person who touched
VFAT. PTAL at other emails in thread too, please.

On Fri, Sep 10, 2021 at 4:57 AM Arthur Marsh
<arthur.marsh@internode.on.net> wrote:
>
>
>  Hi, I have been sharing an old VFAT formatted hard disk on one pc to
> another using Samba and sometime after kernel 5.14.0 it stopped working (apparently no longer being shared as the mount.smbfs command
> on the client failed with error -13 yet mount.smbfs still worked for
> ext3 filesytems shared from the same machine which had the VFAT
> filesystem).
>  The only error I saw on the machine with the VFAT formatted hard disk
> was the output of the mount command had truncated the name of the
> mount to only include the first 4 characters of the base name of the
> mount point.
>  e.g. when VFAT filesystem was mounted on /mnt/victoria, the output of
> the mount command showed the filesytem mounted on /mnt/vict
>
> The kernel build used was i386 with gcc 11.2.0-4 using
>
> make - j2 menuconfig bindeb-pkg
>
> .config available on request.
>
>  The git-bisect was:
> victoria:/usr/src/linux# git bisect loggit bisect start '--' 'fs/fat'#
> good: [7d2a07b769330c34b4deabeed939325c77a7ec2f] Linux 5.14git bisect
> good 7d2a07b769330c34b4deabeed939325c77a7ec2f# bad:
> [a3fa7a101dcff93791d1b1bdb3affcad1410c8c1] Merge branches 'akpm' and
> 'akpm-hotfixes' (patches from Andrew)git bisect bad
> a3fa7a101dcff93791d1b1bdb3affcad1410c8c1# good:
> [edb0872f44ec9976ea6d052cb4b93cd2d23ac2ba] block: move the bdi from
> the request_queue to the gendiskgit bisect good
> edb0872f44ec9976ea6d052cb4b93cd2d23ac2ba# good:
> [b0d4adaf3b3c4402d9c3b6186e02aa1e4f7985cd] fat: Add KUnit tests for
> checksums and timestampsgit bisect good
> b0d4adaf3b3c4402d9c3b6186e02aa1e4f7985cd# bad:
> [c815f04ba94940fbc303a6ea9669e7da87f8e77d] Merge tag
> 'linux-kselftest-kunit-5.15-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftestgit
> bisect bad c815f04ba94940fbc303a6ea9669e7da87f8e77d# first bad commit:
> [c815f04ba94940fbc303a6ea9669e7da87f8e77d] Merge tag
> 'linux-kselftest-kunit-5.15-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
>
> amarsh04@victoria:~$ mount|grep vic/dev/sdb6 on /vict type vfat
> (rw,relatime,uid=65534,gid=65534,fmask=0000,dmask=0000,allow_utime=0022,codepage=437,iocharset=utf8,shortname=mixed,errors=remount-ro)

I don't see how our patch could have caused this either. Nevertheless,
I CC'ed David who has worked on VFAT who may be able to provide more
info.

> Happy to run any further tests but kernel builds are slow on this machine (Pentium Dl.
>
> Arthur.
