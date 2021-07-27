Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE7A3D7CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhG0Rz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229981AbhG0Rz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:55:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36BB060F59;
        Tue, 27 Jul 2021 17:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627408527;
        bh=MbUdLe4herOvz3VgYQxFAs3Y7/pwlqErt8k7VK8fsG0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BMt5TzVeB9P7NWfLXzDJgUczfPSQXygcPbyrRJk8LHgvg8yMyt9doa8SEVdcaRGFm
         3nP3kPNVbXiIKxh4WMd6Z2WDTOaKj5csrbRKrkbLqunNoR45I2jbeXGilHmq0zDVsU
         8kiYSRNvjsJa4fTpBZgrAugQ3esDt4uPxXNpo8OKS8stRfVj0bto5V2BkToj1mQ5Y8
         /EFWKUm5hVsjLrS3SnuvkG1AaWGvfTV9gUNADZQVkQptz0EXIN9tfX1l33j7phenHt
         H8rBtfI1rUyRN66pQfrpEFCRK3UoR5Wmr000i+urrgakmvHsDphhon44ocu3JlmSAE
         Bx97lTFNa/4yQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210726105719.15793-10-chun-jie.chen@mediatek.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-10-chun-jie.chen@mediatek.com>
Subject: Re: [v14 09/21] clk: mediatek: Add MT8192 basic clocks support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 27 Jul 2021 10:55:24 -0700
Message-ID: <162740852499.2368309.12116800140443844946@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-07-26 03:57:07)
> Add MT8192 basic clock providers, include topckgen, apmixedsys,
> infracfg and pericfg.
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---

Applied to clk-next
