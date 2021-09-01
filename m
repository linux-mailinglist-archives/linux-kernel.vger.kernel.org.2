Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893A83FD83E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbhIAK5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:57:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236816AbhIAK5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:57:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1721261056;
        Wed,  1 Sep 2021 10:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630493799;
        bh=D2u+zzdSV0fm2GeMLI8r/Ki9VsZpodpq1yr4TDh8f7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOJEbYiypRpEvsUIB/tAcAqPkBLqpIlF7A+0SK3Uh7ZwEhfIWytqnTBBu6vxHGOWm
         eczxjdE3wKIyO5o/qbydCCs8/WOr2JZwI0lRp29ELbCLGwvasppZf0Cre1Q8+eNG+1
         y86nPnEwFQFo6rjdD0X7mrgjShfRE+7Ha4OOdvSc=
Date:   Wed, 1 Sep 2021 12:56:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     ebiggers@google.com, stable-commits@vger.kernel.org
Subject: Re: Patch "ext4: report correct st_size for encrypted symlinks" has
 been added to the 5.4-stable tree
Message-ID: <YS9cZQ5ElZU2uJ2N@kroah.com>
References: <1630493566211247@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630493566211247@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 12:52:46PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     ext4: report correct st_size for encrypted symlinks
> 
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

Nope, breaks the build :(
