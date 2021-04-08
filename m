Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4AC3584CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhDHNd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:33:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:48796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231641AbhDHNd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:33:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617888796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZCAAR5PzGD8iNhpsXMNf9MkZCpNGlBNFs3tk/riVX8=;
        b=bGysl1+D8zmpjXP6dw65BiFbX710NADXn+3OsqfjJSvPFm1b2IXCVmz7P8Rm+fHii6qyRn
        OvjXvFjfFyuE3c3tQmt8L7hleIWbHNwb6mp1FMxbH559fPzPoDinMJGYN9in3hTkJtHjW9
        62/JV4KF2A7hVdm2+YhOqArEwj31+Lw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 678B0B10B;
        Thu,  8 Apr 2021 13:33:16 +0000 (UTC)
Message-ID: <9e770cd03b69e06349f1b606317335cf49fe8fd6.camel@suse.com>
Subject: Re: [PATCH v2 3/3] USB: cdc-acm: fix TIOCGSERIAL implementation
From:   Oliver Neukum <oneukum@suse.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 15:33:04 +0200
In-Reply-To: <20210408131602.27956-4-johan@kernel.org>
References: <20210408131602.27956-1-johan@kernel.org>
         <20210408131602.27956-4-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 08.04.2021, 15:16 +0200 schrieb Johan Hovold:
> TIOCSSERIAL is a horrid, underspecified, legacy interface which for most
> serial devices is only useful for setting the close_delay and
> closing_wait parameters.
> 
> The xmit_fifo_size parameter could be used to set the hardware transmit
> fifo size of a legacy UART when it could not be detected, but the
> interface is limited to eight bits and should be left unset when it is
> not used.
> 
> Similarly, baud_base could be used to set the UART base clock when it
> could not be detected, but might as well be left unset when it is not
> known (which is the case for CDC).
> 
> Fix the cdc-acm TIOCGSERIAL implementation by dropping its custom
> interpretation of the unused xmit_fifo_size and baud_base fields, which
> overflowed the former with the URB buffer size and set the latter to the
> current line speed. Also return the port line number, which is the only
> other value used besides the close parameters.
> 
> Note that the current line speed can still be retrieved through the
> standard termios interfaces.
> 
> Fixes: 18c75720e667 ("USB: allow users to run setserial with cdc-acm")
> Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Oliver Neukum <oneukum@suse.com>

