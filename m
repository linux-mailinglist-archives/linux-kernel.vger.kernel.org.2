Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1C345B724
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 10:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhKXJNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:13:07 -0500
Received: from mx24.baidu.com ([111.206.215.185]:56084 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229521AbhKXJNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:13:05 -0500
Received: from BC-Mail-Ex07.internal.baidu.com (unknown [172.31.51.47])
        by Forcepoint Email with ESMTPS id C71E0B74B888DD54FDC0;
        Wed, 24 Nov 2021 17:09:54 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-EX07.internal.baidu.com (172.31.51.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 24 Nov 2021 17:09:54 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Wed, 24
 Nov 2021 17:09:54 +0800
Date:   Wed, 24 Nov 2021 17:09:57 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>
Subject: Re: [PATCH v2 1/3] staging: zynpu: Add driver support for ARM(China)
 ZHOUYI AI accelerator
Message-ID: <20211124090957.GA698@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20211124084620.628-1-caihuoqing@baidu.com>
 <20211124084620.628-2-caihuoqing@baidu.com>
 <YZ39YqsNTSolEJZ2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZ39YqsNTSolEJZ2@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex24.internal.baidu.com (172.31.51.18) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 11月 21 09:52:50, Greg Kroah-Hartman wrote:
> On Wed, Nov 24, 2021 at 04:46:15PM +0800, Cai Huoqing wrote:
> > ZHOUYI NPU is an AI accelerator chip which is integrated into ARM SOC,
> > such as Allwinner R329 SOC.
> > Add driver support for this AI accelerator here.
> > 
> > This driver is not tandard linux style, there are some clean up works,
> 
> "standard"?
will fix it
> 
> > fixing code style, refactorring.
> > And it only works with a closed source usermode driver, so need to
> > reverse the libraries, and impelement it, then open source
> > the usermode driver.
> 
> Who will be doing the "reversing" of the usermode driver?
I will provide the library binary, also try to implement usermode code:)
> 
> We can't take this now if there's no actual users of this code that
> anyone can test.  Why not just change the license of the usermode code
> now to make this simpler?
Allwinner R329 board includes this ip core, I have one to test this
driver.
The usermode code is close, I just got an library.

Thanks

Cai

> 
> thanks,
> 
> greg k-h
