Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2376942CDDA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhJMW0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231339AbhJMW0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:26:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14C88610FE;
        Wed, 13 Oct 2021 22:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634163870;
        bh=ALxBKYlLl531lA80YRE4l+ROVmmHmTDOT72LjPi7gTM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eFyfy7p8MDZB8qsf/66JpHPjfM4FzuyXuUsZrP+gJroo4mFz/tWN+zBNG2vgO8q9G
         ry2GT1EW5IokqgVSCZfm9TIkhpT9e9B1qcJdbvwL0QAfip39d63lGVL8a8SKMj3T1o
         v5JbofG9DIZdNmCsVLpm1l6MsXwOLKKfiNAhAY/jZL0K8HNt30nA20Db2w8tLpDOiE
         4jdehNLEnbuCo2gNRetL/491dMKihCwHc8A3WOGkZ+5EknpBdaT5seKEXP//ggxSCk
         MlglKr1T6/ZwjMPdz/XGVd3RiXAv2tkQKlyPJTYWQNM7k3hEHK63ErcKPjSIaudcHq
         ZnGgXzq2nA76Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1633484416-27852-1-git-send-email-tdas@codeaurora.org>
References: <1633484416-27852-1-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH 1/3] clk: qcom: Kconfig: Sort the symbol for SC_LPASS_CORECC_7180
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Wed, 13 Oct 2021 15:24:28 -0700
Message-ID: <163416386868.936110.15823504684881599548@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2021-10-05 18:40:14)
> Fix the order of the Kconfig symbol for SC_LPASS_CORECC_7180.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next
