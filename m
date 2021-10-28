Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610E643E1AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhJ1NL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:11:28 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:16627 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhJ1NLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:11:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635426536; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=Qb7X8st4uzzS9456OTzm8fGK/jpZSE56FlCL1Nrl7ho=; b=IwjFwGb4seB+2Ph6p2PPqWFbP7yUkVMPtpDvP2Z55Crr6uyWB0M6nrleJsOpeh54bNKiyWuw
 BmQdyN1eB0/PKtH2CJeLSbJWW5RgU1nro+toQ4ZGIjbQizqIL3K0KmPF8L5slF5KufHkuRtE
 WBS1aG6XB1U/okcFQOq39r4iTGM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 617aa0e0648aeeca5cd8fd0f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 Oct 2021 13:08:48
 GMT
Sender: pillair=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9961FC43618; Thu, 28 Oct 2021 13:08:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from PILLAIR1 (unknown [49.205.244.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98DE2C4338F;
        Thu, 28 Oct 2021 13:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 98DE2C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   <pillair@codeaurora.org>
To:     "'Stephen Boyd'" <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <ohad@wizery.com>, <p.zabel@pengutronix.de>, <robh+dt@kernel.org>
Cc:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sibis@codeaurora.org>,
        <mpubbise@codeaurora.org>, <kuabhs@chromium.org>
References: <1633330133-29617-1-git-send-email-pillair@codeaurora.org> <CAE-0n53rkv5SKO74M+7bkuMgaD7tS0k6a8m7KeQL8j3DTHdB_Q@mail.gmail.com>
In-Reply-To: <CAE-0n53rkv5SKO74M+7bkuMgaD7tS0k6a8m7KeQL8j3DTHdB_Q@mail.gmail.com>
Subject: RE: [PATCH v6 0/3] Add support for sc7280 WPSS PIL loading
Date:   Thu, 28 Oct 2021 18:38:39 +0530
Message-ID: <001401d7cbfc$f0d1d700$d2758500$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKwJKLJ4tjmgoIJWycFdR/OOcUEpALtul/YqiBB3JA=
Content-Language: en-us
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stephen Boyd <swboyd@chromium.org>
> Sent: Friday, October 8, 2021 12:05 AM
> To: Rakesh Pillai <pillair@codeaurora.org>; agross@kernel.org;
> bjorn.andersson@linaro.org; mathieu.poirier@linaro.org; =
ohad@wizery.com;
> p.zabel@pengutronix.de; robh+dt@kernel.org
> Cc: linux-arm-msm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; sibis@codeaurora.org; mpubbise@codeaurora.org;
> kuabhs@chromium.org
> Subject: Re: [PATCH v6 0/3] Add support for sc7280 WPSS PIL loading
>=20
> Quoting Rakesh Pillai (2021-10-03 23:48:50)
> > Add support for PIL loading of WPSS co-processor for SC7280 SOCs.
> >
> > Changes from v4/v5:
> > - Add yaml conversion for adsp/cdsp dt-bindings
> > - Change clock names in wpss dt-bindings
> > - Correct mistake in signed-off enail ID
>=20
> Can you keep a running tally here of the full progression of the =
series?
> That helps to look back and make sure we don't make a comment that has
> already been made before.
>=20
> One more request. Can you add support for 'firmware-name' like there =
is in
> Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt so that we
> can install firmware into some namespaced/versioned place instead of
> having to put wpss files into /lib/firmware?=20

Hi Stephen,
I have posted v7 with the support for firmware-name to be provided in =
the DT entry.

> It would also be nice to load a
> single firmware file instead of having to split the file into many =
pieces.

This would require lot of changes and lot of code duplication from =
request firmware.
Also the base ath11k firmware files have been posted as split files.


Thanks,
Rakesh Pillai

