Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204C331CE6D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhBPQwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhBPQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:52:04 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9E9C061574;
        Tue, 16 Feb 2021 08:51:24 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2354EA75;
        Tue, 16 Feb 2021 16:51:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2354EA75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1613494284; bh=HLmvc8W/HRBkPh9zXtCkwf3n0e9QtiWcP4PGDLbH4kg=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=KYhFxJX3np7CDLbpEmIwJuU/XzKGejAkLbwfgzGJ0NJFv2VORcZa/Rfiw0usyT0j+
         1lia+cQ4z2sCg74Y3UoAGASS2fDm/xmg9NGuaJ6AehXWvM2bdo0XV+ORK4vsU6tKPn
         TqX/q5QATAmr+jyMkSM9uVXlYGpzlKCBft8H/bBggSemFRA8Y4jO6JAhbnd7rUAdMY
         yCqb+jbh2Fw1Vu4ocNkpFAAxvAXo6dMQks8V5dR0WEEUr9zjdBR4Zn7YdPfQgwMaEi
         7+unwuVDly12oky47LzrNR9fnWP/16DAkoxA+PmVLgxyWvpmzc26CzdkjW0VeDnmje
         whd2DLazKzSEg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: anonymous enums in kernel doc
In-Reply-To: <CAHp75VfpnGEZcnrQLFYaFQ-HuxTmPw5OnewKmRGfXQf__ztjww@mail.gmail.com>
References: <CAHp75VfpnGEZcnrQLFYaFQ-HuxTmPw5OnewKmRGfXQf__ztjww@mail.gmail.com>
Date:   Tue, 16 Feb 2021 09:51:23 -0700
Message-ID: <87r1lgx8fo.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> Mauro, can you do some test cases in your workflow against anonymous
> enum in ernel doc, please?
>
> They are broken again, please fix the script!
>
> drivers/pinctrl/intel/pinctrl-intel.c:204: warning: wrong kernel-doc
> identifier on line:
> * enum - Locking variants of the pad configuration
>
> Above is simply a wrong statement.

The real problem, perhaps, is that there seems to be little point in
adding kerneldoc comments for anonymous enums; where are you going to
use that documentation?  The error message could perhaps be changed to
say that; meanwhile, perhaps this one could be fixed with an action like
s%/**%/*% ?

Thanks,

jon
