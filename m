Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0160532CE3E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 09:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbhCDIQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 03:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbhCDIQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:16:20 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5ADC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 00:15:40 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id q14so32236587ljp.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 00:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SJyZlyEHfVnR3j+KQtSDL4OnWvfrZW9Sy7fZt9eeLfo=;
        b=P8t+fHloRwyoIkI05NgYKdBCj+KdvhlHCPckJ8tCWVkZH2q2Hn4sfLlHhYgp7BnoeE
         eoFoUC6WWaVF5Uhle/DtZrldalw0YHLZbr/dsqY9ONnVILQTRJhIm7kJKQNxnLf7awcZ
         VmQRCa+UGKBxD81acuKo6BhSTroMA/vwyMVeDrOZm8bTjoUunxISbeT/rWjXcxl1drK2
         UFv1w96BtYmz4K3KbfXWmO4lsABr2MErnhBVS7tCE4kXU6S3iFWNjTi241Cs32nzI0+6
         9hnbpVuKoLqpwrZKCtQOzcXiifofVpgaQtcqR6RTfqCrMfSb/Mp/d0wX9ctq42TZXGK2
         qPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SJyZlyEHfVnR3j+KQtSDL4OnWvfrZW9Sy7fZt9eeLfo=;
        b=la06WvUKLk+hb5BlzxImZQciAAeV3i8l/G/Q6PNLLCJM296gb4FJjCyxy9vGAVYtsI
         IXEjoS//QtmaDfHKXLtwMZ0lhwoMwxUSky9CtXzU9C5aX2CIcet8Lr87C6g/tXOav3J9
         FyB1qMgwUBAzDSVITPtuBNoc8X/i1spSDFJFw/oPTPO10m9fN89AfGINNH/YzR4SiDZo
         TVqI9zT+BVTsstjTh23lqVufJ8eMjNWXmg2AS65RqjxFUrMg1D4jwNfISB1G21wfmYtE
         /k++6mzSszqbJc9vRv+0FZDo7hk6b2lDKbYUaEykTEOGd0KsBKgpqHEAMp6dypQYvLVv
         SavQ==
X-Gm-Message-State: AOAM531+TTmAczNgCyVedWflUa4SwB0kLiwKxGe1/Fo5Y2y1l6LNiRSe
        DsXm4tzsn9vFM2qlzKSdTr7sqnARiuR0B7EqyxOF9g==
X-Google-Smtp-Source: ABdhPJytRMXDzPZQu9LPmyCokZi4HFF5dQrsReDzAH3IBF+V58SrZ/BITOlZXALmZp0DjFGB3W+fMGqSsDPtpdNrgfY=
X-Received: by 2002:a2e:9004:: with SMTP id h4mr1678123ljg.326.1614845738903;
 Thu, 04 Mar 2021 00:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20210303203444.3140677-1-j.neuschaefer@gmx.net>
In-Reply-To: <20210303203444.3140677-1-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Mar 2021 09:15:28 +0100
Message-ID: <CACRpkdbG7LJ9jwdsdAxTad8LSKH_9BqcL0N+DMhg6Sxp6Mr=uQ@mail.gmail.com>
Subject: Re: [PATCH] docs: driver-api: gpio: consumer: Mark another line of
 code as such
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 9:35 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> Make it so that this #include line is rendered in monospace, like other
> code blocks.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
