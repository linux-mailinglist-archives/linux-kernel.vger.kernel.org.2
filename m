Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E231430F6F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbhBDP4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:56:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237598AbhBDP4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:56:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC35E64F4D;
        Thu,  4 Feb 2021 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612454117;
        bh=ZhEBPMssfCd7XwlmDVrblEWo2dqcEt97b0rplNHIeuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPj4xRuPdQ+c2zGuJEpoa+t62ZJx9m1moXBPY4Fo3pBFIZKM/hMUYY6utZrPpMXc0
         ajcDSPhuLa/HmF/inhY9qrJj6y9VfpLGK7ZIRefVSzh4sjaDkhKZxOQWKpsRfJZHz9
         DzFkHWL+U2NrHz657ICBwrh01u+2ROt9pJR4+ziw=
Date:   Thu, 4 Feb 2021 16:53:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.12
Message-ID: <YBwYkazovF664H6M@kroah.com>
References: <20210127192922.GA7803@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127192922.GA7803@CORE.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 09:29:22PM +0200, Oded Gabbay wrote:
> Hi Greg,
> 
> This is habanalabs pull request for the merge window of kernel 5.12.
> It contains changes and new features, support for new firmware.
> Details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit 0fc99422bc034de018607ef6b70f92d4bc4a236d:
> 
>   firmware: xilinx: Remove PM_API_MAX value (2021-01-26 19:38:54 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2021-01-27

Sorry for the delay, now pulled and pushed out.

greg k-h
