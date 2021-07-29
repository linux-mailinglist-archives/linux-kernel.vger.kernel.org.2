Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1099F3DA0A7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhG2JzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233574AbhG2JzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:55:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2A83600D1;
        Thu, 29 Jul 2021 09:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627552504;
        bh=6MCZQOWDwAjXZLFKP7B3hl83n9ZGDtph9tn8wBRmULU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIAv2Sqm257OoIchknyzr+koxjpnIgSzOavCzdvj4Wq6RbdU8JG+3NHUXuaAPUFIf
         h1jPJThC1qt6yZ7MSGeVFz70pm/uMKohmm21eUOc7vhRDWjmT68n86enWdU43VEaIZ
         wxwWkp4BPFkQJOvwYmkO1kRPEwRXcUU4+jDE8q0g=
Date:   Thu, 29 Jul 2021 11:55:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: patch suggestion: Kconfig symbols
Message-ID: <YQJ69m8rb8KiiTEI@kroah.com>
References: <295b8f8c-4264-9f32-6723-9d2d574021ac@infradead.org>
 <e77e2329bdafdbea538be0d7edb8a9d7d3e45990.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e77e2329bdafdbea538be0d7edb8a9d7d3e45990.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 08:37:26AM -0700, Joe Perches wrote:
> drivers/staging/vt6655/device_cfg.h:#define CONFIG_PATH            "/etc/vntconfiguration.dat"
> drivers/staging/vt6656/device.h:#define CONFIG_PATH                     "/etc/vntconfiguration.dat"

This can be removed right now, I'll go do that, this is totally
unused...

thanks,

greg k-h
