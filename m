Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C43309714
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 18:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhA3RHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 12:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhA3RHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 12:07:34 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93303C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 09:06:54 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id j25so13774640oii.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 09:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YXo72go/2zLQsVTpl/DsKgd0Ar0mz1CUAPeP2npE5kE=;
        b=p24tFRoL9u8Bbj8AzyFg1IzdFVT9w2G0IgE+5EYTPMPhClIkqzfafWHFbGVP5ctvlX
         llG6kzSpLCttKjPAEBTKhIdKiav6n83VWv1V8P2YNHPnlKmWBtKe8fM7pJ2IKbIelihc
         WKzl3wj4g8ide8bWXLfe18MenVkqvhsQENqwlIfQ3T4+6l662AecRf3T5cB18sMuzfDx
         qcuHFTGjgi4G1e9ElWEg8a7ilUOzPPiITsvnuFH88+pD24A3c4Uz9hcZxwxlfEwz+Nbi
         J+iRAaW5afGP6C5YAgtiXr7LFVpOdWeuzKEkW/qmJlAnCJWL9UXX6xsvxhUgHSwTVC6y
         /PUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YXo72go/2zLQsVTpl/DsKgd0Ar0mz1CUAPeP2npE5kE=;
        b=Yy5JOWw/NPaCFeKEW9UlGfPdY88O9rFewooiyrfXAZtJj8QQJIEGIt5rgQB8xtXpj4
         fBGXwvMiFnCsDWUlBha8KIB2VJoQCSAN7vGHm1Z3YtuQu+RyyEGXtX3m41Yw3Ypsykhy
         be9nWg3BIDd8cGxNyA7PYwGiXpCPPGmDMB41RuXT69MZ8cwBQTN7DyRlMckFoT0dApae
         JEmECXgRxP//PiHrIiv1XmruMH5vutV+x0l8+qCng6PO9rB5zeYzZmSdYJvCnRWpfMLI
         aqdw9PN2yryXxwxfyMWZie/ZUawh0qRH/jR0H5EEL9xD23K80Ois4sbXrIPmEAH0ZjrW
         X5YA==
X-Gm-Message-State: AOAM531vAoP3Nifdvp6YqkKpsRZqRLswNuPmMq4INvf4IsGbq6Fj7iZC
        XVUbE16HhrdiB8ihSF+TUqs/MvPMKay5QHoO
X-Google-Smtp-Source: ABdhPJxlPLzf6kK0PD4Pe+kPdvKZm30wSBoJzwsypQqW20OyjBGSnMclVR1AR7i10u3AZmiMImvDtw==
X-Received: by 2002:aca:dc56:: with SMTP id t83mr3454965oig.75.1612026413625;
        Sat, 30 Jan 2021 09:06:53 -0800 (PST)
Received: from elm (162-237-133-238.lightspeed.rcsntx.sbcglobal.net. [162.237.133.238])
        by smtp.gmail.com with ESMTPSA id c10sm2872961otm.22.2021.01.30.09.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 09:06:53 -0800 (PST)
Date:   Sat, 30 Jan 2021 11:06:40 -0600
From:   Tyler Hicks <code@tyhicks.com>
To:     Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
Cc:     ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Robertson <daniel.robertson@starlab.io>
Subject: Re: [PATCH] ecryptfs: Fix inodes not being evicted until unmount
Message-ID: <20210130170640.GA58096@elm>
References: <20201218190730.141761-1-jeffrey.mitchell@starlab.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218190730.141761-1-jeffrey.mitchell@starlab.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-18 13:07:30, Jeffrey Mitchell wrote:
> On asynchronous base filesystems like NFS, eCryptFS leaves inodes for
> deleted files in the cache until unmounting. Change call in
> ecryptfs_do_unlink() from set_nlink() to drop_nlink() in order to reliably
> evict inodes from the cache even on top of NFS.
> 
> Signed-off-by: Dan Robertson <daniel.robertson@starlab.io>
> Signed-off-by: Jeffrey Mitchell <jeffrey.mitchell@starlab.io>

Hey Jeffrey and Dan - thanks for the patch! Unfortunately, I think this
would allow the eCryptfs inode's nlink count to get out of sync with the
lower inode's nlink count in the case of direct manipulation to the
lower filesystem.

Is the condition that you're trying to fix a result of going through the
this code path?

 ecryptfs_unlink() -> ecryptfs_do_unlink() -> vfs_unlink() -> nfs_unlink() -> nfs_sillyrename() -> nfs_async_unlink()

Tyler

> ---
>  fs/ecryptfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index e23752d..f7594b6 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -147,7 +147,7 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
>  		goto out_unlock;
>  	}
>  	fsstack_copy_attr_times(dir, lower_dir_inode);
> -	set_nlink(inode, ecryptfs_inode_to_lower(inode)->i_nlink);
> +	drop_nlink(inode);
>  	inode->i_ctime = dir->i_ctime;
>  out_unlock:
>  	dput(lower_dentry);
> -- 
> 2.7.4
> 
