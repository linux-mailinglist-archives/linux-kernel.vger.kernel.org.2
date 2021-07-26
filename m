Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045893D5CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 17:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbhGZOsp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jul 2021 10:48:45 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:59735 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbhGZOsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:48:41 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 613B2C0008;
        Mon, 26 Jul 2021 15:29:03 +0000 (UTC)
Date:   Mon, 26 Jul 2021 17:29:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Deepak Saxena <dsaxena@plexity.net>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] MAINTAINERS: rectify entries to mtd-physmap.yaml
Message-ID: <20210726172902.4ce8892f@xps13>
In-Reply-To: <20210726142943.27008-7-lukas.bulwahn@gmail.com>
References: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
        <20210726142943.27008-7-lukas.bulwahn@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote on Mon, 26 Jul 2021
16:29:41 +0200:

> Commit 63f8e9e0ac65 ("dt-bindings: mtd: Convert mtd-physmap to DT schema")
> aggregated, amongst others, arm-versatile.txt and cypress,hyperflash.txt,
> into mtd-physmap.yaml in ./Documentation/devicetree/bindings/mtd/.
> 
> The two .txt files are however mentioned in MAINTAINERS; hence,
> ./scripts/get_maintainer.pl --self-test=patterns complains about broken
> references.
> 
> Refer to mtd-physmap.yaml, so that the maintainers and reviewers of
> ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT and HYPERBUS SUPPORT are
> informed on any changes in the yaml file.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
