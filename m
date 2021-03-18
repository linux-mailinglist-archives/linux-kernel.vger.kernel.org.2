Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DDB340CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhCRSSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhCRSST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:18:19 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A78BC06174A;
        Thu, 18 Mar 2021 11:18:19 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 181CD2C4;
        Thu, 18 Mar 2021 18:18:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 181CD2C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1616091499; bh=D6+NW32QhsSkiW9Ttc6kcoqu/iMNIPHgo6s+YdkpRNA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HgPD5ZwmH755X2ZgoYdrsMiW0iDui3F4GJMFBClm4A+IY2kD3oPGUeIPvG0jOfHQE
         QibBHM5GyOnNEqJvriRmgZIHnyfoMOzExLX2TOafaTqM6hyU18PfjDDMbYjS5SI805
         85dOU+FPnSwlG7GpdMJIXmv8rucBUNRBQzG3l9A1kzatbXVWi3hiGWCb/2YgpGlLS2
         PoH4M85XJGbvxO+b6saMsGX1yP5ZwxwPctsQstBzm2TdljkRy5OycOJo/kYmq/xKZs
         3u+9r4bx7S83rYOWu+kHYcipjcTE76kD941rGVbG7sD9OHG2J15o4SxMryEa8lZXmB
         EwLrq7rL0tKYQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Aditya <yashsri421@gmail.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC] scripts: kernel-doc: avoid warnings due to initial
 commented lines in file
In-Reply-To: <CAKXUXMxWOvM5HRwmAAWEsqQc2k6_ReqRw0uD=VANLO5D7OpFtg@mail.gmail.com>
References: <20210309125324.4456-1-yashsri421@gmail.com>
 <8959bf29-9ee1-6a1d-da18-f440232864f3@darmarit.de>
 <c673e76f-72db-bbee-39d6-f5428e765173@gmail.com>
 <871rcg2p8g.fsf@meer.lwn.net>
 <CAKXUXMzwTp1H_vokVEAJSnmm7jNHfWzhhmLfpcrrBD9b8ak+dA@mail.gmail.com>
 <878s6kto3g.fsf@meer.lwn.net>
 <CAKXUXMxWOvM5HRwmAAWEsqQc2k6_ReqRw0uD=VANLO5D7OpFtg@mail.gmail.com>
Date:   Thu, 18 Mar 2021 12:18:18 -0600
Message-ID: <87o8fgpbpx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> Yeah, and as this line-counting is really just a poor man's
> heuristics, we might just be better to really turn this heuristics
> into a dedicated cleanup warning script, then we can check for more
> indicators, such as "does it contain the word Copyright" somewhere in
> the kernel-doc comment, which tells us even more that this is not a
> kernel-doc as we would expect it.

I really don't think we need that kind of heuristic.  The format of
kerneldoc comments is fairly rigid; it shouldn't be too hard to pick out
the /** comments that don't fit that format, right?  Am I missing
something there?

Thanks,

jon
