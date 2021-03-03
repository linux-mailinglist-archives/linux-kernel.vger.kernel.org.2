Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1254632C000
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579321AbhCCSbB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Mar 2021 13:31:01 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:50128 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240311AbhCCQfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:35:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6F9BA6083275;
        Wed,  3 Mar 2021 17:34:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XkqzEhlnOBsv; Wed,  3 Mar 2021 17:34:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 214DD6083244;
        Wed,  3 Mar 2021 17:34:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 55hyWb7TB4oV; Wed,  3 Mar 2021 17:34:02 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id EEA2A608A38A;
        Wed,  3 Mar 2021 17:34:01 +0100 (CET)
Date:   Wed, 3 Mar 2021 17:34:01 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <675291050.42876.1614789241828.JavaMail.zimbra@nod.at>
In-Reply-To: <040cf2058fe4cf5e63dbff534582881a@walle.cc>
References: <20210303155735.25887-1-michael@walle.cc> <YD+0mAPTMN8AwNBx@kroah.com> <689194005.42755.1614788236355.JavaMail.zimbra@nod.at> <040cf2058fe4cf5e63dbff534582881a@walle.cc>
Subject: Re: [PATCH] mtd: require write permissions for locking and badblock
 ioctls
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: require write permissions for locking and badblock ioctls
Thread-Index: xINH3Mpwe4blEkzF/YfzWKJ0Ni21Ug==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
>>> Thanks for auditing the rest of these from my original patch.  If this
>>> is ok with userspace tools, it's fine with me, but I don't even have
>>> this hardware to test with :)
>> 
>> That's my fear. Michael, did you verify?
> 
> I don't know any tools except the mtd-utils. So no.

openwrt folks have their own tooling, Anrdoid too.
 
>> In general you need to be root to open these device files.
>> So, I don't see a security problem here.
> 
> Then this begs the question, why is this check there in
> the first place?

I fear historical reasons.
As soon you can open the device node you can do evil things.

> This come up because I was adding a OTPERASE which
> was suggested that is was a "dangerous" command. So I
> was puzzled why the ones above are considered "safe" ;)

:-)

Thanks,
//richard
