Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8694218E1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 22:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhJDVAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 17:00:18 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:29735 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbhJDVAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 17:00:17 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 6FA6B240002;
        Mon,  4 Oct 2021 20:58:25 +0000 (UTC)
Date:   Mon, 4 Oct 2021 22:58:25 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        ludovic.desroches@microchip.com, robh+dt@kernel.org,
        corbet@lwn.net, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Manohar.Puri@microchip.com
Subject: Re: [PATCH 0/4] Add lan966 documentation and remove lan966x.c file
Message-ID: <YVtq8Qeb4RbenhTG@piout.net>
References: <20211004105926.5696-1-kavyasree.kotagiri@microchip.com>
 <YVrgzWLReFS5FgWd@piout.net>
 <09645199-50af-0373-c5bb-e0d745543e5b@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09645199-50af-0373-c5bb-e0d745543e5b@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2021 14:55:29+0200, Nicolas Ferre wrote:
> On 04/10/2021 at 13:09, Alexandre Belloni wrote:
> > On 04/10/2021 16:29:22+0530, Kavyasree Kotagiri wrote:
> > > This patch series modifies Kconfig entry, adds documentation for
> > > lan966 family and removes lan966x setup code file as it is not
> > > required.
> > > 
> > > These patches are generated from at91/linux.git
> > > I had agreement with Nicolas Ferre that he will merge these changes
> > > into existing patch.
> > > 
> > 
> > Seems good to me, for the whole series:
> > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com> for the whole series,
> added to at91-soc and merged with previous patch.
> 
> Please have a look at the resulting tree or at91-next branch for
> double-checking.
> 

That's way better, no code at all is the best code to maintain ;)
Thanks for your efforts Kavya

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
