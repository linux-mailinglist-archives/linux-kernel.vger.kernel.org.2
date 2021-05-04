Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B823037315B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhEDU0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhEDU0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:26:10 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E281C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 13:25:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b7so9008257ljr.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxco5XoKdkkQdeuPPA2d1qMEQi2F/pAHKDhVnxntoq8=;
        b=cCqLP/YWXo1MfYZTZ0KgnIYEoCm2iKmH41ZPUffIW/VLUp3TNXlvKDf1CWCEret5aF
         zMs1mD6iNLQG5QMbGipCRIULfZTyU3SIK2+/oaPd5N/vfhP67uQDyQ+NT03CcP2VrOHX
         qmyiAbKRkT9KGEWIN8V6nwv23PME5WgB/jd+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxco5XoKdkkQdeuPPA2d1qMEQi2F/pAHKDhVnxntoq8=;
        b=eUqL9kgvhJw3lbr7Y7eJS1JJssO9PhJmdJ7UgkryXAxw9RASGmssjDekEix05JxNHG
         inQ2RVt4P3q9hz8QzMRoM/xrYUXvaRlpe1quhEu0I/3IP3q2REN3pVrgm2ndkyEExHIU
         /wdU/x69MShIEK6NmXHrXXyL7Uf9Uqe0Ny/0rikwepdE/O88sMmExnuN94b/UrQJEuQ9
         MNwpq1ZH+oXzJa2LXKRZg2+M55MVF9W/41P4bx8xeOgI3yTEzdV4LMD7q1gAUhLEzR52
         RO2kHiIy8pqpucFmKvaqTP/1+dWSt1hpv1TYcICrTe2301MmdxRH55rSOrIQt9oFHHJl
         ypCw==
X-Gm-Message-State: AOAM532TXTX4zBhgCedwznN442NOrl/TAilZaaEU3vCge8BJnriP+W3T
        Kj6MCwzU9OEl3m7uYeRhnN6o+CYjkpwP6zmU4Ts=
X-Google-Smtp-Source: ABdhPJyeeQZ/DsExJDyWTGHxiAYrHjoS6QxYBq2cr5DmCekv0xzr28qrexP9ZL7xDWXoiNObBPPZSg==
X-Received: by 2002:a2e:575d:: with SMTP id r29mr193048ljd.32.1620159912826;
        Tue, 04 May 2021 13:25:12 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id w7sm1483017ljo.43.2021.05.04.13.25.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 13:25:11 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id v5so4035356ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 13:25:11 -0700 (PDT)
X-Received: by 2002:a05:651c:33a:: with SMTP id b26mr18849537ljp.220.1620159911294;
 Tue, 04 May 2021 13:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <YIqFcHj3O2t+JJak@kroah.com> <20210504115358.20741-1-arek_koz@o2.pl>
 <CAHk-=whEjY7eOqPg2Ndw=iM2Mih0BC9LVyX9c6Uc_W=wmwnkkA@mail.gmail.com> <1777114.atdPhlSkOF@swift.dev.arusekk.pl>
In-Reply-To: <1777114.atdPhlSkOF@swift.dev.arusekk.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 May 2021 13:24:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCMLJB4FafaqHOrpE0UOLkq5Wc4EyNSJLzq3NZAwN0-w@mail.gmail.com>
Message-ID: <CAHk-=whCMLJB4FafaqHOrpE0UOLkq5Wc4EyNSJLzq3NZAwN0-w@mail.gmail.com>
Subject: Re: [PATCH v3] proc: Use seq_read_iter for /proc/*/maps
To:     Arusekk <arek_koz@o2.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 1:21 PM Arusekk <arek_koz@o2.pl> wrote:
>
> Keeping it the way it is for the sake of security of userspace applications
> looks more like security through obscurity to me.

No, it's simply "no valid use" and "why expose interfaces that don't
need to be exposed".

splice() _has_ been a security issue before. It's why I want to limit
it now. I want to enable it only for cases that seem to be worth
enabling for.

Have we fixed all the splice security issues? I certainly hope so. Are
you correct in stating that there are probably other places that might
be more interesting to attackers? Sure. But none of that changes the
basic issue: why expose this?

                Linus
