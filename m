Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D91945A374
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbhKWNKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:10:33 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43344 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbhKWNK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:10:29 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DA17C1F45329;
        Tue, 23 Nov 2021 13:07:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637672840; bh=aY5f0ZE6mRocfP077BfQ+DyVCFKvaNgVw0KqMYW9Oac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SoWhcM/JM/MqGIt7YwcUG1aTR4lV8NcUNpHNd1tavD7rvzO2x0gjEKupPs1b+YzBt
         vPw0I+0zkNnYbx6A8kSyh3+3Nekn/rmpcINVmlUPyZdd6BTyJfjOsCqq3AHA59y4q8
         rGTD0h7Z3L29Ry3+IaC/6LNe6WQC4NNlMxn3w/9GUaW+zeWK4Mzypx6WsrqkWNjGs9
         1k+Lvc2gs11mnyD9k4ZU+nh5pHowjCrwAc5O7/cpxokvrFS8RjCklQE7ptesL3gRMt
         aATPBprqsyaSPNpulU6Fbw2nAIJxDIi/q1RVe+26YdITCHfTD2DR5nuumb9jgPeFen
         xMAU1FYo/Qrkg==
Date:   Tue, 23 Nov 2021 14:07:15 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] mtd: core: protect access to MTD devices while
 in suspend
Message-ID: <20211123140715.280b2f70@collabora.com>
In-Reply-To: <20211123125012.ibzqu44ixmykbhkt@skn-laptop>
References: <20211102110204.3334609-1-sean@geanix.com>
        <20211102110204.3334609-4-sean@geanix.com>
        <CGME20211123120353eucas1p2fb2561b7cfddd8d6e7decaef8b504f4c@eucas1p2.samsung.com>
        <21092c0f-e11b-ac16-ab96-2a0556c0e30a@samsung.com>
        <20211123125012.ibzqu44ixmykbhkt@skn-laptop>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 13:50:12 +0100
Sean Nyekjaer <sean@geanix.com> wrote:

> @Boris do we need to do something similar here to what we did with the
> mtdconcat stuff?

Absolutely, physmasp subdevices are never initialized/registered, so
you can't call any of the mtd helpers taking the suspend lock on those.
I guess it'd be better to call mtd_suspend/resume() on the concat device
in though:

static void physmap_flash_shutdown(struct platform_device *dev)
{
	struct physmap_flash_info *info = platform_get_drvdata(dev);

	mtd_suspend(info->cmtd);
}
