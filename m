Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E7235872B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhDHO31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhDHO3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:29:23 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C744C061760;
        Thu,  8 Apr 2021 07:29:12 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id x189so2924998ybg.5;
        Thu, 08 Apr 2021 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cJ1HKbVq8oYS2MezhvWMnzWregg532xa6RuUFoQmjM4=;
        b=j5HdqHozCPgm+rdf5wrN48PYpnJ4eAaKZCJ+dTn5RHjjEpDtAl5aHtC7Yl7f8yDE/p
         wJysoQsWiCG7OFsNmI4mduW3HU5peiVJC8T8QAbF8NW2dTdqK9i9hp46bKcHjikg2ZLq
         gJH6/weLIEkoO1+WBdWug5Q+LDKGBbqUrRYdgLFyXfqlHvyNH5WXB/bWIQgFvaCO2kI/
         Hrxvk5NQKBYRi8cM0Mutcc6vx7plFq3/qkBDZH3a6SQC2tGp71gQcZaUM3Ey855xVxTE
         yqSmY5azF8GTh36VOufefn4uofO8tnmE4YBsDciZTNL6zGu5Go92TeX8vdbzOde/DmN4
         8L8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJ1HKbVq8oYS2MezhvWMnzWregg532xa6RuUFoQmjM4=;
        b=KPFXMMD6spa3KMv95t5GT13p5kJfl3EeyMrxDuLf1Ghi4nbY3Y+iHTcY0SuG8UpdUQ
         XBFXOTGZO5FuEhBrT4k4ED9HFUh6uYibNnGIJUC9KEuN8IWwQOfLImDvO55fpKppxoMk
         qoSaAC8zU7QprqGCG7bUefaOm8gSd7OR9vNO1l56DxVJgRAXT84X48o3/WYKxuqez8KB
         NPQHjlwOx99tx1pmxVz+9dPcE7bNHh5CMxrEos2TgKbzu7i8pgI2CdVWv0bSZJjJXHhH
         k0n/Eh1jcZgrQHE9Zpd0beul1lPUJRL0JUmk7VCnptkg66txoyP02E+dUVCDrDyr0sEo
         XB9Q==
X-Gm-Message-State: AOAM532PY/YSAA012cVnS2/osHl3EfSWTEUC2Zbv7q+sE6g9Au5BFYP5
        FDvix0uS6gCFSCWac5GtMktN1il61+QAbkIyKP0=
X-Google-Smtp-Source: ABdhPJwV/UAGKfdvuY2VHiZaUizO/h/HFjqV/HN2u/My7JCKnVvCPkkukWXZdo/FHIwjFpx9JnKXK0KJ68bpfCHNxiU=
X-Received: by 2002:a25:3211:: with SMTP id y17mr11618063yby.44.1617892151657;
 Thu, 08 Apr 2021 07:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210408120929.GA4346@test-VirtualBox>
In-Reply-To: <20210408120929.GA4346@test-VirtualBox>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Thu, 8 Apr 2021 08:29:00 -0600
Message-ID: <CAOc6eta6ehHRhEYrWv0daS6WrC4oJg0Q8q2CB=K5BzF-E61jxQ@mail.gmail.com>
Subject: Re: [PATCH v2] staging: rtl8712: remove unused variable from rtl871x_mlme.c
To:     Sergei Krainov <sergei.krainov.lkd@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        florian.c.schilhabel@googlemail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 6:10 AM Sergei Krainov
<sergei.krainov.lkd@gmail.com> wrote:
> No side effects can be seen locally or in r8712_find_network()

I am sorry to jump in. Sergei, what Greg is asking is basically why
you want to delete the r8712_find_network call in the first place.
Deleting an unused variable is fine, but the problem here is that you
are _also_ deleting a call to a function that _probably_ does some
things that, even if you want to get rid of the variable, you would
probably like to keep on doing (and so the call would remain). Is that
call really not doing anything relevant? That's what you will have to
explain in the patch in order for it to make sense.

As a side note on top of the question about the call, it's not like
the variable is not being used. It's used right after the call to
r8712_find_network to check the result of the call... so is the real
purpose of the patch to remove the call in the first place and then
having the variable removed because there is no point in having it if
the call goes away?

I hope that helps.
