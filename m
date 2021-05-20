Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551D9389CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 06:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhETEya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 00:54:30 -0400
Received: from mail.thorsis.com ([92.198.35.195]:57549 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhETEy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 00:54:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id B9FB0ECD
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 06:53:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 90pMgLC3qNpX for <linux-kernel@vger.kernel.org>;
        Thu, 20 May 2021 06:53:07 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id E2E6D1FB4; Thu, 20 May 2021 06:53:05 +0200 (CEST)
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Report: * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 NO_RELAYS Informational: message was not relayed via SMTP
        * -0.0 NO_RECEIVED Informational: message has no Received headers
Date:   Thu, 20 May 2021 06:52:50 +0200
From:   Alexander Dahl <ada@thorsis.com>
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>, rppt@kernel.org,
        ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: make the size of vmalloc in cmdline and meminfo
 uniform
Message-ID: <YKXrIotnzsHKP+qp@ada-deb-carambola.ifak-system.com>
Mail-Followup-To: "Xu, Yanfei" <yanfei.xu@windriver.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>, rppt@kernel.org,
        ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210518111254.3820480-1-yanfei.xu@windriver.com>
 <20210518112932.GV12395@shell.armlinux.org.uk>
 <20210518120633.GW12395@shell.armlinux.org.uk>
 <63618f13-07cf-6867-bcb1-7a725e6f3ef4@windriver.com>
 <b115f727-570d-d3c1-2a5b-01ed89c450dd@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b115f727-570d-d3c1-2a5b-01ed89c450dd@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yanfei,

Am Wed, May 19, 2021 at 01:32:23PM +0800 schrieb Xu, Yanfei:
> I am not much familar with community contribution. In this case, what
> kind of tags should I reply? signed-off-by? Reviewed-by? or any other
> tags?

This is explained in kernel documentation, starts here with Acked-by:, Cc:, 
and Co-developed-by:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

And is followed by Reported-by:, Tested-by:, Reviewed-by:, Suggested-by:,
and Fixes: 

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

Hope that helps.
Alex

