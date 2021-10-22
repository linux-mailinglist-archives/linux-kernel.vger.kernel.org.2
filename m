Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0201343730C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 09:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhJVHtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 03:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231872AbhJVHs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 03:48:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5AAD610E7;
        Fri, 22 Oct 2021 07:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634888802;
        bh=8AJ7qqRACbX9zQxbSl9FpCVeB9+19zqFrEQF9r/04pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTowj1X/Ygs1uWd1DGg05Pe4qLs1+HVtz3CNouwaF7EwXOHmiPNYQEG9McztOygAZ
         HC7Hl3AxM2K5+mR7xIKwdZVTUxg+Su1QLh5ceOTAm/ARj7+ciiTMegwVQVWk+D6Z7S
         PlgufyvEo8IFugRskR9W8MSSFnusayXBLVqfpBe0=
Date:   Fri, 22 Oct 2021 09:46:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrewrjeffery@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eddie James <eajames@linux.ibm.com>
Subject: Re: [GIT PULL] fsi changes for v5.16
Message-ID: <YXJsVx5OvW8DO6Os@kroah.com>
References: <CACPK8Xf0_D6P8ru5-UyqXQsF9uTejks8E1O06+1qTs7_R7No1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xf0_D6P8ru5-UyqXQsF9uTejks8E1O06+1qTs7_R7No1w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 12:10:58AM +0000, Joel Stanley wrote:
> Hello Greg,
> 
> Here are a set of FSI changes targeting the v5.16 merge window. They
> have been through a few cycles of review on the list and appear ready
> to be merged.
> 
> There are some dependent hwmon changes that Guenter has acked and
> indicated he is ok with them going through the fsi tree.
> 
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> 
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-v5.16

Pulled and pushed out, thanks.

greg k-h
