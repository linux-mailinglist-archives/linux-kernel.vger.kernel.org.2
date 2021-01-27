Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AFE305DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 14:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhA0Nxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:53:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232486AbhA0Nwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:52:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 633032074D;
        Wed, 27 Jan 2021 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611755519;
        bh=JF5TlDZRR0Gah+FV8gwiJ/9IJZq8Lw6RRJVjyCiEUfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gmiuS7AnX4qO1a/NuuueqEdDLWjZXf3gUErpMddujZlMD1rJbZaoiJ7uUV42ygZZO
         /3dd3lBBeOou/Lx06YAsYbobqmegUKIDiG8uq3b7hI/bmB0yL50AA7FFMwrMqMtCC5
         yQhc1Dv9TACleyQPpOIB9f5BgqjGaUU4pmRdmLes=
Date:   Wed, 27 Jan 2021 14:51:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        mh12gx2825@gmail.com, oliver.graute@kococonnector.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sbrivio@redhat.com, colin.king@canonical.com,
        zhangxuezhi1@yulong.com
Subject: Re: [PATCH v10] staging: fbtft: add tearing signal detect
Message-ID: <YBFv+12xfsoxacDb@kroah.com>
References: <1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 09:42:52PM +0800, Carlis wrote:
> From: zhangxuezhi <zhangxuezhi1@yulong.com>
> 
> For st7789v ic,when we need continuous full screen refresh, it is best to
> wait for the TE signal arrive to avoid screen tearing
> 
> Signed-off-by: zhangxuezhi <zhangxuezhi1@yulong.com>

Please slow down and wait at least a day between patch submissions,
there is no rush here.

And also, ALWAYS run scripts/checkpatch.pl on your submissions, so that
you don't have a maintainer asking you about basic problems, like are in
this current patch :(

thanks,

greg k-h
