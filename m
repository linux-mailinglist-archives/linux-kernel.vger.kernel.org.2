Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD9444F567
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 22:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbhKMVPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 16:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbhKMVPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 16:15:39 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2079C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 13:12:46 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r4so5281770edy.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 13:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bMvMRcKJ0xIGHkquIVh8JvQQqviT/pBrCLoX/nW/010=;
        b=f9evVuOycwlxxEVG1R4k96EeegfDVzhi2vQP4BnWHyWCsMOvPwI8iYvAoAFWU3K7zr
         v71zL3b3rjUdTW28xAJTEZ8TJAugnwGr+uAc78d7xTJ4ds2374dmcxA4MzTcj4vCm98J
         YyyWoMsZJLQLG6gAz/8OynlxBjJYAHY7qSwRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMvMRcKJ0xIGHkquIVh8JvQQqviT/pBrCLoX/nW/010=;
        b=O5wilDMSTxvqd0csva9hU5OUCbtAh22eClXctHbBTpTV5eONfhGr+r7tC85qAdcmVW
         r6dUJocX3ENVmR/UovNmUyhDYHBi2GCvKY/QSh57L5ft024HMhLtCorJVlph+L4NgFqk
         eQOedMAqn5MIp15FkBXLon8fZRA03cfs7hH2yRdb8HSFrhUO8eRxJ7PE0HXLYSAhV8tV
         ZtwkT+lT1rDyB5jFV6nUwnZB9SYxJGcy3YdVBmOsa0um/gaEpHmprKAM8/Pkq6QBmCQN
         1ixMpdjFWEBXsCA7LDTgZCxyIajQPFjj3kZB8gl5PVCCC+k1Eni2NQlhrN7a2eRNXh+n
         NBNw==
X-Gm-Message-State: AOAM533kaItokNGKqIdSTK5UQQBPQW0aXrsNIIvakeDUZX6ehQ74WVCj
        1i7lWI1Bpa1Af1PhMYoBpKuVgTp50VOxVIWFjEY=
X-Google-Smtp-Source: ABdhPJzbDYJgIhuTIPTOJe6JpN00OxkUv3HB0rUPFyNXobUszOBJPDQfRC52i4FmkCQ4D9/qQmhIWw==
X-Received: by 2002:a17:907:c02:: with SMTP id ga2mr32775401ejc.217.1636837965375;
        Sat, 13 Nov 2021 13:12:45 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id y15sm168261edr.35.2021.11.13.13.12.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 13:12:45 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id u1so22106293wru.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 13:12:44 -0800 (PST)
X-Received: by 2002:adf:d082:: with SMTP id y2mr30282675wrh.214.1636837963987;
 Sat, 13 Nov 2021 13:12:43 -0800 (PST)
MIME-Version: 1.0
References: <20211113063648.3184640-1-sboyd@kernel.org>
In-Reply-To: <20211113063648.3184640-1-sboyd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Nov 2021 13:12:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgs19T7XiA00EEzO6960VFpCAO7PQTWUFYn4AZr=ra-BA@mail.gmail.com>
Message-ID: <CAHk-=wgs19T7XiA00EEzO6960VFpCAO7PQTWUFYn4AZr=ra-BA@mail.gmail.com>
Subject: Re: [GIT PULL] More clk changes for the merge window
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 10:36 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
>  - Revert the module platform driver support for Rockchip out
>    because it wasn't actually tested

I'm not sure how to parse that sentence, and the actual commit didn't
give me any hints either.

I ended up just removing the word "out".

              Linus
