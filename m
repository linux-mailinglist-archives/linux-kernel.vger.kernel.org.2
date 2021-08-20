Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7B03F2543
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 05:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbhHTD0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 23:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbhHTD0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 23:26:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2313C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 20:25:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u15so5143007plg.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 20:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tb+3c4sIXia8Tj7TXbcGSfKzAoHqBRtrMhGgnoxQz9c=;
        b=UlcCDs1covM/o5EVQkDUvKUq4BYzlVfj1O2NkuVwbGewbHLaYA1k7cDj99iuCJ4Hdr
         xqc/9D4LE2CQyZxqjlgvQYwYXY7f7d9Ln2txosp4PvwCHCGsanahVQNsdHVVTDpqy4Ph
         4gcyPp4AY4mgBwL4Naw3GS/5eoZXW4DEBE9Y7AilAJWtI+j4IvSR4gztQ4iuCR+l7Ya0
         wnJWFKfHLajnhyHepNgovu2GaEkbJs+34/1u9qZtpurbnl5UA47SCUUfskBIjfMaiGlC
         WlgX8qJGVA9wnFreDDWgmMokCHhor0vJxt511fs0jyPIhuo5R3qyJvUuDbf5x1+FLrpC
         sDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tb+3c4sIXia8Tj7TXbcGSfKzAoHqBRtrMhGgnoxQz9c=;
        b=TndzgMK+Dr9WzxiMMDfo5sWO+4YdsY7NHqSDo4Uoka86XOa0XH0PtnDaa/WOgyXjqD
         jftIxOD0w8Q2ZZ7CLxAj2n9tHwmKZSwneLtZsTJcgj4crbsKcss3W976rx6Cr11sGRPV
         MzAodBYBalqsJrn+iIpk8EjFw6k/gb2I1XmTm6ySQW1XNB4QAvow6S4rjm9/8Gc+vO/z
         PzEeCFfkg1ys8b4uV5LyWVETNuvoaRNmAVPQUlLH94tgaErVf6DglIYscT9rlRpIGmRX
         IJI2aOdo3mLsthxPhC51/smf2nZGdeFZtVtgVABmA1wb5CNRxiIzUTlUy+++dTtQPqKn
         gmAQ==
X-Gm-Message-State: AOAM530zOVuzISVpfyAIfCf+mANQPIWjUiPNQq5naEDswqljIw8GB+Z4
        btCqZLxQlhRMSYThrfQkmaaQtA==
X-Google-Smtp-Source: ABdhPJy5lEitPCHFg1OSUQG2byPt0M4/Vn2i9PLMWC8UpSbU447SdR7DBz6vRKpV6owBYA+uCyeJpQ==
X-Received: by 2002:a17:902:d3c5:b029:12d:32f2:8495 with SMTP id w5-20020a170902d3c5b029012d32f28495mr14949223plb.72.1629429927093;
        Thu, 19 Aug 2021 20:25:27 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:549a:ad5a:e5bd:8c8a])
        by smtp.gmail.com with ESMTPSA id u3sm9211597pjr.2.2021.08.19.20.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 20:25:26 -0700 (PDT)
Date:   Fri, 20 Aug 2021 11:25:23 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Wilczyski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        qizhong.cheng@mediatek.com, Ryan-JH.Yu@mediatek.com
Subject: Re: [PATCH] PCI: mediatek-gen3: Disable DVFSRC voltage request
Message-ID: <YR8go1l0Xnvvqn5E@google.com>
References: <20210819125939.21253-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819125939.21253-1-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 08:59:39PM +0800, Jianjun Wang wrote:
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
