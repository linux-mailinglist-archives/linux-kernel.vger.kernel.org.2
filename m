Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440863C6200
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 19:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbhGLRfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 13:35:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55110 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhGLRfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 13:35:30 -0400
Received: from [IPv6:2a02:810a:880:f54:e464:19d5:3655:dde7] (unknown [IPv6:2a02:810a:880:f54:e464:19d5:3655:dde7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 36EE51F41E3C;
        Mon, 12 Jul 2021 18:32:40 +0100 (BST)
Subject: Re: Aw: Re: [PATCH] soc: mediatek: mmsys: fix HDMI output on
 mt7623/bananapi-r2
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        linux-arm-kernel@lists.infradead.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>
References: <20210710132431.265985-1-linux@fw-web.de>
 <456f0611-1fc7-75ac-ff45-9afd94190283@collabora.com>
 <trinity-02bc17fc-b458-4d17-baca-8afe30e4c92c-1626110171249@3c-app-gmx-bs28>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <dbe23d2a-cd29-0782-1b7d-bcb5c6683607@collabora.com>
Date:   Mon, 12 Jul 2021 19:32:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <trinity-02bc17fc-b458-4d17-baca-8afe30e4c92c-1626110171249@3c-app-gmx-bs28>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12.07.21 19:16, Frank Wunderlich wrote:
> Hi,
> 
> it turns out that problem is the read+or of the new value
> 
> i reverted my patch and changed
> 
> reg = readl_relaxed(mmsys->regs + routes[i].addr) | routes[i].val;
> writel_relaxed(reg, mmsys->regs + routes[i].addr);
> 
> to
> 
> writel_relaxed(routes[i].val, mmsys->regs + routes[i].addr);
> 
> and it works too, but maybe it breaks other platforms

Interesting, I can test if it fix that similar bug on mt8173 when resume from suspend.

Thanks,
Dafna

> 
> regards Frank
> 
