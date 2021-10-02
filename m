Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331BC41FE37
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 23:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhJBVOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 17:14:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:40889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233122AbhJBVOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 17:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633209159;
        bh=yxMgNzarObbpsQDZSpvaMKY0E67LlRv3HMOpH2GLwpw=;
        h=X-UI-Sender-Class:From:To:CC:In-reply-to:Subject:Reply-to:
         References:Date;
        b=GZ8lvrhhxnbOdthB46NN5c0wvqBLCXsm+1acLFQc7yIY60DbDxPvBlgK06Mdkd3l/
         Sk0/5gIgHqfMkSLJCq42UfGmT+duVTkIUuDqZJnZlyau9VSirGKe2zHoHKaykmsfO1
         el+e9Qbq1mB0OPP1CTFQA/vgkLxAjSAhex1j36c0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from corona.crabdance.com ([173.228.106.131]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MEFvj-1mgzSM0qM1-00AIH5; Sat, 02 Oct 2021 23:12:39 +0200
Received: by corona.crabdance.com (Postfix, from userid 1000)
        id C8546899763; Sat,  2 Oct 2021 14:12:34 -0700 (PDT)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     richard@nod.at
CC:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-reply-to: <160773399.91203.1632175069460.JavaMail.zimbra@nod.at> (message
        from Richard Weinberger on Mon, 20 Sep 2021 23:57:49 +0200 (CEST))
Subject: Re: [PATCH 0/1] ubifs: ubifs to export filesystem error counters
Content-Type: text/plain
Reply-to: schaecsn@gmx.net
References: <20210907214034.11676-1-schaecsn@gmx.net> <20210920024824.9E053899858@corona.crabdance.com> <160773399.91203.1632175069460.JavaMail.zimbra@nod.at>
Message-Id: <20211002211234.C8546899763@corona.crabdance.com>
Date:   Sat,  2 Oct 2021 14:12:34 -0700 (PDT)
X-Provags-ID: V03:K1:MCTHo0Wi5ZVuZV+KppndXsSykkDLji6uoywLoQOeoirDVs+SAGl
 0eAEqG8eHUt4400kwgqyW0vEB7qeei+DTuVgkIC+Sz2PPGtmz09J83bi22EkrWWyOTqkPno
 lpm8EK5LhFdj/0wi/dNX9GnEht8giL52uKFbncVORHS0L7RL0qz1BlkD25jssq9csj0CbSS
 wM+SVhyGrtaMwDmKulYPA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k1mpkITKCeU=:hG3I8YuqG0vFlb4+tRvmnL
 bxPzYWNB+tNeUct7FPRl1xkglGCYapvK6YQWY3vqsnQvUeYYyYaNYJrkNJePdWd15ZoAP0Vzo
 oBInBSVnt3/cEjQojQRKP2m3AMk+eyzyNAMklFIE7EwzFi3Q1ppOeV/JlTKiT8v4BOpryTJOU
 kAemnqpTw/MBeoSmbkLJcSvGx4430zor/do+rfSfUq4v/O0IeYxVKAJIjfDwgeAK8+6ImqbAi
 t7uuOyOzqZ4O2dtovvWxo4psULGySVEOKNg87nXPKZYbXKwWzvbucVdmdV89RYRSpges5O28c
 9ouMxXFEmUTCxKjUR0YNX0n3JcoPtaLgIFO7PU8oa+JFtvksh+5rLzp5QYSv5Hq5v01tV5I4x
 XUIK941R2XHqlwA2zZG+5OyjV79pflbeRKGtRN7cPyLczC62LbugSEYI1VpFwFBgLKB67dkXB
 XQr2v5vlYt4athjeARtqPR9D/wr5MdqOAIpDnkB5mFppQkS8hmlBX30z+aEz+/HdR8cBn2KdM
 L9iO/H24zbBATQSHU+CX9DaJzpJPu9mCB0ihdq1D/oFNM71zk8gJ3ZZ4XNd+M9Scr25R6t/rs
 ud6xKWDYZS2wJUcWjck6BvtcUuKb+MuBooiY3IrVybkc4fqeJWh8BJuFDardBu4V9yftDe8PS
 CpxEP2p4d7sF7Cw5xPMjHPYORfMonDHWvOfla/ALoSye73horjLq7DGZ0UbTUmHhm59IlJbiD
 g0LhyHqPMTg9p//iLxDhIoZIU+qJWPYYPS0nhv2Ve4k0NJ1NwEK4QUqd/30hlNPuVF6KHKoPq
 7qsp2hCFWlSX1ioe0HtQnHNXzkOr2B96fCkLvJlUA9MoOvESVvr9i5v9oUswR6U6Cj7W/vcP0
 gmRevF61CMqsB5fMTEygJDs+cNFuwV0GgjyMsKkAMvBeWZ8t/nRd6Xu1EZzW1HFsksw5BVGGY
 SBduN3d7y9eMfOg6cI/Q9XNKCjQx6dZgYsVb+dNa+BSF34xhy3uPsraobiGZs19VDBQyaUDUt
 K+a7qGV35cYYS+O+iSZ4HBzMoHLGtW4Rmgd0n7xbdwqoHFJkhU0ukS9eZtoE//ej7SYytxgZ4
 81dPIbteUnm4aw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Richard,

> > Hello mtd/ubifs,
> >
> > I just want to check back on what you think about having a sysfs for u=
bifs and
> > starting with these three callbacks
> >
> > /sys/fs/ubifs/ubiX_Y/errors_magic
> > /sys/fs/ubifs/ubiX_Y/errors_node
> > /sys/fs/ubifs/ubiX_Y/errors_crc
>
> I didn't have a chance to review your changes to far but in general I li=
ke the idea
> if exposing such an interface.
> Sorry for being a slow maintainer.

I just wonder if you still like the idea of a sysfs for ubifs. At one poin=
t we
should then move forward.

 Stefan
