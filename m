Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99555308ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhA2RCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:02:40 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46711 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhA2Q7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 11:59:54 -0500
X-Originating-IP: 90.65.91.141
Received: from localhost (lfbn-lyo-1-1912-141.w90-65.abo.wanadoo.fr [90.65.91.141])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E7D1D60003;
        Fri, 29 Jan 2021 16:59:11 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bus: mvebu-mbus: make iounmap() symmetric with ioremap()
In-Reply-To: <20210129172838.0c2e2394@windsurf.home>
References: <20201112032149.21906-1-chris.packham@alliedtelesis.co.nz>
 <20201112090202.638c0c13@windsurf>
 <7c0fd747-3ea1-2aa1-0c05-12ae4477a860@alliedtelesis.co.nz>
 <20210126090525.4d085080@windsurf.home> <87r1m3speo.fsf@BL-laptop>
 <20210129172838.0c2e2394@windsurf.home>
Date:   Fri, 29 Jan 2021 17:59:11 +0100
Message-ID: <87lfcbsmqo.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Fri, 29 Jan 2021 17:01:35 +0100
> Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
>
>> Could you sent me the patch I don't have it in my emails boxes.
>
> https://lore.kernel.org/lkml/20201112032149.21906-1-chris.packham@alliedtelesis.co.nz/raw


Applied on mvebu/arm

Thanks,

Gregory

>
> Thomas
> -- 
> Thomas Petazzoni, CTO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
