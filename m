Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683FC307806
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhA1O1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:27:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhA1O0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:26:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2896964DE1;
        Thu, 28 Jan 2021 14:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611843966;
        bh=fyKCFaUjrkKt3tuQEHUgceIKUtLyui94M61Ti9D1ACE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VJUTBovXzS5xEmpNWdGeYGY2XVKZSU6/R0oLKzpgRa36UTLOYxpQuvbi/ZHJibBF3
         XsRLLNUXallngKgN+Ue3WdIVyh21+FzaicOW8S91XtBzV6Kq3jUaylcWIDxJ3e3jJm
         GRyZUEOHUwXBYgOW6l2L4gAJyHzAgEStmeSu+laAtJlMetHa8ruhjJDTfneZHVfbrV
         mG89A8+X7xee03R0G5t2+5PzI1hZ2nmiHeTmwGUUiDXH3/A/fFev9icr7lq7QVgBRc
         yTFlqX1m3fLYPvSjtgOV42jbgw/Nus2+0nGrQMg8NIqOsKNOFjEhWPNCtrZu9X8ssV
         53g3ZlB97xKyQ==
Received: by mail-oi1-f170.google.com with SMTP id k25so6140448oik.13;
        Thu, 28 Jan 2021 06:26:06 -0800 (PST)
X-Gm-Message-State: AOAM531BzBYVFLap6fMGHGpeXoCuY4ghXpyxj7ESA2V9HD2SFqhbdGk2
        Fwdbh80WDc973nAlb2cj4r+zrfcLTj4SvHsDdac=
X-Google-Smtp-Source: ABdhPJxvnfveUy++Y7kX4uFuQXMK3LtVVeJd/wxkjEd+lOiQntYMmFQd7oPP/QdjcTzZg/QgBmsn0noGTKqsJQg8P50=
X-Received: by 2002:aca:eb0a:: with SMTP id j10mr6777833oih.4.1611843965368;
 Thu, 28 Jan 2021 06:26:05 -0800 (PST)
MIME-Version: 1.0
References: <20210116032740.873-1-thunder.leizhen@huawei.com> <20210116032740.873-4-thunder.leizhen@huawei.com>
In-Reply-To: <20210116032740.873-4-thunder.leizhen@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 28 Jan 2021 15:25:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a30Pbrfr4GTodq829T59kCAZ0GWV2WvRKNBSbvTTNbmsA@mail.gmail.com>
Message-ID: <CAK8P3a30Pbrfr4GTodq829T59kCAZ0GWV2WvRKNBSbvTTNbmsA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] dt-bindings: arm: hisilicon: Add binding for
 Kunpeng L3 cache controller
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 4:34 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Add devicetree binding for Hisilicon Kunpeng L3 cache controller.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../arm/hisilicon/kunpeng-l3cache.yaml        | 40 +++++++++++++++++++

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
