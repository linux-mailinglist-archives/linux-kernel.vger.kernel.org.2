Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAA942FB89
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 20:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242182AbhJOTA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 15:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbhJOTAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 15:00:55 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0D3C061764
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 11:58:47 -0700 (PDT)
Received: from [192.168.1.101] (83.6.166.47.neoplus.adsl.tpnet.pl [83.6.166.47])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id C660A1F504;
        Fri, 15 Oct 2021 20:58:43 +0200 (CEST)
Message-ID: <f4af0e40-9e93-dba9-7401-cdfc76ba667e@somainline.org>
Date:   Fri, 15 Oct 2021 20:58:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 4/8] cpufreq: qcom_cpufreq_nvmem: Simplify reading kryo
 speedbin
Content-Language: en-US
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
References: <20211014083016.137441-1-y.oudjana@protonmail.com>
 <20211014083016.137441-5-y.oudjana@protonmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211014083016.137441-5-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14.10.2021 10:32, Yassine Oudjana wrote:
> In preparation for adding a separate device tree for MSM8996 Pro, skip reading
> msm-id from smem and just read the speedbin efuse.
>
While I'd really like for this to be merged, it's gonna totally wreck backwards

compatibility.. But then, since APCC was not defined properly before commit

0a275a35ceab07 arm64: dts: qcom: msm8996: Make CPUCC actually probe (and work)

there's only 5.14/5.15 (both of which were non-LTS) which would *actually* break given

somebody decided that "ah yes, pulling in DTs from these specific mainline kernel releases

is a good idea"...


If I were to judge, it would probably be fine to rid the old mechanism..


Konrad

