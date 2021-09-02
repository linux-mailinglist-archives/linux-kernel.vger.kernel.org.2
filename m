Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C973FED73
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344110AbhIBMF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234081AbhIBMF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:05:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CD09610CD;
        Thu,  2 Sep 2021 12:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630584297;
        bh=XEJ22fybLy+xqqo6hMmuHOERgi3ERFS9VjtxxIiwxXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQ/ZLYckHKCRNITKra/ue/bx03EDtGEhlUw04OJHPWzUsqoep3MTX4WDir1FFIGCt
         6hk9myn0d7gd0bZrPzSRnomDTTsyUaUuafc8f5uxqYDiGzM/rgnzZIpa4un2ArfgoA
         KVzjWVAjbFvFecPUwOJ5xOHhSFhUsHRgOC6Bvw0s=
Date:   Thu, 2 Sep 2021 14:04:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: hi6421-spmi-pmic: cleanup drvdata
Message-ID: <YTC95yQxoZ/0B26b@kroah.com>
References: <6959a4b11cb840aaae8d144889bb7b4899c3b335.1630583284.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6959a4b11cb840aaae8d144889bb7b4899c3b335.1630583284.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 01:48:11PM +0200, Mauro Carvalho Chehab wrote:
> There are lots of fields at struct hi6421_spmi_pmic that aren't
> used. In a matter of fact, only regmap is needed.
> 
> So, drop the struct as a hole, and set just the regmap as
> the drvdata.
> 
> While here, add a missing dot at the Huawei's copyrights.

What "missing dot"?  I do not see any such change in this patch :(

