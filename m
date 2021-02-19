Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C911C31F5E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 09:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBSI2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 03:28:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhBSI1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 03:27:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79B1664E4B;
        Fri, 19 Feb 2021 08:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613723195;
        bh=yq7EMrqicWJGN6iPmLcD64zNky2vncuQfURBBO9inNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WSOKodGbNLeJKH21rNc8oq5P92HuU/J0iZgKZYySCGYjp1Tz4HL/0gpeCiFbyKgIU
         WmKCSR9ohHDoncrazCTKtqaJVydEhmy+OGjDXjwaq9eUZi6cO/f6mRKRT6Ms8jWvVF
         6FsVzRYfh48UAk8uu0PAguFZPw6wzbFGZwh80Ixo=
Date:   Fri, 19 Feb 2021 09:26:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nikolay Kyx <knv418@gmail.com>
Cc:     sergiu.cuciurean@analog.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: kpc2000: code style: fix alignment issues
Message-ID: <YC92OIgh6HTEexu4@kroah.com>
References: <YC7TiCzbB+4ppzdk@kroah.com>
 <20210219080451.19857-1-knv418@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219080451.19857-1-knv418@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:04:51AM +0300, Nikolay Kyx wrote:
> This patch fixes the following checkpatch.pl warnings:
> 
> WARNING: line length of 124 exceeds 100 columns
> CHECK: Alignment should match open parenthesis

That's two different things, please make this two different patches.

thanks,

greg k-h
