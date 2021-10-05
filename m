Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEFD421FF3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhJEH60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233612AbhJEH55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:57:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B446961350;
        Tue,  5 Oct 2021 07:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633420567;
        bh=f4gsbsUJ2pbvz6Vm0qN214XBzGKbfjvTDyCDkH9qwoU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jr0uAPEXaN1ov5aY1GCXK4ansIV4xeQfmIv3dWlzxw+RKXAoYflkVVtsEW+QkLn9i
         HoXNedAH5S4LUu787uOK/T6ITBB3sozWJhgDKVB/wW4sgnfNclbRJhIb/JTav+mOoa
         qFMoPvursQplbFXEaRSU/zmIRnQUp6ilmv+sdINxLTZ0dfyMDxVWY9xmuxgPgOuS6y
         ezvhoaJ4cJLGpifj2IxbDEO5kRjuYFOC7J3s2Q08XEXYPo7V0Utu55n0cozKNebRNs
         vAb0Pze/6bXxz08oVdPvpQJoOZ49bhLqUJd7RpzAabo/c1RoYUfPYJQi8owr8N9FA9
         qiRYYsp4W0QQA==
Date:   Tue, 5 Oct 2021 09:56:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] mfd: hi6421-spmi-pmic: cleanup drvdata
Message-ID: <20211005095603.0e204776@coco.lan>
In-Reply-To: <YVwD2sPZMCtwP9yf@google.com>
References: <b6102d6db357ebb5c937f460a564c6f26281e403.1631709890.git.mchehab+huawei@kernel.org>
        <YVwD2sPZMCtwP9yf@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 5 Oct 2021 08:50:50 +0100
Lee Jones <lee.jones@linaro.org> escreveu:

> On Wed, 15 Sep 2021, Mauro Carvalho Chehab wrote:
> 
> > There are lots of fields at struct hi6421_spmi_pmic that aren't
> > used. In a matter of fact, only regmap is needed.
> > 
> > So, drop the struct as a hole, and set just the regmap as
> > the drvdata.
> > 
> > Acked-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  drivers/mfd/hi6421-spmi-pmic.c           | 16 +++++----------
> >  drivers/misc/hi6421v600-irq.c            |  9 ++++-----
> >  drivers/regulator/hi6421v600-regulator.c | 10 +++++-----
> >  include/linux/mfd/hi6421-spmi-pmic.h     | 25 ------------------------
> >  4 files changed, 14 insertions(+), 46 deletions(-)
> >  delete mode 100644 include/linux/mfd/hi6421-spmi-pmic.h  
> 
> For my own reference (apply this as-is to your sign-off block):
> 
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> I intend to take this with a Misc Ack.

Hi Lee,

Greg already gave you:

	https://lore.kernel.org/all/YVLA14jbwqXjNM2f@kroah.com/

Regards,
Mauro
