Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4547A320A5E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 14:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhBUNEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 08:04:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhBUNEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 08:04:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CA2C64F03;
        Sun, 21 Feb 2021 13:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613912606;
        bh=+8YJso1d5U+qmCHLYyOR3A9yiMaPev5dqfSzbqYDd1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MWmg+Fbo2n4LLziiIcpqRyPwVFqLA8GaK7oPTw/ouQ6Bap9+C5IwWZbJFPy8p7nky
         HhDzv87oMXlwY6g1Owyee4RHpITBKpxLFvEvRYbG8nFQdOHZmwsK8gwkUvM50jBlaL
         AU3cw2MHrkHbzmPZRzaXJYsLdHbVJIuw6vCW4NaM=
Date:   Sun, 21 Feb 2021 14:03:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nikolay Kyx <knv418@gmail.com>
Cc:     sergiu.cuciurean@analog.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/02] staging: kpc2000: code style: fix alignment
 issues
Message-ID: <YDJaHNsT9zta2up2@kroah.com>
References: <YC92OIgh6HTEexu4@kroah.com>
 <20210219163411.24873-1-knv418@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219163411.24873-1-knv418@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 07:34:11PM +0300, Nikolay Kyx wrote:
> This patch fixes the following checkpatch.pl check:
> 
> CHECK: Alignment should match open parenthesis
> 
> in files kpc2000_i2c.c kpc2000_spi.c
> 
> Signed-off-by: Nikolay Kyx <knv418@gmail.com>
> ---
> 
> Additionally some style warnings remain valid here and could be fixed by
> another patch.
> 
> v2: Edited changelog, as suggested by Greg KH <gregkh@linuxfoundation.org>
> v3: Splitted patch in two parts, as suggested by Greg KH <gregkh@linuxfoundation.org>

You sent 2 different patches, that did different things, yet have the
same exact subject line :(

Please fix up and resend.

thanks,

greg k-h
