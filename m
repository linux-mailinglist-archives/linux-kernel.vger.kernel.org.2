Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A633C6ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 12:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbhGMKtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 06:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235529AbhGMKta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 06:49:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B095F61249;
        Tue, 13 Jul 2021 10:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626173200;
        bh=c9UpD6VZOUpDPPoTB+sO8WLxQ5mV4CmewAARcqcWFBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXOurKHbRYOYrrnKlHBccQTTxtCsNLJwFzHb55/RtZia4O9xE0GnCkJfWCdjHX6xf
         PyT2TMloBOUxxg2PAjc7pnl2qiodzxTxCXdfgUtbuEu/sZtvKAbrkNbw6Ag+Lw0VvA
         Stu5OpPGpU9soCMlr3IMG/IpJ8g/abVIcFTxfW5M=
Date:   Tue, 13 Jul 2021 12:46:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v1] base: soc: export soc_device_to_device API
Message-ID: <YO1vDJP9UPOliyzL@kroah.com>
References: <20210713081255.17308-1-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713081255.17308-1-alice.guo@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 04:12:55PM +0800, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Driver which uses soc_device_to_device needs to be built as a module, so
> export this API.

What in-kernel driver needs this?  I have not seen any build errors,
where were they reported?

thanks,

greg k-h
