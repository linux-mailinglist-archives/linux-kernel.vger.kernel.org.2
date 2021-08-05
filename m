Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0473E0F08
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 09:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbhHEHUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 03:20:01 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:39958
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238134AbhHEHUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 03:20:00 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 600F540645
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 07:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628147984;
        bh=dprqqFGKEqV7x72rJjapY3EuNeylEWr75863Ym1V8hE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=UaawYewZNmUGp42wwo3WI+hloRHvyzr7nQCx3BEF0Bg+i7F//zdTz0YqcHTBeCt4E
         WDN7y3zDb73kaGqYf8iPXJFZAgJf7LnIICQV4GfJL69ZCMkhueS+8qXIXdNSNaVXBd
         9kmEqgqV7Zpm5zXfQyhck9Bq7wD0ZC0Njrcg+FJOiHGj5i1DYg13pyBXmx0o+X64bt
         dc+zQY8lxM9XZpN3X9EWGq7sL9AGkjMExRQ11XLdi0PCUCykPhze+DdCRR10Vdm5EQ
         oj5/kbSIR9GPVO5ppPVJW34bvZjCa3L4CAcbINpPKAP0V/aIRXkXypeiM4yHsAgrmv
         KvlG7R4waPqTg==
Received: by mail-ej1-f72.google.com with SMTP id p25-20020a170906b219b02905a698022dbaso1486063ejz.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 00:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dprqqFGKEqV7x72rJjapY3EuNeylEWr75863Ym1V8hE=;
        b=gfGIuWGKBJ7xbSm/6eS/y9nSVn4XzBu/PJRC5WseTTIJwxT7oh3eseCg7xQup2ECNv
         f7wy6iXkBBcOuy2poz8PHhd38cr0XSrqhm4F4h6K9GA5lsjjLY4V7NcEx52+se5NSL1u
         7hAoJMWEMj3+BarEAqcMfDm0rUyY1gcmssR1L8Z5bvSlFnOJAzwDKi/hFFHtFiOTFuO8
         PONSC2rz8PcU6cBNfmkSSBd6yOhC+qt521zyKl/x1fv0d/P9vvTr0941qwKk8gyB2XMZ
         6o62YBG7GTfxZQV66FeFIzixWPIc2h0xpuyzDPQWXb15NpiLFl3HcND7BwKe0/Rn89a/
         yldg==
X-Gm-Message-State: AOAM533TUQXOl87M8QLJK+breAOsXPd8ZzVNU6pcqWgEmqU/RWej/zI1
        QEcK9ehxU/TcbRpCMP3fWzL2nZ3gN2MFyfmIjE2dDZyksWqIkp0hscEj+ZOjWt2Nbj5vJr/AZ2g
        EzFGAVQqaQo8RgW2e75aAlk55vJFPiaN+7H1/ag3gpeQHtBtFdjyijYToYA==
X-Received: by 2002:a17:906:79a:: with SMTP id l26mr3575778ejc.192.1628147983945;
        Thu, 05 Aug 2021 00:19:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVYx4H8kX3IITvR/G2XnEd7cg1AeN9XxMaCTLuh5W0I1dUh/MVFTganzFvEkf0oFXCWq00D8/9Ojo4LD8FkXQ=
X-Received: by 2002:a17:906:79a:: with SMTP id l26mr3575754ejc.192.1628147983672;
 Thu, 05 Aug 2021 00:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210514071452.25220-1-kai.heng.feng@canonical.com>
 <20210802030538.2023-1-hdanton@sina.com> <CAAd53p4NO3KJkn2Zp=hxQOtR8vynkJpcPmNtwv2R6z=zei056Q@mail.gmail.com>
 <20210803074722.2383-1-hdanton@sina.com> <CAAd53p6wi7pk6yFgTnG-JDd9e4zCn3F40bioYyGbAqYg5kMHZQ@mail.gmail.com>
 <20210805030024.2603-1-hdanton@sina.com> <CAAd53p439uW9D1rK07JUQFhVfs1FCvm_rECExp0JmzFHB7dGNg@mail.gmail.com>
 <20210805063536.2698-1-hdanton@sina.com>
In-Reply-To: <20210805063536.2698-1-hdanton@sina.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 5 Aug 2021 15:19:28 +0800
Message-ID: <CAAd53p6BXj_Yxq+8GvDW4eNvbXisz2WK9uf5rcLrCwkMiSB4-g@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Shutdown controller after workqueues are
 flushed or cancelled
To:     Hillf Danton <hdanton@sina.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluez <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[snipped]

> >How? Most of the time the BT controller can't be brought up again
> >after shutdown(), and we need to stop other activities before that.
> >What other reasoning is expected?
>
> See below.
> >
> >Kai-Heng
> >
> >>
> >> >time it's just "Bluetooth: hci0: HCI reset during shutdown failed" in
> >> >dmesg.
>
> In drivers/bluetooth/btusb.c, there are three cases of
>
>         bt_dev_err(hdev, "HCI reset during shutdown failed");
>
> and in btusb_shutdown_intel_new() it has nothing to do with kfree_skb()
> because of IS_ERR(skb).

No, kfree_skb() doesn't gets called in this case. But when that
happens the BT controller won't work anymore.

>
> Feel free to specify why an skb error links to the race you are trying to fix.

The race here is that the btusb_shutdown_intel_new() is trying to
reset the controller while other works like scanning or discovering
are still underway.
So the patch is to ensure that shutdown() callback is invoked after
other works are cancelled.

I think I understand what you are trying to ask, you want to know
where the double kfree_skb() race happens.
I didn't really investigate that because quiesce the other activities
then call shutdown() is the right thing to do and I haven't seen the
kernel splat since.

Kai-Heng

>
> >> >
> >> >Kai-Heng
> >>
> >>
> >> +++ x/net/bluetooth/hci_request.c
> >> @@ -257,8 +257,10 @@ int __hci_req_sync(struct hci_dev *hdev,
> >>                 break;
> >>         }
> >>
> >> -       kfree_skb(hdev->req_skb);
> >> -       hdev->req_skb = NULL;
> >> +       if (!err) {
> >> +               kfree_skb(hdev->req_skb);
> >> +               hdev->req_skb = NULL;
> >> +       }
> >>         hdev->req_status = hdev->req_result = 0;
> >>
> >>         bt_dev_dbg(hdev, "end: err %d", err);
