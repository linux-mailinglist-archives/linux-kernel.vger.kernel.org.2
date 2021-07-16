Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50CA3CB574
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 11:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhGPJvJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Jul 2021 05:51:09 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:60499 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbhGPJvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:51:07 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id BC0D8100004;
        Fri, 16 Jul 2021 09:48:09 +0000 (UTC)
Date:   Fri, 16 Jul 2021 11:48:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <David.Woodhouse@intel.com>,
        <Artem.Bityutskiy@nokia.com>, <ext-adrian.hunter@nokia.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linfeilong@huawei.com>
Subject: Re: [PATCH] mtd: fix size in mtd_info_user to support 64-bit
Message-ID: <20210716114808.246e92ba@xps13>
In-Reply-To: <95e3d455-ccb1-0e22-ee83-78dc6ad8aab1@huawei.com>
References: <20210708131359.21591-1-linmiaohe@huawei.com>
        <20210716010224.44582046@xps13>
        <95e3d455-ccb1-0e22-ee83-78dc6ad8aab1@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaohe,

Miaohe Lin <linmiaohe@huawei.com> wrote on Fri, 16 Jul 2021 09:42:19
+0800:

> On 2021/7/16 7:02, Miquel Raynal wrote:
> > Hi Miaohe,
> > 
> > Miaohe Lin <linmiaohe@huawei.com> wrote on Thu, 8 Jul 2021 21:13:59
> > +0800:
> >   
> >> From: Feilong Lin <linfeilong@huawei.com>
> >>
> >> The size in struct mtd_info_user is 32-bit, which will cause errors
> >> when obtaining the size of large-capacity MTD devices, such as TLC
> >> NAND FLASH-2048Gb.  
> > 
> > Besides the fact that such devices are far from being supported by the
> > Linux kernel, this change would basically break userspace, it cannot
> > enter as-is...
> >   
> 
> I see. Many thanks for your reply! We're working with these large-capacity
> MTD devices now, any suggestion to work around this?

The only way is to create a second UAPI.

Thanks,
Miquèl
