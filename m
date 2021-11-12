Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9405344EEE6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 22:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhKLVzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 16:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhKLVzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 16:55:39 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941D9C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 13:52:48 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id np3so7805982pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 13:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ANGtRiBuH7W5lz4MAhh+1EIghppJj6tpt87fCZ9Im08=;
        b=EEfeFvaAPlQ5UrnzruceLnzgqGeLnQNeSft5NxoAHIx125qUbbMgbakB+xT6q4ZtHT
         JDhzBM84OdmsPG1SJ2ixCFGlr1//0kU5lB8p9PB7POOmlpYjltmR39TN4TZDtP+zx/IP
         URN9ems4qD3EkiNQ8tajXbs1suzS3uBJYgjYV96LK5R5FeaDQBgOiPNdDvABVnNU9pPM
         NYomEwmwPSnTiSQoLHD41hkjgOln46OIPJuSncYTZfystCW4HZhMjKWd3+NmFZISCox9
         ZjdSt8S2tuKQLK7E9SBLgYuXt70cJy7eimM0QJrvpnb0uVu40kssaiYl79rCrHeNjcpi
         sX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ANGtRiBuH7W5lz4MAhh+1EIghppJj6tpt87fCZ9Im08=;
        b=2uZ/4cuSoDrb6g4apBIIiVCUciBDZSRZ82/Pz05IGvSxPBws/N+RAd/Qi4E0Bn74iI
         kHUYDIis1rgE0zNdsbFPHHdxK+ura09CiUQu0Zu01BfxGYb/JvQQRz+6ChRRVThtCSPG
         6VRXpXjTUK7Cdv9RWsW84/5UIWj5cwP+f0u5MiNE/vlA2KdwxYKXCokBqHplkYIRRkxG
         y4Bgy1MdCxYZKScM13VU2+fY7LFCUUjjj19rebExMD2cS4SApME70Ad5ep/xktIB2dNe
         LRd0HfHK5XN+zQqluQpNpXh5b4K5ArY9uTdOCouzquaWiWNz564eIz0XPr4PQaKpoaQm
         LS8A==
X-Gm-Message-State: AOAM530+7o30dnrrPv8DZReGwwRFJPquZHWcKPc8YF7HrGI6pPkAKOFZ
        Hvfl1u6LhwKQQt8VN7lUcoQEylmkFdA1NQ==
X-Google-Smtp-Source: ABdhPJyC7MkUqX+Vo06PtKpg4AaN1sPiv/QSwbIQMW5YrbN4z210PwCJTcTJytum2Q1jSD4kIX5nIw==
X-Received: by 2002:a17:902:860b:b0:143:87bf:648f with SMTP id f11-20020a170902860b00b0014387bf648fmr11696909plo.11.1636753967481;
        Fri, 12 Nov 2021 13:52:47 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z1sm5461684pge.4.2021.11.12.13.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:52:46 -0800 (PST)
Date:   Fri, 12 Nov 2021 13:52:46 -0800 (PST)
X-Google-Original-Date: Fri, 12 Nov 2021 13:52:44 PST (-0800)
Subject:     Re: [GIT PULL] RISC-V Patches for the 5.16 Merge Window, Part 1
In-Reply-To: <CAHk-=whkh5Qma5rHtiRQXF9jVRXDe=bRG+D+LFu4dZpwP1uWAw@mail.gmail.com>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-8aed9afb-1b05-413b-9808-5d0936c9f131@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 13:37:46 PST (-0800), Linus Torvalds wrote:
> On Fri, Nov 12, 2021 at 9:32 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> RISC-V Patches for the 5.16 Merge Window, Part 1
>
> What's "part 1" about this?
>
> This was sent on a Friday of the second week of the merge window.
>
> No way in hell is there going to be a "part 2" that I would possibly
> accept at this stage. It's late as-is.

Sorry that was misleading, I guess I just wrote "Part 1" as a matter of 
habit because it was the first merge window PR I sent out (it's late 
because I changed jobs and my test suite wasn't playing nice with the 
new computers).  I wasn't planning on sending anything else for the 
merge window.
