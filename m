Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC0F322319
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 01:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhBWAYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 19:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhBWAYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 19:24:12 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF09EC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 16:23:32 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id k17so7478123ioc.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 16:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSYZaJXIS6C1ICWmDRD2w5Tj1QqQKhWbKh2gJxndPhk=;
        b=ajmxv4fS6M6sj14txf7zaT5coPITkpoKwRIgXe473kZuObcls/OHDfGBn1Zihh2Eu/
         JL8+BksJ8U7tz/nbwyj/NK/FJT7PRIywEFQ/nTqSK2J1+QGfUW7pvHjGADl7yfGif/PQ
         JsKO2L5Izy22clabS/Gi+5t/LgcNevs3sDMoXu2D0JGepUdh5NXI540WWhd0W/njG60W
         9HLFkSQrO1wKU1qMm9LPMVsFmXkZd4sBQ34vbJB/KkHM00eBx7bzK0UaGrpGDaX6pXUs
         mOFGdDXRMwE52Y754dfNs3cD686Djdv6EoODN/fCWYPTWB3UKdMjC9vDvDGmYEVOKtLK
         S8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSYZaJXIS6C1ICWmDRD2w5Tj1QqQKhWbKh2gJxndPhk=;
        b=iQsPj7WC5PsJnJJLPLr1l0/de/RQd8y+3kYZ09JCQl1x65tH4WvMiaK8VWknGylCak
         3coqLv0O3emaq05himGX14q/PUanYZNOUx0Nl0Khc0zRrpGMzuMANsZlONj1fqIyjxoT
         5cjk1Bdp8Ii2URbZp3hMbB/mOpfBbhA0sdACQScLaWXz8K4/i9b59yZUqWlVe8DaYFQS
         ek/kOhIolpIfUa25hKGZcnO2eEIaxUYXuG9WHO4QCv3P2VRQRzTRx1yutaqocHTDGcol
         Zxj/YeYz24MClt/fsGlEHrKk4N7pO2FRgzedOSV7hZBnehkM+QfH6IMEttf1kBVQz5Uj
         LPzw==
X-Gm-Message-State: AOAM530kkSIeL946nOQsZ2Acs5XvWzKaQuo4Kny+TUagOwNNpT8oZ6bR
        4SP74qQ23/KfToMMyxhZ0CnPnTbHzo9pI13o90zkbQ==
X-Google-Smtp-Source: ABdhPJwhGfngyKx+KH1gapYhp//gieSYgnDoX6gnuQ/irJzk5wEu3895VGrImqqIbcMBtkWsLQpTgbyXNiKx+vlyL/8=
X-Received: by 2002:a02:3541:: with SMTP id y1mr24777666jae.66.1614039811998;
 Mon, 22 Feb 2021 16:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20210210013206.136227-1-dlatypov@google.com> <YCNF4yP1dB97zzwD@mit.edu>
In-Reply-To: <YCNF4yP1dB97zzwD@mit.edu>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 22 Feb 2021 16:23:20 -0800
Message-ID: <CAGS_qxrPEa8kUK+U_bw+isnVRVP_6RdxmyE+Az=G0EhgG45Xhg@mail.gmail.com>
Subject: Re: [PATCH] ext4: add .kunitconfig fragment to enable ext4-specific tests
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 6:33 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Feb 09, 2021 at 05:32:06PM -0800, Daniel Latypov wrote:
> >
> > After [2]:
> >   $ ./tools/testing/kunit.py run --kunitconfig=fs/ext4/.kunitconfig
>
> Any chance that in the future this might become:
>
> $ ./tools/testing/kunit.py run --kunitconfig=fs/ext4

For future reference, this patch would make ^ work.
https://lore.kernel.org/linux-kselftest/20210222225241.201145-1-dlatypov@google.com

(This time w/o the typo in the path to kunit.py :)

>
> Or better yet, syntactic sugar like:
>
> $ ./tools/testing/kunit.py test fs/ext4
>
> would be really nice.
>
>                                                 - Ted
