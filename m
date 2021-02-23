Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89053223EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 02:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhBWB5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 20:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhBWB5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 20:57:35 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7F7C061786
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:56:54 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id u4so15833677lja.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3YTt+OBnZdgY7YTDG9R5B/vNmDOeKHekPCOYy0Yhx0=;
        b=MHcmARE6GXe9GATWNEkX/ppYFvKDMu/Qdj8EquOuKjI/tjKA2KYCQRVSePACbXXz8u
         OG7fWuE61jx12EwVcOlVN244TLyIgWhXresA4yUvIjmoDKkew3ivclzTo+39YiJn/Lbe
         X88LFzYhTu1s6FsdE7T336ZwtI4k6GmRce/tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3YTt+OBnZdgY7YTDG9R5B/vNmDOeKHekPCOYy0Yhx0=;
        b=EDn9jsMmByzmSO+NJFAqfr1M/i4QFruw5xNdas+8mCmo7kIQgmpaXbKENCdTofVmCa
         ilg1oVTRfbWgse6144n/NArRjma/UNNgYlVuoaUBMmbXjsQeMd0LJ6WwYNGbxy/E6yXn
         MWT/67On1erI1VywUXRDkBu9cnb6F3tWxCWniQhpo03xbuPWR91lEXYOEAAXHy5PNAmc
         0JgrkYO2/DSLmd3jwiwNLIANk1sZonHso1jtykAeIIgZp4CG3/UkUE0hYh4Ip/dtN888
         2w5dEny9TGWxZGAbJtNiFp4lwYh2FbK3wMjmqlkHI/3Zx1Ze8eOPNcCQWy3AXxfCXQpt
         HBlA==
X-Gm-Message-State: AOAM531inRyf4lhHgrTqhaGDTItqxaY6jF4jXW84BiB3fp9ARDCWgOhN
        g6BoZK/Q54fdqpLDiPthuY4ScMOxMRhIlA==
X-Google-Smtp-Source: ABdhPJzhumDoAgRBs3b03W+VBGg4DmWTgoR065qqZ64cOsAnK2osU+MkUA1JkeT+e+XHdh4mdb0PSA==
X-Received: by 2002:a2e:8510:: with SMTP id j16mr196365lji.428.1614045413042;
        Mon, 22 Feb 2021 17:56:53 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id p21sm2251354lfu.227.2021.02.22.17.56.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 17:56:52 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id d24so8857533lfs.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:56:52 -0800 (PST)
X-Received: by 2002:ac2:5184:: with SMTP id u4mr10058742lfi.487.1614045411930;
 Mon, 22 Feb 2021 17:56:51 -0800 (PST)
MIME-Version: 1.0
References: <YDOGERvNuU3+2WWe@phenom.ffwll.local> <CAKMK7uHQ=6OJcRguCUtiB456RWdCfwSNEXV8pQsfsPodTJ6uxw@mail.gmail.com>
In-Reply-To: <CAKMK7uHQ=6OJcRguCUtiB456RWdCfwSNEXV8pQsfsPodTJ6uxw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Feb 2021 17:56:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi43mDJab1RQz9Sgz5+m=T=nSCyxULywoUHxstEHd2qnQ@mail.gmail.com>
Message-ID: <CAHk-=wi43mDJab1RQz9Sgz5+m=T=nSCyxULywoUHxstEHd2qnQ@mail.gmail.com>
Subject: Re: [PULL] fixes around VM_PFNMAP and follow_pfn for 5.12 merge window
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 2:25 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> Cc all the mailing lists ... my usual script crashed and I had to
> hand-roll the email and screwed it up ofc :-/

Oh, and you also didn't get a pr-tracker-bot response for this for the
same reason.

Even your fixed email was ignored by the bot (I think because of the
"Re:" in the subject line).

So consider this your manual pr-tracker-bot replacement.

              Linus
