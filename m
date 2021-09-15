Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377EF40C299
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbhIOJPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:15:05 -0400
Received: from foss.arm.com ([217.140.110.172]:53744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237157AbhIOJPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:15:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E34E66D;
        Wed, 15 Sep 2021 02:13:45 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE5D33F5A1;
        Wed, 15 Sep 2021 02:13:44 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/3] arm64: dts: arm: align watchdog and mmc node names with dtschema
Date:   Wed, 15 Sep 2021 10:13:33 +0100
Message-Id: <163169716063.1624125.9381303862313981753.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820081733.83976-1-krzysztof.kozlowski@canonical.com>
References: <20210820081733.83976-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 10:17:31 +0200, Krzysztof Kozlowski wrote:
> Align the watchdog and mmc device node names with the schema to fix
> warnings like:
> 
>   mmci@50000: $nodename:0: 'mmci@50000' does not match '^mmc(@.*)?$'
>   wdt@f0000: $nodename:0: 'wdt@f0000' does not match '^watchdog(@.*|-[0-9a-f])?$'


Applied to sudeep.holla/linux (for-next/juno), thanks!

[1/3] arm64: dts: arm: align watchdog and mmc node names with dtschema
      https://git.kernel.org/sudeep.holla/c/b43446b4f5
[2/3] ARM: dts: arm: align watchdog and mmc node names with dtschema
      https://git.kernel.org/sudeep.holla/c/5f741ef384
[3/3] arm64: dts: arm: drop unused interrupt-names in MHU
      https://git.kernel.org/sudeep.holla/c/217cb530a3

--
Regards,
Sudeep

