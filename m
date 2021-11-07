Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB12447368
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 16:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbhKGPEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 10:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbhKGPEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 10:04:12 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D886C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 07:01:29 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id ay21so26631468uab.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 07:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=l2WEmU5M9+C+iG3hefjUJ2I4m4CKXLMKblM7x32oZY9op/BGEDfaXDbf7vH69ed3L0
         2vEyq14suJEirUUTc2J3FPyJs3K6rcHIcJFzpbbmh3vuefrodgPSyESUKxHVprMTW+76
         6T7Qu53dDP9TSPejHbPfNKDesVSAOY58ZTDL4BPsCMGlbM+YvPsFOIByGgfp2vmBZwcP
         7SuTF1nu83B8uHIVl63lL8k3DcCxYt9DhiN6tpSyk5Aw8RWlnlvIG885fvXj54W6AtIt
         sBLRWxf6fbucshMklflzxentYc+Er38ksE3WgO5PSJjm9nE6RT7D/bUCYe4EMqoVa1WT
         3+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=oAW0bKmzhxmhdBs+mwoLSeD1mU6CQh64qfSDXxTroq7x9tQhD4iAXnQU1IKNEUuRnW
         AYbEBU79g0Pqe4UXNkkGkEmusIXqdOUbtrX3iZ5uFfMs0sTUT4QGvh9VpDdiW/ZjaGS7
         3dE+KiyYYGLBELDtiUGz/GQwzUmW4Q/uCK2X96dZfcg+LopFKALKGshSXf42g5epFmFS
         pJAESDujgjt2OsA+EnhQ5EzBga/jUO92ma5HePwPAGy50l0AIdCxF53qxGLzNE/8Mncz
         KJC8aE7cdyAzGkTY0ftO7oQepdJfxVjPVogLR8tMXLDpbtDxw92nJfqTv3PZ4Icwmm6c
         owbg==
X-Gm-Message-State: AOAM532GxgHRdzeAT2F2xhbEm689Z86xLXTzyZ4TnRIACcoxRwTXsrVR
        WsFyskEpykB2xrQ+XbXrRvUTeF7p1zVSN2JKSMw=
X-Google-Smtp-Source: ABdhPJxHtuc4WtPFWl0v2+Z2/U2cOJKLKKDMkD+wWdEfCDnZOM4f2b4y+FfywrakDZ8tegIvigjoy4YBEzBSsuxdK0o=
X-Received: by 2002:a67:e896:: with SMTP id x22mr1057785vsn.0.1636297288484;
 Sun, 07 Nov 2021 07:01:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:cb08:0:0:0:0:0 with HTTP; Sun, 7 Nov 2021 07:01:27 -0800 (PST)
Reply-To: georgebrownlevi@outlook.com
From:   George Levi <georgebrownlevi@gmail.com>
Date:   Sun, 7 Nov 2021 15:01:27 +0000
Message-ID: <CAKjNCXA5Dh0t_O7fKLEWPB5RoAkqf0i-b8k2VHtjp-eHnRvRKg@mail.gmail.com>
Subject: DO YOU RECEIVED MY PREVIOUS EMAIL?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


