Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4D4424E3A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 09:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240448AbhJGHpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 03:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbhJGHpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:45:54 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D85CC061755
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 00:44:01 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id y28so5798424vsd.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J5MitxDy+0H9+Hdt9WDFvZicHxHGsD1a80GgYOJsjVg=;
        b=c6lI7pFqiczF2Ff2onEgRJQw9MJ5EyY4HgiVZI+81mj4MhCxupIgf8uI0rlm/EWL4j
         ac5eVhn+M6gxDI06/kXAhmcEXcv3IZve/52m5P5/oRGkp8yHbor4ZtcYvxGxgVLXjWgh
         i8A37sO1Unf8qWKg7QKOJn4wP+FOMfAO/VYW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J5MitxDy+0H9+Hdt9WDFvZicHxHGsD1a80GgYOJsjVg=;
        b=1YG7K8crozTnggIjm6PAe6De5iDlIDTvx9R3OO+FE+i0G6+sX27uqPlGCrtXlqin8D
         BEKpu6H4E5QLIsKLKVgbhOMYtsatHWXC6E2yGIvgnuVevqfueppH5ot3EOjvWXQbs1CO
         M2gpv7h8guEn4ZvCWFASBsmJQrI6jhuHhfrT3weDXA49n108jkQVfoFTDYNzmYbXvi16
         MAL2FUpRPkCMgPcz0A3+qRgpenu2WmkQ2Xd2sG5mUfcZ9RR5FgngyhCjWWcyYeIhPwts
         KDnpCUuwcjMLj/9BzBwzm2nMeyoGAITRQokXbjhS1vSbamCTg4bJTs3oCj30DJKkFCXm
         z8Pg==
X-Gm-Message-State: AOAM533gp2TL1LmTdTvmqHJsukK6mqk0b0Yvzphv2s9etEjJajhySiSi
        Xq61vWdFa6j32nCq/PUH31vv/Qo+f77N+RDAx2K3+Q==
X-Google-Smtp-Source: ABdhPJyQUTZ7iKY7lhTqtwDlpw3BaQP5aBddRrEU6QGr6+JxHsPfkaB8dfwIPwU+g/bWDbJ0zaHltLE9xPgcmKvPS50=
X-Received: by 2002:a05:6102:370c:: with SMTP id s12mr2672780vst.42.1633592640623;
 Thu, 07 Oct 2021 00:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210923130814.140814-1-cgxu519@mykernel.net> <20210923130814.140814-4-cgxu519@mykernel.net>
 <CAJfpegvh9if1tZOdnzn87JmDBZC0XBzf63NoOydkCGyX4ssaag@mail.gmail.com> <c7bf6194-2613-0245-e133-8b6ad1386eb8@139.com>
In-Reply-To: <c7bf6194-2613-0245-e133-8b6ad1386eb8@139.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 7 Oct 2021 09:43:49 +0200
Message-ID: <CAJfpegvpG9MM4m3ZY8RS2h7CGekRMZdMSrNEYYadkNN_xyAy-w@mail.gmail.com>
Subject: Re: [RFC PATCH v5 03/10] ovl: implement overlayfs' ->evict_inode operation
To:     Chengguang Xu <cgxu519@139.com>
Cc:     Chengguang Xu <cgxu519@mykernel.net>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 at 08:08, Chengguang Xu <cgxu519@139.com> wrote:
>
> =E5=9C=A8 2021/10/6 23:33, Miklos Szeredi =E5=86=99=E9=81=93:
> > On Thu, 23 Sept 2021 at 15:08, Chengguang Xu <cgxu519@mykernel.net> wro=
te:
> >> Implement overlayfs' ->evict_inode operation,
> >> so that we can clear dirty flags of overlayfs inode.
> >>
> >> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> >> ---
> >>   fs/overlayfs/super.c | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> >> index 51886ba6130a..2ab77adf7256 100644
> >> --- a/fs/overlayfs/super.c
> >> +++ b/fs/overlayfs/super.c
> >> @@ -406,11 +406,18 @@ static int ovl_remount(struct super_block *sb, i=
nt *flags, char *data)
> >>          return ret;
> >>   }
> >>
> >> +static void ovl_evict_inode(struct inode *inode)
> >> +{
> >> +       inode->i_state &=3D ~I_DIRTY_ALL;
> >> +       clear_inode(inode);
> > clear_inode() should already clear the dirty flags; the default
> > eviction should work fine without having to define an ->evict_inode.
> > What am I missing?
>
> Yeah, you are right, we don't need overlayfs' own ->evict_inode anymore
>
> because we wait all writeback upper inodes in overlayfs' ->sync_fs.

Okay, I dropped this patch then.

Thanks,
Miklos
