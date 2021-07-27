Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7D73D7CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhG0R5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhG0R5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:57:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34B5960F4F;
        Tue, 27 Jul 2021 17:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627408639;
        bh=a9AtedpsVUAuKM+1BFYeJHoM9kXALSnQx6b95mRzxr0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=crtnuMuVQtXJT+Dqi9SEAFT0Qqd2xh+phX/7i6EBctBM+InMqfTed18hsjWBFoYIk
         C+z+DvsgUJtVcdMhZYNEuXGzkS7mSvhRGcwy8gmLLCw5LPXyjrg7vK5KChezBxyUHt
         tZpDa3vMrUYd/Wyl09Vax8ZqVjGQayZRczoMJfL9As0tkICVsluu0+KJGaluCR0Vkf
         mWUjtEJt+ttHoTUd6NaDbIErl6cnAQ8js/mXvSWUBef9+IDT2Jd5gRwf2QljbCDd7l
         5ewaMVjFeJ1veb1hbtlw1011SuL6k1dzBs2gG2VamVhZwq2bEm/idtM9I5wObyFdVL
         gOevpWNZVwmcQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210726105719.15793-19-chun-jie.chen@mediatek.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-19-chun-jie.chen@mediatek.com>
Subject: Re: [v14 18/21] clk: mediatek: Add MT8192 msdc clock support
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
Date:   Tue, 27 Jul 2021 10:57:17 -0700
Message-ID: <162740863716.2368309.17172525283851255354@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-07-26 03:57:16)
> Add MT8192 msdc and msdc top clock providers
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---

Applied to clk-next
