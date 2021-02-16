Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DFA31CC65
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhBPOt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhBPOtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:49:53 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA49BC061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 06:49:12 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id lu16so2128450ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 06:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IIaLUy4nmH13O1p+J8MoSLesp4E2WwEuh/p0n2Lqdlk=;
        b=EI7TVrtJFpSwchYWR/l7ishgKKOstgZNc4L4IhNqeTYYQOXDRoM1ZPA5fzoTZZL+h7
         fHY/nPAiM5aFb3j4POIWI2WF2L+srhA80W77Z9K/cDdmdgG3cnomOaO8wcXcl7swkosl
         1VIcQF4bQAlhkhtrxPB82Ro/O7EohpNewcUXVVSKyn0D9i7iY98wJBI5z7SX6EAajkyk
         gd+d9jB5uusNCQ+nlG1y8ejljFn3cIkGJ6xlFueJg/Okmuq1ekfVKb4tnZIIMtCl4Uhd
         MOw0w/LvQ5f4HMmSmGoMmQFYYYthAwkqpfBgXTMKxZbwBHbfjX/nwBGE19x5cq71cH+T
         40Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IIaLUy4nmH13O1p+J8MoSLesp4E2WwEuh/p0n2Lqdlk=;
        b=Uchwf534Q57nrWts4NhKWh3WCOAi6zia0mq+/dwrg9SYHlhPO2mta8dZeEdXHpfvRF
         6RKcXxY0oRrck1om17tiLwWSF6UnvcJ3qPWsmrSAFY9Yn006huF4haIHzTtjPBvO5goL
         AE2LmZ5l8XErwXzqsfq/cWyA34qKCsIM6NDBp9mPJrT2/NNgN4vbZW9HbXTnBpfcTsSl
         jSZh9cXL9d95Y/4/btpDvgV/1h9NxvNhJNh92u5Ftnq4/FGkASSD1DMglhbTO3DUyabl
         WlZOrQaBId4gqyH6B8mmyWmH0RZ7ZeLsykjWpOp4TFS2jx7vPKu6yuLK1Juj7/IX9S3A
         ZnAw==
X-Gm-Message-State: AOAM530ktYpO4JVGXjLTFJEeUHaAMWVFAYwzac6agvnsvKx2Ne5hrE1B
        1k4JHnlMfrQhiUq7ug+S+ka4IpPxFalNu8pG5bcewg==
X-Google-Smtp-Source: ABdhPJwOR+Tlb1UXf4as0I8SzeQhwsak+EKb6mN9s/lSor+Egy6v+dy7dlAIqZXSElDHyEUvb666j8v1qG0//7P3PKM=
X-Received: by 2002:a17:906:240c:: with SMTP id z12mr1090277eja.314.1613486951554;
 Tue, 16 Feb 2021 06:49:11 -0800 (PST)
MIME-Version: 1.0
References: <20210215192237.362706-1-pasha.tatashin@soleen.com>
 <20210215192237.362706-2-pasha.tatashin@soleen.com> <CAMj1kXGxyV0=s6jVZ674O_2amkYSnwSnubnozbzD6g6GOMJE-A@mail.gmail.com>
 <73bf9ad0-37a9-78f4-3583-2845dcb24f34@arm.com>
In-Reply-To: <73bf9ad0-37a9-78f4-3583-2845dcb24f34@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 16 Feb 2021 09:48:35 -0500
Message-ID: <CA+CK2bBRoXEHr+tPz4VH4JkjrhCfTxVi0Y_L8AtFV=o=aJt6sA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: mm: correct the inside linear map
 boundaries during hotplug check
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There is a new generic framework which expects the platform to provide two
> distinct range points (low and high) for hotplug address comparison. Those
> range points can be different depending on whether address randomization
> is enabled and the flip occurs. But this comparison here in the platform
> code is going away.
>
> This patch needs to rebased on the new framework which is part of linux-next.
>
> https://patchwork.kernel.org/project/linux-mm/list/?series=425051

Hi Anshuman,

Thanks for letting me know. I will send an updated patch against linux-next.

Thank you,
Pasha
