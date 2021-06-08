Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A6F3A07BB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 01:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhFHXW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 19:22:58 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:34623 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbhFHXW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:22:56 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1341D1BF204;
        Tue,  8 Jun 2021 23:21:00 +0000 (UTC)
Date:   Wed, 9 Jun 2021 01:21:00 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Parshuram Raju Thombare <pthombar@cadence.com>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        "slongerbeam@gmail.com" <slongerbeam@gmail.com>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        Milind Parab <mparab@cadence.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 2/7] i3c: master: use i3c_master_register only for
 main master
Message-ID: <YL/7XP1fs/2bRiTM@piout.net>
References: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
 <1606717066-3785-1-git-send-email-pthombar@cadence.com>
 <2s3n7419-1nr9-8885-882o-7qrsos6qq6q@syhkavp.arg>
 <DM5PR07MB319618AFCB415501CD33741FC1CD0@DM5PR07MB3196.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR07MB319618AFCB415501CD33741FC1CD0@DM5PR07MB3196.namprd07.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2020 05:47:51+0000, Parshuram Raju Thombare wrote:
> >This looks a bit confusing. Here you're rolling back detailss in
> >i3c_primary_master_register() that were factored out in
> >i3c_master_init(). If i3c_master_init() is successful, then you
> >shouldn't be undoing its things openly in i3c_primary_master_register().
> >Instead, there should be another function that does the reverse of
> >i3c_master_init() here.
> 
> Every function do its cleanup in case of failures.
> And if any failure occur after successful i3c_master_init(), we have
> function i3c_master_bus_cleanup() which does the major cleanup.
> 

The point from Nicolas here was that the workqueue is allocated in
i3c_master_init so you should have a function to destroy it instead of
having to do that separately in i3c_primary_master_register. The same is
true for the put_device. Or you have to ensure i3c_masterdev_release
is called when i3c_primary_master_register fails.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
