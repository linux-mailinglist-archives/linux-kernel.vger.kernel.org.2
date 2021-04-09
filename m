Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3B135939B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 06:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhDIEKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 00:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhDIEKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 00:10:12 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1826BC061760;
        Thu,  8 Apr 2021 21:10:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w28so7547665lfn.2;
        Thu, 08 Apr 2021 21:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jrdGfzw0sLrUe/7ljN5TaAvoWpq/FVRgXaiuOP0F+qw=;
        b=BeKsYzEzoNKY7lToW6m6+vEexUtrGxIm5fBgoZh7/3PECzuJlRUtfssVfHMIoEPJ3/
         4Po6jKgapuUxiSoDWQ1wDcd5nyluNhOyr2FGUe7RrKgVb/U3R9imrnWyI/TRWcHNbI1o
         1C9Rd8Q18uRzGlgVBsdqD/Sc6zepIbBf5E1N4+euuLoogmPSF6qVPMeb75ZDQBhA37YH
         h31k6F+Qa2h6yRX87wZh41iFw7tHVdqpJHj01KIb3CMsFwGYQyNoyKtyCdOWDbxz1wzp
         NhJpWJK+OP3Ed3XPoYhADIHcAaHjsHH5BJioERkY2mASm+eW4vLm3ZHVqjPFYthvTKn1
         BoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jrdGfzw0sLrUe/7ljN5TaAvoWpq/FVRgXaiuOP0F+qw=;
        b=c/GCkeBX/TQ4ITALrsP5x25CmyTk2Ss8kLKTWQUEi5CMoFurggN7tINM9gHS0hvyxy
         yZdFXRtD2LDRqOJRX3fts5gwcWiao2mSh4EsXalSW84E8Ay3BaVt5ucOTQP/3tmNmTXx
         Qk0Y8CuuhLjxKpZp7AY+Sjs9krEc/edJbnf2DSOd33P+nuuFG4ty3RrUiHdscbbWITEk
         gFZGlkjlewQFsXBcA4JnPtSODy4cA/RScmqpzCs1ZgsKmWL6/GnUJv/7SA668am1TBTT
         xMFPNJukvKyaj+mWEJjYqvSSRgEGpmZoj0sy44nf9nrvbzDjhtkDw/b+hfluDisbVls4
         4FAA==
X-Gm-Message-State: AOAM530/f7x1FxBLtIJM3CCzXreEW1M7pz9cSs4+EQZIa0svtAJPfyJ0
        MQZDvwu35dn/9kBAfzrDMF71eU8l00DWj5qzIE4=
X-Google-Smtp-Source: ABdhPJzzqaul7xF/ZUamoMPlogelnhKWk4VAgGT3Ym1rfjd0CvJGieCbIeSnpvX5PsPwSB+FNUzQ0fjjpnHHEy9Tras=
X-Received: by 2002:a19:8c0a:: with SMTP id o10mr9056546lfd.175.1617941398568;
 Thu, 08 Apr 2021 21:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <1617870662-78127-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1617870662-78127-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 8 Apr 2021 23:09:47 -0500
Message-ID: <CAH2r5mtmeMpkp=vAZYws7c7O+bXo-0XCmLLtNPLUYqV3rByqpA@mail.gmail.com>
Subject: Re: [PATCH] cifs: Remove useless variable
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Thu, Apr 8, 2021 at 3:33 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following gcc warning:
>
> fs/cifs/cifsacl.c:1097:8: warning: variable =E2=80=98nmode=E2=80=99 set b=
ut not used
> [-Wunused-but-set-variable].
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/cifs/cifsacl.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
> index d178cf8..fdb258a 100644
> --- a/fs/cifs/cifsacl.c
> +++ b/fs/cifs/cifsacl.c
> @@ -1094,11 +1094,9 @@ static int set_chmod_dacl(struct cifs_acl *pdacl, =
struct cifs_acl *pndacl,
>         struct cifs_ace *pnntace =3D NULL;
>         char *nacl_base =3D NULL;
>         u32 num_aces =3D 0;
> -       __u64 nmode;
>         bool new_aces_set =3D false;
>
>         /* Assuming that pndacl and pnmode are never NULL */
> -       nmode =3D *pnmode;
>         nacl_base =3D (char *)pndacl;
>         nsize =3D sizeof(struct cifs_acl);
>
> --
> 1.8.3.1
>


--=20
Thanks,

Steve
