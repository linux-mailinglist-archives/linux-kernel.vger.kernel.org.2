Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4818833AC35
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 08:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCOH1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 03:27:40 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:40068 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCOH1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 03:27:24 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 1E0832000D5;
        Mon, 15 Mar 2021 07:27:21 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 0749020656; Mon, 15 Mar 2021 08:25:32 +0100 (CET)
Date:   Mon, 15 Mar 2021 08:25:32 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pcmcia: ds: Remove if with always false condition
Message-ID: <YE8L7BLdsQCzgUGs@light.dominikbrodowski.net>
References: <20210301173847.1679956-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210301173847.1679956-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, Mar 01, 2021 at 06:38:47PM +0100 schrieb Uwe Kleine-König:
> pcmcia_device_remove() is only ever called by the driver core with
> dev->driver pointing to a valid driver. (And even if dev->driver was
> NULL, p_drv wouldn't be NULL as p_drv is assigned as follows:
> 
> 	p_drv = to_pcmcia_drv(dev->driver);
> 
> and to_pcmcia_drv is a container_of operation on struct
> pcmcia_driver::drv which isn't the first member in struct
> pcmcia_driver.)
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied to pcmcia-next, thanks.

	Dominik
