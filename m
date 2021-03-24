Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145E6346EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 02:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhCXBZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 21:25:30 -0400
Received: from m12-12.163.com ([220.181.12.12]:45077 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234301AbhCXBZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=O4/+Y
        l7+L+jA/cvkns/Is7wuSzLFWxwyEvnNlw4szcQ=; b=iYLrgz8UTLylqUtlnSiW4
        ilK50eFueW79myS7GXwCThjbfV3IHviVlquvfENcer/rKyKKPkjm6gZAO3ofb7+G
        3O+6HVirRMv/dw905YhZmKl96fm2O94uytPZlIpfi1JXkYu2kOvry/RtlvHwVoLD
        DJA9g11NmDP6ayiyeNB4LA=
Received: from localhost (unknown [218.94.48.178])
        by smtp8 (Coremail) with SMTP id DMCowABnyxzHlFpg8X_KWA--.58686S2;
        Wed, 24 Mar 2021 09:24:24 +0800 (CST)
Date:   Wed, 24 Mar 2021 09:24:35 +0800
From:   Jian Dong <dj0227@163.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, huyue2@yulong.com,
        Jian Dong <dongjian@yulong.com>
Subject: Re: [PATCH] regulator: mt6360: remove redundant error print
Message-ID: <20210324092435.00000343@163.com>
In-Reply-To: <20210323171628.GA9323@sirena.org.uk>
References: <1616502161-125407-1-git-send-email-dj0227@163.com>
        <20210323171628.GA9323@sirena.org.uk>
Organization: yulong
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DMCowABnyxzHlFpg8X_KWA--.58686S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWkCFyDtF4fJr15Zw15twb_yoWfWFX_CF
        1fCa1IkwsrArsrKFnIqF9IvrZxtw1qqa40q39rKFW3AryfZFn8J3srCryxZr4rX3y0krnx
        uwnYvr4UXr17ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb3C7UUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: dgmqjjqx6rljoofrz/1tbiqAhf3Vc7UBLfsQAAsi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 17:16:28 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Tue, Mar 23, 2021 at 08:22:41PM +0800, Jian Dong wrote:
> > From: Jian Dong <dongjian@yulong.com>
> > 
> > fixes coccicheck warning:
> > 
> > drivers/regulator/mt6360-regulator.c:384:3-10: line 384 is
> > redundant because platform_get_irq() already prints an error  
> 
> This doesn't apply against current code, please check and resend.
> 
> Applying: regulator: mt6360: remove redundant error print
> error: sha1 information is lacking or useless
> (drivers/regulator/mt6360-regulator.c). error: could not build fake
> ancestor Patch failed at 0001 regulator: mt6360: remove redundant
> error print

Hi 

I find the problem, before this patch, I had commit a patch 
"[PATCH]regulator: Use IRQF_ONESHOT", and it hasn't be accepted now, So
the current code is different.

I will modify and resend later.  

