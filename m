Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554C643476D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJTI5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229764AbhJTI5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:57:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECD4361004;
        Wed, 20 Oct 2021 08:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634720105;
        bh=PCVaDpH+mrpLD0GnvIKW+142iEL4rJTf3kGqaYnQ0Rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yyrrTIfkiLCiG1EoFREEO6IG9ruiFtqAxzrmETyg6LcZUPtgzSCrjQhIbbwKJHunb
         vSRM96Q3aHW14dqoxfdiUp2gzLk2NJz6nccOpRi3H3Pn/P+kNl8mWVD+nlVHT0jyz3
         aW/gFSPAtSXQtLWkstyDBvrQwLIKkkP5GY6UkCFE=
Date:   Wed, 20 Oct 2021 10:55:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: Rename `by_preamble_type` parameter
Message-ID: <YW/ZZho43B6tbys+@kroah.com>
References: <20211020084033.414994-1-karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020084033.414994-1-karolinadrobnik@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 09:40:33AM +0100, Karolina Drobnik wrote:
> Drop `by` prefix in the first parameter of `bb_get_frame_time` function.
> As the original argument, `byPreambleType`, was renamed to `preamble_type`,
> the parameter referring to it is now renamed to match the new naming
> convention.
> Update `bb_get_frame_time` comment to reflect that change.
> 
> This patch is a follow-up work to this commit:
>     Commit 548b6d7ebfa4 ("staging: vt6655: Rename byPreambleType field")

There is no need for these two lines in the changelog text.  They can go
below --- if you want to have them.

But, as the above commit is already in my tree, there's no need for this
information at all, right?

thanks,

greg k-h
