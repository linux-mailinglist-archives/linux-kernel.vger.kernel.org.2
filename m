Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1183C689C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 04:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhGMCnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 22:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhGMCnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 22:43:01 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB77C0613EF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 19:40:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id l1so9192687edr.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 19:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6SKPfn6xRnP6RvM1343nJURmtoEoYmDq0f1l/33/h84=;
        b=x7RRPQyv9jG3OzPccMOSnW3VrdK3C+C7wh57/h4YZqZTFnUPLVZIkbejJqFM1bGJXD
         hevjB4DEy9ElJW2GegUT1Xz2iGCm80zDMxIHFu6XRcIUtWY+iXCOVvT0Riyb19LtNK/X
         RALuOfemsmqkkECHX8UFntgZwQiBNizAreHhCk+nxQ9KufS/UsFKP4VvmFp4KT9issBw
         d3HYbjdCRd67BmavBuE9GJTUdo8fV2oYiXZC7dHoKcGKuGW1xjO37V29xWHAPtcL2ejB
         2C2bzm6u2g5vlaz5YJv05KqWddMghzzTRd6D0hlHY3+5n9BgfSBLXDolpjLtUY0GcJNu
         torw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6SKPfn6xRnP6RvM1343nJURmtoEoYmDq0f1l/33/h84=;
        b=YybfufnNnuIXekMWibhmk3W0EalurZ0Iv/d7DMgKFOIwy/9OXu6NOGXn/Gl2kAOpRO
         aAdEK0Fz2NFab7hTAJ9TdEcljWRF/RaocCzpBn4zmO2irRaG+mvR6rBPPHBc/8H7yt24
         lnZ2JOTj6jmH0A58ItBVZ4knw3PO+LN8rY+zFuCbFnzPGRIj3HB/g/uzHyQJbf2l/O03
         ClH1YhHezmIYoW1P8zORSl+sn2M0IxySYxfq9Pe7ubQWyzvQHuEOwoUhFroqcewIRrkl
         18ROI9H7FCFUjscQKh217NfiKjPgWLwn9bGz7f9gFZXjG9QpsLCFUALfbDKyFKoYYlUE
         HFjQ==
X-Gm-Message-State: AOAM5318u+U5n6iFN56KBswceqWpZsof/4kcQwIgUrivtf8L9Eyn7j0t
        g90OMjvzE13CiH81g2g8TgauQ+lkGXKWyCu1+njz
X-Google-Smtp-Source: ABdhPJyZ/TPOOkCsJy185npELs8RkJjMh8prX3d/UtGFgQ0YS2+kXH0n7ovix3Q1wjS+ou3pLjc8wCtqxZLZR+mgDZA=
X-Received: by 2002:aa7:dd88:: with SMTP id g8mr2479547edv.196.1626144010862;
 Mon, 12 Jul 2021 19:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210705090922.3321178-1-roberto.sassu@huawei.com> <20210705090922.3321178-4-roberto.sassu@huawei.com>
In-Reply-To: <20210705090922.3321178-4-roberto.sassu@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Jul 2021 22:40:00 -0400
Message-ID: <CAHC9VhQAM+-TXOHLkcY2VGyJ3PNES0EaNr3PccHT=j3nGAvfPQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ima: Add digest and digest_len params to the
 functions to measure a buffer
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        prsriva02@gmail.com, tusharsu@linux.microsoft.com,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 5:09 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> This patch adds the 'digest' and 'digest_len' parameters to
> ima_measure_critical_data() and process_buffer_measurement(), so that
> callers can get the digest of the passed buffer.
>
> These functions calculate the digest even if there is no suitable rule in
> the IMA policy and, in this case, they simply return 1 before generating a
> new measurement entry.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/ima.h                          |  5 +--
>  security/integrity/ima/ima.h                 |  2 +-
>  security/integrity/ima/ima_appraise.c        |  2 +-
>  security/integrity/ima/ima_asymmetric_keys.c |  2 +-
>  security/integrity/ima/ima_init.c            |  3 +-
>  security/integrity/ima/ima_main.c            | 36 ++++++++++++++------
>  security/integrity/ima/ima_queue_keys.c      |  2 +-
>  security/selinux/ima.c                       |  6 ++--
>  8 files changed, 39 insertions(+), 19 deletions(-)

The SELinux changes are trivial and fall into that
cross-subsystem-ACK-not-really-necessary category, but why not :)

For the SELinux bits:
Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
