Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B343F5F85
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbhHXNwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237656AbhHXNwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:52:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EC6061245;
        Tue, 24 Aug 2021 13:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629813117;
        bh=BaSafuoLyFX1koX4yvN+9fdgKZm1oDFEONIYSNud8pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MhNkCXnSBjZX3GTX1BVwlXDWJfd8n/VqC+ajtwa9RY/mmV2rc3zW06FvPs+XabGcy
         8fuk10x86N+EoiWJr1e+nbi/YJEgIjIQLL8WgMU+STOQFAV27FoPSdJXiwlrg4DeyZ
         QLblRyGj1cRvONJIV+nDc7DMWj31i+71EkVnZWQw=
Date:   Tue, 24 Aug 2021 15:44:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     oakad@yahoo.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tifm: switch from 'pci_' to 'dma_' API
Message-ID: <YST3o3eGCw/ek4lm@kroah.com>
References: <fa6cc76718abf0a546e2e9bd9509ea6e495aadd6.1629658403.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa6cc76718abf0a546e2e9bd9509ea6e495aadd6.1629658403.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 08:54:24PM +0200, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> The patch has been generated with the coccinelle script below.

And again, why is this needed?
