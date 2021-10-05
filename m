Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF78E421F50
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhJEHRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230526AbhJEHR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:17:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EC5561506;
        Tue,  5 Oct 2021 07:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633418138;
        bh=AWOoDnZwAjqHTNASt9nix/Q85Dw8cfXYbiHOK3MMejM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=csL4m8QH45VKFthT1lySjOv83vntsdiv83yC4cMo+cxzwDMydDBDJOfyx311AsbRl
         +PQ8q+0nSL/dXhHkl5EjqjJM35dFer3UPpwkrqTodyFuF5eZxRTQYjuh/imV6J8Afc
         aBSXK+jUjxrNmoV5QoQM4yrjky/Fcv+pFEhgoL9Q=
Date:   Tue, 5 Oct 2021 09:15:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, cuibixuan@huawei.com,
        syzbot+f3e749d4c662818ae439@syzkaller.appspotmail.com, yhs@fb.com,
        stable-commits@vger.kernel.org
Subject: Re: Patch "bpf: Add oversize check before call kvcalloc()" has been
 added to the 5.14-stable tree
Message-ID: <YVv7mCe4eQ23X8Bx@kroah.com>
References: <163341735610637@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163341735610637@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 09:02:36AM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     bpf: Add oversize check before call kvcalloc()
> 
> to the 5.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      bpf-add-oversize-check-before-call-kvcalloc.patch
> and it can be found in the queue-5.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Oops, this is already in the tree, dropping it...

greg k-h
