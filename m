Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F1A3BA4D6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 22:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhGBUzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 16:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230274AbhGBUzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 16:55:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AF9D613E8;
        Fri,  2 Jul 2021 20:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625259180;
        bh=PmOqPkABTz0RGEK4HIf1Ym6gYzjtW5ypA2aziXgk48I=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=kcLD3i7qh/YjQW2E4JIcC/7cgdK9K+iUbSc5cwsWwWETBEk8njRL5hUKRyWS9z+En
         jtKkxbw9OfqNVYXxZxtfaEdm8Leb9zSg8iFYOkDmuX28PciJLh5C0Fx+zNB2K5YR7n
         yoxanA5rPlTgmGNaH4LEqqdMVukLeK8lkzTUR89ppRJGNt37XwHNcdzeeLY3twrMRu
         9IUgWKbJltujMPKQb8lrJ0r09cpcoJMA4ggIBJTZtLjKEwLZsywHUTjG7+RJgAahVT
         rj+HYwsicnRsP8OEFVjRcWM0TMLFmXGJK3tcm10JE0SzFMiYYxxRCmXuyY2eWFXgkK
         2HH8kDLER68lQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0000000000002de98c05c61dba72@google.com>
References: <0000000000002de98c05c61dba72@google.com>
Subject: Re: [syzbot] upstream build error (16)
From:   Stephen Boyd <sboyd@kernel.org>
To:     gengdongjiu@huawei.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        syzbot <syzbot+567c9f52d94ad483cac5@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Date:   Fri, 02 Jul 2021 13:52:59 -0700
Message-ID: <162525917933.3570193.3861451207856095054@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting syzbot (2021-07-01 23:04:23)
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    3dbdb38e Merge branch 'for-5.14' of git://git.kernel.org/=
p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11c93764300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcaee64f929f74=
d56
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D567c9f52d94ad48=
3cac5
> userspace arch: arm
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+567c9f52d94ad483cac5@syzkaller.appspotmail.com
>=20
> drivers/clk/hisilicon/clk-hi3559a.c:818: undefined reference to `hisi_res=
et_exit'
> drivers/clk/hisilicon/clk-hi3559a.c:800: undefined reference to `hisi_res=
et_init'
> arm-linux-gnueabi-ld: drivers/clk/hisilicon/clk-hi3559a.c:806: undefined =
reference to `hisi_reset_exit'
>=20

I think we fixed it. It's staged to merge in the next couple days.

#syz fix: clk: hisilicon: hi3559a: Drop __init markings everywhere
