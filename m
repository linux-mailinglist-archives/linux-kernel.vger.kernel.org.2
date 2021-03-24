Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F226347D19
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbhCXPzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:55:52 -0400
Received: from smtp.kvr.at ([83.65.151.181]:38281 "EHLO smtp.kvr.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236861AbhCXPzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=20200417.ckk.user; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=T+ZUbHfYrCAAOdsY5MRcKMgLRvqFDJxpzqwv+fHA394=; b=VOdsh2GKl2fY/glBlYpV7c/XyP
        hhlPDORhCi8Fr7y3vOvxJbrrz/6PwiZ5Zd4vQfr/1UeQfLi3S8J367omp2xMCfNroE8f9WqDBCEJW
        5ByDo/YIviG3+YSCLgJf7SPHzwOHeAPMSUihrYmSA+mHRW2eLTXMygeAUsOLrxh5zSD74VzT6c3aj
        DgGYlfJ9gEgVq4IoYJo2QIbpkLiStqE1dCDS6jHN4j+X+j6LefXKHbAHI3NZRhMpwpSLUKFiXI8Q/
        Bgax/3+5sk58sVbjqYnjWUgKZ33BNNcTZqSuMKUmCt8jOXe0sbWtY1GHNvkZzKhsRTmHjkMIbLrP3
        jIhSB3iLX+wX1qPurTxxBeBy01WsBlJ5971bEeEYLHN2lMhfnfQoQOZZKWIy/jGezlq1Gkjz6Is2R
        FPzKlhi1YNAN0WNtAF9lA47+FC0oUuAJFIIFcXeHXETQT6nhOPK4p9U4YoLZDd68DXU344rxzZwSZ
        oscyOS1lDdq/Uet6xT6Io1pqQMv4FuhsFcSovmrTuXqx7B5/ipnrm3oHGN2qigg6K+2MThIA8kKgY
        6JinFU9rVh1seodhGltWDsh7MImQ/3Usheylm5+procoSYG80dBdyL4TCVqQ48q4h0S4dPma8Ug+A
        hi9N4Jp+id7d8isoZVoPFXYDNfMu/UT3/6cYxNwnc=;
Received: from [192.168.0.7] (port=59720)
        by smtp.kvr.at with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <ckk@debian.org>)
        id 1lP5r0-000bkl-1D; Wed, 24 Mar 2021 16:55:30 +0100
Subject: Re: [3/3,v3] tools/power turbostat: Enable accumulate RAPL display
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kurt Garloff <kurt@garloff.de>,
        Salvatore Bonaccorso <carnil@debian.org>
References: <1f6d32e14f121a8ccf8807b8343597c3ae88c7d2.1587196252.git.yu.c.chen@intel.com>
 <20210308134957.23852-1-youling257@gmail.com>
 <CAAYoRsXec2eq=t-pSn5TOqNt0G6kfZCKkDuEhCnX5SgL0zgkBg@mail.gmail.com>
 <20210308161548.GA37664@chenyu-desktop>
 <CAAYoRsVkrHberSgM42dqYjdVwz8vumURJ1_DGeV1R5-=LMdjVA@mail.gmail.com>
 <20210312134114.GA21436@chenyu-desktop>
 <CAOzgRdYZM53OC-7DwnmKr3WBOAkKmqstvvs36cMVTOQUZ8qrUg@mail.gmail.com>
 <CAAYoRsX-WJFEJQVve=fmZqh37uYSX5v5EAFsy=hBRc=V4GCG9g@mail.gmail.com>
From:   Christian Kastner <ckk@debian.org>
Message-ID: <6625df66-531b-beb2-25f6-68feab28bda2@debian.org>
Date:   Wed, 24 Mar 2021 16:55:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAAYoRsX-WJFEJQVve=fmZqh37uYSX5v5EAFsy=hBRc=V4GCG9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.03.21 15:44, Doug Smythies wrote:
> Just resending to previously missed people who should also test this.
> (See other e-mail: Re: turbostat: Fix Pkg Power on Zen)

Worked fine on my end (Zen 2), thanks.

>>> From 00e0622b1b693a5c7dc343aeb3aa51614a9e125e Mon Sep 17 00:00:00 2001
>>> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>> Date: Fri, 12 Mar 2021 21:27:40 +0800
>>> Subject: [PATCH] tools/power/turbostat: Fix turbostat for AMD Zen CPUs
>>>
>>> It was reported that on Zen+ system turbostat started exiting,
>>> which was tracked down to the MSR_PKG_ENERGY_STAT read failing because
>>> offset_to_idx wasn't returning a non-negative index.
>>>
>>> This patch combined the modification from Bingsong Si and
>>> Bas Nieuwenhuizen and addd the MSR to the index system as alternative for
>>> MSR_PKG_ENERGY_STATUS.

