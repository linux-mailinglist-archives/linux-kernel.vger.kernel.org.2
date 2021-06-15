Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010063A7DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFOLym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:32904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhFOLyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:54:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DBB260FF0;
        Tue, 15 Jun 2021 11:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623757957;
        bh=2VVHP822lYRhsSNsXyvBdgbGe+qUNXNXZeQE62K+LQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a96hfrEUA8l0XzuoZfIawv5nogIipX+rQ8tIuU88D9M2P1USHb2Ad39b/nPr4xT/k
         doz0ZYHzVpiSdzUbrS29RsWvJv60yzF6gXtbNZ/LdDw+2iqGkIl597CcNklFP+/fhs
         nf9UjxIVKb1f5uG5Yo2rQH4gQ2jW1TDQYUeDLQ24=
Date:   Tue, 15 Jun 2021 13:52:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jason Li <jason.li@cortina-access.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Message-ID: <YMiUgpRbfwMHCqD+@kroah.com>
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2021 at 11:45:16AM -0700, Alex Nemirovsky wrote:
> From: Jason Li <jason.li@cortina-access.com>
> 
> This driver supports Cortina Access UART IP integrated
> in most all CAXXXX line of SoCs. Earlycom is also supported
> 
> Signed-off-by: Jason Li <jason.li@cortina-access.com>
> ---

I can't take this without the DT maintainers acking the DT changes.

So can you resend this so that they can notice that it requires their
review?

thanks,

greg k-h
