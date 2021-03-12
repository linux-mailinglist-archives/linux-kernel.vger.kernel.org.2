Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5370339037
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhCLOmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhCLOmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:42:17 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3F3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:42:17 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id r20so7042202ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/ZgtvRUCOeB2tes232V28vaR4drPg6AkuyiMBwt7N/Q=;
        b=TT4sNAbE++eXFwV/kLG3OLxZb9hyTRXOGfbo6NPgoa2hdLLMENGShbvPYOMDArP8C5
         RKlPk5VVpXNLF5blZeOdwAjGPqVXpFNPgjYYrVb6O7GTSkRB+Fyx4O0pa1l1kOsnNznE
         xFQvIUZJl9uQGXJCjQKizXLGUUTlD0HXVt/Jj+aRfi07o21cJzRKvEb8KZXWulKHg8zG
         cYjle+Zze0D4cKdNB230Q6aco2pQXDIaERXcL6iiXjVMaecRViWLROHlXHGW5L3Y96Iw
         lxE1WH3xyR63B64hekFbsHI2M4laMPJAcwNUXM8c15Kdw4Xwvmqb+4R3WaP2XCRHxlrc
         GyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/ZgtvRUCOeB2tes232V28vaR4drPg6AkuyiMBwt7N/Q=;
        b=A/MVtu5Y6AjybuqoEEkt+x8JMFy7HACRyAZDJ2j60go3Ud9gNJ9l2sgDg52hjVjvDP
         jfjXDqyga67WqsqkMgVJaSubQHGNsx9gGfuSbOpUp48gp9/s6nY94oqLbQaM8cNvIbNU
         IFw8gqMFzGjWec73UEYXdyoBBy4WWSNCvN28lcq7a6grZRUNgV/s4Tqsar8w4a55MpEU
         HK+wFd8y4KnhMl8yxZI1VkVO/MCbAlI6k+Lg7NwG9XBLyNO8ceDVEY0TaRYpFiYkMbaD
         wiEk9ZaYjmglbIjimP00Y2xr2/hYGdLarkWdvi/9A79RWSFyAG6MSSSBFiJxAH7gbIuY
         EMFQ==
X-Gm-Message-State: AOAM532QSXx/94Z9re2AIIi7gIhTWjvXWGiLQQlcWIn3RhVmXVxFTa8+
        Ml8OCazPvrMx/wPSgw8LhxU+JYB0rL/YuIwTbF4=
X-Google-Smtp-Source: ABdhPJyYrWIGZUKMt0BSk3MntCjtvxsWjGr/pshTWbxymBr5n5Yeb0oG2eoConQ8JmoQLge5D2qeM72hwKUHisAYu+8=
X-Received: by 2002:a2e:b606:: with SMTP id r6mr2573928ljn.327.1615560135802;
 Fri, 12 Mar 2021 06:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20210312122531.2717093-1-daeho43@gmail.com> <YEtg8U7whCVV2tQt@kroah.com>
 <CACOAw_zhZ0OgT-KCBmD_H6_U=CZCNY44D-ojH2AZah2cbAvdAQ@mail.gmail.com>
 <YEt00vJ6oVfoRjSJ@kroah.com> <CACOAw_yjyy+58B=RawAaQO98NQB43roZOv4sq5313sFHN1myXQ@mail.gmail.com>
In-Reply-To: <CACOAw_yjyy+58B=RawAaQO98NQB43roZOv4sq5313sFHN1myXQ@mail.gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 12 Mar 2021 23:42:04 +0900
Message-ID: <CACOAw_wipL_SHyKp+56SOx99LnBZsrWq2eRmLm7Bz16jEYM8zg@mail.gmail.com>
Subject: Re: [PATCH v4] f2fs: add sysfs nodes to get runtime compression stat
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So, do you want we protect the values here with spin_lock and just
read without spin_lock in sysfs read part?

2021=EB=85=84 3=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 11:37, =
Daeho Jeong <daeho43@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> As you can see, if we're doing like the below.
>
> sbi->compr_written_block +=3D blocks;
>
> Let's assume the initial value as 0.
>
> <thread A>                                             <thread B>
> sbi->compr_written_block =3D 0;
>
> sbi->compr_written_block =3D 0;
> +blocks(3);
>                                                                + blocks(2=
);
> sbi->compr_written_block =3D 3;
>
> sbi->compr_written_block =3D 2;
>
> Finally, we end up with 2, not 5.
>
> As more threads are participating it, we might miss more counting.
>
> 2021=EB=85=84 3=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 11:04=
, Greg KH <gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
> >
> > On Fri, Mar 12, 2021 at 10:56:13PM +0900, Daeho Jeong wrote:
> > > Thanks for suggesting me sysfs_emit().
> > >
> > > For atomic values, actually, those are needed for writer part, not re=
ader.
> > >
> > > +#define add_compr_block_stat(inode, blocks)                         =
   \
> > > +       do {                                                         =
   \
> > > +               struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);       =
     \
> > > +               int diff =3D F2FS_I(inode)->i_cluster_size - blocks; =
     \
> > > +               atomic64_add(blocks, &sbi->compr_written_block);     =
   \
> > > +               atomic64_add(diff, &sbi->compr_saved_block);         =
   \
> > > +       } while (0)
> > >
> > > I needed a protection here, because they might be updated in the race=
 condition.
> >
> > Why?  What are you trying to protect from "racing" here?
> >
> > thanks,
> >
> > greg k-h
