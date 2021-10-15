Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF0C42E98E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbhJOHBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232270AbhJOHBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:01:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 178BA6108B;
        Fri, 15 Oct 2021 06:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634281146;
        bh=9z0dR3D3D7TMKMx2B0oPkFhP6DQ3gTm16QqQoHLMboM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvWJZN1d4Kd5Hhnm41gYoFmagWIcu/CtGhxd24TrUocdXVefSViqfYJLiyxVFaLBv
         3yTOCRKMO2AOY7TrFo1z4pwJ3kQPOQ2l9LBFfwVdtgTK+OsfvkVKKGiQDKSrE2py13
         lyGlxeBrhVgGA9mB+VaRUETaea5WQzWiwrIMj0/o=
Date:   Fri, 15 Oct 2021 08:59:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: vt: replace snprintf in show functions with
 sysfs_emit
Message-ID: <YWkmt6NePIUnNUXf@kroah.com>
References: <1634280696-5056-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634280696-5056-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 11:51:36PM -0700, Qing Wang wrote:
> show() must not use snprintf() when formatting the value to be
> returned to user space.

Again, who is making this "must" requirement?

I, as the sysfs maintainer, am not saying that all existing show
functions MUST be converted, so I find it hard to believe that someone
else is...


> 
> Fix the following coccicheck warning:
> drivers/tty/vt/vt.c:3902: WARNING: use scnprintf or sprintf.
> drivers/tty/vt/vt.c:3910: WARNING: use scnprintf or sprintf.

Someone needs to change this warning to show the correct thing here.

thanks,

greg k-h
