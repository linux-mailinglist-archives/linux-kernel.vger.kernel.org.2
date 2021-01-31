Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B4A309ED6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhAaUZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhAaTcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:32:00 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A214AC0611BD
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:22:31 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m22so19825668lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NcpZ+zIFTh/+vz3FgyVcp4oMhtiQGE8wtz4bP+gP9JE=;
        b=WJ1gjfyXL9YRRBEf8/+jVE29cSlaY7PGBvbWaUPYLrM8DtvlCN8LOApXCdw4sX5JMq
         4d58rwMEfVkkmpLAB7wxu1BgGMhvddRpjN04hj8ZCyOdeM6XAkTziJp0dd8/HEB6lyT2
         4W63bb30rIjbJEyRw3stRFjNRCsW094Tiq05E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcpZ+zIFTh/+vz3FgyVcp4oMhtiQGE8wtz4bP+gP9JE=;
        b=L+DOp4KpVp+3+svDOPDa5olBI0+ZsT24kg1eHucbtsNxcm+KRKui+9vAM/biqFvspj
         VNZKcWQFfv1ccT/S+xbxGDhQs+QgHCIgfEbvb3UCdZmQGx9aY1IiyKZfsy3ISv5oHpYr
         UCw4krrZpyc2RaQbTY15UoMmzmA0x0qjcWKONgwVnc7rncinxaUqA/e2e952e89Yy4Gd
         WQ6KxWiWbruHRaTJeS/8jtbMYmh2w0pEcc329p95TxVjU83owzYNPvergUxNy8raAVhP
         2LhtjsoXTcrJC+/8sTIakxnC6D6l6sZtEHj/sF+TqU4fDfMzym36oStR42doip+w+ZTo
         lSfQ==
X-Gm-Message-State: AOAM532uTeMZvJm/qmOpVljZ6cYWLjyzzuKSIw5aC5LnjXuTJes2xYBT
        /NTspTUsA4yZ3Nq34YcNZI3VMeEikqMsDw==
X-Google-Smtp-Source: ABdhPJyvNURFDR2COzE09Q+bAOIx9mxwIroalP9pgZAkdnN8Dhm8wN0i+04x7snBe57S0raStuym7w==
X-Received: by 2002:ac2:5466:: with SMTP id e6mr1718655lfn.243.1612120949846;
        Sun, 31 Jan 2021 11:22:29 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id f21sm2166228ljc.86.2021.01.31.11.22.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 11:22:29 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id a25so16931136ljn.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:22:28 -0800 (PST)
X-Received: by 2002:a2e:8116:: with SMTP id d22mr7914619ljg.48.1612120948527;
 Sun, 31 Jan 2021 11:22:28 -0800 (PST)
MIME-Version: 1.0
References: <8eb145f609386c98be1ec6381424cf408804ac7d.camel@hammerspace.com>
In-Reply-To: <8eb145f609386c98be1ec6381424cf408804ac7d.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jan 2021 11:22:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjtGGxGYT6aVaGOxwSp2YtdVdOOQj2nUiPiQHhWTHmcwA@mail.gmail.com>
Message-ID: <CAHk-=wjtGGxGYT6aVaGOxwSp2YtdVdOOQj2nUiPiQHhWTHmcwA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client bugfixes for 5.11
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 8:59 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
>   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.11-3

Merged. However, it looks like you won't get a pr-tracker-bot reply
because I'm not seeing this email on lore.

So I'm doing these manual replies for now, it looks like the mailing
list is not doing great.

         Linus
