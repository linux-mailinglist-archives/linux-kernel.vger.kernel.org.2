Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E89541A972
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbhI1HQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233681AbhI1HQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:16:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD7DE611CA;
        Tue, 28 Sep 2021 07:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632813273;
        bh=aLHU7FlZOD3i0JWyAgeAMQ+892/l2DAnTYYZt5uVdYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rV0kRJxA0GfXCLOdzoc3qyorGN7j0itIt+pb83Ocq7K7KeRxSA9K0R5sTncu1c0pv
         hrvhPD1aR4LsZwUvUjdZpaZexC3CIjb2hD/woiGU2qFUAw8R8/u0EuvVocOcou0Uqc
         alxQDB2kjV4SU2h+adM3HLKtI0HS8rMnnCDDeVa8=
Date:   Tue, 28 Sep 2021 09:14:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: hi6421-spmi-pmic: cleanup drvdata
Message-ID: <YVLA14jbwqXjNM2f@kroah.com>
References: <YUsuZaMJoEMHkxgG@google.com>
 <0cc63f19506ea78d3a1c111774c97bbbc1a9a292.1632812219.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cc63f19506ea78d3a1c111774c97bbbc1a9a292.1632812219.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 08:58:19AM +0200, Mauro Carvalho Chehab wrote:
> There are lots of fields in struct hi6421_spmi_pmic that aren't
> used. As a matter of fact, only regmap is needed.
> 
> So, drop the struct as a whole, and just set the regmap as
> the drvdata.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As everyone else acked this, any objection for me to just take this in
my char-misc tree?

Otherwise, whoever else want to take it:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

thanks,

greg k-h
