Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5992C3E1098
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbhHEIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232591AbhHEIyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:54:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 946756105A;
        Thu,  5 Aug 2021 08:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628153646;
        bh=e4/+u67PQLWbwRW/+Zo90jHnaAIdfNh2nVTTaCbQ3qE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xkXbelI7vGun57y5T2hN2gh55i0InDf6HEC85ue0T7rmTck/pmBIxplf6QHNVOW18
         0r/TvwuEkMCNVrK4HI3ADtkCtNJPXPK/l+MD40mHf2KkkfXVc3bT+F6+u8p/pFk2f8
         AcCyz+tM3YL7TEZfSpscqnKq+tEnDKyx94IIxyp8=
Date:   Thu, 5 Aug 2021 10:54:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 5.14-rc5
Message-ID: <YQunK2AvKEz/ysOz@kroah.com>
References: <YQuj0Nqq3YRXVLKh@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQuj0Nqq3YRXVLKh@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 10:39:44AM +0200, Johan Hovold wrote:
> The following changes since commit ff1176468d368232b684f75e82563369208bc371:
> 
>   Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.14-rc5

Pulled and pushed out, thanks.

greg k-h
