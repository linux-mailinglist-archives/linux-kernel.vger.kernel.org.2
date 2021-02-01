Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA0530AAF9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhBAPUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:20:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230192AbhBAPTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:19:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7ADC764E97;
        Mon,  1 Feb 2021 15:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612192720;
        bh=M6Pq1vR46oimtjF7/euCfQOikq+Mmgpo47GOSu/7s0A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dbv1bOGZdMDmoS0j+W9Kb7EwQBky5Bhf7NxF4bXaWR8ntocEFL5D0VF4TaVLKM6SP
         D7vi5UL7r8Da82ln3jbF24Wkdxlbn8IeRbMdNUjKqJiLTH9zqEFjsDr24fyu61XIR+
         Q4F8kOTm0AL5aPJHq/atgSEFftUh98dtdJu9LYK2gtNK+bsaetyP/EIKco4wF5cfuP
         OMgm/xQq0tbYAiXVzZprYn4ZUvvPdQjUwCF3a4Sy5mVxS4HFix6uNHVcFIfOHqoNBM
         Nf+BhYKCZEf2kJkrulEmBdTDuRYu89wXJR2nMhh4E13sYFiDVc3+LcEqGhZHbp4Ioh
         ZRNMO2AwWDeZg==
Subject: Re: [PATCH v3] clk: exynos7: Keep aclk_fsys1_200 enabled
To:     =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     kgene@kernel.org, krzk@kernel.org,
        linux-samsung-soc@vger.kernel.org, tomasz.figa@gmail.com,
        linux-kernel@vger.kernel.org, cw00.choi@samsung.com,
        s.nawrocki@samsung.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210131170428.3290-1-pawel.mikolaj.chmiel@gmail.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <273b996a-8551-8383-5f9d-61ff5bd9663c@kernel.org>
Date:   Mon, 1 Feb 2021 16:18:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210131170428.3290-1-pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/21 18:04, Paweł Chmiel wrote:
> This clock must be always enabled to allow access to any registers in
> fsys1 CMU. Until proper solution based on runtime PM is applied
> (similar to what was done for Exynos5433), fix this by calling
> clk_prepare_enable() directly from clock provider driver.
> 
> It was observed on Samsung Galaxy S6 device (based on Exynos7420), where
> UFS module is probed before pmic used to power that device.
> In this case defer probe was happening and that clock was disabled by
> UFS driver, causing whole boot to hang on next CMU access.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v2:
>    - Avoid __clk_lookup() call when enabling clock
> Changes from v1:
>    - Instead of marking clock as critical, enable it manually in driver.

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
