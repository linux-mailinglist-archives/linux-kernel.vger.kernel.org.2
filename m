Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2081C3B77CB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 20:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbhF2S2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 14:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbhF2S2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 14:28:53 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBAFC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 11:26:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id k10so41089902lfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pceICAVc3FRjs3oaqr7b2P22W2Ms3JeVrkpDbjmXB3k=;
        b=KMQ8kAPF661x96HUOtTE8PNF8G0M49wR+crECtib50YcD9kxNLel9cEeR41EpoL9PO
         LnAkUJx/XPiwxyVGWG/6crkpBkiisLz52NaES8uF7LevUtjodQq+oHiP/AG1pKPxGyrn
         NQ5y4T90guKFRx9Sr1UaUwgb51Rb7PQUHK9IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pceICAVc3FRjs3oaqr7b2P22W2Ms3JeVrkpDbjmXB3k=;
        b=Ks1T5MrKFhk8aQCNhJh0aMRD7o8u+OA/nObLi8/RWfpPHb5/NbGX8ndK6ep3CMrKBP
         5ojT/Hc6VyTGxAbrW2LE0HL2XYxg8MbzgrdX6oxZ1h6J60sohcjOrmJuVfGv0tmvOWei
         xxYUjeN2Fm4o34hV90C2XsBFiG/p1/dac69fAQMVumBq4RErRceqm/N+czDZJFnjxpGo
         ZiYnOtjX5spHRKQIqZxZkDJsW3GiJ4d4zVMqjaxCvcAJNoE+kTLaVt0m1REybCoSeegQ
         zXZLKzhu596F7E7iTTFEyhNtw6xV5dTrfUcKOBXm116YIsVcWiqb2qiZhAyVr8m+KEm9
         Brvg==
X-Gm-Message-State: AOAM532wrvQ8TR95DVc32MkE9azK03tgALXm3x8Z53VCrfjHq2KmrZIy
        mctLi+I6hmuwF65hnFBs3dn6KlnKZLAlxzA0fWw=
X-Google-Smtp-Source: ABdhPJzL5V7SPI6y/1u1G9MfDzpkzxhO5GQ8E4d2yJ25EabJkSJ0Yy8JJE1CneiT/r+K4pNwfWzaVA==
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr23516196lfc.249.1624991182744;
        Tue, 29 Jun 2021 11:26:22 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id q5sm1700838lfb.277.2021.06.29.11.26.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 11:26:22 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id n14so8769lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 11:26:22 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr23551808lfc.201.1624991182126;
 Tue, 29 Jun 2021 11:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <e566b945-2fd0-bff0-b291-e7538bafc3fc@monstr.eu>
In-Reply-To: <e566b945-2fd0-bff0-b291-e7538bafc3fc@monstr.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Jun 2021 11:26:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wieg+T4HS+7na7m3huPNT3PrGPJE6nwdeABsQueSY=38Q@mail.gmail.com>
Message-ID: <CAHk-=wieg+T4HS+7na7m3huPNT3PrGPJE6nwdeABsQueSY=38Q@mail.gmail.com>
Subject: Re: [GIT PULL] arch/microblaze patches for 5.14-rc1
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 7:30 AM Michal Simek <monstr@monstr.eu> wrote:
>
>   git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.14

I think git.monstr.eu is having some issues, I'm not getting any
response from it..

            Linus
