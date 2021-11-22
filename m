Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C332945937C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbhKVQ5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 11:57:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:57652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240478AbhKVQ5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 11:57:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F5CA60C49
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 16:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dP4QVNMf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1637600074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gFB4GGO7VWHQ+sHus62itweDuqdAMpzJGDCrOx7Sl+o=;
        b=dP4QVNMfSY4LMQGoIsQd1bXzVBqBnIQdji9g635rBa5MrXNngFIb7ns5m+skmXDLacidx/
        KVvVKkYjfvyWzs7tqKXk2ZmnH5v/ycgZZaHYYWZFdjbrWSY0OdPfcUDQ7kpRtv0tlVR7Dl
        XK0ay9GNE9xlDz1wxXxmjRwVlimdYqo=
Received: by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 12a4b9d9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 22 Nov 2021 16:54:34 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id v7so52019495ybq.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 08:54:34 -0800 (PST)
X-Gm-Message-State: AOAM530alg1mWFC8bhfe/WC9b3oW9Pwg//+2f6hvELOzL7iHW7P1RAF1
        Kv6sA4z4FuVGAUo8HuIH5TrSIlrUJKSihXRbH6s=
X-Google-Smtp-Source: ABdhPJxQCZYDHGUlMO1aafPrAbyf5t9NtzQjwUTLTK2qy3WoWzWX94MpQ5F7E6I3jpnFtG0Lh5Wkf4D8W6lABPYYIq8=
X-Received: by 2002:a25:acd4:: with SMTP id x20mr67974442ybd.416.1637600073306;
 Mon, 22 Nov 2021 08:54:33 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9pShXywMogVkcBsXtfKxFHmQLe0F9cMF27aveUz6iyWhA@mail.gmail.com>
 <454da641-c065-132e-174b-4e6c9d7db83e@intel.com>
In-Reply-To: <454da641-c065-132e-174b-4e6c9d7db83e@intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 22 Nov 2021 17:54:22 +0100
X-Gmail-Original-Message-ID: <CAHmME9pDO-vXtRaKWRET3V7bPhEoQMV8ofvsVSeFswSiUGjBrA@mail.gmail.com>
Message-ID: <CAHmME9pDO-vXtRaKWRET3V7bPhEoQMV8ofvsVSeFswSiUGjBrA@mail.gmail.com>
Subject: Re: RPM raw-wakeref not held in intel_pxp_fini_hw
To:     Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc:     Vitaly Lubart <vitaly.lubart@intel.com>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniele,

I'll give it a whirl on my laptop. Thanks.

Jason
