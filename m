Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1A945CBD0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350405AbhKXSJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:09:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351552AbhKXSJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:09:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C53416102A;
        Wed, 24 Nov 2021 18:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637777172;
        bh=Yd2zzwjkxvXr2lz7EPUopzKeueXmqiiyttONU7uA5bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/+OaFVRWIpV6LXo1I7SGELZaYlpiLjirLRnT+ZyYu2G/Yus9a7W35hx56LKI3Zv7
         LKifUznPip3eAMf8mAMUC9sYimLzzvVzzI11DxLiLIm6Dk5LnR+E1McWKSNiO04Z4j
         KAwWKPwWp5v3/AT2etAmQMg+LcELtQb/krbPTjeOSw2CszZflAIA26sseo3jNdl1aN
         oaohsFfgHxa9M15e7voCdFo/MmDjnZpc+lyzhEL1EhdgXSF0Ueh8Xk45O1jhc/YxoJ
         T9oCwKUTS3STJUYvxGg3IunqKkvbMaoaUbWsCQiMb3nXyW7Ho9sNPWhDDAnrVB/Ntl
         5Ldvn9pMepY8A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mpweY-00017I-6K; Wed, 24 Nov 2021 19:05:54 +0100
Date:   Wed, 24 Nov 2021 19:05:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mingjie Zhang <superzmj@fibocom.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] USB: serial: option: add Fibocom FM101-GL variants
Message-ID: <YZ5/AvKK6lPFo/vm@hovoldconsulting.com>
References: <20211123133757.37475-1-superzmj@fibocom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123133757.37475-1-superzmj@fibocom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 09:37:57PM +0800, Mingjie Zhang wrote:
> Update the USB serial option driver support for the Fibocom
> FM101-GL Cat.6
> LTE modules as there are actually several different variants.
> - VID:PID 2cb7:01a2, FM101-GL are laptop M.2 cards (with
>   MBIM interfaces for /Linux/Chrome OS)
> - VID:PID 2cb7:01a4, FM101-GL for laptop debug M.2 cards(with adb
>   interface for /Linux/Chrome OS)
> 
> 0x01a2: mbim, tty, tty, diag, gnss
> 0x01a4: mbim, diag, tty, adb, gnss, gnss
> 
> Here are the outputs of lsusb -v and usb-devices:

> Signed-off-by: Mingjie Zhang <superzmj@fibocom.com>
> ---
> Changes in v3:
>   - Add the usb device infomation
>   - Make the entry in sort order (VID,PID)
> 
> Changes in v2:
>   - Add the description of the corresponding interface
>   - Blacklist the adb interface

Now applied, thanks!

Johan
