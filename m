Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D21C31F192
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 22:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhBRVKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 16:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhBRVKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 16:10:46 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8911C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 13:10:06 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id a4so1939541pgc.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 13:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFuWVcfezeRuRTof6nz3CYKtFriRYGUNbLlHaDQ4yQE=;
        b=uzPriHvMWygw1o4JQz8tcuiP433U24qdXJ2/LEzxQtgc5EscpyeZntikbWoOmfRvbT
         vHNTniMcmcAm6VGtZIjYq/8uGTY7V70sbV8gS5Ybq344MbwiPb0u1n6zG6WJvS7pL63g
         BZWc+axQ3byJDvmbE7RXB1gHnpePHt3y6Nh/sVHgptOeosiVHh661Xyn/HxjhNA9UMaa
         ZWTFqdyJfLfF8zNHuubC9uGFMGXSdeQ3aYazxpF4fgT+CGOr70JmRX4xkCzvhEF94hdt
         5PDO+CLgPqKO/bZdM6DM/BSujkypWUiTdV1t5lPlreaDT3bipZehXMvdUzVB2WFNGwJv
         1UjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFuWVcfezeRuRTof6nz3CYKtFriRYGUNbLlHaDQ4yQE=;
        b=LZB2wUsJpNQaj6qdfswzNTOL0XWOFRuR9KL9v7U/Rai5DmweKn8Dxa5byhiZb1Jo4k
         lt+Esd54CK2Sx84oa2VgvMHguOxfZE2r/g7c0lxS6dhdSbVc39OrT4Ysor9fzSD6su3s
         gdHiRT1D5cGc/oKOOb2/7rHrmXQhVsfKrTmdllTNUxlB6xGIPKa7O7YvQHNlYQp6DAMX
         hxsGWj5eg+6m7z8EGZFD97/et5lwBCptFHg0hdDCZ8zsQmboCWs5o07ZIuzR7ERLsbS+
         ejGBKohZKBrvj0IT9r78NQcLDSsts/b8vkhBkPxEXu0uD0Pg7kmturrRXM3PkFkKuGUJ
         9lCQ==
X-Gm-Message-State: AOAM532b0jPkP0BhLC6qCe6nFJ6PNFpixxMlYl3Lx+19uAGxnSEw9bLk
        yV2rxck88biAVthCuiNX3Erh3tPraMbnWqt1hv0=
X-Google-Smtp-Source: ABdhPJzXTY6OPUT4Fd6gxt8z5FXshbJv779uf09xyHaB9soR8yV7wbIOUeeR2ckWeDyoJ7QbXxweunva2KSyW8MvhAU=
X-Received: by 2002:a62:7a0b:0:b029:1de:7e70:955d with SMTP id
 v11-20020a627a0b0000b02901de7e70955dmr6090753pfc.49.1613682606406; Thu, 18
 Feb 2021 13:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-4-mgross@linux.intel.com> <CABb+yY1MLxArMY7g7HY06Tn5aABwpmUuXN9KddHZpW-_Mmu2iA@mail.gmail.com>
 <ffc9713e441389d19e7221ad4d16b938fa412361.camel@intel.com>
In-Reply-To: <ffc9713e441389d19e7221ad4d16b938fa412361.camel@intel.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 18 Feb 2021 15:09:55 -0600
Message-ID: <CABb+yY2kxCjHqbBbgcPShyMA-xtcJEpzGXxqnjDAoufhidX-LQ@mail.gmail.com>
Subject: Re: [PATCH v6 03/34] mailbox: vpu-ipc-mailbox: Add support for Intel
 VPU IPC mailbox
To:     "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>
Cc:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "bp@suse.de" <bp@suse.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 6:02 AM Alessandrelli, Daniele
<daniele.alessandrelli@intel.com> wrote:
>
> Hi Jassi,
>
> Thank you very much for your feedback.
>
> On Sun, 2021-02-14 at 22:54 -0600, Jassi Brar wrote:
> > IIUIC, maybe the solution is simpler .... What if we set txdone_poll.
> > Always return success in send_data(). And check if we overflew the
> > fifo in last_tx_done(). If we did overflow, try to rewrite the data
> > and check again. Return true, if not overflew this time, otherwise
> > return false so that mailbox api can ask us to try again in next
> > last_tx_done(). This way we can do away with the tasklet and, more
> > importantly, avoid send_data() failures and retries on clients' part.
>
> That's a clever solution to avoid the tasklet. The only issue for us is
> the automatic TX retry from the controller. I understand that's
> generally a desirable feature, but in our case we'd like the client to
> have full control on re-transmission attempts.
>
> That's because some of our data is time-sensitive. For instance, when
> we process frames from a video stream we prefer dropping a frame rather
> than re-transmitting it and delaying the processing of the rest.
>
> Now, I understand that the client can set the 'tx_block' and 'tx_tout'
> channel fields to specify how long it wishes to wait, but the problem
> is that our (single) channel is shared between multiple applications
> having different timing requirements. That's why we prefer to let
> applications deal we re-transmissions.
>
> Given the above, do you think it's reasonable to leave the
> implementation as it is now?
> (from initial analysis, the tasklet doesn't seem to affect the
> performance of our use cases significantly, so we are fine with it)
>
Yup. It is intel specific so, hopefully, we don't have to deal with
other vendors trying to support their use cases.
Are you targeting the next merge window or this one?

cheers.
