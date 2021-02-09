Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A293A315C14
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhBJBTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbhBIWR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:17:28 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A93C0617AA
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 14:15:00 -0800 (PST)
Received: from [192.168.1.101] (abac187.neoplus.adsl.tpnet.pl [83.6.166.187])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 0D1101F968;
        Tue,  9 Feb 2021 23:14:57 +0100 (CET)
Subject: Re: [PATCH] firmware: qcom_scm: Add MDM9607 compatible
To:     Rob Herring <robh@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210131013058.54299-1-konrad.dybcio@somainline.org>
 <20210209203803.GA129939@robh.at.kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
Message-ID: <36b0fcf5-a72e-763a-a300-30bc199ee45d@somainline.org>
Date:   Tue, 9 Feb 2021 23:14:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209203803.GA129939@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.02.2021 21:38, Rob Herring wrote:
> In the future, please split binding changes to separate patch.


I will keep that in mind for the upcoming patches!


Konrad

