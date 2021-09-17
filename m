Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B33E40EEF2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 03:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242479AbhIQB4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 21:56:00 -0400
Received: from mx22.baidu.com ([220.181.50.185]:55850 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230135AbhIQBz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 21:55:59 -0400
Received: from BC-Mail-Ex25.internal.baidu.com (unknown [172.31.51.19])
        by Forcepoint Email with ESMTPS id D007E98AF78AADBE57E8;
        Fri, 17 Sep 2021 09:54:34 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex25.internal.baidu.com (172.31.51.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Fri, 17 Sep 2021 09:54:34 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Sep 2021 09:54:34 +0800
Date:   Fri, 17 Sep 2021 09:54:34 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>, open list:
        GPIO SUBSYSTEM <linux-gpio@vger.kernel.org>, ;
        linux-kernel <linux-kernel@vger.kernel.org>
Illegal-Object: Syntax error in CC: address found on vger.kernel.org:
        CC:     ;linux-kernel <linux-kernel@vger.kernel.org>
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
Subject: Re: [PATCH] pinctrl: freescale: Add helper dependency on COMPILE_TEST
Message-ID: <20210917015434.GA17483@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20210825082251.2484-1-caihuoqing@baidu.com>
 <CACRpkdYekS+2WKoyT5ssSp28XR4pxb+4yMZnP9PPRXpG+UE-LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYekS+2WKoyT5ssSp28XR4pxb+4yMZnP9PPRXpG+UE-LA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex27.internal.baidu.com (172.31.51.21) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 9月 21 00:07:32, Linus Walleij wrote:
> On Wed, Aug 25, 2021 at 10:23 AM Cai Huoqing <caihuoqing@baidu.com> wrote:
> 
> > it's helpful for complie test in other platform(e.g.X86)
> >
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> 
> It seems weird to only enable this on a few select subdrivers rather
> than all of the Freescale drivers?
The others seem to depend on SOC_IMX arch related headers
but it's ok for ARCH_IMX related to use COMPILE_TEST.
> 
> (Also: the Freescale maintainers are very silent, some feedback
> would be helpful.)
> 
> Yours,
> Linus Walleij
