Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899AF3FAA12
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 10:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhH2ILh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 04:11:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232155AbhH2ILe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 04:11:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9424C608FB;
        Sun, 29 Aug 2021 08:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630224643;
        bh=9rYyvMODTtObBSqfSrojxx5ZQ0pfDpovtGm0HkyPW+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTMOJ1BPPUlIrSn2F8oIoxKLOdios+4mn8o9NzIbO4jTn2M7EVvPyN3axtkf2tsyl
         GuUIKwIb4mFGDK73Kxc9dyYdIwiWj0JcF2207IKV/SXLJagOg0xp1HjUktx5OVO5Bh
         oekl86pa23iMYDXd2i6H5hHeDlRB266LjAYBLIhc=
Date:   Sun, 29 Aug 2021 10:10:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, ross.schm.dev@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH v3] staging: r8188eu: core: remove null check before vfree
Message-ID: <YStA+Yts2hG6eoMV@kroah.com>
References: <YSs4fvzUw1PK4C9+@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSs4fvzUw1PK4C9+@user>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2021 at 01:04:22PM +0530, Saurav Girepunje wrote:
> Remove NULL check. NULL check before freeing function is not needed.
> Correct the indentation.
> 
> ChangeLog V3:
> -Added change log.
> 
> ChangeLog V2:
> -Correct the indentation.

Please put this information below the --- line, as the documentation
says to do.

thanks,

greg k-h
