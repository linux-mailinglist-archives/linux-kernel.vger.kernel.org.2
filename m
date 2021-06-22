Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D25E3B08D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhFVP1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:27:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40202 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231987AbhFVP1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:27:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624375497; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=HAS87M3nxs9uoFOR7nCyuKz9APa+x88LkbPn3mBt0P4=;
 b=o42/h8eyT2M+y0T6pSG06g10ka8Wstrpk+MibDeiI++p0Q6RwSuO44j9X09Ks3tqBAEdTCOq
 I48PehOiv1pjzFcA6k7/uLRLF3t84I3A3CVLZEBacAQDL0VYZMPln55/xTrGpWm2MWizNlnT
 LDlRY9/jIiYDhP3idQXZLCmr0d0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60d200bb62f3f07b5379408a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Jun 2021 15:24:43
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EBE91C4323A; Tue, 22 Jun 2021 15:24:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CCA3C4338A;
        Tue, 22 Jun 2021 15:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CCA3C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: rtl8192de: Fully initialize curvecount_val
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210617171317.3410722-1-keescook@chromium.org>
References: <20210617171317.3410722-1-keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kaixu Xia <kaixuxia@tencent.com>, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210622152442.EBE91C4323A@smtp.codeaurora.org>
Date:   Tue, 22 Jun 2021 15:24:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> wrote:

> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally writing across neighboring array fields.
> 
> The size argument to memset() is bytes, but the array element size
> of curvecount_val is u32, so "CV_CURVE_CNT * 2" was only 1/4th of the
> contents of curvecount_val. Adjust memset() to wipe full buffer size.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Larry Finger <Larry.Finger@lwfinger.net>

Patch applied to wireless-drivers-next.git, thanks.

0d5e743db480 rtlwifi: rtl8192de: Fully initialize curvecount_val

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210617171317.3410722-1-keescook@chromium.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

