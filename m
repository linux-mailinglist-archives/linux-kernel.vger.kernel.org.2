Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086F0350EF0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhDAGTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:19:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233179AbhDAGS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:18:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4A6A61055;
        Thu,  1 Apr 2021 06:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617257939;
        bh=gElSOjVtdc12CvdtDDqcH/JZDoE/IjGq/ZL89JJmA8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qazVuY12Z7GQo4LuwH7zfuOkbFSCrlB0MiSCGOfW4Q/+peGkmsJt1qFBjaU7yrAph
         66wYbh035nLFZY2T7xBGRPd38BFC6PwqrPslKwE3ignIH81PFA/SsU/BF95hgmUtVd
         4weBss3xgRRZikYccwqZU08AX+5fIdLzVSNlsIto=
Date:   Thu, 1 Apr 2021 08:18:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: vmw_vmci: initialize payload passed to
 vmci_send_datagram()
Message-ID: <YGVlzj5UAWkQVH8j@kroah.com>
References: <20210401055747.3820-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401055747.3820-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 02:57:47PM +0900, Tetsuo Handa wrote:
> KMSAN complains that the vmci_use_ppn64() == false path in
> vmci_dbell_register_notification_bitmap() left upper 32bits of
> bitmap_set_msg.bitmap_ppn64 member uninitialized.
> 
> KMSAN also complains that vmci_check_host_caps() left the payload part
> of check_msg uninitialized.

So shouldn't this be two separate patches?

thanks,

greg k-h
