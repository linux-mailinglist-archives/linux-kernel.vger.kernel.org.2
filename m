Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58DD3C333B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 08:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhGJGhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 02:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhGJGhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 02:37:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE618611ED;
        Sat, 10 Jul 2021 06:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625898874;
        bh=oHDiNnrS3PM2micTiMuaBqRrE7hJHCyDRvav3f6SkgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNsdWZgRthAIaqhT3FWY2GFB+gz6CYGZai2NL2i3vFzopeGMorodM7zWZKA4GwfbR
         ieCc9RDELaDIinNh3Sv5WRnY/Ch89/DVwDISj3CzGXsFuf+t47h7DFVMahC3L1Tc4Q
         wNxF5+y+wz2oumaEGClMLUxhp8Kjpvb4X1e/jU+I=
Date:   Sat, 10 Jul 2021 08:34:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        gil.fine@intel.com, rajmohan.mani@intel.com,
        linux-usb@vger.kernel.org, Prashant Malani <pmalani@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: thunderbolt: Warning and 20 second delay in S4
Message-ID: <YOk/dzmF9sRg4uBn@kroah.com>
References: <CAE=gft50j2D_UmNNVOj-h6Hyi5ctMztAVDBP442SPinmCwcnpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft50j2D_UmNNVOj-h6Hyi5ctMztAVDBP442SPinmCwcnpw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 02:31:35PM -0700, Evan Green wrote:
> Hi Mika et al,
> 
> I'm experimenting with suspending to disk (hibernate) on a Tigerlake
> Chromebook running the chromeos-5.4 kernel. I don't have any USB4
> peripherals plugged in. I'm getting this warning, along with a 20
> second stall, both when going down for hibernate and coming back up.

5.4 is pretty old, especially for thunderbolt issues, can you try 5.13
please?

thanks,

greg k-h
