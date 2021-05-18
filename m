Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139903872CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346924AbhERHF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346910AbhERHF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:05:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9421C611BD;
        Tue, 18 May 2021 07:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621321479;
        bh=/85N896sPWs3Fav4FWV2ONkGxpYFdYbrWJDrsPbsIjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rLGLHFuEcdOy7w2Wd/XB2zT2wwLC6szRWxMCr1x60/ToT3QpkRhACcC0Yv9dm6MGL
         o1qwTsWCAg1172YBPdyP0MrXBN9kJAoSm9sK99VE0iwCgnASLBx0+CYrU5QHPfHACi
         6vvR02vQzKYgWzKymTB7r1MJ+z5bCajBTvA4RJ1Jk6K/VjKKuz74Db47bMwlu0lDPi
         w/7hEu4OrF/1vED/jphC5PMrUYgMqfMrNk/v7deWTTpESICqmOBUHujDyoj4FOZced
         Op70sw7sTyf76i6lEO3/hvobT8xciu8MNM3+YaEr1BYztwfaXR2RKBheyE/5vN1koZ
         xzImpyi2HszDQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1litmP-0005jB-Lj; Tue, 18 May 2021 09:04:37 +0200
Date:   Tue, 18 May 2021 09:04:37 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tung Pham <Tung.Pham@silabs.com>
Cc:     Pho Tran <photranvan0712@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Pho Tran <Pho.Tran@silabs.com>
Subject: Re: [PATCH v12] USB: serial: cp210x: Add support for GPIOs on CP2108
Message-ID: <YKNnBckiw4fLIuQL@hovoldconsulting.com>
References: <CO1PR11MB488255D1B04D3B90886A59BE812C9@CO1PR11MB4882.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB488255D1B04D3B90886A59BE812C9@CO1PR11MB4882.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 03:18:06AM +0000, Tung Pham wrote:
> Dear Johan Hovold.
> Do you agree and approve with this path?.

I'm still waiting for you to confirm that you have tested the patch with
different pin configurations in eeprom. The first few iterations clearly
weren't tested and I don't want to waste more time reviewing it before
it's tested as I believe I mentioned in my last mail.

Johan
