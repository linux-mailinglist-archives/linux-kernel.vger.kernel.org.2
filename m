Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334E4411200
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 11:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbhITJmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 05:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234983AbhITJme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:42:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5BEA60F58;
        Mon, 20 Sep 2021 09:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632130809;
        bh=8tiTnLVffN6ZWxDDdUg5QGF6UzX0ktUwJLwWv0V7DrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MCXx/mm/qbozdDv7d85aMaP6gsUPDqVzN5tbx4oHi2956ZScaqYlUMAFPyYPiAce2
         Xu1YYqnjDw2qiybyIDboUJWc/SYtR8Y6lDavlpl2rhEKT7I2zWGES7lOOPJnUUoDFK
         T6K+bP6vbbZgJctZLxJHCLGnm5Sf9T9aqaTdkpy+Fi6joTp7GBkfRQYk78BApwO6rY
         OqRkjD5sAGp6eVrKndV2LPeY8AAxpSTI9+OzkuTrw6pn4cRXwDFJLDS/qo+0tWY1HU
         BitbtZ3PjjyPfbMPhQY8wHicmf1VmEtzD7RpDN2AyOPqkz0JuhbTql0Zu0Vlm5nX14
         CRsCjBgQvDgaQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mSFmR-0000oA-TZ; Mon, 20 Sep 2021 11:40:08 +0200
Date:   Mon, 20 Sep 2021 11:40:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/30] ABI: sysfs-class-gnss: use wildcards on What
 definitions
Message-ID: <YUhW9wbwnAXIj+oN@hovoldconsulting.com>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
 <80b7f60a6bac7bb1938d60dca509d75dff3c2c62.1631782432.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80b7f60a6bac7bb1938d60dca509d75dff3c2c62.1631782432.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 10:59:44AM +0200, Mauro Carvalho Chehab wrote:
> An "N" upper letter is not a wildcard, nor can easily be identified
> by script, specially since the USB sysfs define things like.
> bNumInterfaces. Use, instead, <N>, in order to let script/get_abi.pl
> to convert it into a Regex.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Johan Hovold <johan@kernel.org>

> ---
>  Documentation/ABI/testing/sysfs-class-gnss | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-gnss b/Documentation/ABI/testing/sysfs-class-gnss
> index c8553d972edd..9650f3a7fc03 100644
> --- a/Documentation/ABI/testing/sysfs-class-gnss
> +++ b/Documentation/ABI/testing/sysfs-class-gnss
> @@ -1,4 +1,4 @@
> -What:		/sys/class/gnss/gnssN/type
> +What:		/sys/class/gnss/gnss<N>/type
>  Date:		May 2018
>  KernelVersion:	4.18
>  Contact:	Johan Hovold <johan@kernel.org>
