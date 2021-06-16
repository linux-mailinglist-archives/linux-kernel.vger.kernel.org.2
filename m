Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EF43AA6A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhFPWj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbhFPWjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:39:25 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE68C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 15:37:18 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id ct13so419994qvb.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OK2NDMUzBsybXO4abJIrrZW9kNkcEezA9igAWLIEj3k=;
        b=0YW83Biv8EfJMk1CmToxoRpyrvWTV0z9t5uIHY43PimJt05LJANkhR+ttNPHn9Nc59
         YNMxdCGtc7DjTnByxJaQ0ejK3AAaYqiU3miUsUlDBLi8MRCPnAF+Lr07LYbukcZ6frY1
         PejpQVJgJJVxexr978Ckvr0kcrVS7QGaczej1vXeSV/UsuJEYw8Zu6TVsd2Sza4R7xGk
         dut1sI659OUSzC6eLKkn1CQESTdEU1bJOmq/3dIVhmsYMmVj+a2NnG6RarBkt9NBmf1W
         ftlY/vzGaVAT4r/viu38wCjwIK7BHnCCzUPx5UQwXbW/1ipo1KrEWUd5rfI+gZFjEoC+
         RC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OK2NDMUzBsybXO4abJIrrZW9kNkcEezA9igAWLIEj3k=;
        b=TdPK1bs7WNqvCASmCwc3ROvLOY8aRoISKkJ+RdrXFzlMRNYAtVMtxSba3A4/SPHKD5
         iIRKvC7eWGqAfx5xCj02kw/4fZs028gTXApzC08lq59xf9Oh3vRmnK5lmdPe/oIXsiPz
         6jebLgJKxRLHjq8gag0fqJiUSNBueo48KOCd2Kt/C13rsvsEtXwRmStlMBJY2fJPGbV9
         u3swHfmSFmz41Ma8Kkzq4pf6GiR3io19mY864Bb5fSUxA57djUvF5+8PjNIAW2EuVQji
         o8Pk8d1kxM6n/duhHWDS8hlRQxeT3jSKGCxuFQ/09Lp3lSddUwaPZIfoF7FyI3GR1mda
         ZR+g==
X-Gm-Message-State: AOAM533GETin9w7MDaF0Ve1c9Ap+Vv/0oVf5zYxooAsB0HYH2bL/5cIg
        LAVIMkAce9PNPfsVsVRFt6ryDnczME/ozqXAOeCpYw==
X-Google-Smtp-Source: ABdhPJx+qFmAYrTPRdIpQ0Q8tn0d7xHPEVOkGjexZxoJmZT1a1kqDZP9B1EY+o8PriLjuk3+OACcoLrsal8LqkIAlYw=
X-Received: by 2002:ad4:5be4:: with SMTP id k4mr2384072qvc.24.1623883037311;
 Wed, 16 Jun 2021 15:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210616190759.2832033-1-mw@semihalf.com> <20210616190759.2832033-6-mw@semihalf.com>
 <YMpWJ79VF7HmjumQ@lunn.ch>
In-Reply-To: <YMpWJ79VF7HmjumQ@lunn.ch>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 17 Jun 2021 00:37:06 +0200
Message-ID: <CAPv3WKfwe9sm5mQCEo4tAubLDTUCeeeLeuB2FQaoWA8qyz+CqQ@mail.gmail.com>
Subject: Re: [net-next: PATCH v2 5/7] net: mvmdio: add ACPI support
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>, upstream@semihalf.com,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Jon Nettleton <jon@solid-run.com>,
        Tomasz Nowicki <tn@semihalf.com>, rjw@rjwysocki.net,
        lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 16 cze 2021 o 21:51 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> On Wed, Jun 16, 2021 at 09:07:57PM +0200, Marcin Wojtas wrote:
> > This patch introducing ACPI support for the mvmdio driver by adding
> > acpi_match_table with two entries:
> >
> > * "MRVL0100" for the SMI operation
> > * "MRVL0101" for the XSMI mode
> >
> > Also clk enabling is skipped, because the tables do not contain
> > such data and clock maintenance relies on the firmware.
>
> This last part seems to be no longer true.
>

Well, it is still relies on firmware (no clocks are passed via ACPI),
but skipping this enablement is hidden in the internals of
devm_clk_bulk_get_optional() and clk_bulk_prepare_enable().

Best regards,
Marcin
