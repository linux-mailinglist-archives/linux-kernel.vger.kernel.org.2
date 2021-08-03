Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BBB3DE6D0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 08:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhHCGmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 02:42:36 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:44948
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233902AbhHCGmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 02:42:35 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id A8B953F070
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 06:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627972943;
        bh=WOGxtwx6AEh5sPp4Uy0fChJ5+55ettnCggYD7WCOhLY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dCrDiUW38KjRV+u1obvcGLqtUCZ1p5Rvr1qGJnZy/QLzxr2I9S7pdEELeJ4EG9pR9
         9AI/pliFBbJwqXHcQ3UbnyhatuQzvm8IvC9EaBk/3Ro0w+m1gvz8XoPG4QaiXd3u4a
         JYQgyJL/25NoPWFUVqbuVpWOfcVRmtp/v+ZgPLa22FmfgxSDGoPo0e2T0QWNNGq+QO
         prrOEXFFAQqLW/VRBCOOYvhHvakrm+RbCg2MfC+snQ/kBwcaWK5WDkDHATfoYrDcad
         uMQcer6Fz8z+zhT1kDRJdPvWdbbyU36FFthVsUjbye6bRhWgvEdsJ9CuEpO8uQIY6b
         GX/YUuHejTuDg==
Received: by mail-ed1-f71.google.com with SMTP id p2-20020a50c9420000b02903a12bbba1ebso9927066edh.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 23:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOGxtwx6AEh5sPp4Uy0fChJ5+55ettnCggYD7WCOhLY=;
        b=Ek38XCeFwCk5ngkKOFqq2hXIAXleJlB/V/Hrgrbuu8NHKmdkrdY84qYnccvzMMZ+0v
         07aKvQAiZx+tMTp3NsoixuuUciTi2Zl/+sA9ARuXQ5exjfEGr6xODu5eLu3ypR7vy2Ke
         tKVxqgrfRdbRyrlJDHSuoL8461odke8ZhNoIkr5JQjrDByIC/ZEOC8dIV95CC0b83N7f
         fTpS2E3shDLg9FpmJJEvfiFtbcu6DeHwmtQ33t4u5ZUSbUzjCE/333QI9twMV5VP0Moy
         ZQYQnWU0wsM5wRbtdVaVCLEWOL9kP7+gVDzD4DPn8x7Ks4unBnvjMhS2InFiLLavHypP
         M63Q==
X-Gm-Message-State: AOAM533Zo/nymtjGFkwAM56rowJiuGQy7iauWjMdidkKZqTCXKd0SYn0
        sCYLUjX7jsAMT9FI/fb+13BoHpJt+VPMlDHj0gKrriPjT17dpIUwoxsUlfqGj1nCfhpGwp4QdYz
        /TQDJcn5J/q/Gn9nfxA0k8kO8QCh/Pf+RVFcztNKadU0ns1+0hJSR4bsxdg==
X-Received: by 2002:a17:906:4e52:: with SMTP id g18mr19461993ejw.432.1627972943362;
        Mon, 02 Aug 2021 23:42:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4elE987Jh4ibN4W1ZpLtyp77e6TnKGcx0FC8iRxdRfFA+YYC0MIZAsiDuO4B3H+DuiodPtyWa4x9NjD6Ax9g=
X-Received: by 2002:a17:906:4e52:: with SMTP id g18mr19461964ejw.432.1627972943071;
 Mon, 02 Aug 2021 23:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210514071452.25220-1-kai.heng.feng@canonical.com>
 <576B26FD-81F8-4632-82F6-57C4A7C096C4@holtmann.org> <8735ryk0o7.fsf@baylibre.com>
 <CAAd53p7Zc3Zk21rwj_x1BLgf8tWRxaKBmXARkM6d7Kpkb+fDZA@mail.gmail.com> <87y29o58su.fsf@baylibre.com>
In-Reply-To: <87y29o58su.fsf@baylibre.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 3 Aug 2021 14:42:07 +0800
Message-ID: <CAAd53p4Ss1Z-7CB4g=_xZYxo1xDz6ih6GHUuMcgncy+yNAfU4w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Shutdown controller after workqueues are
 flushed or cancelled
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mattijs,

On Fri, Jul 30, 2021 at 7:40 PM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Kai-Heng,

[snipped]

> Thank you for your help. Sorry I did not post the logs previously.
>
> dmesg: https://pastebin.com/tpWDNyQr
> ftrace on btmtksdio: https://pastebin.com/jmhvmwUw

Seems like btmtksdio needs shudown() to be called before flush().
Since the order was there for a very long time, changing the calling
order indeed can break what driver expects.
Can you please test the following patch:
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2560ed2f144d..a61e610a400c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1785,6 +1785,14 @@ int hci_dev_do_close(struct hci_dev *hdev)
        aosp_do_close(hdev);
        msft_do_close(hdev);

+       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
+           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+           test_bit(HCI_UP, &hdev->flags)) {
+               /* Execute vendor specific shutdown routine */
+               if (hdev->shutdown)
+                       hdev->shutdown(hdev);
+       }
+
        if (hdev->flush)
                hdev->flush(hdev);

@@ -1798,14 +1806,6 @@ int hci_dev_do_close(struct hci_dev *hdev)
                clear_bit(HCI_INIT, &hdev->flags);
        }

-       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
-           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
-           test_bit(HCI_UP, &hdev->flags)) {
-               /* Execute vendor specific shutdown routine */
-               if (hdev->shutdown)
-                       hdev->shutdown(hdev);
-       }
-
        /* flush cmd  work */
        flush_work(&hdev->cmd_work);

Kai-Heng

>
> Mattijs
> >
> > Kai-Heng
> >
> >>
> >> Thanks,
> >> Mattijs Korpershoek
> >>
> >>
> >> >
> >> > Regards
> >> >
> >> > Marcel
