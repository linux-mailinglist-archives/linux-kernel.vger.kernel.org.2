Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15603D72F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbhG0KSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:18:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236098AbhG0KSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:18:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A00A8615A6;
        Tue, 27 Jul 2021 10:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627381111;
        bh=A7qBZch1Jg2+ovWxWu1HL0c/yuEfhiAGxh72KvH6fPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZlr4g1JkRK0vKnNnWuK1Zx1rHDSdq0bvDQ3LSc/W12+//cfU/8kuu2gCjR328vVj
         Y5C8AHVX9L3zYHwIaVmOshU9QQYZ0yhokYThrcChqtVtL93wxg2fiqSLGS42BfC94T
         OU+nG2xFLgfbZm+Pt377eLAW3Iu9KtAj+AEyKzK8=
Date:   Tue, 27 Jul 2021 12:18:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Get rid of old tty_driver functions
Message-ID: <YP/dbe2n1HVbbxIg@kroah.com>
References: <20210723074317.32690-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723074317.32690-1-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 09:43:09AM +0200, Jiri Slaby wrote:
> This series converts the rest of the drivers to use:
> * tty_alloc_driver instead of alloc_tty_driver, and
> * tty_driver_kref_put instead of put_tty_driver.
> 
> They were more of less interchangeable, alloc_tty_driver() and
> put_tty_driver() are older interfaces which weren't eliminated until
> now.

Nice, thanks for cleaning this up!

greg k-h
