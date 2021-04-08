Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEBE357D7E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhDHHlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhDHHla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:41:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D34FD6113A;
        Thu,  8 Apr 2021 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617867679;
        bh=xxNX0m+8Gxl1L8GQASi5C/ka0wkUuOHo19jCsCKTLzU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TozqV++Kd/OjBnht0XoHu4yYQnYxttTxRHsmXE5BSRXlnmJYYKiy1JlrvM8k+FtBe
         rWNr6i+SQFHPE569cxWga9MMkL46HFXMIdn1sgwA0cvh3wdZrBA8zxuTJCfEINJ0hr
         dZeVx8dy95FMUEA1Hd7y6vRBw8vBJZCNmiCNozNUzg6vmSn+WYeFGmNg64GzfXPNxc
         m5suAOQGTRyUSpy9O8L0dfzfa1NH63hGfJ7JcyeFdlkmI2uj0cygV/F5wVphhRSg2H
         mXk6WiBTYicwa/VHR4EC0ztmEXVCC7M8fp3cZKCfcz/WdGysW+GBaMqe93whLahuWV
         5Utq92TNb7BIA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210408095312.00004267@163.com>
References: <1616469034-9691-1-git-send-email-dj0227@163.com> <161715700800.2260335.7834636340431628632@swboyd.mtv.corp.google.com> <20210408095312.00004267@163.com>
Subject: Re: [PATCH]  clk: imx: reference preceded by free
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     abel.vesa@nxp.com, mturquette@baylibre.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, Jian Dong <dongjian@yulong.com>
To:     Jian Dong <dj0227@163.com>
Date:   Thu, 08 Apr 2021 00:41:18 -0700
Message-ID: <161786767850.3790633.2996848068001353291@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jian Dong (2021-04-07 18:53:12)
> On Tue, 30 Mar 2021 19:16:48 -0700
> Stephen Boyd <sboyd@kernel.org> wrote:
>=20
> > Quoting Jian Dong (2021-03-22 20:10:34)
> > > From: Jian Dong <dongjian@yulong.com>
> > >=20
> > >  when register failed, clk will be freed, it will generate dangling
> > > pointer problem in later reference. it should return directly.
> > >=20
> > > Signed-off-by: Jian Dong <dongjian@yulong.com>
> > > --- =20
> >=20
> > Any Fixes tag?
>=20
> Sorry for late, I'm unfamiliar with tag rule.
>=20
> For this patch include two files commit 2f77296d3 and fe37b482
> maybe likes:
>=20
> Fixes: 2f77296d3        (clk: imx: add lpcg clock support)
> Fixes: fe37b482         (clk: imx: add scu clock common part)
>=20
> and I noticed this patch has been merged, do I need RESEND again with
> tags like above?
>=20

Looks like Abel already picked it up so no need to resend.
