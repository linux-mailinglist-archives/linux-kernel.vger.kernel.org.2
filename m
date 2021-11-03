Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B44A44488B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 19:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhKCSvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 14:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhKCSvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 14:51:10 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C514FC061203
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 11:48:32 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s24so5412986lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 11:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLY2jWhqalFDEIv6BXGfHi2ORZbhy7ia23ahAiBL5q8=;
        b=MnYIfh9K4iVdIy3/Q4jGlXOD785PXwFrrhp22S3h38IRAVyPUnzbxb2WF4fj/Q7oAZ
         k5gzuePlePHk9WLhHPRZ6KYD6FddHjWoMv8AHmbVHAQXRmVPVTvhoHcrxmRo3FWUaJMm
         +ofwiIHgazHGiQXZTih/ekH4r888DWo9POyRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLY2jWhqalFDEIv6BXGfHi2ORZbhy7ia23ahAiBL5q8=;
        b=p9QTUTDciTsdVlDDVS5fio+FhJfRMNfKHVXdd67YYt+2KxmVdYdhNJQOJaixmpyaPJ
         Qx5E16VLhKJ1pezJNaAAY6fSN7uJb2dVVUqcQBypBTGQClPMCm25CLwZmSjLoB97bos1
         6zrIHAmmL+AhUjgA3jZU0iQo3lMfBvggPwvA39ZVkeeBhmToxSqrQfieOJjUDa/hLfI8
         sHWllBPhlM2gEdgZMFP5z93orXrYjam2iVCFleDdmdHmCSegrH8OA9LAFsdp3DYorVGy
         9GOdb0l4ft9EGgOt6L3y3lxylvYDIzGQSdcYD5TxxnDuNql2iAF5/TBCU9e9bn6/LmuO
         VroQ==
X-Gm-Message-State: AOAM532FZTK44u/vPOuu9BDW5WsFgKL8wOdfySjKtTA/FEwO4ODJKqD+
        wIAQ4d5kL1T7mHBLuljKczS6sjCoxYMg57KI
X-Google-Smtp-Source: ABdhPJyRZ1eRZU/MZNoNfVXhkv/Wk7rE44vbNFG0Z8qbrmBvPTc90+Pog5hiRgIgc06OBBH/9ODqdA==
X-Received: by 2002:a2e:1546:: with SMTP id 6mr17737776ljv.479.1635965310777;
        Wed, 03 Nov 2021 11:48:30 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id n7sm244564lft.309.2021.11.03.11.48.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 11:48:30 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id o18so7007153lfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 11:48:30 -0700 (PDT)
X-Received: by 2002:a05:6512:3993:: with SMTP id j19mr39722467lfu.402.1635965309983;
 Wed, 03 Nov 2021 11:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <5779281.lOV4Wx5bFT@kreacher>
In-Reply-To: <5779281.lOV4Wx5bFT@kreacher>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 3 Nov 2021 11:48:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2tO46FtJaRpCrdgifAusMbhsBAcg_ZmX3+AO_-sf-DA@mail.gmail.com>
Message-ID: <CAHk-=wh2tO46FtJaRpCrdgifAusMbhsBAcg_ZmX3+AO_-sf-DA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Drop ACPI_USE_BUILTIN_STDARG ifdef from acgcc.h
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 11:46 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> The ACPI_USE_BUILTIN_STDARG symbol is never set in the kernel build,
> so stop checking it in include/acpi/platform/acgcc.h and drop all of
> the macros depending on it (which appear to duplicate the analogous
> macros from linux/stdarg.h, but in fact are never used).

Ack. Thanks,

                Linus
