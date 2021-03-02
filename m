Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C0332A08E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576061AbhCBEXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:23:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240002AbhCBAhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 19:37:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27A2D6023B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 00:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614645425;
        bh=N2mwWtTHaQKdyNYa4nePUQtBQq2/4wIaRpydzOplecM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GyO83wb+CZWtC/zKyoU9sYvN34xex9VGsbS5834/UCAZ0+SCz2VmGfa3T694c/fhC
         4qXMQYiy4FsR0eC7Z9ur6vAASOhLVqXyK3sLL+sihpZxIqVbLR33z3Or+tFmZuATBR
         LNjANDno8v5IfisFVNvg85uH9NKGlKTqMd104rigFDlS/MnVmKZpLWIR5SG37kKBxI
         yraKsGACJnLWT5yE3yEy4VxO4265obDhSEPV1x1ropWl0PKxeyLEPUSekB+MdQWFVq
         hO9n1qr9pgvu9hyKsNByAObrsoDoEzUJEmAjuSCqm0Phcwnq4xDpZFjwE1LBVRm63v
         txWXeRltrVHwA==
Received: by mail-ed1-f49.google.com with SMTP id h10so23078142edl.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 16:37:05 -0800 (PST)
X-Gm-Message-State: AOAM533bKQQ5lfIDrwE2ymdzXX3THgYvy7yFH8RtpMzMzyNpipH4iq63
        LBHnQC2Sd7s1y7ViJ0QHX8EilbZa1BSaZYRcCg==
X-Google-Smtp-Source: ABdhPJzS++jETiKO7iSIvESeXqX+H1gC2cKMA2r/ShtQGoLjnFLIyBmHxQZVHF4cabJfuF4LOHpbeW8tbFn+v1dGYWM=
X-Received: by 2002:a50:fe17:: with SMTP id f23mr19217294edt.258.1614645423671;
 Mon, 01 Mar 2021 16:37:03 -0800 (PST)
MIME-Version: 1.0
References: <1614644074-12476-1-git-send-email-victor.erminpour@oracle.com>
In-Reply-To: <1614644074-12476-1-git-send-email-victor.erminpour@oracle.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 1 Mar 2021 18:36:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKbDzi6VFPVwpxqGG_RVuqwpWQsA820thZ6Z8ZqntL8Yw@mail.gmail.com>
Message-ID: <CAL_JsqKbDzi6VFPVwpxqGG_RVuqwpWQsA820thZ6Z8ZqntL8Yw@mail.gmail.com>
Subject: Re: [PATCH] c6x: Remove stale symlink 'scripts/dtc/include-prefixes/c6x'
To:     Victor Erminpour <victor.erminpour@oracle.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 6:14 PM Victor Erminpour
<victor.erminpour@oracle.com> wrote:
>
> Remove stale symlink 'scripts/dtc/include-prefixes/c6x'
>
> Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
> ---
>  scripts/dtc/include-prefixes/c6x | 1 -
>  1 file changed, 1 deletion(-)
>  delete mode 120000 scripts/dtc/include-prefixes/c6x

You are the 3rd fix. There's already one pending in linux-next I'll be
sending to Linus this week.

Rob
