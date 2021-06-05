Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A1E39C4F0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 04:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhFECEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 22:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhFECEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 22:04:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B9D9613BF;
        Sat,  5 Jun 2021 02:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622858577;
        bh=r4EcPxMJSzOnJumoMVDFIEmBiosX3pqnj+rFFKZBTdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FjKa4X0QV01OweMLfCz0TTewqTcl6egVJWc2mp0IcCUaSoGJzARjsVyOla9pxZjj3
         rdJtQjz0dLc+E5jqGH47SDe++quTm5n7wfLb08ol+TZFXf0HE23Bu/dux2JEZ84etk
         Cz9Oj4vqYJylSd0aBVQ5M9czWqSagDxF2lYOmLJNJc3DeZlh//33XjqwpDT5TJLbMw
         +nrUrrfFyLoopuNTObNYavgzY8CgeuY4uW2aLxSogc9IJ9q1GP6WdKoEqtk+Qo2LdA
         ne5HzTjF9IubV9BiSlks7yn4OsShh8tMKKOLBoWtHyoa7Y1+FH41CEu82VztDTt6ij
         jiLd5oX4Tk+CA==
Date:   Fri, 4 Jun 2021 19:02:56 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: clean up
 /sys/fs/f2fs/<disk>/features
Message-ID: <YLrbUHfOa3zfwmNs@gmail.com>
References: <20210605003210.856458-1-jaegeuk@kernel.org>
 <20210605003210.856458-3-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605003210.856458-3-jaegeuk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 05:32:10PM -0700, Jaegeuk Kim wrote:
> +What:		/sys/fs/f2fs/feature/

features/, not feature/.

> +/*
> + * Note that there are three feature list entries:
> + * 1) /sys/fs/f2fs/features
> + *   : shows runtime features supported by in-kernel f2fs along with Kconfig
> + *     - ref. F2FS_FEATURE_RO_ATTR()
> + *
> + * 2) /sys/fs/f2fs/$s_id/features <deprecated>
> + *   : shows on-disk features enabled by mkfs.f2fs, used for old kernels
> + *
> + * 3) /sys/fs/f2fs/$s_id/feature_list
> + *   : shows on-disk features enabled by mkfs.f2fs per instance.
> + *     this list covers old feature list provided by 2) and beyond
> + *     - ref. F2FS_SB_FEATURE_RO_ATTR()
> + */

It would be helpful to make it clear which of these use the one-feature-per-file
convention and which use the comma-separated features convention.  And also
whether future features will be listed in both (2) and (3), or just in (3).

Otherwise this patch looks good -- thanks!

- Eric
