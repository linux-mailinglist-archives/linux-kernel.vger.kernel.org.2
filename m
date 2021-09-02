Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4283FEDF8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344732AbhIBMsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344474AbhIBMsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:48:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41A4E60F4B;
        Thu,  2 Sep 2021 12:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630586840;
        bh=+EA3TGY+wk4s7qcMYWQyoSQZEnBOtgNwQlNF0Odv+k4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hopQzbzFq2LHkCUVnIksl7xgexrg0zpDMbTVxtztWjqL8w1B47FrcuWSUxSC+MUoU
         CnRJiyJcY6dv4OZwHsDN2U1ZNNrXz3nlMvhN08TuXrfUzOc50wcIDk649oLYVjAAHa
         g4QW+FuCn6sK59odqJMu6d2KhXLkJl1xvPZ9Tc1ElX7rlxQfmtPIr0j8tgra8eENLo
         JfRBn+ZoXR6dR3U1qHf6qcqPBZJV1gESfRPxpB0u5Pyx7cWY/nIRVW6pLg0nA7SoKz
         HlqXcXwGmRZn/nYHXtyrje/feHuasVValKubXSycGKbqkSDGtvZDUNoo/Kz8FLeGW/
         Z+GWBHWZXzRkg==
Date:   Thu, 2 Sep 2021 14:47:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: hi6421-spmi-pmic: cleanup drvdata
Message-ID: <20210902144716.661e183f@coco.lan>
In-Reply-To: <YTC95yQxoZ/0B26b@kroah.com>
References: <6959a4b11cb840aaae8d144889bb7b4899c3b335.1630583284.git.mchehab+huawei@kernel.org>
        <YTC95yQxoZ/0B26b@kroah.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 2 Sep 2021 14:04:55 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Thu, Sep 02, 2021 at 01:48:11PM +0200, Mauro Carvalho Chehab wrote:
> > There are lots of fields at struct hi6421_spmi_pmic that aren't
> > used. In a matter of fact, only regmap is needed.
> > 
> > So, drop the struct as a hole, and set just the regmap as
> > the drvdata.
> > 
> > While here, add a missing dot at the Huawei's copyrights.  
> 
> What "missing dot"?  I do not see any such change in this patch :(
 
Probably moved to some other patch during the dozens of e-mails
that this patch series suffered.

I'll resend this patch without this comment.

Thanks,
Mauro
