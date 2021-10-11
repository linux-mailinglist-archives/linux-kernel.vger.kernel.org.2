Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D8542977B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 21:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbhJKTUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 15:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbhJKTUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 15:20:32 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B896C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 12:18:31 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p16so7078935lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 12:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akSYF39zgtk0a5MnXnEYsYFXQGdJumKzdd6cC0TD2zg=;
        b=A4QzBMlCMcBx5BCw4khuK2ji3v2yerT3KTw/4+qVIbsvo5B70UhvreUPdj9K7tHbQ/
         GM/9M705H033Sm1LVwWfUojU92ep1ICGRa+zBv6ei6WkxxlMd67VsAXa4B2wym1X8LD0
         zK/HaC9as2SgjDwA6dvyPAsfMg3nelTosFWyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akSYF39zgtk0a5MnXnEYsYFXQGdJumKzdd6cC0TD2zg=;
        b=wGdLR/LEFoYY9iTLNDEwOYmgnoJQySr9AAUhCi9VtP6g50x3rmTYyB54g2Vy9eKRDh
         wVaENwfWZ+6y2ImRoDpAW8mb9Pn/vOVjDkYAJfNxt63WpR4LATleYv9vwoFGlZ34Viz4
         S9BVDVpD+woTpBK9vKapz2Nk26N0IrDzzARH8juMNI0lFmfitL2j2z+AlSCpId9jfrAk
         wJzg75apuORpTatyCLzlk5PFLDl4v0jEaj6P2V1rLgfPd+dOMvFRFsy/dhItw91ap6b+
         CEG763oOh4zcUd9RKYnt2uRojdyXCX0WQF6WV/wWP+rjP1+jo1zlJEN6KzrPGurZjKJF
         F3YQ==
X-Gm-Message-State: AOAM531r7fqaexplwBxgV8BJVAL3ID4tsi0hIue+YnBMUh+KTkeiZ0cm
        Uc5lsFyDIpe6WW/JY2sy7H2xbgqpijEsJ8YR
X-Google-Smtp-Source: ABdhPJxjzDLuz+pbtIws2KuOeRnPTRi72d6fSNU4M00ns8iSAqUOWd6kySC156PzJmK+Q9xCgBBd6A==
X-Received: by 2002:a19:c74d:: with SMTP id x74mr28691281lff.603.1633979909624;
        Mon, 11 Oct 2021 12:18:29 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 195sm160071ljf.13.2021.10.11.12.18.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 12:18:29 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id p16so7078765lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 12:18:29 -0700 (PDT)
X-Received: by 2002:a05:6512:2248:: with SMTP id i8mr6899360lfu.655.1633979908936;
 Mon, 11 Oct 2021 12:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633976241.git.dsterba@suse.com>
In-Reply-To: <cover.1633976241.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Oct 2021 12:18:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyP7conp58OoJA5wjWdMf8BBek3vw0C3n9HBOw8BHZuw@mail.gmail.com>
Message-ID: <CAHk-=whyP7conp58OoJA5wjWdMf8BBek3vw0C3n9HBOw8BHZuw@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 5.15-rc6
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 11:40 AM David Sterba <dsterba@suse.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.15-rc5-tag

I see the 'for-5.15-rc5' _branch_, but there is no tag there.

Did you forget to push that out?

              Linus
