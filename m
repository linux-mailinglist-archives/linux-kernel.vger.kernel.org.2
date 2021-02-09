Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E48315C66
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbhBJBhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:37:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234216AbhBIX1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:27:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86D0764E0D;
        Tue,  9 Feb 2021 23:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612913184;
        bh=XpMyJu/iwBK2KIYgNXuNqtt58XrlGklwGk2mLpeS+LM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CkVwGySmdW2hXaDAiyoHi0KFMyIj5jRo5GGr8Gex8b9xy3UWp0cuRJ7d39chNROdc
         K7JWhgtS7haX/9jm9a+ZU0BJKUEKmlCPrtXETDOM/JgFS7zQ3P8cfVtZ/qyCIUPY9B
         ijjd2zZI7sKloRbenpN7KT4nF3jq7fQAzVDznW3RcS8WCXTuwRuCUBgPBVwZu06ept
         ovJIq7Mdh8u53tCeCGpSsMA9uaVwSBLychl6QIrfqhGaGDnyzxqJSVBKFe5ZS3I8Ku
         ZQ/hrZ7P6ONKn1Wxwjp7xDsWc/FbjkUA4BgCYkimYv26W+tDv4hoqzwJ1+fDxaVSRQ
         XCX7qsVM62D8Q==
Date:   Wed, 10 Feb 2021 00:26:19 +0100
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
Message-ID: <20210210002619.43104a9b@kernel.org>
In-Reply-To: <a86c5069-d423-44db-92dd-b3e406b7ec91@www.fastmail.com>
References: <d59ba191-43db-4b7b-b201-62a60ca752c0@www.fastmail.com>
        <20210209213330.hnc7op72zoj24mgz@pali>
        <7b0988cc-eeb8-4ea7-92f6-e8234ca910d3@www.fastmail.com>
        <20210209224223.p22yhjdy7ibzepss@pali>
        <93745280-dbe9-491c-a79d-c9c364b83880@www.fastmail.com>
        <20210209225630.mdwnzkvnaz3r4blt@pali>
        <a86c5069-d423-44db-92dd-b3e406b7ec91@www.fastmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Feb 2021 15:16:45 -0800
nnet <nnet@fastmail.fm> wrote:

> I've two of these and I've just swapped them (and re-pasted the heat sinks).
> 
> The second one ran under load for awhile and now has frozen as well.
> 
> Under a moderate load `wget -O /dev/null <large.bin>` @X00Mbits they are fine.
> 
> Under a 1 min speed test of load ~200Mbits routed WireGuard they freeze.
> 
> They fine with both those workloads @1000_800.
> 
> Perhaps it's heat? Unfortunately I don't have any numbers on that ATM.

Try disabling cpufreq in kernel completely, compile boot image at
1200 MHz. If it continues freezing, then I fear we can't help you with
1200 MHz :(

Marek
