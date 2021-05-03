Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7DC371F1F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 20:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhECSFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 14:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhECSFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 14:05:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671FFC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 11:04:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j10so9341518lfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDT2iOj8qBpgLchbxVPMSU7pQe2V2hpsXxFE1HWPV7w=;
        b=T+EfGWagrDg4BQkFQcBMU7cv5sNyMgxFY5hqjwYWPt4BW6C0beOZoXbfOlSlqBWHYE
         Edekzs3yM/taz6lv4RQZp6zvSAeqWFG92JkovoozH5w0+uCNxmGgGxYWlxvHd7sJ0p5n
         XNcyG+fkr27BwoQrks6h9TJmUux2I1wBa+Dh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDT2iOj8qBpgLchbxVPMSU7pQe2V2hpsXxFE1HWPV7w=;
        b=B2PDjBKu/FrwMQlgI8P/B37AFcpOPpAe94uHSLzm/eFV+vwiWehCmk9SPzBXW8jk98
         AcMnIfKFpcMPIbQfvH1MRPOSuXTiYv6s3574HnjmkgiuV8IGyCFaPa9EGbolN77TjNCS
         mV80lmUuBy6ZTFz3/y1yJz0ENbBDHVVo/cTF10dgULXmq0K0IQkC1Y72nbFThQ2q8fdD
         gHO0nl48VeleMmo88oY1feOBSC1pf7fsNG0bGwzi2mIN47ic+nMMd2YbtaWv9hAMwc+t
         cGulN2oSoA50PAR6VJYcziWp2j4jX5SKkK8HY4CQ46HS2mIN/AOZgSh6LnslBfs5u6Lb
         a2Xw==
X-Gm-Message-State: AOAM532AyEdMQXgTpRVNLV3Im4jFM2k3M3n6ijimE5V8HCpWLZDcspTD
        sZPYfiKpzz6kuJOOKBfIZ9wKSUzDEvvMsfYPml4=
X-Google-Smtp-Source: ABdhPJzlGnNcvfpDLlsLoJ6+h3NiG9yezayqTQPrfTQgF964gcQBeQINCpWZh6uWqV92FHQ1JW/gVw==
X-Received: by 2002:ac2:563a:: with SMTP id b26mr5816745lff.324.1620065054707;
        Mon, 03 May 2021 11:04:14 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id d15sm29952lfa.137.2021.05.03.11.04.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 11:04:14 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id c3so5338189lfs.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 11:04:14 -0700 (PDT)
X-Received: by 2002:ac2:5f92:: with SMTP id r18mr14272456lfe.253.1620065053975;
 Mon, 03 May 2021 11:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210502193216.24872-1-brgl@bgdev.pl>
In-Reply-To: <20210502193216.24872-1-brgl@bgdev.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 May 2021 11:03:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSWp3exv8tZ2th5im_P7HF=c6iuOOVb9iSrNrd6405WA@mail.gmail.com>
Message-ID: <CAHk-=whSWp3exv8tZ2th5im_P7HF=c6iuOOVb9iSrNrd6405WA@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: updates for v5.13
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al,
 would you mind taking a look at this part:

On Sun, May 2, 2021 at 12:32 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> You'll notice that we have a bunch of configfs commits in our tree not acked by
> the configfs maintainers. These commits implement the concept of committable
> items in configfs - something that was well defined in the documentation for
> years but has remained unimplemented. Despite the first submission of these
> patches back in November 2020[1] and repeated pings & resending, configfs
> maintainers have remained unresponsive. After reviewing these on the GPIO
> mailing list, we decided to pick them up ourselves and send them your way
> together with the first user: the new GPIO simulator.

It doesn't look huge to me, and I don't care all that deeply about
configfs, and honestly, I'm not seeing huge amounts of actual
development there, with recent commits all being about cleanup of vfs
changes (eg things like the new idmapping changes etc).

That said, I really don't want to pull that with some core sanity checking.

So Al, do you see anything horrendous in how that configfs thing uses
a rename to do kind of an "atomic swap" of configfs state?

                       Linus
