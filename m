Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AC545DA12
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352686AbhKYMdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:33:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345004AbhKYMbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:31:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C6FA61074;
        Thu, 25 Nov 2021 12:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637843302;
        bh=c6XrtSt+7tVxiYxPHL5gzsTXTdIfYjn9rP6f1kfJk7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mDamCPimpQUp5wCP8aJp9An3+y9xq8r2aiiru7LpRTuRSJi9quedYmHck7JyCzBgA
         j03+JGiY5bTbQYmsTvi0fzp5sD/6QqiCSDn68CwF+RD2lcdbNMaAs4/1c9xCVeMubJ
         hYSvkRhIgwaHMNtuhPDWl8683OxG1XOKGQlhPibY=
Date:   Thu, 25 Nov 2021 13:28:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 5.16-rc3
Message-ID: <YZ+BWehxNBVbyqfV@kroah.com>
References: <YZ97xbN1Ln83r+hP@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ97xbN1Ln83r+hP@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 01:04:21PM +0100, Johan Hovold wrote:
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.16-rc3

Pulled and pushed out, thanks.

greg k-h
