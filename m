Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1990B36064E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhDOJ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhDOJ6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:58:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D27F61166;
        Thu, 15 Apr 2021 09:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618480666;
        bh=Z8fKpQhCnoPycrzSI0zFpUvBPt/oa7wi/1dPZ/AiPkk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KaRXvhZbzzVO4VeHKwH7FSnlwK57Jqnszi14cKw7z/nkoxRfGx+yL5NiS1hyTxOwF
         Abg1zmSJ944r5DvL1YaHesXwhlP9lj4z2qadQTqauD2F7mViViqYER8AB/HTfv/C1O
         2NpWpOT7+kAx2PDLEHBPNbI/TSDzO+YRSNjgecKFzF+z+K6H8hRuQQ5RBPMrK7IFvU
         VFIjP5xIAf+64HSNF3SIlaQ2DETfKzOBcGrjrOo8Dwyt2Tnqgn1xNo8S5k8USaqbQF
         Cr+a1tV4Ra9sGAohklL0dueRYGoW9dGXuETXSRYMs5Y8i1rSv/lC9DsV406FwQD1Mi
         gX6btdq/xA07Q==
Subject: Re: [PATCH v2 2/3] mmc: sdhci-s3c: correct kerneldoc of
 sdhci_s3c_drv_data
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
 <20210415084412.51125-2-krzysztof.kozlowski@canonical.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <91d3b5ed-63ac-cf5d-e3bf-8ec853927cee@kernel.org>
Date:   Thu, 15 Apr 2021 11:57:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210415084412.51125-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15.04.2021 10:44, Krzysztof Kozlowski wrote:
> Correct the name of sdhci_s3c_drv_data structure in kerneldoc:
> 
>    drivers/mmc/host/sdhci-s3c.c:143: warning:
>      expecting prototype for struct sdhci_s3c_driver_data. Prototype was for struct sdhci_s3c_drv_data instead
> 
> Signed-off-by: Krzysztof Kozlowski<krzysztof.kozlowski@canonical.com>

Reviewed-by: Sylwester Nawrocki <snawrocki@kernel.org>
