Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A8C40D2DC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 07:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhIPF1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 01:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234298AbhIPF1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 01:27:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AB7361130;
        Thu, 16 Sep 2021 05:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631769974;
        bh=+QwIs8lMVd8wd8UB6Nx4ivNCClKmvJpy7RLokCXUfaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X6LeVqdZpmpFVRJ+0Nv5JtBts+b8gB78yse4SxHkWXNSHdHYI/M/M0aZ7rDuHrl92
         6pYtKAQpI5z1ClUsWWR15HXgKse234ybCp50osMyf0V0i10i0vABgY8og2i8iSFA2u
         LOJ9C1Hav6HYFQXmOi/5NNziwcnz89ybS2vdwO4k=
Date:   Thu, 16 Sep 2021 07:25:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     min.li.xe@renesas.com
Cc:     arnd@arndb.de, derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        linux-kernel@vger.kernel.org, lee.jones@linaro.or
Subject: Re: [PATCH misc v2 2/2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <YULVYrvUM+JQils9@kroah.com>
References: <1631731629-20862-1-git-send-email-min.li.xe@renesas.com>
 <1631731629-20862-2-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631731629-20862-2-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 02:47:09PM -0400, min.li.xe@renesas.com wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> This driver is developed for the IDT ClockMatrix(TM) and 82P33xxx families
> of timing and synchronization devices.It will be used by Renesas PTP Clock
> Manager for Linux (pcm4l) software to provide support to GNSS assisted
> partial timing support (APTS) and other networking timing functions.

Where is that software?

Why is this new api not a standard one?

What is the standard here?

What do other devices do and why is this a new api?

> Current version provides kernel API's to support the following functions
> -set combomode to enable SYNCE clock support
> -read dpll's state to determine if the dpll is locked to the GNSS channel
> -read dpll's ffo (fractional frequency offset) in ppqt

Why do all of these have to be in the kernel at all?

thanks,

greg k-h
