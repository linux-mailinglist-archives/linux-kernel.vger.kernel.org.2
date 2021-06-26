Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EBC3B4C64
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 06:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhFZENt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 00:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhFZENs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 00:13:48 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01A1CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 21:11:26 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 43C349200B4; Sat, 26 Jun 2021 06:11:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3FEDF9200B3;
        Sat, 26 Jun 2021 06:11:26 +0200 (CEST)
Date:   Sat, 26 Jun 2021 06:11:26 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] serial: 8250: Fixes for Oxford Semiconductor 950
 UARTs
Message-ID: <alpine.DEB.2.21.2106260539240.37803@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Here's v2 of the outstanding fixes for Oxford Semiconductor 950 UARTs, 
comprising an chip-specific clock handling implementation for accurate 
baud rate selection including higher baud rates and FIFO rx trigger level 
configuration.

 NB I have since had an opportunity to check what transceiver chips have 
been used with the option card I have been experimenting with, and they've 
turned out to be the Zywyn ZT3243F, specified for up to 1Mbps, so no 
surprise they eventually gave up as the rates I have tried increased, and 
quite interesting it was only at 4Mbps that they did it.

 Please apply.

  Maciej
