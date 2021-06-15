Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7ED3A874B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhFORRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhFORRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:17:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 911B561420;
        Tue, 15 Jun 2021 17:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623777320;
        bh=Jtec2saajfBJb2/jk1pYQMMJxuk7X+g6wO32rKBrHoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0sIh5a0Ekt+FeloEwZPNhnUOiPxmy4gHTmZNpRVpBKnwSrjEHAF4gNqnqrvawgIAU
         8WrPHvl/9blaevfSio/13rEci4ae9AKQAxuZvp2wCta7giQT+Yk54jDg9sZCwAbgho
         NbxM6evanN2TUIYhKRGVaLsuPzt595BEJydFCl2w=
Date:   Tue, 15 Jun 2021 19:15:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc:     devicetree@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Jason Li <jason.li@cortina-access.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Message-ID: <YMjgJYdjmCoCER7l@kroah.com>
References: <20210615165750.31261-1-alex.nemirovsky@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615165750.31261-1-alex.nemirovsky@cortina-access.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 09:57:48AM -0700, Alex Nemirovsky wrote:
> From: Jason Li <jason.li@cortina-access.com>
> 
> This driver supports Cortina Access UART IP integrated
> in most all CAXXXX line of SoCs. Earlycom is also supported
> 
> Signed-off-by: Jason Li <jason.li@cortina-access.com>
> ---

I only received 2 patches, here 1/3 and 2/3.  What happened to 3/3?

And please use 'git send-email' to properly thread your patches so our
tools can correctly pick up the whole series when wanting to do things
with them.

Can you fix that up and resend?

thanks,

greg k-h
