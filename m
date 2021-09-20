Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7592B4117FE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbhITPUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbhITPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:20:14 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF4EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:18:47 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id r18so11374649qvy.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=QSp9JWX4XAHKXl7X56VeCQC0onvxbHHBBOV+a/7+PNE=;
        b=NmWN5Ueez/dX36oYFR1NPVKLoAbXR2em9qFrKqQ0Lh1347vdue+y16P/jDmz3v0VPg
         oXqsjEqq8Of/rC6sy/QT8itIz2VyMn+hrBpZMoWoFmwsdF+Da2p8UsRmSg2P2zlTtnGy
         AvxsoqG6/6QS0LE0Gla1UvTAu1H4sE2OJqe6cKnGjCWYuB0EyR7Dzn2n+ajCgu2ANf0Y
         sNZ3DUrUqEbL8I3wEhCrtURQw/Xx5BNdGk0L1MYmiIYtGzAWEPvKlHMo9z5iAdjhab+C
         fCTQv2sG95cnMUM/Mmo3GoalpTr8nI2GHQUPR22jWfWwDxD68mkpvS6QG2JLle7sgNms
         rETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=QSp9JWX4XAHKXl7X56VeCQC0onvxbHHBBOV+a/7+PNE=;
        b=e/88O66zNJ7pReqltQxQT5WA5r+joOaZOhmJid7eUp2pXQgNgGN+rnxKLxATQkgE/A
         YWPtr4K8uZ0BQTNVAoVtT36WVDPsWyeU4HEpZYQZKpRzfGHBNj6Dzn5DfppNe203ktf6
         5hyVUTdUExwt7SeB8EpFz3AoyQo7i2F4+0eZsA7F6A54uHS3dJ9RdMoVQHZ4izdXMaC2
         LpfMynhpTfwypLTfTyR3XShFgl8PwfexQ4pfIYTlYKMZrAs833zdy8ZMItrmeDObu/8A
         0zk/Yj8MmTplHlXt9puA8X1fu0xb6LDrZMfGqo5n9IXWuRE6mWeamy4RAV+TJcY0iWi7
         qjsw==
X-Gm-Message-State: AOAM533X9vCf6YjJAYj9k7hFgYVbE23ziFv5nJ+DrPb6iuSFofXoVcXh
        NObMdqtPfisrSwd+SebTv6i8uTOdIrzJjd/r7hA=
X-Google-Smtp-Source: ABdhPJwNTU9YU7pQWUvVI4iXjB5F2w6fKZfW7OlfNt1MiA7unpc84b687tgb1ao9Y9lEj1LGCTWwRPVPwToVHmM6TfY=
X-Received: by 2002:a05:6214:1474:: with SMTP id c20mr25426239qvy.14.1632151126802;
 Mon, 20 Sep 2021 08:18:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2788:0:0:0:0:0 with HTTP; Mon, 20 Sep 2021 08:18:45
 -0700 (PDT)
Reply-To: headoffcedirectorwu3@gmail.com
In-Reply-To: <CABzOjNfrmkbmXjKAtVxcTM+kuRog65DCxU2inaY1DtUDiG7zuw@mail.gmail.com>
References: <CABzOjNd=-k8StXAf9STGMYd0=B4zaprGKRtvNKbzVe7jMuXNUg@mail.gmail.com>
 <CABzOjNfrmkbmXjKAtVxcTM+kuRog65DCxU2inaY1DtUDiG7zuw@mail.gmail.com>
From:   "headoffcedirectorwu3@gmail.com" <jpaulesqqc@gmail.com>
Date:   Mon, 20 Sep 2021 15:18:45 +0000
Message-ID: <CABzOjNcx3km0QLnmrXVmXP18a6Mneagyz=3=B+4fVWzWE-8nhg@mail.gmail.com>
Subject: wu
To:     jpaulesqqc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Our office contact , 2554 Road Of Kpalime Face Pharmacy Bet, Gulf  Lome Togo

I m bank director bring notice for you that our IMF compensation you
sum of $850,000.00 because your email address was found in one of scam
victim list. Do you willing to get this fund or not?

Sincerely
Frank Joe
Bank Director
Whatsapp, +22870248258
