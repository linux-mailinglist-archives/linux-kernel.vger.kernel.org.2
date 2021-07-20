Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207233CF283
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 05:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243120AbhGTCpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 22:45:55 -0400
Received: from out2.migadu.com ([188.165.223.204]:62805 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243599AbhGTCoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 22:44:20 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1626751475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sw5SEhUMVjH0b29chfgxZqMFJVmpaqk6z1U2SbaeDhc=;
        b=kHy2EfQpVAZ3qPpl6gQsKUpcT/Gqg2glWAApmeYfeUDyi6N6yt+yRW0cvmbufk9nEQPjo4
        3tbuFN33FZhwJ1MoPn/Hlzpqp+8erGniUzGElWW4HGOvwJO0EGiOYQH2sQ6vDymLRMYKQ/
        Ps59MrPTbGQ0/8WprW5ABtHu0c0P8tk=
Date:   Tue, 20 Jul 2021 03:24:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yajun.deng@linux.dev
Message-ID: <086ce4244213ed4fd8b0557033b8d2a7@linux.dev>
Subject: Re: [PATCH 2/4] net: Adjustment parameters in rtnl_notify()
To:     "=?utf-8?B?UsOpbWkgRGVuaXMtQ291cm1vbnQ=?=" <remi@remlab.net>,
        courmisch@gmail.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <5299846.uZDWVASI8p@basile.remlab.net>
References: <5299846.uZDWVASI8p@basile.remlab.net>
 <20210719122506.5414-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

July 19, 2021 10:36 PM, "R=C3=A9mi Denis-Courmont" <remi@remlab.net> wrot=
e:=0A=0A> Hi,=0A> =0A> Le maanantaina 19. hein=C3=A4kuuta 2021, 15.25.06 =
EEST Yajun Deng a =C3=A9crit :=0A> =0A>> The fifth parameter alread modif=
y from 'struct nlmsghdr *nlh' to=0A>> 'int report', just adjustment them.=
=0A> =0A> I can't see that anywhere in the patch.=0AI had resent the [PAT=
H 0/4] and [PATH 1/4].=0A> =0A>> Add the case the nlh variable is NULL in=
 nlmsg_report().=0A>> =0A>> Signed-off-by: Yajun Deng <yajun.deng@linux.d=
ev>=0A>> =0A>> diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netli=
nk.c=0A>> index 59aebe296890..03e04d0b8453 100644=0A>> --- a/net/phonet/p=
n_netlink.c=0A>> +++ b/net/phonet/pn_netlink.c=0A>> @@ -38,7 +38,7 @@ voi=
d phonet_address_notify(int event, struct net_device=0A>> *dev, u8 addr) =
goto errout;=0A>> }=0A>> rtnl_notify(skb, dev_net(dev), 0,=0A>> - RTNLGRP=
_PHONET_IFADDR, NULL, GFP_KERNEL);=0A>> + RTNLGRP_PHONET_IFADDR, 0, GFP_K=
ERNEL);=0A>> return;=0A>> errout:=0A>> rtnl_set_sk_err(dev_net(dev), RTNL=
GRP_PHONET_IFADDR, err);=0A>> @@ -204,7 +204,7 @@ void rtm_phonet_notify(=
int event, struct net_device=0A>> *dev, u8 dst) goto errout;=0A>> }=0A>> =
rtnl_notify(skb, dev_net(dev), 0,=0A>> - RTNLGRP_PHONET_ROUTE, NULL, GFP_=
KERNEL);=0A>> + RTNLGRP_PHONET_ROUTE, 0, GFP_KERNEL);=0A>> return;=0A>> e=
rrout:=0A>> rtnl_set_sk_err(dev_net(dev), RTNLGRP_PHONET_ROUTE, err);=0A>=
 =0A> Sorry but I don't like to replace explicit NULL pointers with impli=
citly=0A> converted zeroes.=0A> =0A> --=0A> =E9=9B=B7=E7=B1=B3=E2=80=A7=
=E5=BE=B7=E5=B0=BC-=E5=BA=93=E5=B0=94=E8=92=99=0A> http://www.remlab.net
