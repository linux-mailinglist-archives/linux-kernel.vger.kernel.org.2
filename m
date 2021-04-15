Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA2736034F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhDOH3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231241AbhDOH3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:29:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5935611F1;
        Thu, 15 Apr 2021 07:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618471729;
        bh=8o7VZnjPkPwZMae4GI6SJw7WDLgUFYz+v82i4LP4MXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gm1QWcAW5RPP1QCUSzZV5xqevFjbXGWqUseSn/tH9SGZqy/aWXZudTXoYYrZP6yYM
         zAHTo2amU1xhcAgxWJSElIS8VyXe2kbI8K1uOXbnLHgiq0s+wHERKS8oojQVfB3vs2
         PhviDKhPTSgppW1MpzPBYWWkrluk2MFt3AkY+9VI=
Date:   Thu, 15 Apr 2021 09:28:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Outreachy kernel] [PATCH v4] staging: rtl8723bs: Remove
 led_blink_hdl() and everything related
Message-ID: <YHfrLoot3iJSpAHU@kroah.com>
References: <20210415071731.25725-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415071731.25725-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 09:17:31AM +0200, Fabio M. De Francesco wrote:
> Removed useless led_blink_hdl() prototype and definition.
> Removed struct LedBlink_param. Removed LedBlink entries in
> rtw_cmd_callback[] and in wlancmds[]. Everything related to LedBlink is
> not anymore needed. Index of slots changed in arrays comments to reflect
> current positions.
> 
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Reported-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> Changes from v3: Merged the series into one single patch for avoiding
> unnecessary intermediate stages.

Much better, thanks for sticking with this.  Now queued up, and I think
this is going to be the last patch I take for 5.13-rc1.  The rest I'll
store up for the next kernel release after that...

thanks,

greg k-h
