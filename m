Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBB63D491F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 20:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhGXRkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 13:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhGXRkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 13:40:24 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC01C061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 11:20:56 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id cv7so2987355qvb.12
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 11:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeMJR/oOT6vnUfEf1QGuRaqBtn1buVaEAa8SwfA3FM8=;
        b=ZgQiFzz0yfKej069imP4GcuB6HeHasV7gVLeT/CfcWN/DTJJg/Spjk6rqSuFDFhlT1
         oVmOW7zBobMisHPGm2lJ6U2deTrWP2dVpcAnkBwrEckp1xEgEVLqrGzio/uH9L0FtJ5x
         YwuITmQmANyJv6cVc1xXEw2bnfEQi9ni8vCVJEQierUO67Va65eBkypz5yIlWnx/sRnj
         Rn1vhvhajRBLIKYV1ZblyUfw7X488U151n4vUehE3r4BY6PlShmmVWoqx8oKVthyfLw6
         T5LvrGgwzMWi8l148NpGRoEnKkQskY2AUFedNhoTmCnP1WvfH1mAVmzhtgS6HRfQ60yb
         t50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeMJR/oOT6vnUfEf1QGuRaqBtn1buVaEAa8SwfA3FM8=;
        b=QItpq/zKriiRu9VaVJT9hrVvuxEjt7RkBn69ZA3aOyGXrBpksTYlCTmPr+sY6efoKs
         zsazrE85TG5t8mRHmBQMkcopIYoSRFChn2uVzTLg15llBUEGqGAc+pT1CEoN6nSRH+ok
         BjSyMfonV1MSDK4zRpEbNxEG4Gcwn5+CTNds4qYVLNgmgjjniV0oYNs+kzzVvHrfQNkE
         l8rylH43hfA8g/eBHKjobI/nSbiO3S2de++K7R/Ig/0Bxd6ao6ISzf0qHL9IhIlr77KE
         UDUBFqwITFbQz51kd9g21LfXeCsIBo9lWr4xUVO2upIcaQWKKZB8PwScuqAzaZVKKX1U
         ASWg==
X-Gm-Message-State: AOAM530IMz/KRKa7kfaCjzPYBeqcmfVET1eC7JLzqPvaRGj+b56Lq1h4
        VsGLhbVS4duiKTbkuCcuwDn29c3MZ3fS9oDxc2M=
X-Google-Smtp-Source: ABdhPJwue+Tzkl6UbAMvQoa11TWdFyaB3DBO04u2KVlOxPM50w9P2ankRPrOl20M6vwOqwo8EisbJUGjr8bJVz62/Qo=
X-Received: by 2002:a0c:d68f:: with SMTP id k15mr10642939qvi.14.1627150855374;
 Sat, 24 Jul 2021 11:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <1627100621-19225-1-git-send-email-chihhao.chen@mediatek.com>
 <s5h7dhgi1e2.wl-tiwai@suse.de> <CAEsQvcs3P+TqQFzQetPfRycpo66eJFwnzwhk2JyCXFaCLFHmFg@mail.gmail.com>
In-Reply-To: <CAEsQvcs3P+TqQFzQetPfRycpo66eJFwnzwhk2JyCXFaCLFHmFg@mail.gmail.com>
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
Date:   Sat, 24 Jul 2021 15:20:47 +0000
Message-ID: <CAEsQvcu3jXa4fXJAu7nvT+G+-S2bZ1BPkcuwnT4VjbrnW1Pkog@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: fix incorrect clock source setting
To:     Takashi Iwai <tiwai@suse.de>
Cc:     chihhao.chen@mediatek.com, alsa-devel@alsa-project.org,
        wsd_upstream@mediatek.com, damien@zamaudio.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Dr. Iwai, perhaps we could restrict the generalized fix for the
> Behringer UFX1604 / UFX1204 with some simple logic to devices that
> only have *one* clock source.

Okay, rereading the original commit log from Cihhao Chen I gather
Samsung USBC Headset (AKG) with VID/PID (0x04e8/0xa051) actually has
two clock selectors and only one clock source.

Correct me if I'm wrong.

This is complicated by the fact I haven't been able to find a lsusb -v
of Samsung USBC Headset (AKG) with VID/PID (0x04e8/0xa051)

Even so, my proposition still stands: devices with only one clock
source and only one clock selector should be able to handle us
selecting the clock selector to the only clock source.
