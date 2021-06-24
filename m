Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF6E3B34DB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 19:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhFXRhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 13:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhFXRhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 13:37:10 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF60C061574;
        Thu, 24 Jun 2021 10:34:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id mj3so3336498ejb.4;
        Thu, 24 Jun 2021 10:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+1dHCIjVGu+VUQzg64ApXX1v4ulkFxMzGJoEo7mlEN8=;
        b=AARHRFZK4+BCpIFSAR4Ai01+dvIC2tHWRomTVTb1qj8A98A4rj7a7RL0a1YxshGXjS
         ylJERtxccirnh2JtFVERSbZqjqFkZv151h58DU7fxtNvk1ymxTwBWWxeK4CRSorRYFX3
         ZH3KmSFqkl+0HpUw+VOEJPP+aZsXVDgdooZjimavAs28OTJ+5nW7jqV+w2VtbIyI875S
         JDEA8jR5UG1z465hHft34VuKxHIYrEfwcZwk6JTrJ/qGaWKaRZPXFasqE5z8e2nzzQMG
         uXVmd7OVicFr2VZlaFpLatGxVSRkMPTjImm4rK45atjpd8bgjoYlhpjMHni+J2lrE74m
         44vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1dHCIjVGu+VUQzg64ApXX1v4ulkFxMzGJoEo7mlEN8=;
        b=YULjqUZyxxazIk8p+0A/+qIXMwMwKdDJDfAPBrh+IUiB2lRqcaJOulpFqach9816zQ
         qIxoKUoZqcWZ4UTgEGMV00HJim2I1YbCuaC0+BLJfA9wvl4ax3b8SBiWvHT1WlCA4T2W
         0KMl0wrGO3DFi0KjjSwv2EajNCT4HiKQRWVxIE3Y1e+c7AYTIq3cyFtj83vmINI+kHNr
         oY9ZDRkRpJpCJwUcARgwWqvHLoM6yoQLtR75oK6KAWjj0bJ9cSADENQaLWpybz3QWptx
         FJVLdOrVOqtfJ9nuiLYwhwqKLeEYuGehzVeYaebXyIWMfGy9YEM93Su726nTWFOuh7JF
         Dd0w==
X-Gm-Message-State: AOAM533cPMkcaPFR4UUePffJVONIA7m2J+YNUB8EwzUclj7lPbdoZxqb
        TB9tzfCVyW9KOqG8Eeb5HB5pMjynjP5nsK3jCOM=
X-Google-Smtp-Source: ABdhPJwtErtzq1+hHcQMB5rM9v6vcBduXUsJyHaoWqc3HwRhLcDrty3aCQ7bdHIlsFcpiQypqmQkzot764eK+TZffv8=
X-Received: by 2002:a17:906:3d3:: with SMTP id c19mr6297403eja.202.1624556090041;
 Thu, 24 Jun 2021 10:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210621100519.10257-1-colin.king@canonical.com>
In-Reply-To: <20210621100519.10257-1-colin.king@canonical.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 25 Jun 2021 02:34:38 +0900
Message-ID: <CAKFNMomw60BGObwF2ZOFriFwPnEk5hFZgC-5vJwJjPnrW3RyPw@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: remove redundant continue statement in a while-loop
To:     Colin King <colin.king@canonical.com>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you.  This change is correct also in view of the expected
behavior of the function
(it really is unnecessary).
I will send this to upstream.

Regards,
Ryusuke Konishi

On Mon, Jun 21, 2021 at 7:05 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The continue statement at the end of the while-loop is redundant,
> remove it.
>
> Addresses-Coverity: ("Continue has no effect")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/nilfs2/btree.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
> index f42ab57201e7..ab9ec073330f 100644
> --- a/fs/nilfs2/btree.c
> +++ b/fs/nilfs2/btree.c
> @@ -738,7 +738,6 @@ static int nilfs_btree_lookup_contig(const struct nilfs_bmap *btree,
>                         if (ptr2 != ptr + cnt || ++cnt == maxblocks)
>                                 goto end;
>                         index++;
> -                       continue;
>                 }
>                 if (level == maxlevel)
>                         break;
> --
> 2.31.1
>
