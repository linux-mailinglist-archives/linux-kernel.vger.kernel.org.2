Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E9439B565
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhFDI7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:59:32 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:37513 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhFDI7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:59:30 -0400
Received: by mail-lf1-f42.google.com with SMTP id f11so12930069lfq.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 01:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/jcUN5Pr1n6HTlXvEq++SAZmvv+rGmd9f5h/IEw88E=;
        b=tCOn0KeYbBXVsEvHdiNoxR3vT/eDT1koFBDlRNjoFv2QoycJwCTN7+WRx2EULW/4R1
         NTgbY3pRxS/EUriSBGmbX4FfLi/zryMPFH6+32FQVKCnKbP2Vy1T12B1Zsa9kHQakT4N
         p5Mgqp10AmtrJdhEQLxeDCAN8Qzq85GlM7JIzYwbtBhe6QsJR9KlnZzgfP6oxPLLIqNY
         It8XLEqaHg/j9DHFOXhGvPes4BrdedLdr5fyfP+VnBsFFFgb0wOvW9gcdk3ObqeFWI9P
         LxTqNsLtd5rCWkw5O8mXbn2n8OrIVZDRrTmsG9VYr8OUgGFeKj0e7xdiSGz81e54lSaw
         4Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/jcUN5Pr1n6HTlXvEq++SAZmvv+rGmd9f5h/IEw88E=;
        b=SWUi4P7bgjpCtQQQ2C74IJmqvUzCnCjsAIKONh9IIrVXiUeGpIQ7yqoRT6pTtyS34w
         0O66WMto2XnTyIBQOxrhspfeqGuugPEGk0ZdQdKGtKHpEYE8cFb//jOzBUqEZgK5myDf
         9zD8ren9V88XjUcMSmNuNgej0LMUKtxHKujQyS6/aCIg+SpUrsCoFqmSJZgjkT/Mn4Xj
         9LSEX70RUTxUveDKZ+8buW4S06IQfCenQtPnNYRm4BuPP7oq5fCdZPwSmxGiywqINo29
         lg01ycR5ETuR4PFZxP9T2/HMXoVnRM2iJ90FHYXYE5qEN5NAvoX3ScA349HqRV2sOC9d
         Em0g==
X-Gm-Message-State: AOAM531nsNZjt1x6kXpYjWs6KlItg4Crwv44ueh5scIwbfPt2DgdV09n
        KfYT16eMRsC3NDTbZme4ujhgsEe9kHoxIGHXtTNp8g==
X-Google-Smtp-Source: ABdhPJxbd+oPaahs3Qal3C/S0gS8W9AkP69zut0KB0EoETyRMpK52iyGNSe6iE0v6qs6gj5V2LOgl5SfvJgA3+rMPEk=
X-Received: by 2002:a19:4cd7:: with SMTP id z206mr2063492lfa.414.1622796996237;
 Fri, 04 Jun 2021 01:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210604162616.v3.1.I444f42473f263fed77f2586eb4b01d6752df0de4@changeid>
 <fc36d07a8f148a45c61225fefdd440313ee723d0.camel@hadess.net>
In-Reply-To: <fc36d07a8f148a45c61225fefdd440313ee723d0.camel@hadess.net>
From:   Archie Pusaka <apusaka@google.com>
Date:   Fri, 4 Jun 2021 16:56:08 +0800
Message-ID: <CAJQfnxHtgsCTS5GCTj-p4iqaR=jZVPho1ELgFQ6-UngZcBECig@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] Bluetooth: use inclusive language in HCI role comments
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bastien,

Thanks! That was a great input.
I'm not sure though, do we have a standard, proper way to deprecate macros?
Or does a simple /* deprecated */ comment works for now?

Cheers,
Archie


On Fri, 4 Jun 2021 at 16:39, Bastien Nocera <hadess@hadess.net> wrote:
>
> On Fri, 2021-06-04 at 16:26 +0800, Archie Pusaka wrote:
> >
> > The #define preprocessor terms are unchanged for now to not disturb
> > dependent APIs.
>
> Could we add new defines, and deprecate the old ones? Something akin
> to that would help migrate the constants, over time:
> https://gitlab.gnome.org/GNOME/glib/blob/master/glib/gmacros.h#L686-716
>
