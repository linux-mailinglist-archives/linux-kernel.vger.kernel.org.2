Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F189402F85
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346147AbhIGUSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbhIGUSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:18:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40041C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:17:39 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c8so194009lfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+KGhYMgK1PVHY7rBwS9EUIJXA2FVDMYX9D+w6O1J5w=;
        b=VEz360yo7xu2o0NuXGXH5d8Q7YvFTngvyuJBX8GHrU0YXCxs51kibW+M2plsjo4dDK
         Ndn74+JzT91U/n5NlJfhQ9Nnq3vM0rbjUCsRdQ5cQyJG8dEvJE0nC6koSHjF19nhiVAx
         yfJo6e0butS5hr2d5jVc5/1EMBpy3M5TlsOFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+KGhYMgK1PVHY7rBwS9EUIJXA2FVDMYX9D+w6O1J5w=;
        b=RvaVSjta5z4fCbh9ZvWLXypjUU4agzOpxH9h/qvbluJ5eaUXsHz3MfQyYB75ycMPKy
         Z+V06rBtultcsJ9MO5UaBvcGAhvUnaWQXywGk7Hws91bx6Q0THHt2xMPs7+o/hv50h01
         VbRF+BbVIrtSHvUsUrVJWXWJHVC57hB2fbn+P3zNkOj1g65XKsM5qOr3mNlzl9eCJQLM
         lP5S0iEYw8v69ja2cMCMzOVD3iW1rJlpfOTxuY3QBm+MnC13gc1y8v6LqEzOkOiJIjuz
         Gn7DZXx/viozX7QgItEVEZNoX9DgCo6pbX4xWOscjuYQaXRvm5wYvvqX6sK0kw8MBqkD
         p6pQ==
X-Gm-Message-State: AOAM533SPV1WhaqsCnbloei7KO1K8PLnJlKBJdueI2N2+KwmCZEPpPiO
        wJ+0y0iUpAuqiRR9oBz/H6rMEf4PsVOBtmZBkyw=
X-Google-Smtp-Source: ABdhPJxl9Tz89oH5gANABuP9eYFDyEE9TY2v87trXvdKQFs2IPkuujfIHjeaPcKYm/uaK8ziDll66w==
X-Received: by 2002:ac2:50c7:: with SMTP id h7mr131736lfm.75.1631045857159;
        Tue, 07 Sep 2021 13:17:37 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id n5sm1531611ljj.97.2021.09.07.13.17.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 13:17:36 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id m4so500088ljq.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:17:36 -0700 (PDT)
X-Received: by 2002:a2e:8107:: with SMTP id d7mr56757ljg.68.1631045856232;
 Tue, 07 Sep 2021 13:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210907102428.616e5087@endymion>
In-Reply-To: <20210907102428.616e5087@endymion>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 13:17:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLh7BGv-6_TFsqezM31o0ZoZruBkUs8fus-Fm-sn233g@mail.gmail.com>
Message-ID: <CAHk-=wgLh7BGv-6_TFsqezM31o0ZoZruBkUs8fus-Fm-sn233g@mail.gmail.com>
Subject: Re: [GIT PULL] dmi fix for v5.15
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 1:24 AM Jean Delvare <jdelvare@suse.de> wrote:
>
> Please pull dmi subsystem fixes for Linux v5.15 from:

Please give me a blurb about what this fixes.

I did look at the single commit and made something up, so this is
already merged (as pr-tracker-bot has noticed), but in general even
just one-liner trivial "this fixes modalias that got broken by a
misplaced field" would have been appreciated.

             Linus
