Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F8D39A686
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 19:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFCRBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 13:01:45 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:17289 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhFCRBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 13:01:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622739600; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=F429vFtl3XvYQi65CeuZUOOowDumhKntT+Oh2DXf98s=; b=JrLsolsUZDtXvjtOFPhAOyBGuiqfcKeM6yVfegYezAuTrQdVwMBOjYevr2YkE6SdNAfO5IHh
 JsLHvnN5AIPOkDPU6TmO9rV9cOdTSQyZm8a8F4P1E5x5HIwVXFGmaBtR8NJ9It0p9FOgWzwq
 10L0TaPdTvkhIs7Qnj+gILP9AJ0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60b90a83f726fa4188c6a5a6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Jun 2021 16:59:47
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9C780C4360C; Thu,  3 Jun 2021 16:59:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        PDS_BAD_THREAD_QP_64,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from BCAIN (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 54E76C43217;
        Thu,  3 Jun 2021 16:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54E76C43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Nathan Chancellor'" <nathan@kernel.org>,
        "'Andrew Morton'" <akpm@linux-foundation.org>
Cc:     "'Nick Desaulniers'" <ndesaulniers@google.com>,
        <linux-hexagon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>
References: <20210521011239.1332345-1-nathan@kernel.org> <0f3ac242-d187-57b5-e715-ea25933dbd52@kernel.org>
In-Reply-To: <0f3ac242-d187-57b5-e715-ea25933dbd52@kernel.org>
Subject: RE: [PATCH 0/3] hexagon: Fix build error with CONFIG_STACKDEPOT and select CONFIG_ARCH_WANT_LD_ORPHAN_WARN
Date:   Thu, 3 Jun 2021 11:59:43 -0500
Message-ID: <09a301d75899$daf244f0$90d6ced0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQImhg45Cwtn7gWc92+5nwbl9gAFPwIZtIyFqlNZDdA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Nathan Chancellor <nathan@kernel.org>
...
> On 5/20/2021 6:12 PM, Nathan Chancellor wrote:
> > Hi all,
...
> Brian, did you have any comments on this series? ARCH=3Dhexagon =
defconfig
> is currently broken in -next, it would be a real shame if this =
continued
> to regress after you just got Hexagon building in mainline. These
> patches seem like they would be worthy of a 5.13 pull request.

I have started the internal review process to get these queued up in my =
tree.  But I don't know if I would have it in time for 5.13.

> Otherwise, Andrew could pick them up with your ack and stick them in
> front of "mm/slub: use stackdepot to save stack trace in objects" so
> that there is no build regression.

Of course: I'll send my ack for the sake of keeping the build green.

-Brian

