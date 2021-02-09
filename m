Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77834314A73
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 09:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhBIIhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:37:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:46332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhBIIgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:36:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B25F064E92;
        Tue,  9 Feb 2021 08:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612859725;
        bh=WhtliDAb1YWPH5oA6TUFSHepoThSC8K19vPVZAq5nQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzDC5Lt3hlfx+Hlye0wq0H6n2sZ+i7ckHjRAh2tXn+HXS7dyadoF3H/M40MYAkdjD
         WE7LPJiAtMMlb9tDSyYvAZfl2aZJlnuyL/bhBqlxxupQyGDalmfrSxuHPF3atGMzJn
         T30LnVbZWS3rTjcwWQdrm89/N+XY8zsbv08d+Btw=
Date:   Tue, 9 Feb 2021 09:34:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs second pull request for kernel 5.12
Message-ID: <YCJJCx/0wudJ0JbV@kroah.com>
References: <20210208163022.GA5745@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208163022.GA5745@CORE.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 06:30:22PM +0200, Oded Gabbay wrote:
> Hi Greg,
> 
> This is habanalabs second pull request for the merge window of
> kernel 5.12.
> It contains important fixes, especially in the firmware-related code.
> Details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit 369aea84595189200a2e6b028f556a7efa0ec489:
> 
>   mei: implement client dma setup. (2021-02-06 15:48:11 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2021-02-08

Pulled and pushed out, thanks.

greg k-h
