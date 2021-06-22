Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852A83B08DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhFVP14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:27:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40202 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232166AbhFVP1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:27:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624375539; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=qdJZxu++vGAng/43VaeTldg+8gyYf/4ml4ovXBB/hbE=;
 b=sZkCz11US+ZcxugSqUOFokpBsGHnTIPq10t4GmAv0miAj5xP6bk0KCyAEB0pgp7VNwNHI8BB
 XVWr5EKIhuFh9/1HIt8rBxOrPCzByNFHSg/M5Uo/E5NIAnmxpPsS8nZlzWhbkEtNj8mKjHWx
 aPq/oCx3m6wBVdlsRpnvCPn27iE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60d200cf1200320241eecd4a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Jun 2021 15:25:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF713C4360C; Tue, 22 Jun 2021 15:25:02 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CF54AC43460;
        Tue, 22 Jun 2021 15:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF54AC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mwifiex: Avoid memset() over-write of WEP key_material
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210617171522.3410951-1-keescook@chromium.org>
References: <20210617171522.3410951-1-keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210622152502.EF713C4360C@smtp.codeaurora.org>
Date:   Tue, 22 Jun 2021 15:25:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> wrote:

> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring array fields.
> 
> When preparing to call mwifiex_set_keyparamset_wep(), key_material is
> treated very differently from its structure layout (which has only a
> single struct mwifiex_ie_type_key_param_set). Instead, add a new type to
> the union so memset() can correctly reason about the size of the
> structure.
> 
> Note that the union ("params", 196 bytes) containing key_material was
> not large enough to hold the target of this memset(): sizeof(struct
> mwifiex_ie_type_key_param_set) == 60, NUM_WEP_KEYS = 4, so 240
> bytes, or 44 bytes past the end of "params". The good news is that
> it appears that the command buffer, as allocated, is 2048 bytes
> (MWIFIEX_SIZE_OF_CMD_BUFFER), so no neighboring memory appears to be
> getting clobbered.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-drivers-next.git, thanks.

59c668d700be mwifiex: Avoid memset() over-write of WEP key_material

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210617171522.3410951-1-keescook@chromium.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

