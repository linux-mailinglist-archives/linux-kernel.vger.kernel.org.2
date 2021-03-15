Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416DF33AC5C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 08:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhCOHgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 03:36:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229828AbhCOHgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 03:36:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2D7264DAF;
        Mon, 15 Mar 2021 07:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615793773;
        bh=D528rbfLh8zZTCX5u9fbw/DucSrt77tO+DqrXHDn2V0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dO1mcP97ftKFPgeb+DhHYDSMl3wP2m9IFi9wQaJY92FA8J6kLfRItewVib2a0LMLp
         RXl+EWsucIUkZAa0s/bkOPJ8WbTPadWsSSv1a7c8d8TZYGLvdWGu48N7BoN2XWKKu1
         DUQTzr9zXRGs28SRw6Pi8AHbjpytILixMDEkgji8=
Date:   Mon, 15 Mar 2021 08:36:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Hongren Zheng (Zenithal)" <i@zenithal.me>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Alexandre Demers <alexandre.f.demers@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        usbip-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] docs: usbip: Fix major fields and descriptions in
 protocol
Message-ID: <YE8Oan2BmSuKR4/p@kroah.com>
References: <YE6/HQoxkraowTI7@Sun>
 <YE78SRefRe1trldP@Sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE78SRefRe1trldP@Sun>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 02:18:49PM +0800, Hongren Zheng (Zenithal) wrote:
> The old document for usbip protocol is misleading and hard to read:
>   * Some fields in header are incorrect
>   * Explanation of some fields are unclear or even wrong
>   * Padding of header (namely all headers have the same length) is
>     not explicitly point out, which is crucial for stream protocol like
>     TCP
> 
> These fixes are made through reading usbip kernel drivers and userland
> codes. Also I have implemented one usbip server.
> 
> Major changes:
>   * Document the correct field as described in the codebase.
>   * Document the padding in usbip headers. This is crucial for TCP
>     stream hence these padding should be explicitly point out.
>     In code these padding are implemented by a union of all headers.
>   * Fix two FIXME related to usbip unlink and Document the behavior
>     of unlink in different situation.
>   * Clarify some field with more accurate explanation, like those
>     fields associated with URB. Some constraints are extracted from
>     code.
>   * Delete specific transfer_flag doc in usbip as it should be
>     documented by the URB part.
>   * Add data captured from wire as example
> 
> Also some changes suggested by a previous patch in
> https://lore.kernel.org/linux-usb/20180128071514.9107-1-alexandre.f.demers@gmail.com/
> is adopted in this patch.
> 
> Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Signed-off-by: Hongren Zheng (Zenithal) <i@zenithal.me>
> ---
>  Documentation/usb/usbip_protocol.rst | 290 +++++++++++++++------------
>  1 file changed, 159 insertions(+), 131 deletions(-)

What changed from v1?  Always list that here below the --- line.

> 
> diff --git a/Documentation/usb/usbip_protocol.rst b/Documentation/usb/usbip_protocol.rst
> index 988c832166cd..a15d9c1254e2 100644
> --- a/Documentation/usb/usbip_protocol.rst
> +++ b/Documentation/usb/usbip_protocol.rst
> @@ -5,8 +5,14 @@ USB/IP protocol
>  PRELIMINARY DRAFT, MAY CONTAIN MISTAKES!
>  28 Jun 2011
>  
> +Update: Fix major fields in protocol
> +14 Mar 2021

This does not belong here, the git changelog shows this information.

The original date above can be removed as well if you want.  And if the
mistakes are all fixed now, that line can be dropped too :)

thanks,

greg k-h
