Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC3325C53
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 05:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBZEGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 23:06:36 -0500
Received: from z11.mailgun.us ([104.130.96.11]:23486 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhBZEGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 23:06:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614312375; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=vv556+002EiQC8eL9922TOX6vL/H2fZ6CrWj5YF8v6w=;
 b=QXZBGE5YGmLCYuJ44SzH4qBOYhI9vAROHd+ZIuoXtsXmMlMT/ePn/aaYg3Cl2mDiF0ShsQcC
 s0e7jjKw8N7nr7RiX29KDEl8nNnjFRJFdbVwmtw5jDRjzH8kmt+VciCn7ZB+U6bh4u7hj16c
 FfbIKcIxxUcRjGg00CtVUurOCyw=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6038739acc1f7d7e95e3ecbf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Feb 2021 04:05:46
 GMT
Sender: skakit=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F2B3C43461; Fri, 26 Feb 2021 04:05:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: skakit)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5CDAC433C6;
        Fri, 26 Feb 2021 04:05:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Feb 2021 09:35:45 +0530
From:   skakit@codeaurora.org
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [PATCH 6/7] regulator: qcom-rpmh: Use correct buck for S1C
 regulator
In-Reply-To: <20210224163114.GD4504@sirena.org.uk>
References: <1614155592-14060-1-git-send-email-skakit@codeaurora.org>
 <1614155592-14060-7-git-send-email-skakit@codeaurora.org>
 <20210224163114.GD4504@sirena.org.uk>
Message-ID: <79e3438fe9ad1b7c1ec8664335a36c31@codeaurora.org>
X-Sender: skakit@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-24 22:01, Mark Brown wrote:
> On Wed, Feb 24, 2021 at 02:03:11PM +0530, satya priya wrote:
>> Use correct buck, that is, pmic5_hfsmps515 for S1C regulator
>> of PM8350C PMIC.
> 
> Fixes like this and patch 3 should be at the start of the series, this
> ensures that they have no dependencies and can easily be sent to Linus
> as fixes.

Okay.
