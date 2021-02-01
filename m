Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C5A30A48B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhBAJlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhBAJlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:41:36 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BFBC061574
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 01:40:55 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id j13so18087160edp.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 01:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hIUPWGL9LOU/zPCO63a7e5ubCBpwA6j8jBe7AJ0YMCY=;
        b=rLHbgqVkEul68rFEzQezpbE34F6ih6YVsgGrPQ43VjQa2hNVraIyB1ZVpKXt+sey5l
         vH76AX1VAfKJw2g6GjzRfz5ijYZD3kZn+q9P8mbjLuzNRnlSIEnOWJC3Q+lIjgJxDuWV
         KmcIL8Y9TVDOR0VBYdZdBsG1QCxmJKAZ3jMlRLziYarBEHORK6ksk9mO31xgnpyOXdNQ
         PYDtwY6LtFqpm6zc//jORlupXq2sEeWeLLDOZ9poqzvpQdqKSRk8BS7T1wXa/J82rTIa
         h4FtDI450iUoSD9lV1ZCsKLhybboUCizgCFcNJM0VOPQwBPWgUyJYdvUZ30/y78UhlSM
         HSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hIUPWGL9LOU/zPCO63a7e5ubCBpwA6j8jBe7AJ0YMCY=;
        b=aa0taKcoJdYb2mYXe0WTNoc9ZO3lcoIHied4o4gr9dZ8TRgK5rLfIdB4XW8DYMMOzG
         WQ3ZeMGAgIGahPG+Lxfe+jN5b1iOnQlUhjvVhAG2ftU+tD+YhvB33BuM1/mayW6FI2Ao
         7xy3lyv4gyX2umOUDTTrZaGgRFSpZ6B07AEbO6SupG9U0c3cbujl9XH0fON+/hpPdDLp
         FgX3r/yod3TFFn7mD9551McSEl2xCfARcKWq4Ojg3M5Ogh8wm1GGBva5at9lxJ3mIYCh
         TCalHfTWCP3I7ywZcfHIw4ebyRhf7wyBR9ilRbqEiRVJF61ohF+KySND5Rp18WcYeX7o
         HrCg==
X-Gm-Message-State: AOAM5305y8Hh5UhkKypwsd96zJksgzRHVBr9La6M102scmRn2XauVwyC
        2ooAPKlCuKklzgTW9nps4PgVQQ==
X-Google-Smtp-Source: ABdhPJxWu2QunWYUgAcW1ur5IvAp69p7d1VmB/yHSW0iPnJqIW1cuI7d5j1graYwBbWO7IuD7EbPUw==
X-Received: by 2002:aa7:ca55:: with SMTP id j21mr17489370edt.172.1612172454672;
        Mon, 01 Feb 2021 01:40:54 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q4sm7788556ejx.8.2021.02.01.01.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 01:40:53 -0800 (PST)
Subject: Re: [PATCH 0/3] arm64: dts: zynqmp: Enable and Wire DP
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, git@xilinx.com
Cc:     Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1611232558.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <06015f0f-dece-a3e5-66d4-814069af4449@monstr.eu>
Date:   Mon, 1 Feb 2021 10:40:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1611232558.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/21/21 1:36 PM, Michal Simek wrote:
> Hi,
> 
> I am updating DT patches which were there part of DP v11 series sent by
> Laurent in past [1]. Patches have been removed in v12 [2].
> The series is rebased on the top of [3] which wired si5341 clock chip.
> 
> [1] http://lore.kernel.org/r/20200318153728.25843-1-laurent.pinchart@ideasonboard.com
> [2] http://lore.kernel.org/r/20200718001347.25451-1-laurent.pinchart@ideasonboard.com
> [3] http://lore.kernel.org/r/cover.1611224800.git.michal.simek@xilinx.com
> 
> Thanks,
> Michal
> 
> 
> Laurent Pinchart (2):
>   arm64: dts: zynqmp: Add DPDMA node
>   arm64: dts: zynqmp: Wire up the DisplayPort subsystem
> 
> Michal Simek (1):
>   arm64: dts: zynqmp: Add DisplayPort subsystem
> 
>  .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 10 ++++++
>  .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 31 ++++++++++++++++++
>  .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 10 ++++++
>  .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 11 +++++++
>  .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 11 +++++++
>  .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 11 +++++++
>  .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 11 +++++++
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 32 +++++++++++++++++++
>  8 files changed, 127 insertions(+)
> 

Applied all.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

