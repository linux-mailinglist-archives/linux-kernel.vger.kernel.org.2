Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0DA420149
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 13:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhJCLXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 07:23:25 -0400
Received: from relay03.th.seeweb.it ([5.144.164.164]:39275 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhJCLXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 07:23:24 -0400
Received: from [192.168.1.101] (83.6.167.124.neoplus.adsl.tpnet.pl [83.6.167.124])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id CF1FC1F67A;
        Sun,  3 Oct 2021 13:21:33 +0200 (CEST)
Message-ID: <778e6a99-a9aa-05a1-351b-ebf9efbf9033@somainline.org>
Date:   Sun, 3 Oct 2021 13:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 01/11] clk: qcom: add select QCOM_GDSC for SM6350
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211003083141.613509-1-luca@z3ntu.xyz>
 <20211003083141.613509-2-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211003083141.613509-2-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.10.2021 10:31, Luca Weiss wrote:
> QCOM_GDSC is needed for the gcc driver to probe.
>
> Fixes: 131abae905df ("clk: qcom: Add SM6350 GCC driver")
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>
Missed that, as I had more GCC drivers enabled in my config, good catch.


Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>



Konrad

