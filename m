Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268043ED30E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbhHPL3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbhHPL26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:28:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9701DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:28:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id by4so25985392edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=frFulgLh8rs3n0J3DmwciDfQ4Vmsy89SKZsGl9E35RM=;
        b=NQqxnoPqnJnxf+MEqHQm0Vcs7rt0DudebdKPaGsN1OJF3E2bOvBbJ9cgYGDiCwrOLb
         hElKdpRmbFZgofwXM/W+sUEtE2TFOpqWm94oTqq8g3Y0B0n8oYMF8KydOzGrSTj+8Pcd
         JBWp+COKyY5SVBfy/8K+yC1mG2tFPUX1lsqldZilDnW6QZySopZ6ld4eyy/Oxr6f1jmv
         X2CUbMRsLi2Yzmjh/8mZ5g/bWAv2nTEIr50gfXrEfsllFDNnA+hCZv/IPndJvRmDz9Bz
         Q3LI2jPMEGY8Lr3tV+z4BsbLJ54my82eMDXUQBrJYR8IouRIbp1+DzklwoLI5QbWb/7S
         Ip3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=frFulgLh8rs3n0J3DmwciDfQ4Vmsy89SKZsGl9E35RM=;
        b=g5wXMGK6TdUgVjFy+XowPG/8BCGuil0uPEWISEFdsrVwCOVNrtvdWIG6Mtl5mdjXFC
         GqH/AyEhPmYsb5kiK2AP9k4QaBaFoXMesiaxV3GMLWHiKytyH8pQZm+0j/K5JlYO+CV/
         90NNy/otKUvI2w1LbIq/lllbjEMxxeR6WNIIDOQuBJ5D9+xK69rfNp4HmZSh1JOzknD1
         /EgjT11p97y9QsYpf512jYrGWKh0+guhPIRjHeEGG4o1I36ECzwkd+hFDT4zzk/LQVXK
         mP7lBJsLeBZ20qbBzK2SdJxCk+2hjJW7CxbJ+XaUxdlUmkinSSqEUjVft86SpxZBFkq0
         VcwA==
X-Gm-Message-State: AOAM532KJkxN3DNSThjzIV6IblhnIVuHfQc+QZ63QIDFo0saJQEnObrL
        kKxqUsle8iAS13NiUmH+5uycG885styyRzbeNewPeQ==
X-Google-Smtp-Source: ABdhPJzTTeq6qweOVKAxI4IwnkAW57gR+BovitOdMJSAlb6ilaSeDPPT3/kBHn6i87QOHoIirJrZ6H3tBX+I9fKYrFs=
X-Received: by 2002:a05:6402:152:: with SMTP id s18mr19359572edu.221.1629113303070;
 Mon, 16 Aug 2021 04:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+3zgmsDd1NhJ0thX68zLxEyLuv+uSyp2LbvGymdV7nWFc2npg@mail.gmail.com>
In-Reply-To: <CA+3zgmsDd1NhJ0thX68zLxEyLuv+uSyp2LbvGymdV7nWFc2npg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 16 Aug 2021 16:58:11 +0530
Message-ID: <CA+G9fYsnhkV5LvacYtqjgF4iFR8MSAnrz-oDSytK=oj=Gz3T8w@mail.gmail.com>
Subject: Re: Re: [PATCH 5.10 00/19] 5.10.59-rc1 review
To:     Tim Lewis <elatllat@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Sun, 15 Aug 2021 at 08:41, Tim Lewis <elatllat@gmail.com> wrote:
>
> Is there a reason for skipping the selftests/netfilter tests?
>
> eg;
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.57-155-ged2493daa915/testrun/5442487/suite/kselftest-net/test/netfilter:nft_trans_stress.sh/details/
>
> I have not double checked (n=1) but it looks like this patch is the
> first for that test to hang on for 13 hours. The state just before I
> killed the test;

I have seen a set of test cases hang so I have skipped them.

x86_64 is using NFS root file system the net and netfilter tests performing
network interfaces up and down causing network failure and system hang.

The reasons for failure are listed in this document.
https://github.com/Linaro/test-definitions/blob/master/automated/linux/kselftest/skipfile-lkft.yaml

- Naresh
