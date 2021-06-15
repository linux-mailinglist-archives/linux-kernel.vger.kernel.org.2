Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D423A790B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 10:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhFOId6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 04:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhFOId5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:33:57 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17166C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 01:31:52 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id s20-20020a4ae9940000b02902072d5df239so3330160ood.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 01:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3dO284bYJ6q91he9TN4i789n8aq0qfxCmY82ZOLDlVg=;
        b=KMlKS3TPRf7FVeE6WZLeaDDgqwwzU8pJ/NVr6ke+KAWx6Acl8LK1BQ0+/+Vy8oEnx3
         2EQvwJiUvB8kMtTLhAOI2zu3BG4qcJapo6qusCU1PA1JilSOiMbqJar7lSKW2uGMEyFf
         QvTx4MykLLCcReEPo1LC38Aq7hHnmuadibJpR+/fEiqyQSf6XDS8onP/3W3kIJjwy+77
         zVtRXuVxyx8XUEH806BY8/hHn/mH8T/7NgOAgfl2y9UoxQvNeyCOm+A77AZ3Tj0ZUZL9
         OAPSqsJ8WvFjZkeTUsXpMIm/b0VXuoJntbn7uFH89DbgYk7vDjIF4Dv7od1R23opqQnY
         stIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dO284bYJ6q91he9TN4i789n8aq0qfxCmY82ZOLDlVg=;
        b=gmOPztpLZfkdHS2VWBv1KNm0FQVsJwynB/3jXPXd3wGrNHMLH4PJijphXdI9UTm67V
         Kij1ab+prgHxEx54owZA5x2Lq4jKPBt7wPqsAcUEA79HuIHxv1SjFc5bRrW4fIEvcA7P
         uImodJiSTekR4BtXzJ/sjbqj5dmJWNlzWrC6FUkvV5yh9gEsnhOO23160/S37m7r1H83
         b/ige/RQzm4qY/MaA8pZo2hGJgx7dHCxYaQGB11FmV2bz1o555fHEqoEIECOkPPQanqk
         5D+LUp3iKudOh/ENcb3PtXvrE9Apx3hJ8FywzJCgpKgocpInGMM4/zijy1tZaLMseQvP
         2iAQ==
X-Gm-Message-State: AOAM530EpeW6b1UF/aAAfp/iTG7ITzcIeZEHM9pP4Gb116ZdkD1lu0kf
        QQ9MZs29L8BPM6cCBh44tpqyBjLDqwRj/wpAHWbOlMsiPZg=
X-Google-Smtp-Source: ABdhPJyFQ0sNTzS7oKpaJtT5gXMjgDAECGOGjzyIBXxeTavrnNhCRrxx+DiMKKnxLElDHHBuY/E1mUewQsgCcvTb09w=
X-Received: by 2002:a4a:ea2b:: with SMTP id y11mr16619979ood.77.1623745910578;
 Tue, 15 Jun 2021 01:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210614125100.17627-1-ogabbay@kernel.org> <20210614125100.17627-2-ogabbay@kernel.org>
 <0ad1aa7cc1504b759f997028c80a6bd6@AcuMS.aculab.com>
In-Reply-To: <0ad1aa7cc1504b759f997028c80a6bd6@AcuMS.aculab.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 15 Jun 2021 11:31:24 +0300
Message-ID: <CAFCwf10WzmED-c3ofsXxx309prcpo-wma_i+hcOdG3Ckg_a8DQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] habanalabs: zero complex structures using memset
To:     David Laight <David.Laight@aculab.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Koby Elbaz <kelbaz@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 11:27 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Oded Gabbay
> > Sent: 14 June 2021 13:51
> >
> > From: Koby Elbaz <kelbaz@habana.ai>
> >
> > fix the following sparse warnings:
> > 'warning: Using plain integer as NULL pointer'
> > 'warning: missing braces around initializer'
>
> Sparse is being over-enthusiastic.
>
> ...
> > diff --git a/drivers/misc/habanalabs/common/firmware_if.c
> > b/drivers/misc/habanalabs/common/firmware_if.c
> > index 14e70422af25..d5d0db7fd6ef 100644
> > --- a/drivers/misc/habanalabs/common/firmware_if.c
> > +++ b/drivers/misc/habanalabs/common/firmware_if.c
> > @@ -392,10 +392,11 @@ void hl_fw_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
> >
> >  int hl_fw_send_heartbeat(struct hl_device *hdev)
> >  {
> > -     struct cpucp_packet hb_pkt = {0};
> > +     struct cpucp_packet hb_pkt;
>
> Try just deleting the 0?
> I think modern compilers allow {}.

The problem is we sometimes run on less-than-modern compilers...
So I prefer this method (memset). No harm is done here in any case.
Oded
>
>         David
>
> >       u64 result;
> >       int rc;
> >
> > +     memset(&hb_pkt, 0, sizeof(hb_pkt));
> >       hb_pkt.ctl = cpu_to_le32(CPUCP_PACKET_TEST <<
> >                                       CPUCP_PKT_CTL_OPCODE_SHIFT);
> >       hb_pkt.value = cpu_to_le64(CPUCP_PACKET_FENCE_VAL);
> > --
> > 2.25.1
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
