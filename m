Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D48845E864
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 08:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359191AbhKZHV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 02:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbhKZHT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 02:19:56 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343B6C0613E0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:16:44 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z5so35029713edd.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tszJl3nRrOBevJxO8tAz11+YJXfp2nVs65aqfAK7OeE=;
        b=ItPWoq8OOtt+ENwFjKXv6Iku99UMURX/FYI1SFTacqs2+qJFsbGKH0vsirTSwKeihA
         CGNdCPG7ZXoWPXT7VxgRV2IrjwYSB0/02/k+p/vunK7KRsy2OCgKdV5ja1LVKOTG8Dwm
         U2lVS65Uw8QfC1Zf1TLc2Pr5kN3qfER/WsJXq9iljPLBqY/FNPhhYIPXRl0j5q8pZUn8
         220vE19DkXjLXqTjIJj2Nd1m6WTvh3prxskaR/1QdHgpppgvtpOuU3TDyw+VDWO6dH/6
         U6+bQ7XlO2Cb8qyi0nRw8BXbUrBxLI8QyiIymMwXawKBQOSONFNSeXJNq3qpK8ZH2nVo
         +MpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tszJl3nRrOBevJxO8tAz11+YJXfp2nVs65aqfAK7OeE=;
        b=DHiA+R36fjIk9081BwLGkpweBUV7MujF8WdQqcGcjijbGVdGRiHRXpCBBJSSdnF9Hm
         TUmNDCGYki5938SLAYYy+NJufl+BhGBJZ7FwGvjBSdsrcnRpLcjaTj4btN17KwJm+8H7
         kd3UceES5kPYySHeU5FFO529W91v52mgQ23pt3btKOVlDeI8xXD8B6xdr6JONiHM9Dd4
         XnlbImW7XG/4AWyhNi5gTcHUJ5h6nG8MDSjdygRU6lVthk2mtDk57+UFXoNR+K9Z8yFo
         wAziivBXBh7wQabMGJql7Jrpgl5KutnxtSzGyZE42JVknR74Wyct7CeOHOuXbqmxP8HY
         hF+A==
X-Gm-Message-State: AOAM533Gx2jajKJ+inynn+SQEny6gNurKAJ9aX9wcE2QrUs1xgQQz9aq
        tWp2CWdVvAKA8Lqf3XiULnBT9vjogcobTBgloLQPZg==
X-Google-Smtp-Source: ABdhPJxr+mgQO/tGGWGLCgVfXM57lHwgCuStOtBvO+BkRLqSdhcZQgx/wmlYjWPThHxA/Amw5eONTAX4fSbMtwP8eVQ=
X-Received: by 2002:a05:6402:147:: with SMTP id s7mr45728798edu.8.1637911002824;
 Thu, 25 Nov 2021 23:16:42 -0800 (PST)
MIME-Version: 1.0
References: <7df04f45-8746-e666-1a9d-a998f1ab1f91@gmail.com>
In-Reply-To: <7df04f45-8746-e666-1a9d-a998f1ab1f91@gmail.com>
From:   Joel Colledge <joel.colledge@linbit.com>
Date:   Fri, 26 Nov 2021 08:16:32 +0100
Message-ID: <CAGNP_+WRohG5BMPvJUM1gAm8gOk=b1jn0_+TMr3FyqxnP+_EmA@mail.gmail.com>
Subject: Re: [PATCH v2] docs: admin-guide/blockdev: Remove digraph of node-states
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Joel, are you OK with this change going through the -doc tree?

Yes. This has my ack. Thanks!

Joel
