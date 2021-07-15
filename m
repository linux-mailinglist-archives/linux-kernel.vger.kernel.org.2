Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C80B3C9A36
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239787AbhGOINf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231655AbhGOINe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:13:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 330B5610D1;
        Thu, 15 Jul 2021 08:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626336640;
        bh=rKCR00UG/qw5FUHKpBMFkLO1eC1tLjMCz6QzQc0jzfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dMzQ/nK+v5/YHQsG39gOzjPIhC4/mL/kEO1MXg+9vj9NytAjO9JDdNom01GIirdBI
         NEoQMexS6QUh3UwWA2leXiSGrnkLGe2aLgp+JCBt3SdROWrF303aPngb5xQvoP59wt
         KrVmrqt+lx/GtyclskAIP5/LeIvw7XFGb4GnjJUU=
Date:   Thu, 15 Jul 2021 10:10:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jia He <justin.he@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Felipe Balbi <balbi@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chen Lin <chen.lin5@zte.com.cn>, linux-usb@vger.kernel.org
Subject: Re: [PATCH RFC 10/13] usb: gadget: simplify the printing with '%pD'
 specifier
Message-ID: <YO/tfvKCKwiIk5n9@kroah.com>
References: <20210715031533.9553-1-justin.he@arm.com>
 <20210715031533.9553-11-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715031533.9553-11-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 11:15:30AM +0800, Jia He wrote:
> After the behavior of '%pD' is changed to print the full path of file,
> the log printing in fsg_common_create_lun() can be simplified.
> 
> Given the space with proper length would be allocated in vprintk_store(),
> it is worthy of dropping kmalloc()/kfree() to avoid additional space
> allocation. The error case is well handled in d_path_unsafe(), the error
> string would be copied in '%pD' buffer, no need to additionally handle
> IS_ERR().
> 
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Chen Lin <chen.lin5@zte.com.cn>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  drivers/usb/gadget/function/f_mass_storage.c | 28 ++++++++------------
>  1 file changed, 11 insertions(+), 17 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
