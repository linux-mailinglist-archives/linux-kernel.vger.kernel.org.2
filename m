Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90ED1447295
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 11:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbhKGKxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 05:53:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232174AbhKGKxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 05:53:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3A6561054;
        Sun,  7 Nov 2021 10:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636282267;
        bh=HogiSAqNJk+tKE5Ovu3L13MarfHIAETawLX1pm7B1Nk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WqhSWadJjjbHO4b6yRU4i+ZxOSAAtJcaR9rXjZi7/6B4iNgxewqRk+f/72I7eTfXC
         8YOCyeZsIgbQ1CZiM2Vz6YVWKpo+CvGjaQzD+3K07VDDEwuPBBh3C703lNLJVRn+7r
         KOaDOXLZCziZkijIOCQn91ncpb270kBMefmKhJkw=
Date:   Sun, 7 Nov 2021 11:51:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Coresight fix for v5.16
Message-ID: <YYevmBXnYNFYSzjO@kroah.com>
References: <20211105224714.1873452-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105224714.1873452-1-mathieu.poirier@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 04:47:14PM -0600, Mathieu Poirier wrote:
> The following changes since commit 561ced0bb90a4be298b7db5fb54f29731d74a3f6:
> 
>   arm64: errata: Enable TRBE workaround for write to out-of-range address (2021-10-27 11:46:06 -0600)
> 
> are available in the Git repository at:
> 
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-fixes-v5.16

Pulled and pushed out, thanks.

greg k-h
