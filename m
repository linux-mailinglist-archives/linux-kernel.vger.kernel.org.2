Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE063FD843
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbhIAK57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238899AbhIAK56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:57:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3CB161008;
        Wed,  1 Sep 2021 10:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630493822;
        bh=s2mntapYKc4wxoNjhgx3I5J0jpY1HLtydr90GsKktcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3zp+/6nZdYxaUU7aEtU76BE7rUEOZEHFb0jxLQbp+n3aqK3iBLnfyLN2+Fu3Xamx
         XVEPsjv7XXTjjXbrFA/Ur74eLOJycQ/4FWuOTPiOLJjRRFFzmUBbnx3EqV//Ppql1e
         //qk/had16tBLcuNbv8Qy/CzgNt7OTiNW2h7V84M=
Date:   Wed, 1 Sep 2021 12:56:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     ebiggers@google.com, stable-commits@vger.kernel.org
Subject: Re: Patch "ubifs: report correct st_size for encrypted symlinks" has
 been added to the 5.4-stable tree
Message-ID: <YS9ce4EKVEGQb995@kroah.com>
References: <163049356719157@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163049356719157@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 12:52:47PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     ubifs: report correct st_size for encrypted symlinks
> 
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

Breaks the build, now dropping.
