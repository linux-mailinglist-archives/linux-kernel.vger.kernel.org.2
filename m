Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4352308A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 17:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhA2Qaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 11:30:39 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:37153 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhA2Q32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 11:29:28 -0500
Received: from windsurf.home (aputeaux-654-1-223-147.w90-2.abo.wanadoo.fr [90.2.82.147])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4C481200011;
        Fri, 29 Jan 2021 16:28:39 +0000 (UTC)
Date:   Fri, 29 Jan 2021 17:28:38 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bus: mvebu-mbus: make iounmap() symmetric with
 ioremap()
Message-ID: <20210129172838.0c2e2394@windsurf.home>
In-Reply-To: <87r1m3speo.fsf@BL-laptop>
References: <20201112032149.21906-1-chris.packham@alliedtelesis.co.nz>
        <20201112090202.638c0c13@windsurf>
        <7c0fd747-3ea1-2aa1-0c05-12ae4477a860@alliedtelesis.co.nz>
        <20210126090525.4d085080@windsurf.home>
        <87r1m3speo.fsf@BL-laptop>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021 17:01:35 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> Could you sent me the patch I don't have it in my emails boxes.

https://lore.kernel.org/lkml/20201112032149.21906-1-chris.packham@alliedtelesis.co.nz/raw

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
