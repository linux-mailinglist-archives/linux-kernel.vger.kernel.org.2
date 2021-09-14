Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62D340BB40
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbhINWU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235579AbhINWUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:20:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34E546115B;
        Tue, 14 Sep 2021 22:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631657971;
        bh=q+mdlni/Lc4QXtv6o/C+t7RnY907X+7s3l2g53w6MvY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KDH6uBsMjp02Wma+DztUUPddGxrj1eWwDVD9Bmyul4zmCS2hUBb+PMOzutqfSbcxj
         IN61vHZcM4Y/OJdwHxWFrgnUy+To48Mmvpu3a+Df/SVvXJ1skKybALTvdMf0noHpcE
         x1rKppBM32vhHlC83/nsiE2kNuaqFSRnHwk10s8+q5kHZgEhagaTTiMqxuQKQD+F0S
         ppCHFbKLKRTxi8OZOW3T/jMw6mTG41IhmfH9iTLfTgYB+Fxt7EzGHiXbX4ipXy3bpk
         x62gQponqJCRa+lOTAY2OFMHsAb0j3WotBud+ajknniFL7MwpCRzs+zJEXe25BGTMt
         W370uzyg8KH5Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914021633.26377-17-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-17-chun-jie.chen@mediatek.com>
Subject: Re: [v3 16/24] clk: mediatek: Add MT8195 vdecsys clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Sep 2021 15:19:30 -0700
Message-ID: <163165797007.763609.1710818190993007147@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-09-13 19:16:25)
> Add MT8195 vdec clock controllers which provide clock gate
> control for video decoder.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied to clk-next
