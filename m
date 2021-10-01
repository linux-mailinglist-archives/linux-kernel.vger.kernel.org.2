Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9B641F0F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354945AbhJAPP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354869AbhJAPP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:15:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EB1761A03;
        Fri,  1 Oct 2021 15:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633101223;
        bh=lBCw9bkSZZDHUXzzaKop+6Hnc/MB752lkrnFW0SX3Yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VldMVTz6nDca+vkVL8e0kiTzKzysrG6rFWnNAdrhL29IS+EMl5QwhGpw8dSZLXlBh
         RYbctzhceiSbuD4LaWuLtoUIuBQXVmxEPSlh4UE5F+8UMCNeglXC361wnol0MdUsAc
         ExxYnVHJCfPy1EhxNh6TSc2+qsyiFjynOVMT4zPg=
Date:   Fri, 1 Oct 2021 17:13:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] usb: Introduce Xen pvUSB frontend (xen hcd)
Message-ID: <YVclpB4HP4hynENV@kroah.com>
References: <20211001150039.15921-1-jgross@suse.com>
 <20211001150039.15921-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001150039.15921-3-jgross@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 05:00:38PM +0200, Juergen Gross wrote:
> --- /dev/null
> +++ b/drivers/usb/host/xen-hcd.c
> @@ -0,0 +1,1641 @@
> +/*
> + * xen-hcd.c

Need a SPDX line here, instead of the license boiler-plate text you
have.

Did you run checkpatch on this thing?  I thought that would have told
you about this.

> + *
> + * Xen USB Virtual Host Controller driver
> + *
> + * Copyright (C) 2009, FUJITSU LABORATORIES LTD.
> + * Author: Noboru Iwamatsu <n_iwamatsu@jp.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * Or, by your choice:
> + *
> + * When distributed separately from the Linux kernel or incorporated into
> + * other software packages, subject to the following license:
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to
> + * deal in the Software without restriction, including without limitation the
> + * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
> + * sell copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> + * DEALINGS IN THE SOFTWARE.

Dual licensing a USB host controller driver is, um, a very dubious
thing given that you can only interact with symbols exported with
EXPORT_SYMBOL_GPL() from the USB stack.

So you might want to change this...

If not, and you want to keep the dual license, I need some explaination
from a legal person at your company included in the changelog text, and
a signed-off-by from them as well.

thanks,

greg k-h
