Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC31367D99
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbhDVJVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhDVJVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:21:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F9D461445;
        Thu, 22 Apr 2021 09:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619083268;
        bh=swUHc5wvkzaAa5SxdaBYmZWrNcqVhsRIxe6jTiGy4uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tFdJIreeDMW2ApKStU2K3MXDVsc99nU4FSIBOj2UAYRHe81wgks8EZ0DckgEBeaoJ
         RARApqWlpyPqnEOJ0ik1YXYEZud+NvfC3PFiT2r9m7rh2qfQLOJgOE12DmfzZTfk2K
         UmzZycQkSw7FoBqs60wnyrLjWpNMkQhxTtqbFX7I=
Date:   Thu, 22 Apr 2021 11:20:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial updates for 5.13-rc1
Message-ID: <YIE/09NMpOd1O5bb@kroah.com>
References: <YIE4lPAcXV1qYT64@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIE4lPAcXV1qYT64@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 10:49:24AM +0200, Johan Hovold wrote:
> The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:
> 
>   Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git usb-serial-5.13-rc1

Pulled and pushed out, thanks.

greg k-h
