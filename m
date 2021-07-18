Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C915B3CC973
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 15:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhGROCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 10:02:03 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:59795 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhGROCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 10:02:01 -0400
X-Greylist: delayed 15694 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Jul 2021 10:02:01 EDT
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 16IDwl2W018702;
        Sun, 18 Jul 2021 22:58:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 16IDwl2W018702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1626616728;
        bh=tFk8Ig3q2oNJF/uk+ytx6lDN8oyMkUcP+7lIMpcBLL8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vxEqs/zLT/cZHUdHEvAJN3pPsbhfO6xxjTaa5NEQ+HZTqOgg8ovygZsFFsYWe7nI7
         AG95bp95biXVghjpPXKA5uu4cPtZGxK0RW9aUqTJx37puo4IfHLBp67m6rwveqMn6A
         b7TQ5z3FQ/unBUyDBsB5allPqP+zRj6oQgtp+F2uuh4sLZdyLJy42XUcZZxV8e2hzo
         lsXHE+FbkVRFPCqu0/GL86ZK230Stzmmnm+CH+s+FON6w2vfgeS6GO12Zy0Mm3vctq
         PCcN4gjKCDRFJT4WDZCoEIgGIt9AWfRDoexL7cBFaCbyRWgNp8JI40TAXUxr05P87N
         DamuCVu5i1K2Q==
X-Nifty-SrcIP: [209.85.210.182]
Received: by mail-pf1-f182.google.com with SMTP id o201so13771440pfd.1;
        Sun, 18 Jul 2021 06:58:47 -0700 (PDT)
X-Gm-Message-State: AOAM5301Dd2U5kGrniwk4JgmHmc4X+iG1zUKW+pOJ1rRkIgPrLcghPmT
        1S/NFcfEh4/fMzwlJUZMFDxreAw2KfOy8AjZSgU=
X-Google-Smtp-Source: ABdhPJwiwHhDDous4ehqf4AQKQ3JHjjc87AyIMp+whc3LeTPoGqbKThNSWrayq9dfd0JUpQ6z+ppbryea42JNP8u1Xw=
X-Received: by 2002:aa7:8593:0:b029:32b:c173:cd96 with SMTP id
 w19-20020aa785930000b029032bc173cd96mr20987095pfn.63.1626616726882; Sun, 18
 Jul 2021 06:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <ad9c50c54887bde41ae5de782248231c06a527c0.1626262835.git.rrichter@amd.com>
 <d935cf2c8d73ac2ad6a9390f563d561bfa65bcdf.1626262835.git.rrichter@amd.com>
In-Reply-To: <d935cf2c8d73ac2ad6a9390f563d561bfa65bcdf.1626262835.git.rrichter@amd.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 18 Jul 2021 22:58:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNATs8O1O3iRpw7U2_zc3EOJ_O8t8bzcfA+ps2M01GsoVAQ@mail.gmail.com>
Message-ID: <CAK7LNATs8O1O3iRpw7U2_zc3EOJ_O8t8bzcfA+ps2M01GsoVAQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Fix intiramfs script name
To:     Robert Richter <rrichter@amd.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 6:26 PM Robert Richter <rrichter@amd.com> wrote:
>
> Documentation was not changed when renaming the script in commit
> 80e715a06c2d ("initramfs: rename gen_initramfs_list.sh to
> gen_initramfs.sh"). Fixing this.
>
> Basically does:
>
>  $ sed -i -e s/gen_initramfs_list.sh/gen_initramfs.sh/g $(git grep -l gen_initramfs_list.sh)
>
> Fixes: 80e715a06c2d ("initramfs: rename gen_initramfs_list.sh to gen_initramfs.sh")
> Signed-off-by: Robert Richter <rrichter@amd.com>

Applied to linux-kbuild.




> ---
>  .../early-userspace/early_userspace_support.rst           | 8 ++++----
>  Documentation/filesystems/ramfs-rootfs-initramfs.rst      | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/driver-api/early-userspace/early_userspace_support.rst b/Documentation/driver-api/early-userspace/early_userspace_support.rst
> index 8a58c61932ff..61bdeac1bae5 100644
> --- a/Documentation/driver-api/early-userspace/early_userspace_support.rst
> +++ b/Documentation/driver-api/early-userspace/early_userspace_support.rst
> @@ -69,17 +69,17 @@ early userspace image can be built by an unprivileged user.
>
>  As a technical note, when directories and files are specified, the
>  entire CONFIG_INITRAMFS_SOURCE is passed to
> -usr/gen_initramfs_list.sh.  This means that CONFIG_INITRAMFS_SOURCE
> +usr/gen_initramfs.sh.  This means that CONFIG_INITRAMFS_SOURCE
>  can really be interpreted as any legal argument to
> -gen_initramfs_list.sh.  If a directory is specified as an argument then
> +gen_initramfs.sh.  If a directory is specified as an argument then
>  the contents are scanned, uid/gid translation is performed, and
>  usr/gen_init_cpio file directives are output.  If a directory is
> -specified as an argument to usr/gen_initramfs_list.sh then the
> +specified as an argument to usr/gen_initramfs.sh then the
>  contents of the file are simply copied to the output.  All of the output
>  directives from directory scanning and file contents copying are
>  processed by usr/gen_init_cpio.
>
> -See also 'usr/gen_initramfs_list.sh -h'.
> +See also 'usr/gen_initramfs.sh -h'.
>
>  Where's this all leading?
>  =========================
> diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.rst b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
> index 4598b0d90b60..164960631925 100644
> --- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst
> +++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
> @@ -170,7 +170,7 @@ Documentation/driver-api/early-userspace/early_userspace_support.rst for more de
>  The kernel does not depend on external cpio tools.  If you specify a
>  directory instead of a configuration file, the kernel's build infrastructure
>  creates a configuration file from that directory (usr/Makefile calls
> -usr/gen_initramfs_list.sh), and proceeds to package up that directory
> +usr/gen_initramfs.sh), and proceeds to package up that directory
>  using the config file (by feeding it to usr/gen_init_cpio, which is created
>  from usr/gen_init_cpio.c).  The kernel's build-time cpio creation code is
>  entirely self-contained, and the kernel's boot-time extractor is also
> --
> 2.29.2
>


-- 
Best Regards
Masahiro Yamada
