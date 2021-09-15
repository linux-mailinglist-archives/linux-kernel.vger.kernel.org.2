Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B877240CC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 20:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhIOSgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 14:36:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229718AbhIOSgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:36:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A5BC60F38;
        Wed, 15 Sep 2021 18:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631730881;
        bh=lKcVzRdaqApzkeUxpFpEvcJ5ti9y/x/HiAZFWw9uFXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PzZxzCzgd8ZGGijkkhdqkzlHitGSL8p7fnqUPr6gsuBNV9XePIXo+fZrXGY30UGhe
         78ovnTVelIO6NFLYV32kehgadoHbzDl+MfFJ3DfRGFdqKqt1t4uxZkTZlTNMUN55Ou
         S8HLHC+YNbPwFodBcbCFYpFVYjNBORFaDNYhErf8=
Date:   Wed, 15 Sep 2021 20:34:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     min.li.xe@renesas.com
Cc:     arnd@arndb.de, derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH misc v2 1/2] mfd: rsmu: Resolve naming conflict between
 idt8a340_reg.h and idt82p33_reg.h
Message-ID: <YUI8vxTny+2rPJlb@kroah.com>
References: <1631729480-20668-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631729480-20668-1-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 02:11:19PM -0400, min.li.xe@renesas.com wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  include/linux/mfd/idt82p33_reg.h | 148 ++++++++++++++++++++-------------------
>  1 file changed, 75 insertions(+), 73 deletions(-)


I can not take patches without any changelog text at all, sorry.

Also, did you cc: the needed mfd developers and maintainers and lists?

thanks,

greg k-h
