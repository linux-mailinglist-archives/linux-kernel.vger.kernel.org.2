Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262F33E0CDF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 05:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbhHEDpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 23:45:22 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:58634
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238552AbhHEDpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 23:45:21 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 0E4173F09E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 03:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628135107;
        bh=APPuhfsQfqQEMobjGYPZbM2beq7YPUNg/7gJvMYzqEQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=k8FkWpuWU6RVUROcm4UJeUpMEfhfTleKouatsYloqzfDTd74Pcmhrn5ZSlqM37nn2
         2Z8CgQL/uM4cAGcuNyF30ImOg1UvllPEYgdVpDfKgm5cYohPFCsBtmau+PkbrLmtTh
         eXkq514pru53dFZp7+z6gPVeizJVT93TS0QY0C1IVn4yq5nhPsJjOxOTmY33aAUGxz
         sKSbWAeJ8Petu1M2Bd9AJOZ8ifFxmecpH8SZYtzu8MkaJJEh1He+qa7jaRNAVrBtIJ
         dhPzEqi1B5C4cmutra0f/BSoNL2uEAdTsURUVpqhG9V2UaVWXzGrPxIruvoVLk/UCD
         ld856R9E++8lA==
Received: by mail-ed1-f71.google.com with SMTP id l3-20020aa7c3030000b02903bccf1897f9so2465289edq.19
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 20:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APPuhfsQfqQEMobjGYPZbM2beq7YPUNg/7gJvMYzqEQ=;
        b=nkH2oMqVCk+aBrqPCdInLHzUIiDCQ4hrYR//eS1KN/daU0Mus16B75ZrIBars3DKKg
         PHeZXQes+iYZYK8Ic7Slk9GvzdYHhKaiTYnrOhcHfq4BRR4+PIENvR+OAQ58qRuIJeG+
         03S9NAc1WA3jVX6Dpdrjml1CxTTy9i7rO705KUKPr8z3wzDIzoOyO7aH8LcLlSGUPkhP
         mmOhvDPq6tCZ6rPHTEV9j61RJZUB0tG2IfqzB5ysyvFsUL1FHToz8wbVQ3vOivadFn41
         HUoLFnWN/6lyssT+vBvLQeTEr708GLc8xhtjmLvZ2F+m85XEC3o/dTWbOI9z3n26ASy1
         mYLw==
X-Gm-Message-State: AOAM531UR0VpVV99kpD4+OJOUpddQhAUSFkh8bBfQByGwuSPibvjPcCv
        8ybEsYywHQp2D+6bOT7yiEoJz9sjkDOuwMnLqkmFuQ1WIlWYVndERIAl8VrcIdIfs3eWOLjCvwR
        tM/FZtnKMWPPqLoKl7zEa2a/uNWtUc3qpCZDbfReMhgvAtcOViQlUuNcytA==
X-Received: by 2002:a17:906:4e52:: with SMTP id g18mr2646044ejw.432.1628135106722;
        Wed, 04 Aug 2021 20:45:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJs7u574RmyzXvUoIjt5iNmjnIw4M3B7uVx7H1vvmyilGjodSKKXJCaZP1PbcOo+n1gu13DGiBpmXYHSHP1GI=
X-Received: by 2002:a17:906:4e52:: with SMTP id g18mr2646023ejw.432.1628135106429;
 Wed, 04 Aug 2021 20:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210514071452.25220-1-kai.heng.feng@canonical.com>
 <20210802030538.2023-1-hdanton@sina.com> <CAAd53p4NO3KJkn2Zp=hxQOtR8vynkJpcPmNtwv2R6z=zei056Q@mail.gmail.com>
 <20210803074722.2383-1-hdanton@sina.com> <CAAd53p6wi7pk6yFgTnG-JDd9e4zCn3F40bioYyGbAqYg5kMHZQ@mail.gmail.com>
 <20210805030024.2603-1-hdanton@sina.com>
In-Reply-To: <20210805030024.2603-1-hdanton@sina.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 5 Aug 2021 11:44:50 +0800
Message-ID: <CAAd53p439uW9D1rK07JUQFhVfs1FCvm_rECExp0JmzFHB7dGNg@mail.gmail.com>
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

On Thu, Aug 5, 2021 at 11:00 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Wed, 4 Aug 2021 22:35:43 +0800 Kai-Heng Feng wrote:
> >On Tue, Aug 3, 2021 at 3:47 PM Hillf Danton <hdanton@sina.com> wrote:
> >>
> >> On Tue, 3 Aug 2021 14:45:07 +0800 Kai-Heng Feng wrote:
> >> >On Mon, Aug 2, 2021 at 11:05 AM Hillf Danton <hdanton@sina.com> wrote:
> >> >>
> >> >> Given the skb_get in hci_req_sync_complete makes it safe to free skb on
> >> >> driver side, I doubt this patch is the correct fix as it is.
> >> >
> >> >Some workqueues are still active.
> >> >The shutdown() should be called at least after hci_request_cancel_all().
> >>
> >> What is muddy then is how active workqueues prevent skb_get from protecting
> >> kfree_skb. Can you spot what workqueue it is?
> >
> >I managed to reproduce the issue with another kernel splat:
> >------------[ cut here ]------------
> >kernel BUG at mm/slub.c:321!
> >invalid opcode: 0000 [#1] SMP NOPTI
> >CPU: 2 PID: 2208 Comm: kworker/u9:3 Not tainted 5.14.0-rc4+ #16
> >Hardware name: HP HP ProBook 650 G8 Notebook PC/87ED, BIOS T74 Ver.
> >01.03.04 01/07/2021
> >Workqueue: hci0 discov_update [bluetooth]
> >RIP: 0010:__slab_free+0x20c/0x3a0
> >Code: 00 44 0f b6 54 24 1a 8b 74 24 14 44 0f b6 4c 24 1b 44 8b 44 24
> >1c 48 89 44 24 08 48 8b 54 24 20 48 8b 7c 24 28 e9 ad fe ff ff <0f> 0b
> >49 3b 54 24 28 0f 85 6b ff ff ff 49 89 5c 24 20 49 89 4c 24
> >RSP: 0018:ffffaa0e4164fc50 EFLAGS: 00010246
> >RAX: ffff9cc9a217e668 RBX: ffff9cc9a217e600 RCX: ffff9cc9a217e600
> >RDX: 000000008010000e RSI: ffffd09044885f80 RDI: ffff9cc980e96500
> >RBP: ffffaa0e4164fd00 R08: 0000000000000001 R09: ffffffff885b3a4e
> >R10: ffff9cc999aab800 R11: ffff9cc9a217e600 R12: ffffd09044885f80
> >R13: ffff9cc9a217e600 R14: ffff9cc980e96500 R15: ffff9cc9a217e600
> >FS:  0000000000000000(0000) GS:ffff9cca2b900000(0000) knlGS:0000000000000000
> >CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >CR2: 00007ffe164d5b98 CR3: 000000013f410002 CR4: 0000000000770ee0
> >PKRU: 55555554
> >Call Trace:
> > ? psi_task_switch+0xc3/0x1e0
> > ? __switch_to_asm+0x36/0x70
> > ? skb_free_head+0x67/0x80
> > kmem_cache_free+0x370/0x3d0
> > ? kfree_skbmem+0x4e/0x90
> > kfree_skbmem+0x4e/0x90
> > kfree_skb+0x47/0xb0
> > __hci_req_sync+0x134/0x2a0 [bluetooth]
> > ? wait_woken+0x70/0x70
> > discov_update+0x2ae/0x310 [bluetooth]
> > process_one_work+0x21d/0x3c0
> > worker_thread+0x53/0x420
> > ? process_one_work+0x3c0/0x3c0
> > kthread+0x127/0x150
> > ? set_kthread_struct+0x50/0x50
> > ret_from_fork+0x1f/0x30
>
> [...]
>
> >
> >So hci_request_cancel_all() -> cancel_work_sync(&hdev->discov_update)
> >and can prevent the race from happening.
>
> Given
>
> __hci_req_sync
>   err = hci_req_run_skb(&req, hci_req_sync_complete);
>   kfree_skb(hdev->req_skb);
>
> hci_req_sync_complete
>   if (skb)
>         hdev->req_skb = skb_get(skb);
>
> once more skb_get makes the above race hard to understand, though it should
> better check error before freeing skb there to avoid blind free.
>
> >
> >And the kernel splat is just one symptom of the issue, most of the
>
> It fails to support your reasoning so far.

How? Most of the time the BT controller can't be brought up again
after shutdown(), and we need to stop other activities before that.
What other reasoning is expected?

Kai-Heng

>
> >time it's just "Bluetooth: hci0: HCI reset during shutdown failed" in
> >dmesg.
> >
> >Kai-Heng
>
>
> +++ x/net/bluetooth/hci_request.c
> @@ -257,8 +257,10 @@ int __hci_req_sync(struct hci_dev *hdev,
>                 break;
>         }
>
> -       kfree_skb(hdev->req_skb);
> -       hdev->req_skb = NULL;
> +       if (!err) {
> +               kfree_skb(hdev->req_skb);
> +               hdev->req_skb = NULL;
> +       }
>         hdev->req_status = hdev->req_result = 0;
>
>         bt_dev_dbg(hdev, "end: err %d", err);
