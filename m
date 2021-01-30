Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1023092E6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhA3JJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:09:13 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:56112 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbhA3JIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 04:08:07 -0500
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Jan 2021 04:07:49 EST
Received: by isilmar-4.linta.de (Postfix, from userid 1000)
        id 4BCA3200EB0; Sat, 30 Jan 2021 07:18:25 +0000 (UTC)
Date:   Sat, 30 Jan 2021 08:18:25 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: Make syscalls' helpers naming consistent
Message-ID: <20210130071825.GA26647@isilmar-4.linta.de>
References: <20210130014547.123006-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210130014547.123006-1-andrealmeid@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 10:45:46PM -0300, André Almeida wrote:
> The documentation explains the need to create internal syscalls' helpers,
> and that they should be called `kern_xyzzy()`. However, the comment at
> include/linux/syscall.h says that they should be named as
> `ksys_xyzzy()`, and so are all the helpers declared bellow it. Change the
> documentation to reflect this.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Fixes: 819671ff849b ("syscalls: define and explain goal to not call syscalls in the kernel")
> Signed-off-by: André Almeida <andrealmeid@collabora.com>

Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
