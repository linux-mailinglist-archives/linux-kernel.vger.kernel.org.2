Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791D431B816
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 12:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBOLfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 06:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhBOLfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 06:35:45 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78A4C061786
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 03:35:04 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id o21so4604261qtr.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 03:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LWrT8fZ201oRUWB5SANs4J6J66fxCMxMhnS4qgTBh3w=;
        b=i5xjhDLNkMrL//Xp50xS/bfVCwM3dBlG4QTulJZQ+Nb1tIZTYqaF0+DlWviGe7/tZT
         dnxmX7TQHx/vegReqj6uOjsDj8lxussCU29kWRFSAOb7qJzuveCI9YDsKwbin2UNJ1Dg
         v+Dktuqu/4ovnxFUxlr9tHIc3/wEUvCKuxJhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWrT8fZ201oRUWB5SANs4J6J66fxCMxMhnS4qgTBh3w=;
        b=DZ3W03rN8Rwd4po/zF3F7MLn+x8y9q0IrbxdQIvItZXhxE8ImBkJIiuOiFXHIpg2p8
         /cLUKF/OSBaNdRG0jPGF6uXA7s3YFB+/ZK4D99N4cFYmCQuTmtTvgapJ9Z0mc3NBbDQi
         RiCfnsaX+tYYcr07VFQBQTJhNu+5xHdI4AzQmOSkLJUhHzVagzaNP0j6Zb+0er2wCL8Y
         jKNUxK0hHmWCaUadbuWUpX+PmuWvrP0BY07CJcny2JpzrxGTLTH7auNUP85PQDsZTuNw
         29PPD1hIkX+Bw0jq6NtyjovXUg1ztdNztdnkoLGgH3VC+nKqntzuU8HwY1gwa4FgsvdV
         hRdQ==
X-Gm-Message-State: AOAM532KF3lGwbqA59Vb1A+b/sUX1MMrbQ/+299ScjIA3rEDLw7EoIfm
        g+WVgzX3EEbRCnyL3tjJDHP9qdNbFRNrN2gbujzTtA==
X-Google-Smtp-Source: ABdhPJyadDYkgRM4Ru/vdhJiHMG8Mk2MVykrG8xexKVBuTXrk3Wj1k22YIM5G9DsfHe+fBHAcZUMJnrGMhX43ZIjs/k=
X-Received: by 2002:aed:2845:: with SMTP id r63mr13568740qtd.386.1613388904137;
 Mon, 15 Feb 2021 03:35:04 -0800 (PST)
MIME-Version: 1.0
References: <20210213095724.3411058-1-daniel@0x0f.com> <20210215112409.1a755bf0@xps13>
 <CAFr9PXkh+attaCc6C2UxB=qvXksWriWOaaoEndy4k6SGE0QOHQ@mail.gmail.com> <20210215121653.4edd86c4@xps13>
In-Reply-To: <20210215121653.4edd86c4@xps13>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 15 Feb 2021 20:34:53 +0900
Message-ID: <CAFr9PXmc09zkXfhxPmPADuZE=EPZg=8kaWhc1oeNRbnzSLqqgA@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spinand: add support for Foresee FS35ND01G-S1Y2
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Mon, 15 Feb 2021 at 20:16, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> But a changelog should always be added when you change something
> between two versions. And the changelog can be located below the three
> dashes ("---") without being part of the final commit message, it does
> not need to be in a separate cover letter.

Oh. I didn't even realise that feature existed. :)

> I see. Can you please try the following:
>
> nandwrite -o /dev/mtdx /dev/zero
> nanddump -ol1 /dev/mtdx
>
> If the entire area is effectively free to be used, you should see 0's
> everywhere. Otherwise you should have ff's somewhere.

Ok, I will confirm this and get back to you.

Thanks,

Daniel
