Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADE431DC20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhBQP0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:26:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:49888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233630AbhBQPTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:19:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91BF664E33;
        Wed, 17 Feb 2021 15:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613575147;
        bh=Z/8o6XErFXuKuW0v3Bgjxn/zs7WUGSBupjAHS/gFS1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wutHLT0IHHsyt5UuPU/Zx+D68xEklbpYzP27fZ9IxqxHHEr+8jtZobEG4lxrL6eQN
         4Rr00wrEXTDoYoQBOZKbwNYS23zLt4v2AsglSeKaO/4QtLuAsqT9oWeOFRIcJH9kSY
         WCQAM1qsFVK2eOKFbPYlZ3UcrQQR5392wIo286RY=
Date:   Wed, 17 Feb 2021 16:19:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mayanksuman@live.com
Cc:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        rcy@google.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gasket Fix comparision with Null
Message-ID: <YC0z6PP2g/Raq80H@kroah.com>
References: <PS1PR04MB2934DD6390C8B16DB832BC97D6869@PS1PR04MB2934.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS1PR04MB2934DD6390C8B16DB832BC97D6869@PS1PR04MB2934.apcprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 06:58:16PM +0530, mayanksuman@live.com wrote:
> From: Mayank Suman <mayanksuman@live.com>
> 
> The change was suggested by checkpatch.pl.

What change?

Please read the section entitled "The canonical patch format" in the
kernel file, Documentation/SubmittingPatches for a description of how to
write a good changelog text.

thanks,

greg k-h
