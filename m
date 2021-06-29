Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401863B7339
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhF2NfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 09:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233665AbhF2Nex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:34:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2780C61D4D;
        Tue, 29 Jun 2021 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624973546;
        bh=N5nKZVhyVnaXFO9+amiH8e/fbL4qqMXzYfOv0Kle2zE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eVP7SmWCkWzDclN1i8ksCFuxBtjFOEqTGF51EEW8UVNImYHbhS//oBYnmqtviOHJ/
         /1tWsd9FG8UlSlOi48GENozjsYxriURvrCjaxFYU+NjwC+E4uT9mICxEl/Lbyw7joj
         lZeh7hu24NZAQTUBCAV8L83tQZEUG+AUJ+OsLl5dgaxfRSzh1jrBwOI83ugSVIkTBp
         5RDRi9qZEw0twKcHfMzslO14t6hrn93z/HDj607kTvBoKrObYyBd5DCEch3OOFb6zm
         DedgGmwp9UFymfXgaYbc6Q1063ETsm/i3SafneAqL24zPQuRP+ESzwsb6PBU9XvI2c
         r7yoDMcjb74SA==
Date:   Tue, 29 Jun 2021 15:32:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v10 2/5] regulator: hi6421v600-regulator: fix platform
 drvdata
Message-ID: <20210629153220.52fffece@coco.lan>
In-Reply-To: <CAFRkauCPKQyD_Dooqrxvra94RyLXrPDeCSSdfBfvh-o0Zh8q3g@mail.gmail.com>
References: <cover.1624962269.git.mchehab+huawei@kernel.org>
        <eed34e8897c79a2ab13573d3da12c86569bca0f6.1624962269.git.mchehab+huawei@kernel.org>
        <CAFRkauCzHqUfva+zTRhOyiMMb4WsKPHvYJuqpOPwy+siPMZGOQ@mail.gmail.com>
        <20210629130957.484f5c43@coco.lan>
        <CAFRkauCPKQyD_Dooqrxvra94RyLXrPDeCSSdfBfvh-o0Zh8q3g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 29 Jun 2021 20:51:01 +0800
Axel Lin <axel.lin@ingics.com> escreveu:

> > If you're in doubt, try to apply this series, and then change the
> > driver again to use platform data. You'll see that it will stop
> > booting after initializing the first regulator.
> >  
> 
> Sorry I don't have this h/w to test.

Then, why do you care? Your patch broke the driver. Changes like
that should be tested on a real hardware, in order to avoid
regressions.

Thanks,
Mauro
