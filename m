Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62C844BCA0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhKJINw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:13:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:35132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230006AbhKJINu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:13:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28B7261052;
        Wed, 10 Nov 2021 08:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636531863;
        bh=BBjQtxjd+p51t3Jc7H1e6LC25QvgFXdTNenm7EdSd4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p0E8KL7OCj8xp1dFKx5c0BhMkAwZFORpJc8AHTfsDUROqvcNgoHZQvmR8wE6YV8JQ
         +t6sKkUwFiUVjk5TsqSXxevsNt+npqJRIFw/gAVdzi10nD+D5Z76NoKb0bYYX6opwR
         nKdan/MLahvYqbjwov0CWI8Dg3HwPNoeXJLFAb6I=
Date:   Wed, 10 Nov 2021 09:11:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Yao <yao.jing2@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] usbip: vudc: Replace snprintf in show functions with
 sysfs_emit
Message-ID: <YYt+lXdjBqX6YecN@kroah.com>
References: <20211110023244.135621-1-yao.jing2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110023244.135621-1-yao.jing2@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 02:32:44AM +0000, cgel.zte@gmail.com wrote:
> From: Jing Yao <yao.jing2@zte.com.cn>
> 
> coccicheck complains about the use of snprintf() in sysfs show
> functions:
> WARNING use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf, snprintf or sprintf makes more
> sense.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>

Again, same coments as on the staging driver change.
