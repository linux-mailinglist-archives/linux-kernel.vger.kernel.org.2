Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E581C31BADE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 15:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhBOOU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 09:20:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhBOOU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 09:20:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2F1964D73
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 14:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613398814;
        bh=q0JlYlCf2nyiA49eTd+sXAKopkQYFgdklHf+ZkCGemM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NEfB7ZW9pIJeG+Nikm2OzURIn1fPaBViGYL/EyGkzYCTtr6oUQ17y/qjThkMqCI5q
         oDi5NQSFwNoEXt1XPdyQhYthz4Pp3/6UjPR2s473G8wLuk/PmDwX2LOWwEvpMqa22z
         IonNY7DhIiFGI+7mLAIgIYDG8gxnSUVBBmrTRBOmmEXrt6IS1bbOYw4KSpwePKH+8B
         EcLQUamp/gSZrroI2jlyDx7W28Pg0ZxRWrp4f3w2Du6jLDc8+9azfsv9VYzMga58MT
         jSVa+0YJp1vFTso19XPahybuaUOTSoPSCIMHrJbytAlleswwbG8tN6XNzjhwwK73l5
         j2vyzCMG6ri8A==
Received: by mail-ot1-f47.google.com with SMTP id w26so403160otm.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 06:20:14 -0800 (PST)
X-Gm-Message-State: AOAM531gkwgfHTSApCPCDTZauEEOVCIE6ncIMwbZTm4zq2xl8R/qx6Os
        bIoR3itiHPbnxUm7M0zwjAokBJrq62t+ENxOznw=
X-Google-Smtp-Source: ABdhPJzHQ3ZNhQdVjpHCzKDTmD8iRPGe94g3oXTpYq1d+qvMC4dpWDMBG8GCdrpjz6sVW5GoJiDBdWhIiIxlKrDY4wc=
X-Received: by 2002:a9d:3403:: with SMTP id v3mr11497589otb.305.1613398814038;
 Mon, 15 Feb 2021 06:20:14 -0800 (PST)
MIME-Version: 1.0
References: <20210201100023.10985-1-patrice.chotard@foss.st.com> <800f8dfa-0949-ddf8-1635-15311c2c9623@foss.st.com>
In-Reply-To: <800f8dfa-0949-ddf8-1635-15311c2c9623@foss.st.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 15 Feb 2021 15:19:58 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1Xqd0LijMhoms8vdS8zNDP-r=d7i1XL=kOk606Quo-xg@mail.gmail.com>
Message-ID: <CAK8P3a1Xqd0LijMhoms8vdS8zNDP-r=d7i1XL=kOk606Quo-xg@mail.gmail.com>
Subject: Re: [PATCH 0/3] MAINTAINERS: update STMicroelectronics email
To:     Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 2:17 PM Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
> Hi Arnd, Olof, Kevin
>
> What is the best way to get this series merged ?
> Do you pick it and apply it directly, or do we integrate it in the next STM32 pull request ?

I usually pick up updates to the MAINTAINERS file as bugfixes, so
either send them as part of the fixes pull request, or forward them
to soc@kernel.org to apply directly.

If you cc me on patches for a particular platform, I usually just ignore them,
unless they get sent to soc@kernel.org, and in that case I will either apply
them or ask back if they were meant for us.

      Arnd
