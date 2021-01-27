Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA37E305DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhA0ONx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:13:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:38200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233526AbhA0OIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:08:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85FFB2100A;
        Wed, 27 Jan 2021 14:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611756489;
        bh=yqGnxCx5oZvyrJm+gp7Zb+WXFEubWq9jM3h88+rjhyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iiDc6+xJvbdEqFiw0ZJd2eElatv9eP3dsYLHwWFb8xr2IUduGaRXSjNB53x91t2rz
         ZrXEyf4QE5UphvjfxbriUuiyARobfGjoKmk5G1/pPet2DJSi0GaXDgDV0u8G7v2ce5
         tyWgkMtFhXeO8t3RhTyj43UPZlzBg52JIu5jWWm8=
Date:   Wed, 27 Jan 2021 15:08:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        mh12gx2825@gmail.com, oliver.graute@kococonnector.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sbrivio@redhat.com, colin.king@canonical.com,
        zhangxuezhi1@yulong.com
Subject: Re: [PATCH v11] staging: fbtft: add tearing signal detect
Message-ID: <YBFzxucgqJCX8IBO@kroah.com>
References: <1611756149-165287-1-git-send-email-zhangxuezhi3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611756149-165287-1-git-send-email-zhangxuezhi3@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 10:02:29PM +0800, Carlis wrote:
> From: zhangxuezhi <zhangxuezhi1@yulong.com>
> 
> For st7789v ic,when we need continuous full screen refresh, it is best to
> wait for the TE signal arrive to avoid screen tearing
> 
> Signed-off-by: zhangxuezhi <zhangxuezhi1@yulong.com>

Again, slow down, and wait for comments before responding so quickly, as
you missed all of my review...

greg k-h
