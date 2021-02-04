Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DEB30F6DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbhBDPwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:52:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237462AbhBDPuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:50:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B682764DA5;
        Thu,  4 Feb 2021 15:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612453795;
        bh=Q7NOkrxsLwfOICWsHM+eOh5lMOeFEXRUlWX9aCa9VtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mq1YrEEPrJX6l5tirF5uA8MEZnR4KnPuVyc3F0a8xKQCwGq4WmEO7qzoJD00/XaN7
         3P4ByIM0mW60/xLM6gOItEYBXq2byWQ8RoO2afPt6RXQBADpZ98z4uQTIV6DcdWmcG
         dY5WUcpnN/vRhvZaVaS3Q409KhV6VfXuTTgfBmpk=
Date:   Thu, 4 Feb 2021 16:49:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jason Li <jason.li@cortina-access.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Message-ID: <YBwXoCwKwkcMPYvy@kroah.com>
References: <1612425530-20483-1-git-send-email-alex.nemirovsky@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612425530-20483-1-git-send-email-alex.nemirovsky@cortina-access.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 11:58:47PM -0800, Alex Nemirovsky wrote:
> +static uintptr_t *cortina_uart_ports;

Note, "uintptr_t" is not a valid kernel type.

Please use a pointer to a real thing, no void pointers please.

thanks,

greg k-h
