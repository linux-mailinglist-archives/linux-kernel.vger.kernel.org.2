Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C9A39FB32
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhFHPxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56709 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230425AbhFHPxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623167469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C7EvR7VdOAZ/iLmKH20fyJ3KSzctR8QK2Dmq7ETeypw=;
        b=SLO8eAAruK0BwLejKPD92+dejE+5fOBhNtNo1WouE29DENJb7ScUVEKcs9IoiRYLKEIPqm
        ziAq+u54vdMOlitrG4AU1SzZU1S6xHyqTC4kY6/WbkkMlj9frXmTWRwSxo8Xai5PDWIYtZ
        4p3vgdhBCS5WPlhC2Eh20zxVKt5PCZ8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-I_AAKKjiNbapL0oXrJcPCg-1; Tue, 08 Jun 2021 11:51:06 -0400
X-MC-Unique: I_AAKKjiNbapL0oXrJcPCg-1
Received: by mail-wr1-f71.google.com with SMTP id v15-20020a5d4a4f0000b0290118dc518878so9654896wrs.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 08:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=C7EvR7VdOAZ/iLmKH20fyJ3KSzctR8QK2Dmq7ETeypw=;
        b=Hu1AuptmCByA1zOh8s4CGXyNvElDBr/h/vZP80eQbOqbrvq3QPeQpVuVqX/FMpM+1S
         hvLMaaViBk4rOZWWptndOPAbugEi24pxZSI62b7urSx9E6YeoU1IijdbLjFu+xub/79K
         cAAjCAZsGbBUndkKVvciy4ZoiW1cIlsMYcAw+/2fWvkMofHp67gcs7KsP/1vVQoW6pwV
         QJ7ezmDqIW+IH4xXdKGs3kEbNSRr1J7ggl0RBt8cjtZ0525V0DazeVqa92yQzYTXd/YB
         4dKTiT1vhSTDNLrB2Jz/gfURzTQi+d3Mqec4/+wUaBeA41k3t9ny4f2FPP5mhXd7YEz/
         oTCQ==
X-Gm-Message-State: AOAM5303mjt7t9c4IFSTz5ox5s8Y6dwE+/bHt/0Rh4E8gUn3BBuwGPQ3
        zPugqkScGbpGu5fH6aSl5QjNd/t+PKbLAeM6ootZQNvSqyZNwle8Nqp5rWqQqbmrfO2tET/YdvL
        PxiP8zSbA3XBSAUe2dCIN5gjy
X-Received: by 2002:a1c:a917:: with SMTP id s23mr18629725wme.55.1623167464981;
        Tue, 08 Jun 2021 08:51:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWwxLZ+NJIT7rS1RBKo6fZIJ6pPJ5Jyz5Cfr4Q7NDJ2Qxk2hRHkprTl0V4yJJcD7Y+ypyeOg==
X-Received: by 2002:a1c:a917:: with SMTP id s23mr18629719wme.55.1623167464880;
        Tue, 08 Jun 2021 08:51:04 -0700 (PDT)
Received: from dresden.str.redhat.com ([2a02:908:1e46:160:b272:8083:d5:bc7d])
        by smtp.gmail.com with ESMTPSA id s62sm3589591wms.13.2021.06.08.08.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 08:51:04 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] fuse: Switch to fc_mount() for submounts
To:     Greg Kurz <groug@kaod.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, Vivek Goyal <vgoyal@redhat.com>
References: <20210604161156.408496-1-groug@kaod.org>
 <20210604161156.408496-7-groug@kaod.org>
From:   Max Reitz <mreitz@redhat.com>
Message-ID: <0d3b4dfb-2474-2200-80d1-39dcbf8f626e@redhat.com>
Date:   Tue, 8 Jun 2021 17:51:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210604161156.408496-7-groug@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.06.21 18:11, Greg Kurz wrote:
> fc_mount() already handles the vfs_get_tree(), sb->s_umount
> unlocking and vfs_create_mount() sequence. Using it greatly
> simplifies fuse_dentry_automount().
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   fs/fuse/dir.c | 26 +++++---------------------
>   1 file changed, 5 insertions(+), 21 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index b88e5785a3dd..fc9eddf7f9b2 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -311,38 +311,22 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
>   	struct fs_context *fsc;
>   	struct vfsmount *mnt;
>   	struct fuse_inode *mp_fi = get_fuse_inode(d_inode(path->dentry));
> -	int err;
>   
>   	fsc = fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry);
> -	if (IS_ERR(fsc)) {
> -		err = PTR_ERR(fsc);
> -		goto out;
> -	}
> +	if (IS_ERR(fsc))
> +		return (struct vfsmount *) fsc;

I think ERR_CAST(fsc) would be nicer.

Apart from that:

Reviewed-by: Max Reitz <mreitz@redhat.com>

