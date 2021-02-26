Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8770132607C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhBZJtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhBZJtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:49:23 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C02C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:48:41 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id k13so13745319ejs.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xrw0bPY3dRaQun4EfVVXzqdCe+d3ceyGPlj8WbSMudQ=;
        b=VOH920EVdn3aZoa4vJKbkxtK5Iez9PqlzMZtdibal49Itgmmk42+G+NiS1ORASqdfq
         gEVKA807y68W3984LfXaoG9MIX/ZuFI7SXkKgh1wa6EQRoFznRhHW+cxbStGVIo3PwZ3
         oLEihxh8u2e1NsRcXw5eo73X6JvHVC8W7iJ6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xrw0bPY3dRaQun4EfVVXzqdCe+d3ceyGPlj8WbSMudQ=;
        b=LwNS3+DCkTO2lOB/S2T2ckDCxmESbXUjxmzFTvVl0g1ZFSE1EsZDoa5qjZllJ2fS2b
         O2LW+ouFn52IKWAuinYvEClr9LPba6BEcYME4ZIXMiDnCcqhTDp8183/egyZLtX/P7dR
         cYy9QXfs7D1C92G+8nqE4pnunoLYDWuia4hX1xStb3xqUVkmtgscuudUkmVY87vxYkP5
         P6tEubc23amj+wB7WBNeqf8Sl82/axxNkXMo1Ou0Uw47PMAnx9Njjc8t2Do7yCO8fHGY
         4PY0oByiiCN5vPCRXg1PRM5N9awrwE6HLvvw6uh/sALPdvx18Dk3EatyonkTqZpb95Bq
         fCPQ==
X-Gm-Message-State: AOAM5315P0yWiGLtlMpkrMZ786dAwdFxdeQUBeRMqwkZSq49SFDjpAZd
        6H2dq/agh7TVT3gACZZDYUnUsOUTEFHl871yoHig+A==
X-Google-Smtp-Source: ABdhPJxWuSz2iyDDTGjfGe4Jvdayc3bHShA++D78xtofe6tqHY74fUEFB0e7W1vxS4IaVgMnZ4FHVK2UHVhoYGv51Ck=
X-Received: by 2002:a17:906:3fc3:: with SMTP id k3mr2392671ejj.522.1614332920681;
 Fri, 26 Feb 2021 01:48:40 -0800 (PST)
MIME-Version: 1.0
References: <20210216060128.126938-1-axel.lin@ingics.com>
In-Reply-To: <20210216060128.126938-1-axel.lin@ingics.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 26 Feb 2021 15:18:29 +0530
Message-ID: <CAMty3ZBbCxYp75Jumu7XPW8snz3KbEg=4u_mwKR3XacDjv8F2g@mail.gmail.com>
Subject: Re: [PATCH] regulator: pf8x00: Use regulator_map_voltage_ascend for pf8x00_buck7_ops
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 11:31 AM Axel Lin <axel.lin@ingics.com> wrote:
>
> The voltages in pf8x00_sw7_voltages are in ascendant order, so use
> regulator_map_voltage_ascend.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
