Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0C9316FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhBJTSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:18:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:33878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233224AbhBJTSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:18:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA95B64E6F;
        Wed, 10 Feb 2021 19:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612984686;
        bh=bI1+l4RjA4lmiWBw0Fmh1n7HvJNbX+aLWt47sQQTcN0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hsd38Yq9nOlGc+cSPrmltZL8/oRvFmb6HiPYWz0gltqGL5jujif0rhMxBBS8kKn2Q
         /hGtnFIIZW9rSNFutJYJwNp4D4NxebhT+/61RvzXnCnMWLgNiAzjY4VW0mnlODlH7I
         psAM9WQETTW2ZmO7vsw+fIcvbxR9nmR9cDij81tpenuzpgeBqxCoX+Bf7JgwCgPfKX
         yYRvfR7LlmT36vbB5yOLIK9FeQBPMLDKSyz2LV79Mi+f5bxwv2R03eJEhyaTj2h+p5
         bC3/d175vCOSZeTDwoV6/94/5HcTvLt+BycKchJvD48TxoUQpXq5GX+b2hAyhso/hK
         Uq/CALOOoS3Mg==
Date:   Wed, 10 Feb 2021 20:18:01 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     nnet <nnet@fastmail.fm>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>, a.heider@gmail.com,
        andrew@lunn.ch, gerald@gk2.net, gregory.clement@bootlin.com,
        kostap@marvell.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        luka.perkov@sartura.hr, miquel.raynal@bootlin.com,
        mturquette@baylibre.com, rmk+kernel@armlinux.org.uk,
        sboyd@kernel.org, tmn505@gmail.com, vladimir.vid@sartura.hr
Subject: Re: [PATCH mvebu v2 00/10] Armada 37xx: Fix cpufreq changing base
 CPU speed to 800 MHz from 1000 MHz
Message-ID: <20210210201801.6d329b76@kernel.org>
In-Reply-To: <966f50f2-68b2-4d4f-85f0-396df112c0f4@www.fastmail.com>
References: <20210209224223.p22yhjdy7ibzepss@pali>
        <93745280-dbe9-491c-a79d-c9c364b83880@www.fastmail.com>
        <20210209225630.mdwnzkvnaz3r4blt@pali>
        <a86c5069-d423-44db-92dd-b3e406b7ec91@www.fastmail.com>
        <20210210002619.43104a9b@kernel.org>
        <ac03801e-87e2-4e57-b131-bff52f03579d@www.fastmail.com>
        <1cd0c2ee-aa3a-4da2-9c0c-57cc5a1dad49@www.fastmail.com>
        <a1277b1f-f829-4d02-9e54-68ab4faaa047@www.fastmail.com>
        <20210210092339.qy6wwuq6qr5m2ozr@pali>
        <d6971325-af71-4f71-91c2-7b661804c022@www.fastmail.com>
        <20210210180322.rlfxdussqhejqpo6@pali>
        <966f50f2-68b2-4d4f-85f0-396df112c0f4@www.fastmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021 11:08:59 -0800
nnet <nnet@fastmail.fm> wrote:

> => md d0012604 1; md d0012604 1; md d0012604 1  
> d0012604: 2b417501                               .uA+
> d0012604: 0000945b                               [...
> d0012604: 00000000                               ....

So this means that in OTP you have this values:
1200 MHz - 1213 mV
1000 MHz - 1213 mV
 800 MHz - 1097 mV
 600 MHz -  898 mV
