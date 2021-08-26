Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5C73F83BE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 10:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbhHZI2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 04:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232992AbhHZI2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 04:28:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 786D2600CC;
        Thu, 26 Aug 2021 08:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629966476;
        bh=E/GIkrBn5BphzYFzZOnvFHAw2Op/qWr0so4ma1QeeAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1DptTjHUyMWlv+6mreVFTfg2EDM3kDtxIqDkN8p17AJph3F7TgqUu9+wEuK18McXg
         BY40n3Q6VOwt8V7qWLDgTNiGrjX939L9qlReXoTP9/wn2cTnUgkiWw5c7IeAREruxs
         UmLvtCZRwxEDsZXxTSZ3SBzoMmdemzvx2exz/CIo=
Date:   Thu, 26 Aug 2021 10:27:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 5.14-rc8
Message-ID: <YSdQiKGUqEAG0b8e@kroah.com>
References: <YSdNhWruPcclFUu9@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSdNhWruPcclFUu9@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 10:15:01AM +0200, Johan Hovold wrote:
> The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:
> 
>   Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.14-rc8

Pulled and pushed out, thanks.

greg k-h
