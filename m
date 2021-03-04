Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C64432CF38
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbhCDJC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:02:56 -0500
Received: from foss.arm.com ([217.140.110.172]:35436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237100AbhCDJCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:02:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B6CD1FB;
        Thu,  4 Mar 2021 01:02:01 -0800 (PST)
Received: from [10.57.17.29] (unknown [10.57.17.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 935153F73B;
        Thu,  4 Mar 2021 01:01:58 -0800 (PST)
Subject: Re: [PATCH 1/8] ARM: ARMv7-M: Fix register restore corrupt after svc
 call
To:     dillon min <dillon.minfei@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@armlinux.org.uk, afzal.mohd.ma@gmail.com
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
 <1614758717-18223-2-git-send-email-dillon.minfei@gmail.com>
 <5284d390-c03a-4035-df5a-10d6cd60e47b@arm.com>
 <CAL9mu0KUhctbBzmem1ZSgEwf5CebivHOSUr9Q7VTyzib8pW=Cw@mail.gmail.com>
 <5efe3d44-8045-e376-003e-3ccbff54fb23@arm.com>
 <CAL9mu0JoHqo_wnpNN9ZqRnzzKjhOwEktZ5yPtO8-6WBh51g1BQ@mail.gmail.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <703c43f1-7b83-32ec-7c50-baab00b6bb34@arm.com>
Date:   Thu, 4 Mar 2021 09:02:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL9mu0JoHqo_wnpNN9ZqRnzzKjhOwEktZ5yPtO8-6WBh51g1BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/21 5:42 AM, dillon min wrote:
> Okay， got it. after adding msp/psp switch code in RTOS, now the kernel
> can be loaded normally
> without any modification.

Yay!

> 
> So, just drop the changes in proc-v7m.S.

Glad to see they are not strictly necessary :)

Thanks
Vladimir
