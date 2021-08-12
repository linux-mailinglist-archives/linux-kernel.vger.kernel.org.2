Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160253E9EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 08:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhHLGxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 02:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234718AbhHLGxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 02:53:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBC6F6103A;
        Thu, 12 Aug 2021 06:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628751171;
        bh=7mu4Ipsd06cm4QBrmrbucxTGVRGJN4PzWTMdE9wwbrU=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=JXDPas5I8yBxBrn2AxEiGDa3RwNLAXJO9hQlCzbFqbUkaZ0jcCDQowUEDDSqc6Mu8
         pqRS+6vP4ds0XZaHNGwUhjDC0qgOpsgt9AUTTVM2TFjQogxrIP7jQzhb4o1GJWTavV
         ywCgbZKghTaMmVpunD4t1w7ooZhrt+Yi8lhVjhe/YBWca/a3mMCL9KboAeQ6BvsHiH
         l6hOqveJ3aIw3bUxC1xGOZN1nlak+8Zn/QEq8tu0FnXWVU6aLcOxUMYMqpxniHO+AY
         x/LjYgM53vQGKFWHEd9JZj1xmojz1/e40WNthUUNCCJW/jUdDWyBZ+xL+cjm3tdwX1
         mRYQGYTtUFzgg==
References: <1628739182-30089-1-git-send-email-chunfeng.yun@mediatek.com>
 <1628739182-30089-5-git-send-email-chunfeng.yun@mediatek.com>
User-agent: mu4e 1.6.2; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Al Cooper <alcooperx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH 5/6] usb: gadget: bdc: remove unnecessary AND operation
 when get ep maxp
Date:   Thu, 12 Aug 2021 09:52:34 +0300
In-reply-to: <1628739182-30089-5-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <87h7fvyx1e.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chunfeng Yun <chunfeng.yun@mediatek.com> writes:

> usb_endpoint_maxp() already returns actual max packet size, no need
> AND 0x7ff.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

-- 
balbi
