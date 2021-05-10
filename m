Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091EF377ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhEJJCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhEJJCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:02:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3272B60FE8;
        Mon, 10 May 2021 09:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620637290;
        bh=D18cw+fs8QmLRUSC31UNLkbAGiDlCX2TMHaNpx2XmS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aFQzh4EEAS2aBJNvhmMXmb4eCPPSmllkV9ZEl8MuxfKlIjMH/fg3wMuJJwz6Enwbw
         IWQqbi6Ky2/uXgOMxBkBkdWXHUby2ILZDS/SY6oEjWX6AW2ciaZfz1Ku4Q+5qwaBOO
         sS5BDoeTePJFrRo9QnqS5W0HQjCTw1xdFhs+1pWlfjX/sMmKd/K96piWa2XFUjbzxT
         e4AteoXAo9Hri1QH29afFk8RC2ak6KsAOtbvmHMOOaeUZWDFh3fyFqvaQTQWWRo1MD
         uUgI152j73E9f64eoYFrMyd1nSCaf2fXIYyiK+g3oGs724vKlHQ465e0bXjSAlnnwN
         XlUiWNVYT4G4w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lg1nB-0000wg-7F; Mon, 10 May 2021 11:01:33 +0200
Date:   Mon, 10 May 2021 11:01:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Juergen Borleis <jbe@pengutronix.de>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] USB: serial: ftdi_sio: add IDs for IDS GmbH Products
Message-ID: <YJj2bXAgYtgg0jC9@hovoldconsulting.com>
References: <20210422075852.9351-1-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422075852.9351-1-jbe@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:58:52AM +0200, Juergen Borleis wrote:
> From: Dominik Andreas Schorpp <dominik.a.schorpp@ids.de>
> 
> Add the IDS GmbH Vendor ID and the Product IDs for SI31A (2xRS232)
> and CM31A (LoRaWAN Modem).
> 
> Signed-off-by: Dominik Andreas Schorpp <dominik.a.schorpp@ids.de>
> Signed-off-by: Juergen Borleis <jbe@pengutronix.de>

Applied, thanks.

Johan
