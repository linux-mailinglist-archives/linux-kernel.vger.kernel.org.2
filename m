Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2E434A298
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCZHhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230164AbhCZHg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:36:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0539D619D3;
        Fri, 26 Mar 2021 07:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616744218;
        bh=/Nr/At0k6iwfJorKVN37xh/uOmrukCDNegi3ej35b3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nl7AzAkf7S4m2pr7ClivLds9oqgdqSBJQT3v5IHKM4AYwxhkwckMEQhLJaUi6gur6
         fMyaTam+WSiN5IMjo3G4SpVj+nKnGGLL5Yf9R4Vkr0WBPma9EwxTDLOJ/QtyS4dRaM
         bgEjcnGiwxmdTbrYlbBRCns81pE8KL8PC1UDQQW6RuXBzc9dYHBO73e9dwpLs8m1xa
         MzOBQ/e4q4QiS5Sl0EMB9qXCA6/xeFEj+tc8aEvrougrk34lNm0YWG9IbEGt2PS9Po
         H/deaovo05n9blLLUPeDn4rjt5Yr3WAIEL2Ki0ox0jkOZ79ovY6DWayxX4Mj0CMezo
         tvEK72z8NtzDw==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] memory: tegra20: Correct comment to MC_STAT registers writes
Date:   Fri, 26 Mar 2021 08:36:53 +0100
Message-Id: <161674420623.5944.7028475282352338247.b4-ty@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323210446.24867-1-digetx@gmail.com>
References: <20210323210446.24867-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 00:04:45 +0300, Dmitry Osipenko wrote:
> The code was changed multiple times and the comment to MC_STAT
> registers writes became slightly outdated. The MC_STAT programming
> now isn't hardcoded to the "bandwidth" mode, let's clarify this in
> the comment.

Applied, thanks!

[1/2] memory: tegra20: Correct comment to MC_STAT registers writes
      (no commit info)
[2/2] memory: tegra20: Protect debug code with a lock
      (no commit info)

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>
