Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8334BC48
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 14:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhC1MNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 08:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhC1MNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 08:13:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 070B161969;
        Sun, 28 Mar 2021 12:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616933587;
        bh=jo5enAknEV4a+Va77/aGwWkIJzKoGh9dP5i8ca2yuY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bIaoQCYDzI2iWxwSmLhjFjF5vAcoZX0xDzUfKNSI89LTLqmjPM/kSVZSwGy4RYkHM
         +i61ewtF/qTxCmMnTZwBsm4cMkMwdN2Fz8kPYVT9aYhWlsIzVOXExr1O+bT2/7evCV
         5leLwwsGEXm6V83zycetmXRJTQAnczYopaWJhn/U=
Date:   Sun, 28 Mar 2021 14:13:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     min.li.xe@renesas.com
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 2/2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <YGBy0LfM5z+8GCpU@kroah.com>
References: <1616772851-29774-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616772851-29774-1-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 11:34:11AM -0400, min.li.xe@renesas.com wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> This driver is developed for the IDT ClockMatrix(TM) and 82P33xxx families
> of timing and synchronization devices.It will be used by Renesas PTP Clock
> Manager for Linux (pcm4l) software to provide support to GNSS assisted
> partial timing support (APTS) and other networking timing functions.
> 
> Current version provides kernel API's to support the following functions
> -set combomode to enable SYNCE clock support
> -read dpll's state to determine if the dpll is locked to the GNSS channel
> -read dpll's ffo (fractional frequency offset) in ppqt
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> Change log
> -rebase change to linux-next tree
> -remove uncessary condition checks suggested by Greg
> -fix compile error for x86_64

Where is patch 1/2 of this series?

Also, please fix up the errors that the testing bot found, and properly
version your patch submission so I know which one is the "latest" one to
look at.

thanks,

greg k-h
