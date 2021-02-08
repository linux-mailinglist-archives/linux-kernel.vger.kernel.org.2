Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30F3313E4F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbhBHS77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:59:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234783AbhBHRRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:17:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 421B564E92;
        Mon,  8 Feb 2021 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612804628;
        bh=KLmb93/B2j0nZmi7FzZVDm20XDsLAsvhiyEZBglgTQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nlfx+5R38pzDH7w5qof+6wJD3HERNesRpYktS8p2ywNo9wLBkZDZZ/2aoNDhqWPtG
         +vJwiBboHU3luyU8Lqj1tpHHRURaQPztQDCahRZwBmQGG86ACMfRmj+dWJ0lZfvQWW
         pYVr7KjBfO1Ex4ajXPYENKOGmwHfgioknBOPotY3s5Nl2BwrQmt/1xyOzResp+sHVl
         QMmJEaOfb578NBar8FB+tLyy9wbcssNg8ZqYFzixmHsAqsIdWltEbKm2JE7ytQUwW0
         oQJjTP8UzPg+5fXiuQkZ0KGtiFsgWgLUwmzhen/IaealkD74tb2IklePmMrFPocYxk
         T2eTEQH8XbaxQ==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kernel test robot <lkp@intel.com>
Subject: Re: (subset) [PATCH] memory: ti-emif-pm: Drop of_match_ptr from of_device_id table
Date:   Mon,  8 Feb 2021 18:16:55 +0100
Message-Id: <161280460935.4459.12084725290331844085.b4-ty@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210206111343.19273-1-krzk@kernel.org>
References: <20210206111343.19273-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Feb 2021 12:13:43 +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might be not relevant here).  This
> fixes compile warning (!CONFIG_OF with clang):
> 
>     drivers/memory/ti-emif-pm.c:238:34: warning:
>         unused variable 'ti_emif_of_match' [-Wunused-const-variable]

Applied, thanks!

[1/1] memory: ti-emif-pm: Drop of_match_ptr from of_device_id table
      commit: 62c290a6784af56fa1438f6d2688cd9360c840f1

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>
