Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BF23B786D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 21:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbhF2TQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 15:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbhF2TQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:16:20 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ED3C061766
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 12:13:52 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id t24-20020a9d7f980000b029046f4a1a5ec4so1898991otp.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 12:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IXvp6iYKQ7LnDZgY4w/YeVt41OnTxqbG05Qy728iqDQ=;
        b=XBe6ZNy9PinPV3StEvl00KHi2NGx4DwYVRdaw7sfW5C17MpRktVuuTgcyqre+nt+ad
         f7Xtb7JecKipWjzeAfQhChNAx2oHAK841c3lVi8OHGVsBbQN29bqdQg8T4Pg3yHju47S
         chdICXJHMFQTMGyHvXrPFw3tuQlmN/ujJiRyVgNoZoBdEkkKr3ZnRwbcEwGXlvY3jGU+
         a767VexQaeNRSbD48jFoCwPwYQ/NFc3hlBBbQb+NdrgOW0leYl6fOQHrUdamAQ5WArwu
         jy+/9M3YBlPs9H2asOze84NOpQDyX7318bXoJYNLUusR4T1Vp0ENPt0nUjbZgInMF5cO
         fwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IXvp6iYKQ7LnDZgY4w/YeVt41OnTxqbG05Qy728iqDQ=;
        b=l2VDBxEiFZYY8dz7jl2o5YmRYH1BMTCdVjsGLPOHjPsceZUlUc+cJAzwWvpd2mamAl
         xfPPvgSvmBm9tPAdSxrtviCxY1er0fxgzmjyDJ8ATDk1yxHm4uHeWtvYfMkNRWZuEZv1
         o2Zh49WDUAUhbRjw7jJIBQdzExOxiBVFpi7TGLwuPotUbBn0vd5HIf2qSiqx3hthjcnm
         ao5cg1ETSsf2mPl3OpNGDPL+yo7gkm0LE2LKo2x0WHlAzDYY/U9G2y60ZfiEFqhDJO4B
         L2CDDMkhPV7HzVoX3ahtxDBTKbywdFeaNySy2kgGNTT0cKa0kTWFd62Em473+dhig5SE
         3tRQ==
X-Gm-Message-State: AOAM533SoXQmeMSvbEXExF/Tldgcq6jgGOfYuzhMETyvg3nS9slLmaIK
        TuGL1RItKF5rbaFpy/XkM4UXDmXPcydq6asv
X-Google-Smtp-Source: ABdhPJz4Km15cqKpfqYG6bnFUHdFiJMXgnHFhUkf/d8pxk+AZBjQcf/VOpdyt5J1c7n79donpSlTrw==
X-Received: by 2002:a9d:2781:: with SMTP id c1mr5747720otb.34.1624994031775;
        Tue, 29 Jun 2021 12:13:51 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:f8e3:a853:8646:6bc8])
        by smtp.gmail.com with ESMTPSA id n72sm4101436oig.5.2021.06.29.12.13.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 12:13:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH 1/3] hfs: add missing clean-up in hfs_fill_super
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20210629144803.62541-2-desmondcheongzx@gmail.com>
Date:   Tue, 29 Jun 2021 12:13:46 -0700
Cc:     gustavoars@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <28CCF4E3-51D1-43BE-A2BA-4708175A59C0@dubeyko.com>
References: <20210629144803.62541-1-desmondcheongzx@gmail.com>
 <20210629144803.62541-2-desmondcheongzx@gmail.com>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 29, 2021, at 7:48 AM, Desmond Cheong Zhi Xi =
<desmondcheongzx@gmail.com> wrote:
>=20
> On exiting hfs_fill_super, the file descriptor used in hfs_find_init
> should be passed to hfs_find_exit to be cleaned up, and to release the
> lock held on the btree.
>=20
> The call to hfs_find_exit is missing from this error path, so we add
> it in to release resources.
>=20
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> ---
> fs/hfs/super.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 44d07c9e3a7f..48340b77eb36 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -419,6 +419,7 @@ static int hfs_fill_super(struct super_block *sb, =
void *data, int silent)
> 	res =3D hfs_cat_find_brec(sb, HFS_ROOT_CNID, &fd);
> 	if (!res) {
> 		if (fd.entrylength > sizeof(rec) || fd.entrylength < 0) =
{
> +			hfs_find_exit(&fd);

I see that there are several places of hfs_find_exit() calls in =
hfs_fill_super(). Maybe, it makes sense to move the hfs_find_exit() call =
to the end of the hfs_fill_super()? In this case we could process this =
activity of resources freeing into one place. I mean line 449 in the =
source code (failure case).

Thanks,
Slava.

> 			res =3D  -EIO;
> 			goto bail;
> 		}
> --=20
> 2.25.1
>=20

