Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395B342C9FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhJMT0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 15:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhJMT0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:26:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A81C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:24:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x27so16579195lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OcVw8ovBCZVOoCHV49LU9UJr7n1pv24bvXfSbF9CliM=;
        b=spTehBDgwgxtAT5s4zEyEzdavxm/I/DtmCIdVIVhZeouKvynu2a3SSRGv2kSQLqT1K
         I39IIC9a59bpOtvUMiPw5D8FnlNU8xvsp+JppFy07dv5mRlOnsqU87Al5n8LybTZHcDD
         vSFYTHwK5kNMRUcSvts5fuPzG2AUMWSuCMG52e8mGTwyYBDx1rAJi+kZhIu0AS20m4mW
         EHLfDzWt2InVuusPhroF1IGYYVVqy1VJrL4walMelIL/ih2NPNGT9u5/BNXIJFWDYwiH
         V6z0GrBuZYx+hHxo+7M84CzO9P9HEU79eMisNKW6ORHFm9Biu8v/RlbVgm+ODvHFINk+
         rN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OcVw8ovBCZVOoCHV49LU9UJr7n1pv24bvXfSbF9CliM=;
        b=R6Ly9P7sNuGOKVog3gevohWx3uqVayy0dhAU4k+BB7gtUeiH0HdpYgAj55+P7BqwJJ
         kuJscvtSvF8gn4oNqwpXmjOmFv7cLRmBR3wJQng8PHRNrP4dTED88/cok2yT78RAncCy
         YrFxscKbkn3RwbG4Y+3dt5p7D0lLPTnFKRNQ+J3N+k1QpOW8f4thvhLiRfX5oi53F+hN
         UkiI6DPHLXok015YehbO5Mq6P+ItLKYOvQZgxtL1Hw+Wv1Yv8U8jLqQYD42smk/P/oVX
         N1EZWb0xyj8S70ZIAhw46k42w7ZbpzpAsmD+qJnl2nIRvIaSVzgohvXbNiGDb1nW3iiK
         PyRA==
X-Gm-Message-State: AOAM532UP0XnoOS7X4SOlRvFQfow+ydt7Mwyjyml++QcPJ65V0rAZfId
        QEVGsaV92GI3aw/hPkWqBeDL/OsEzkObwQ6wP1Ze9Q==
X-Google-Smtp-Source: ABdhPJxHS51cV0uhO42k3Hh0LtZ1R7GCobDDAlublLaFoZOcD9wkHJnk8ZUeFVAgfhmgNRh0GzhaEgTs2Qw7kDxahQk=
X-Received: by 2002:a05:6512:131b:: with SMTP id x27mr807634lfu.210.1634153082922;
 Wed, 13 Oct 2021 12:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211001190040.48086-1-shakeelb@google.com> <20211001190040.48086-2-shakeelb@google.com>
 <20211013180122.GA1007@blackbody.suse.cz>
In-Reply-To: <20211013180122.GA1007@blackbody.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 13 Oct 2021 12:24:31 -0700
Message-ID: <CALvZod6dN5Ub-r9+evXYCaeNuzrDs1byPLY1DAyn=R7rqHoqKg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] memcg: unify memcg stat flushing
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:01 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrot=
e:
>
> Hello Shakeel.
>
> (Sorry for taking so long getting down to this.)
>
> On Fri, Oct 01, 2021 at 12:00:40PM -0700, Shakeel Butt <shakeelb@google.c=
om> wrote:
> > There is no need for that.  We just need one flusher and everyone else
> > can benefit.
>
> I imagine a cgroup with an intricate deep hiearchy with many updates and
> a separate (simpler) sibling/independent cgroup that would need to pay
> the costs of the first hierarchy updates [1] when it asks just for its
> own stats (bound by the amount that's leftover from the periodic
> updates).
>
> The stats files (or wb stats) are likely not that time sensitive and the
> reclaim (that can be local only but is slow path anyway) already uses
> the global flushing.
>
> I wonder whether the bigger benefit would be to retain the global
> stats_flush_threshold counter but flush only local subtree.

I did contemplate on this (i.e. a stat read paying the flushing price
for everyone else) but decided to keep as is based on:

1) The periodic async flush will keep the update tree small and will
keep infrequent readers cheap.
2) Keep things simple for now and come back if someone complains for
very frequent stats readers.

Shakeel
