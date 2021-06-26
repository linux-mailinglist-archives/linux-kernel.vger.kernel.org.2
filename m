Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB043B4C56
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 06:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhFZENW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 00:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhFZENV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 00:13:21 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1E0FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 21:10:59 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 01B3392009C; Sat, 26 Jun 2021 06:10:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id F08EE92009B;
        Sat, 26 Jun 2021 06:10:57 +0200 (CEST)
Date:   Sat, 26 Jun 2021 06:10:57 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     linux-serial@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 0/2] serial, Malta: Fixes to make the CBUS UART work
 big-endian
Message-ID: <alpine.DEB.2.21.2106260509300.37803@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Earlier this year I noticed the CBUS UART, a discrete TI16C550C part 
wired directly to the system controller's device bus and supposed to come 
up as ttyS2 in addition to ttyS0 and ttyS1 ports from a Super I/O device 
behind the PCI southbridge, is not recognised with my MIPS Malta board 
booting big-endian.

 I got to the bottom of the problem now and as it turns out we have two 
long-standing bugs causing it, one in generic 8250 code and another in 
Malta platform code, and this has never worked in the big-endian mode.  

 Here's v2 of the series, addressing minor issues with 1/2 pointed out in 
the review.

 Please apply.

  Maciej
