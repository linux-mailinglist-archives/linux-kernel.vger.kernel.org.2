Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DFD3EF154
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhHQSGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:06:21 -0400
Received: from smtprelay0074.hostedemail.com ([216.40.44.74]:33966 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232692AbhHQSGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:06:01 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 79D5E100A44A9;
        Tue, 17 Aug 2021 18:05:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 67452D1517;
        Tue, 17 Aug 2021 18:05:26 +0000 (UTC)
Message-ID: <79ad056a8d6b71df0a793f18c5752c2eaf8c836c.camel@perches.com>
Subject: Re: [PATCH] macintosh: no need to initilise statics to 0
From:   Joe Perches <joe@perches.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jason Wang <wangborong@cdjrlc.com>, benh@kernel.crashing.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
Date:   Tue, 17 Aug 2021 11:05:24 -0700
In-Reply-To: <2105ef52-b736-cc18-def9-02ac174d1922@csgroup.eu>
References: <20210817115104.30057-1-wangborong@cdjrlc.com>
         <2105ef52-b736-cc18-def9-02ac174d1922@csgroup.eu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: r6f78e9dki483a97e8tpk5gf81t9mny4
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 67452D1517
X-Spam-Status: No, score=0.19
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18NRR3d9r9nOd9Sa3Pmevs4UvdI+JZtr+I=
X-HE-Tag: 1629223526-123757
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-08-17 at 13:59 +0200, Christophe Leroy wrote:
> 
> Le 17/08/2021 à 13:51, Jason Wang a écrit :
> > Global static variables dont need to be initialised to 0. Because
> > the compiler will initilise them.
> 
> It is not the compiler, it is the Kernel. It is done here:
> 
> https://elixir.bootlin.com/linux/v5.14-rc6/source/arch/powerpc/kernel/early_32.c

I don't know why that's done generally.

From memory, it's also required by the c spec unless it's for a union
where the first union member is smaller in size than other members.


