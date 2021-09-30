Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDC341DC30
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348830AbhI3OYl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Sep 2021 10:24:41 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34590 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351913AbhI3OYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:24:33 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A3CAF1F44DAD;
        Thu, 30 Sep 2021 15:22:49 +0100 (BST)
Date:   Thu, 30 Sep 2021 16:22:46 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH] mtd: add MEMREAD ioctl
Message-ID: <20210930162246.61359ea7@collabora.com>
In-Reply-To: <YVXBf0v0AQ5+G9dt@larwa.hq.kempniu.pl>
References: <20210920070221.10173-1-kernel@kempniu.pl>
        <20210928155859.433844cb@xps13>
        <20210928162402.6bb64fcf@collabora.com>
        <20210928163519.08cd1138@xps13>
        <YVTBoAnQKYLNpOPc@larwa.hq.kempniu.pl>
        <20210930085133.13b5a228@collabora.com>
        <20210930104721.03dc45bb@xps13>
        <YVXBf0v0AQ5+G9dt@larwa.hq.kempniu.pl>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 15:54:07 +0200
Michał Kępień <kernel@kempniu.pl> wrote:

> Boris, I think a Suggested-by tag crediting you is in order for both the
> unbounded malloc issue and the MEMREAD ioctl, but submitting-patches.rst
> says I should not add this tag without your permission.  So, are you
> okay with me adding it?

Sure, no problem.

