Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C173D3808
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 11:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhGWJIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhGWJIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:08:14 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A34C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 02:48:47 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id v8-20020a0568301bc8b02904d5b4e5ca3aso647455ota.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 02:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vt64JT5Gp6RooRNCcXnfzF2yBALXrrPFILlPs1pbVY4=;
        b=CvHOasvlmEYGrUbaI8jDGcGCFgT83AqH3aAm5085iA6agYR2Ws9KPUjAgJFqKxJq0T
         S6vSqq33ZhPSXNiIkU0IMut9ScOrUSSpPqYW6+KsLpdbu4CXHJs6IoRgza6qtE2We/Kj
         3lkNZ1IpFsOhuHsZ/RJ8nmI71EYFtmo2KxmnTwvmxlADr/LA7VetCfT3lYVjhidMgTrT
         bXvo0au+oBn41ZrBmAA8X95kBPaLViF6NIq2/m/0CfYcvBeaOwS4+VAF9BQpP50UkzRj
         DH7DOemH76sUcoLd4yD9fpEDEVAmUgWDsIxbndUGYuETi6kz7fyY1gzFy7fEG/jf1W6Z
         jgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vt64JT5Gp6RooRNCcXnfzF2yBALXrrPFILlPs1pbVY4=;
        b=i1Tgjhm3ANeImSkYr4T1T+wt6c/NtN0hzsiYTewj3wNB79hDm1lTaI+Dme6+8WCQni
         MYFjcip6MXRv/rXcKRGvm3e/9RPJBdz0oc4o7IRjim/q5ByLvbhRg40hfNGREVucjDQk
         J+HCAItM31OUH5RnNYmOkUOc+Hhp4isCZUhE5+fRmK6e/WkezfZdBuvinj83r4btRQIo
         JxfZRXyBsHAuRMeeqdAyK5ejZJ4ZBiEHie8jBDx2jq8Ip+thEcC5IH+Z2f8Taauctr5c
         EXcV8PE+4B70A38vI441bpFQLmuSDXw2nJXwreuBpa/UPqCTbehb7f0gPcO4hRplGYO3
         1D+g==
X-Gm-Message-State: AOAM530MEymJlzguDIgSgMhwVVkCoNkYI72aIMEgTBUX6tjSq7um1Lie
        7jgONW81hGjfr5lMOb4181SQ8v2Ov5X1aP5Ma9KVw2+ZZR1tvRtGnA==
X-Google-Smtp-Source: ABdhPJzWhTKoakAso+FWJ6AGitMWvTLTu4tirAsSbo1PwPQZ1ivWpt5e36C5VXkkJcC3ey8tPMnUh0zqfXWAk6yz0M4=
X-Received: by 2002:a9d:8d3:: with SMTP id 77mr2517642otf.6.1627033727185;
 Fri, 23 Jul 2021 02:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <1624345891-4215-1-git-send-email-zheyuma97@gmail.com> <YPpbu8YFx9bKa343@light.dominikbrodowski.net>
In-Reply-To: <YPpbu8YFx9bKa343@light.dominikbrodowski.net>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Fri, 23 Jul 2021 17:48:35 +0800
Message-ID: <CAMhUBjnzw78UBX+iFyi5MDcWVCFpAz2JixPLzaNJF2juKWKz7Q@mail.gmail.com>
Subject: Re: [PATCH] pcmcia: i82092: fix a null pointer dereference bug
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 2:20 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Applied to pcmcia-next, thanks. Are you aware of the last version where this
> driver worked correctly? It seems that this bug has been present there for
> ages.
>
> Thanks,
>         Dominik

Sorry, I don't know. Judging from the commit log, I even suspect that
this bug has existed since the introduction of this driver......

Regards,
Zheyu Ma
