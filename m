Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A62E3D39B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbhGWLCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbhGWLCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:02:36 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267EBC061757
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 04:43:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id y8so1996472wrt.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 04:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7joHR173kmsc59rBBr/ksencMbsFUjxYr35XX72uJ4=;
        b=XmDE1aZ04m4QoePKjKFJawONG0A6JuZs/DgUv0j28eTcPurXk++wwQGYzEZtls3jVu
         Xod3TmM4Fyls9kKhlk6XdWUSypFAzgBgg53DWjxhbDuzlNzNbLaL/qWoEz2a3xN9zQtC
         LYDGKY3310RxmO1CvWKcsrhQg6MpdlcKQnTfaQ74r90KDBW9EmVe/8F4Gm0Am/mxZtyp
         k8mlnAlOj4P05/yVIgxsTB24IaKfoVnyuXPxBchHaocjjsw8DI/hVXEPjDWuhCHrPGK/
         ondyvi4a2R55a3uFACQydfM/HxZY2oZDHeidtbZXDdkjqocloYZhxR/kwplwb27WTRMw
         ReeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7joHR173kmsc59rBBr/ksencMbsFUjxYr35XX72uJ4=;
        b=o10gkHCqtP9eKQxHWZaP1NTJv0/cBbsEFnONDuxmq0uSiNEtYYSbZGYofAiTzo2Yut
         b66i8xBR08G0YuT5kE5gNOXkNX48bb/ma8McYx6Agl7d5zQGSKqu/NkGncqbxJ5myD8j
         QDO8BPylEjRlxZKJpMedkUYCt01f1sC76lMplMWc/tWxtXPlroZkltGhAXjkdXhGM00A
         1O2v5j9TioBwjpzJ24BNd8+9ZnFKMJnTy5EO17vpZoeE21qi3HGQGRFCtj5ZuUy010nB
         zZpx/XnSDD1AYYeP2u4hWYxHnsFtqfjei+Ju6pAVo+5NHyMK30dNLkrtuu9qf3Yia2yr
         oW8g==
X-Gm-Message-State: AOAM530gYlMjpwqGjaxBVveLNkGBxh0jps6P//X7RPIzSf1pbfUNqkeb
        M1fVPs/H5g0QsvYanBR/WwDpuUZHWv64XjiO83LOew==
X-Google-Smtp-Source: ABdhPJyBe356P7hF37a77qJ0nScNcGn6bF9gReBYqYI52GxtnMyzsolZO5kOIE/TqQBeFjA+1b5QpZD5xQmnGB2VXSA=
X-Received: by 2002:adf:ec07:: with SMTP id x7mr4977285wrn.262.1627040587489;
 Fri, 23 Jul 2021 04:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210715225146.v2.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
 <57AE120A-78AE-4990-8D7F-BA8D8077B610@holtmann.org>
In-Reply-To: <57AE120A-78AE-4990-8D7F-BA8D8077B610@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Fri, 23 Jul 2021 19:42:56 +0800
Message-ID: <CAJQfnxFzj9m43wntnb2gvXkJS6B5+aQGsu7v6hc4H4ktAopk7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_h5: add WAKEUP_DISABLE flag
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Thu, 22 Jul 2021 at 22:32, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> > Some RTL chips resets the FW on suspend, so wakeup is disabled on
> > those chips. This patch introduces this WAKEUP_DISABLE flag so that
> > chips that doesn't reset FW on suspend can leave the flag unset and
> > is allowed to wake the host.
> >
> > This patch also left RTL8822 WAKEUP_DISABLE flag unset, therefore
> > allowing it to wake the host, and preventing reprobing on resume.
> >
> > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Reviewed-by: Hilda Wu <hildawu@realtek.com>
> >
> > ---
> >
> > Changes in v2:
> > * Remove unnecessary variable
> >
> > drivers/bluetooth/hci_h5.c | 83 +++++++++++++++++++++++++++-----------
> > 1 file changed, 59 insertions(+), 24 deletions(-)
>
> so the set does not apply cleanly to bluetooth-next
>
> Applying: Bluetooth: hci_h5: Add runtime suspend
> error: patch failed: drivers/bluetooth/hci_h5.c:11
> error: drivers/bluetooth/hci_h5.c: patch does not apply

Hmm, it applies cleanly for me. Not sure what's going on.
Anyway I rebased and made a little change as v3, please take a look!

>
>
> And I am really close to not accepting any patches for hci_h5.c anymore. This thing turns into crazy hacking and nobody is taking my hint to redo this as clean H:5 3-Wire serdev standalone driver.

Pardon my unfamiliarity, but could you share more about your vision of
a clean h5 driver? Should the RTL component be moved out to btrtl?
Do we have something as a reference?

>
> Regards
>
> Marcel
>

Thanks,
Archie
