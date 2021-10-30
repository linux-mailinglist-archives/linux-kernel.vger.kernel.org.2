Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE4144080A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 10:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhJ3IwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 04:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhJ3IwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 04:52:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B02460FF2;
        Sat, 30 Oct 2021 08:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635583781;
        bh=6IXKLJ58+cyBCo43o4s3fVBxSUNZW/Xnmky9nWdIPCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C3fUa3YBDlzRo6YbM/CtnAvby+IjYkNlIqgd1lrybnb4R/pzWYBoOa9At/yOz4Gvm
         E9sjO5lP/0o9TRZjtlF3vVR/8rvRC2jWWYwBE6I6nqIDTZ8tTnF5LuXceqBJKZiZ0g
         H164VrbABPMsxVNEaCC2cTEOlpLCwuiKVoYyt4Pc=
Date:   Sat, 30 Oct 2021 10:49:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v3] Coresight changes for v5.16
Message-ID: <YX0HBPBig8HA558L@kroah.com>
References: <20211027195224.4005465-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027195224.4005465-1-mathieu.poirier@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 01:52:24PM -0600, Mathieu Poirier wrote:
> The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:
> 
>   Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)
> 
> are available in the Git repository at:
> 
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v5.16.v3

Much better, thanks!

Now pulled and pushed out.

greg k-h
