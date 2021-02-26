Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E3A3268C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 21:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhBZU2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 15:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhBZUUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:20:23 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB01AC061788;
        Fri, 26 Feb 2021 12:19:42 -0800 (PST)
Received: from [192.168.1.101] (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 8EED93F363;
        Fri, 26 Feb 2021 21:19:39 +0100 (CET)
Subject: Re: [PATCH 06/41] arm64: dts: qcom: sdm630: Fix intc reg indentation
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konradybcio@gmail.com>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
 <20210226200414.167762-7-konrad.dybcio@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
Message-ID: <3212bcde-024f-fd42-8f68-156b4f09823a@somainline.org>
Date:   Fri, 26 Feb 2021 21:19:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210226200414.167762-7-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one slipped my watchlist and still uses the old email..

From: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by:  Konrad Dybcio <konrad.dybcio@somainline.org>

