Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A1041AB86
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbhI1JKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239795AbhI1JKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:10:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEEAC60FC2;
        Tue, 28 Sep 2021 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632820155;
        bh=1Vhte9Ro5QwLvH3RD7I8NX1g4Y5GHjQOuHyXqDB5SP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RiqHZJ56Bc8xwKRyjWd2VRc6QiAa7sRjm1CkEUTVcMIHDKRWw2iszX6r6mRPogcBB
         uqkRyMbgkovNzgH4FSOxKKyZClW+DdlTPv+9/naHJ98JmDFbA1i4q6YKDOzoj/FX16
         FjgQvZ2xYhMalZlnB8jA/gLoDbHapX/dw6zJVZ7w=
Date:   Tue, 28 Sep 2021 11:09:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: hi6421-spmi-pmic: cleanup drvdata
Message-ID: <YVLbuI6SXVPy2CQm@kroah.com>
References: <YUsuZaMJoEMHkxgG@google.com>
 <0cc63f19506ea78d3a1c111774c97bbbc1a9a292.1632812219.git.mchehab+huawei@kernel.org>
 <YVLA14jbwqXjNM2f@kroah.com>
 <YVLI9sXN2R/IHSzq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVLI9sXN2R/IHSzq@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 08:49:10AM +0100, Lee Jones wrote:
> On Tue, 28 Sep 2021, Greg Kroah-Hartman wrote:
> 
> > On Tue, Sep 28, 2021 at 08:58:19AM +0200, Mauro Carvalho Chehab wrote:
> > > There are lots of fields in struct hi6421_spmi_pmic that aren't
> > > used. As a matter of fact, only regmap is needed.
> > > 
> > > So, drop the struct as a whole, and just set the regmap as
> > > the drvdata.
> > > 
> > > Acked-by: Mark Brown <broonie@kernel.org>
> > > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > 
> > As everyone else acked this, any objection for me to just take this in
> > my char-misc tree?
> > 
> > Otherwise, whoever else want to take it:
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> If you do end up taking it, you'll have to convert my Ack.
> 
> Although, I'm probably in a better position to take it TBH.
> 
> Happy with either.  You decide.

You can take it, thanks!

greg k-h
