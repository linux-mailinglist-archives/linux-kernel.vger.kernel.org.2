Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B270D31FEA2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 19:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBSSOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 13:14:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhBSSOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 13:14:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F011064E44;
        Fri, 19 Feb 2021 18:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613758444;
        bh=UVlHOufbHUG8NtYLUcmOtrcd4LtJHVEv5SvtflqnwGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UMOrK8dK2xRwQejExH1w+/L6MNEu599tB7zzfsj1w2nALlRahDKa/CnrdOi9fQ15E
         xth+oqFXonZrKSqPIOnhvFZEmDkIWPvUigAoTk6vPQuHQMPFsW5OkffwGgqA43oBC0
         3oZqhbZbNbMQAhXnsDfUmtTI9AV+4fU7o3efpXVk=
Date:   Fri, 19 Feb 2021 17:25:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kurt Manucredo <fuzzybritches@protonmail.com>
Cc:     ross.schm.dev@gmail.com, straube.linux@gmail.com,
        dan.carpenter@oracle.com, d.straghkov@ispras.ru, tiwai@suse.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: fix code style comparison warning
Message-ID: <YC/mf97ypmGMdtSA@kroah.com>
References: <20210219144928.8-1-fuzzybritches@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219144928.8-1-fuzzybritches@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 02:50:53PM +0000, Kurt Manucredo wrote:
> 
> 
> changes since previous version:
> - change Subject line
> - change commit message
> - change commit message position to above signed-off-by

This all goes below the --- line please.

Please make a v3.

thanks,

greg k-h
