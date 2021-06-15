Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493773A7DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFOMFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFOMFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:05:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CA2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:03:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a11so18023244wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LDMPqnkit3/YLm1o6MAn8gbI6ZgkBKcNq+W43U1Ct6c=;
        b=gI0JobN3UwdNv3RqVqmIq7lUQHHgt1CaMRbgws21isXklhmBl2DIxG3IIen+0BkOeH
         xtlNUcDtE6qmSoQOLGDc3/Jnc1kQVbXGqoVWAv3VTZ0EeVbMBhyQD79TWrM/KjwjbfZX
         qkRa9QzGQLsyP5tYgqi8N83n2X2fsYHRf1byqA73Cx+b6LgGoz3aoiHDdpEUj11LOSmQ
         FsSsVRgGyIq+WWw2QHnh3+9QAGScfbRPV6HmWLJD2r0IYcrMy78hEr/tIT0GPW/lTuAA
         sm69RSLfvnhaSMMQmpiNpa1qSs/29Zdvxl0Dlq68vsrzAlOaWEiwR0ilQ8mSQp+5ctAQ
         KRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LDMPqnkit3/YLm1o6MAn8gbI6ZgkBKcNq+W43U1Ct6c=;
        b=AgMuWQ2ZH8ZuUI0vF+dwgmwmwIH5QHqTI7LKNc/fDMr1g2oK0HGnTbsQ+O04sgebIa
         C9a54Jl7B5M7VRG6mo0yCHdacp3e45OZzU/P7fG+LjZlE5VQEIiIkKicANgIoYETrAse
         VlDSGvAkfrBy4tdB/pYB1NowIZ7Cby3K+LW6mWXedfX2war4D9Qw6+Wn7qgAMt/9xZQz
         DwG+JZ4tLAIH6D3G2UzQ1eLbcihXerSsF0b3cQ8G/sKl4bXTMNRkR3aNBYtdhTeXIEWU
         o/yRe7r9xmiJfyxu1EeVOsQg4UTAgWoScIn1KISdXiKEBkO10L4K7Z0pWPOT6cCzRllg
         MFTg==
X-Gm-Message-State: AOAM531WEQyNrUI0oXp6Xt90J75c2IA0rrojMWyG1b0GHKRoqdecpMc9
        zqc/Ht24Nxp5Twh2ZKxobrbRIA==
X-Google-Smtp-Source: ABdhPJysKtEJ0adw+nmllA2Upch+edF9I3Xd3nPGW6AOX/wsqna0wJ9D/Jv3pHG2dBfUkAc3oIyZHg==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr24498190wrv.322.1623758587009;
        Tue, 15 Jun 2021 05:03:07 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id x7sm19522829wre.8.2021.06.15.05.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 05:03:06 -0700 (PDT)
Date:   Tue, 15 Jun 2021 13:03:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     patches <patches@opensource.cirrus.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] mfd: sm501: use DEVICE_ATTR_RO macro
Message-ID: <YMiW+AocCuZP0ro2@dell>
References: <20210602114339.11223-1-thunder.leizhen@huawei.com>
 <20210602114339.11223-5-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602114339.11223-5-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021, Zhen Lei wrote:

> Use DEVICE_ATTR_RO macro helper instead of plain DEVICE_ATTR, which makes
> the code a bit shorter and easier to read.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/mfd/sm501.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
