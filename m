Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9F144A7F5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 08:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243825AbhKIH7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 02:59:23 -0500
Received: from mx.socionext.com ([202.248.49.38]:26109 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243813AbhKIH7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 02:59:21 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 09 Nov 2021 16:56:35 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 99F3A206E773;
        Tue,  9 Nov 2021 16:56:35 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 9 Nov 2021 16:56:35 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id 4C9FCB62AB;
        Tue,  9 Nov 2021 16:56:35 +0900 (JST)
Received: from [10.212.3.203] (unknown [10.212.3.203])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 2BC0EB6291;
        Tue,  9 Nov 2021 16:56:35 +0900 (JST)
Message-ID: <5187b9ee-30dd-70e1-f85c-5e4db5911ad1@socionext.com>
Date:   Tue, 9 Nov 2021 16:56:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 0/3] Add clock node and phandles for M10V platform
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takao Orito <orito.takao@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1636364713-21451-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a1-9u0wpNh5E--gMA_Qh0g9GvpL=SzL=278SqLeEp62cQ@mail.gmail.com>
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
In-Reply-To: <CAK8P3a1-9u0wpNh5E--gMA_Qh0g9GvpL=SzL=278SqLeEp62cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/08 20:02, Arnd Bergmann wrote:
> On Mon, Nov 8, 2021 at 10:45 AM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
>>
>> This series add a clock node of Milbeaut driver and clock phandles
>> to clock consumer nodes.
> 
> Thank you for the submission!
> 
> The patches look good to me, but I don't take non-bugfix changes
> during the merge
> window. If there are no other objections, please send them to
> soc@kernel.org next
> week, and I'll pick them up through patchwork for v5.17.
> 
> Can you also send a patch there to add yourself to the MAINTAINERS file?
> 
>        Arnd
> 

Thank you for reviewing.
OK next week I will resend the patches, including a patch adding me
to the MAINTAINERS.

Thanks,
Taichi Sugaya
