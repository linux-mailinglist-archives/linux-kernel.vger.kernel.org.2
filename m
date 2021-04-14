Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BE935F527
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351570AbhDNNnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:43:04 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:35500 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhDNNnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:43:02 -0400
Received: by mail-ot1-f47.google.com with SMTP id a2-20020a0568300082b029028d8118b91fso876238oto.2;
        Wed, 14 Apr 2021 06:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HuL2RDhG4k62RO3tH9ljk4ol7fBjEx023kQ/T78JSCI=;
        b=XsvAAVNGAT6fDnm7E00Nw0ZyqN9l3aDJGt7MfaqRulI3+W1/kyCXNqwPnyf4resYZ2
         VF8yIXIbZu4I9USLkuS3UUuFvuBdsEm4SyOGudMSuiR42M7hccSuew7tTbq6WqytGdE9
         DmE33O2bkrS/M4tWddEe9wYCbZOIvqlNiMDL/Tipqg2pUkYetErz4z4ilBKulE7/rUUF
         CUcdWjRyWySpwyORbmAsqQaDwZRVIdNzaweml2dXOwLiUHbyKlpgppTb2P540Hl2ODII
         6UtqUyxsd/+Y7a8hrkmUlvKwjmIOYN4GSD6VF0IhtpPU2JERjxZemcmKj+Pbx2ot/7pT
         sHPw==
X-Gm-Message-State: AOAM530IIewTvaHt1yEsqZB11BCI65UPAEa12Hb2TCP20Fr0yr/beSRn
        bfOswBebNRvvt6bCixeqHptGmjD8Za7FOJxdHyY=
X-Google-Smtp-Source: ABdhPJygmbUq89Ki6pQ2dKpnSUSbhtWKttyYPtgYEdzjekdY2mF+A685alXNi2VO2ZAZz0tTbQCU1QkLIN9t3SjHsA8=
X-Received: by 2002:a9d:6951:: with SMTP id p17mr20180717oto.206.1618407759989;
 Wed, 14 Apr 2021 06:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <vaWPnw1Txo_MD5Sf-BnMmq3pBTkITza0W5p_jAi8JIy3hBAbCsKPXZ5g5IHKYGqK6zLjzUNgJ59xMCHvhREBUq6Vc1105b8yCIVDgaPABqE=@protonmail.com>
 <dff6badf-58f5-98c8-871c-94d901ac6919@leemhuis.info> <wqM80O49houE3ZJHpxjcrNxijZ_h9pMjxZU2OCL-ZpsdwMhIVFcGXZb9qe93r2AY0qd0dB-94ZVQaF-Xb-i-zqX5DIO5S4C6UTBpVkxvszA=@protonmail.com>
In-Reply-To: <wqM80O49houE3ZJHpxjcrNxijZ_h9pMjxZU2OCL-ZpsdwMhIVFcGXZb9qe93r2AY0qd0dB-94ZVQaF-Xb-i-zqX5DIO5S4C6UTBpVkxvszA=@protonmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Apr 2021 15:42:29 +0200
Message-ID: <CAJZ5v0hX2StQVttAciHYH-urUH+Hi92z9z2ZbcNgQPt0E2Jpwg@mail.gmail.com>
Subject: Re: "Reporting issues" document feedback
To:     w4v3 <vv4v3@protonmail.com>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 3:22 PM w4v3 <vv4v3@protonmail.com> wrote:
>
> Hi Thorsten,
>
> Thanks for the quick and illuminating response :)
>
> > Links to your bug report and the thread on the mailing list would have
> > helped here to understand better what's going on, but whatever, they are
> > not that important.
>
> Here you go: https://bugzilla.kernel.org/show_bug.cgi?id=212643
> https://marc.info/?l=linux-acpi&m=161824910030600&w=2
>
> > But it should, otherwise the subsystem should remove the line starting
> > with B: ("bugs:" in the webview).
> >
> > Rafael might be able to clarify things.
>
> > But afais it's appropriate there is a B: line: just a few weeks ago I
> > took a quick look at bugzilla and ACPI bugs in particular, and back then
> > most of the bug reports there got handled by the maintainers. That's why
> > I assume you were just unlucky and your report fall through the cracks
> > (but obviously I might be wrong here). And maybe your report even did
> > help: the developer that fixed the issue might have seen both the bug
> > entry and the mailed report, but simply forget to close the former.
>
> Good to know. It does seem like many recent ACPI bug reports on bugzilla
> have been processed by maintainers. Maybe it is the ACPI-subcomponent I
> chose for the bug: in Config-Tables, only two other bugs were submitted
> and they did not attract comments. Anyways, I understand now that it's
> not an issue with the document so thanks for forwarding it to Rafael.

As a rule, ACPI bugs submitted through the BZ are processed by the
ACPI team (not necessarily by me in person, though), but the response
time may vary, so it's better to report urgent issues by sending
e-mail to linux-acpi@vger.kernel.org.

Definitely issues where table dumps or similar are requested are best
handled in the BZ, so reporters can be asked to create a BZ entry for
a bug reported by e-mail anyway.

If you are interested in the history (ie. what issues were reported in
the past), you need to look at both the BZ and the ml record.

HTH
