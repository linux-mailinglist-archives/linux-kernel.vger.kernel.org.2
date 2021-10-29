Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA8443FECB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 16:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhJ2O7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 10:59:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhJ2O7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 10:59:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 914DE610FD;
        Fri, 29 Oct 2021 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635519411;
        bh=bMV/1PbMJP7CtoklBvM/xAc1tZHuvQBwEa5ecHdlhxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9lRyc942+2VzO2kLrkvu99WBg+GULMB8lkSo+m1ayQclHq9rrjHOHup/PF0JTqKA
         POxT+S43Mu4iFn8PzTn8Kc2/suNF2nBihFaB32ABdBxZnKVTAPl1q04TmRIiSBAPGg
         FblJHPk15NeM+iq15oIhisbvjonPhWCKNiQr4C5Q=
Date:   Fri, 29 Oct 2021 16:56:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial updates for 5.16-rc1
Message-ID: <YXwLnTjevfTjM6hi@kroah.com>
References: <YXuu6YrDdp1E6Tpr@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXuu6YrDdp1E6Tpr@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 10:20:57AM +0200, Johan Hovold wrote:
> The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:
> 
>   Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.16-rc1

Pulled and pushed out, thanks.

greg k-h
