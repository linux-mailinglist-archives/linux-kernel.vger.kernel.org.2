Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BCA31BA91
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 14:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhBONve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 08:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhBONuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 08:50:37 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FD1C0617A9;
        Mon, 15 Feb 2021 05:49:04 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id n195so7190520ybg.9;
        Mon, 15 Feb 2021 05:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tewnbC3dv6CLWZYjCSkkFhNn2HY0qxkNK1L1Y+ZOeD0=;
        b=tIzDAZU9UeVDxFTm4le/n+URb36ilkklhBC998RO0hMSmydCFG+4y9MTpTR9sPYtSQ
         gxRmsV3eI59y9mvXXqdlqsbmnh63LhY6CauIHhvEXgLk5rln6RixH6qUj2QpjO3EOfpH
         j5FvsE3ViS+KCz9oMOd8EG0rEILrfmeKZ9crIgVuBP2JM6iogAvEa1tp+vvyvxTRBmTc
         EDJZJSMiCCjuqnhm73LkbZSESiujmIVlSR8YuhnCSVRFdzACe7t7buZlGEKedIpEy8gw
         GeVm6ov0IxLxEbuQzL+HDi4WsY4700oELqqt+jcDaedhhgWrTCUh0cK3qbW+EFiKMN6h
         nnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tewnbC3dv6CLWZYjCSkkFhNn2HY0qxkNK1L1Y+ZOeD0=;
        b=XsYEoxnapirCDJ1X+/caTJ0P55lCSrX3jmVuEIC+s0GRu/6J9HK5wY8sXtyAUzGqMm
         GdZwh73U7W0Y0xHZqNfcMtV/MA3yVyK09uG+DIIm8hwWkSWOVQ5mXEAjj3opSD0pFeUF
         AjcjdmkOEgu31HyC1B9rp31U7favpsy6Ce2Bm4E8qQePrA6cNpFWPos794oVXuLUHQ7j
         q+mwMUsTzlgEL4WnbNrOyClX3/KeEG1zWmrkyll5rOknnN+dcHz+9mS+meIOLET0eoAT
         KMoLmpiZ9ntF1rfMbWbMdN+C5FZ2bda9p+uO2XlJS8vwrPueNc+bkCf5Y0F7RgtwU8P+
         gbEg==
X-Gm-Message-State: AOAM533kUTpR5sXYwtARa74TVHxSDamsvxqwcqA5h8poj0v4sVIaFIKu
        o/fL1QMT/8n+NZTnbc/X8BYHN3v0WiLee5wsTkE=
X-Google-Smtp-Source: ABdhPJxPuCXbU0xstxqJygYEAbJLELkRR0aQN6MuauSkVr/df+et4nCg6VQhLtDAytbrsiIprzi+nudZ7ZNzTrUNbzg=
X-Received: by 2002:a25:af50:: with SMTP id c16mr22768507ybj.10.1613396943879;
 Mon, 15 Feb 2021 05:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20210215093740.20080-1-zajec5@gmail.com>
In-Reply-To: <20210215093740.20080-1-zajec5@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Mon, 15 Feb 2021 14:48:52 +0100
Message-ID: <CACna6rx5ijZ-zO9Mt0yVWJBCd0XG1d5-zU1y-=7BzrFsQ_=Hzw@mail.gmail.com>
Subject: Re: [PATCH] mtd: parsers: add MTD_OF_PARTS_BCM4908 config option
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Feb 2021 at 10:37, Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> wr=
ote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> Right now ofpart parser gets always compiled with the BCM4908 support.
> It's not a big issue at this point as BCM4908 partitioning support comes
> at close-to-zero cost. It may differ for possible further ofpart quirks
> though.
>
> Make BCM4908 support selectable to set a clean pattern for adding further
> quirks.

Patch to be dropped.

I'll rework original patch, hopefully without breaking anything this time.
