Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2182393312
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbhE0QBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:01:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:48016 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236736AbhE0QBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:01:44 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 86F542D6;
        Thu, 27 May 2021 16:00:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 86F542D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622131210; bh=8T/nB5f/r77tdlhAKOPk62iWe1qb9lmrEftk1GQJ4O4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=h6SVsC9zr1T/73w4m2I5md/n/b6t+3wq3YoNLTbQ7+BSHUFsnKHRNHJi1RwhP0JvS
         7EJiapPdANHc5yNA5iUesYeYOesUEPUCT66AtIu/x+9ZSWSFHqCKW7XTqNUFwUdvvn
         oSUMPS1WAzlbtREMKhFFkk8FyDO1gQsy+R0y87LaKirz52ejCtCp6o2YxqIPs5ynha
         J/qH/pS86RzjTzfUZDWbw43u+SRGNeq9eGsZZeW60Z7oalJN7vRVqNtOLjeLd2DMd5
         J2maFWISJpZr7efLCsFyknxEv45qqiqf2GTwWSm4KZWsPFHnANOpT7yT43Mg1MiPNd
         isRViuKqfVZCA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Wu X.C." <bobwxc@email.cn>, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v4] docs: Activate exCJK only in CJK chapters
In-Reply-To: <83208ddc-5de9-b283-3fd6-92c635348ca0@gmail.com>
References: <2061da0a-6ab1-35f3-99c1-dbc415444f37@gmail.com>
 <83208ddc-5de9-b283-3fd6-92c635348ca0@gmail.com>
Date:   Thu, 27 May 2021 10:00:09 -0600
Message-ID: <878s40416e.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Activating xeCJK in English and Italian-translation documents
> results in sub-optimal typesetting with wide-looking apostrophes
> and quotation marks.
>
> The xeCJK package provides macros for enabling and disabling its
> effect in the middle of a document, namely \makexeCJKactive and
> \makexeCJKinactive.
>
> So the goal of this change is to activate xeCJK in the relevant
> chapters in translations.
>
> To do this:
>
>     o Define custom macros in the preamble depending on the
>       availability of the "Noto Sans CJK" font so that those
>       macros can be used regardless of the use of xeCJK package.
>
>     o Patch \sphinxtableofcontents so that xeCJK is inactivated
>       after table of contents.
>
>     o Embed those custom macros in each language's index.rst file
>       as a ".. raw:: latex" construct.
>
> Note: A CJK chapter needs \kerneldocCJKon in front of its chapter
> heading, while a non-CJK chapter should have \kerneldocCJKoff
> below its chapter heading.
>
> This is to make sure the CJK font is available to CJK chapter's
> heading and ending page's footer.
>
> Tested against Sphinx versions 2.4.4 and 4.0.2.
>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Tested-by: Wu XiangCheng <bobwxc@email.cn>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Link: https://lore.kernel.org/lkml/2061da0a-6ab1-35f3-99c1-dbc415444f37@gmail.com

I've applied this, thanks.

jon
