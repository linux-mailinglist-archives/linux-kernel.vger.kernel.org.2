Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A0D4212CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhJDPkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:40:52 -0400
Received: from foss.arm.com ([217.140.110.172]:52738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233881AbhJDPkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:40:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87568D6E;
        Mon,  4 Oct 2021 08:39:02 -0700 (PDT)
Received: from [10.57.53.1] (unknown [10.57.53.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 061213F70D;
        Mon,  4 Oct 2021 08:38:59 -0700 (PDT)
Subject: Re: [PATCH 4/5] arm64: mte: Add asymmetric mode support
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210913081424.48613-1-vincenzo.frascino@arm.com>
 <20210913081424.48613-5-vincenzo.frascino@arm.com>
 <CA+fCnZeW35+ZmvM6SxZSb_NAMqsK42Ds_ADVKeVkfs9MT=Aovg@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <cd011cc0-5d3d-b642-55c3-fa2107f7f826@arm.com>
Date:   Mon, 4 Oct 2021 17:39:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+fCnZeW35+ZmvM6SxZSb_NAMqsK42Ds_ADVKeVkfs9MT=Aovg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 10/3/21 7:15 PM, Andrey Konovalov wrote:
> This part is confusing: mte_async_mode gets enabled for the asymm
> mode, which contradicts the comment next to the mte_async_mode
> definition.

Good point I will fix the comment near by the mte_async_mode definition.

Thanks!

-- 
Regards,
Vincenzo
