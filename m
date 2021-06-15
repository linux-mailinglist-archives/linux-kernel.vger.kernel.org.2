Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A973A7833
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhFOHqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:46:18 -0400
Received: from relay02.th.seeweb.it ([5.144.164.163]:58273 "EHLO
        relay02.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhFOHqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:46:05 -0400
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jun 2021 03:46:04 EDT
Received: from [10.0.20.3] (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 7B07A1F4B5;
        Tue, 15 Jun 2021 09:35:38 +0200 (CEST)
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Add support for SONY Xperia 1 II
 / 5 II (Edo platform)
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        jamipkettunen@somainline.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
References: <20210612192358.62602-1-konrad.dybcio@somainline.org>
 <20210612192358.62602-3-konrad.dybcio@somainline.org>
From:   Marijn Suijten <marijn.suijten@somainline.org>
Message-ID: <50fd5f94-f1e6-575d-6ffe-11f89bc35d3d@somainline.org>
Date:   Tue, 15 Jun 2021 09:35:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210612192358.62602-3-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/21 9:23 PM, Konrad Dybcio wrote:
> Add support for SONY Xperia 1 II and 5 II smartphones (read one/five mark two).
> They are based on the Qualcomm SM8250 chipset and both feature 5G modems. There
> also exists a third Edo board, namely the Xperia PRO (PDX204), but it's $2500
> and no developers have obtained it so far (to my knowledge).
> 
> The devices are affected by a scary UFS behaviour where sending a certain UFS
> command (which is worked around on downstream) renders the device unbootable,
> by effectively erasing the bootloader. Therefore UFS AND UFSPHY are strictly
> disabled for now.
> 
> Downstream workaround:
> https://github.com/kholk/kernel/commit/2e7a9ee1c91a016baa0b826a7752ec45663a0561
> 
> Tested-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

Thanks!
