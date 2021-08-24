Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598A43F6146
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbhHXPHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:07:43 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:39640 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238118AbhHXPHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:07:41 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 17OF6qgw026318;
        Tue, 24 Aug 2021 17:06:52 +0200
Date:   Tue, 24 Aug 2021 17:06:52 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul =?iso-8859-1?B?R3L232Vs?= <pb.g@gmx.de>
Subject: Re: [PATCH] Revert "USB: serial: ch341: fix character loss at high
 transfer rates"
Message-ID: <20210824150652.GA25488@1wt.eu>
References: <20210824121926.19311-1-johan@kernel.org>
 <20210824123232.GA25435@1wt.eu>
 <YSTzPIkwNDOON5j8@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSTzPIkwNDOON5j8@hovoldconsulting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ removed Cc stable for the rest of the discussion ]

On Tue, Aug 24, 2021 at 03:25:16PM +0200, Johan Hovold wrote:
> Zero-length packets are used to indicate completion of bulk transfers
> that are multiples of the endpoint max-packet size (as per the USB
> spec). Without those the host controller driver doesn't now that the
> transfer is complete and that it should call the driver completion
> callback (and instead waits for the other completion conditions).

Thanks for the explanation. I guess that in my case, given that the
serial port would emit lots of continuous data (e.g. "find /" or "dmesg"),
there's always something pending and the risk that it ends exactly on a
64-byte boundary remained low and never happened in practice.

> It may be possible to configure the device to send ZLPs somehow but
> since there's no public documentation for the protocol that may require
> some reverse engineering.

I totally understand. I'll drop my CH34x adapters and try to figure more
suitable ones (i.e. some which work *by default* under Linux). Their
small footprint was nice but without doc they're only usable for low
speeds :-/

Thanks!
Willy
