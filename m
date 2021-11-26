Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253EE45E85B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 08:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359221AbhKZHUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 02:20:04 -0500
Received: from mx24.baidu.com ([111.206.215.185]:33028 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1359001AbhKZHSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 02:18:02 -0500
Received: from BC-Mail-Ex12.internal.baidu.com (unknown [172.31.51.52])
        by Forcepoint Email with ESMTPS id DAB70995F93BBB3390A2;
        Fri, 26 Nov 2021 15:14:41 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex12.internal.baidu.com (172.31.51.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Fri, 26 Nov 2021 15:14:41 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Fri, 26
 Nov 2021 15:14:41 +0800
Date:   Fri, 26 Nov 2021 15:14:44 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>
Subject: Re: [PATCH v3 1/3] staging: zynpu: Add driver support for ARM(China)
 ZHOUYI AI accelerator
Message-ID: <20211126071444.GA32426@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20211126021904.32325-1-caihuoqing@baidu.com>
 <20211126021904.32325-2-caihuoqing@baidu.com>
 <YaCCFv2DLzeng+UE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YaCCFv2DLzeng+UE@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex11.internal.baidu.com (172.31.51.51) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 11月 21 07:43:34, Greg Kroah-Hartman wrote:
> On Fri, Nov 26, 2021 at 10:18:59AM +0800, Cai Huoqing wrote:
> > ZHOUYI NPU is an AI accelerator chip which is integrated into ARM SOC,
> > such as Allwinner R329 SOC.
> > Add driver support for this AI accelerator here.
> > 
> > This driver is not standard linux style, there are some clean up works,
> > fixing code style, refactorring.
> > And it only works with a closed source usermode driver, so need to
> > reverse the libraries, and impelement it, then open source
> > the usermode driver.
> > So add this driver to linux-staging
> 
> Sorry, but no, I can not take this driver into the kernel tree until
> there is an open source user of the new api that you are creating with
> this driver.  This was discussed many times on the linux-kernel mailing
> list and at the Linux kernel summit a few months ago (see the summary at
> lwn.net about it.)
> 
> So please work on that first, and then we will be glad to revisit taking
> this kernel driver into the tree.
OK, I will do that.
And after doing some clean up, try to take this code to the "real" linux tree.

Thanks,
Cai
> 
> Also, it is much simpler just to take a few hours and clean up the
> coding style issues yourself rather than relying on the community to do
> it for you over a few months.
> 
> thanks,
> 
> greg k-h
