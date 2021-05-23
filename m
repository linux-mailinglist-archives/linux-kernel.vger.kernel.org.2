Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858E938D7E0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 02:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhEWAIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 20:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhEWAIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 20:08:09 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF9EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 17:06:43 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 22so17406471pfv.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 17:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfYRF1b1oHr6saSKxaH7T1g69quhuErgPZcFY9YPsBg=;
        b=rTcIVbsR4M8se90NJlGDq94mhnst/WOvRVsZjlbfzhUKglq3zLnaAB4D4AiPCXs/9v
         RKg3sV8nttBn7Z780gznjBVCIi3rVzAmwVv/ImnbGVtmDh0kJlgR3ZDxpet0cdGAZwUg
         YlLCYQeO02Ov0Pw1R3I9pLkB33x6NvrbCZRDbQHfkmh0rgCGPsg52DdAAF9eTkwpceoZ
         S2AV8plMjF5KCqneeF8yLPZ6f5cZAKA9MQXgdo/Aiy5C7d1jAYoa/xtYKCva/PJwqKWe
         kQ3N4mtaQRZlbPnGDaWxZl0CzO4hein1lpvMuPX9szWHY/o1yjdJ4meZeySvkpJqgOh7
         JZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfYRF1b1oHr6saSKxaH7T1g69quhuErgPZcFY9YPsBg=;
        b=J0P3nKPpWQ+RnA+MkzVAq3DitCR8+Mb2/Vq0UigdUkIRLkUtiVjPN93AucsGiFZ4Zz
         /ULQSjZIF2guu6g8hbiBc436w/nl6+FmDHFlAgpl+UtucU8neqnxVEVc6MyUWOAJxoIt
         zvnv5KMl1OakHQjQWDJG37AnpbbLTmopX3DExeY/CDpaj76XeY7CeYn/ygeQy+gF91jH
         F1vuuUwLN728fn2V1b/iHA1jGbsHM7GT8KnWch1WyF4Abczek/6GUtJG9YOjEEn2hqQn
         a0EMlM961ysiDaBgir1IOjRMwevhzzEWH/iV1LAZVDb5nQ/Fyi2+mVIpKE0gu3uR2Znz
         ZlFQ==
X-Gm-Message-State: AOAM5321EJRIZIzheoheYz82unArj6xSGaTprpLLASbMPKzYLiLX9w3l
        daKPVmpcKd79v8liBw9q54lZseKaQFPP3ESMkLLylg==
X-Google-Smtp-Source: ABdhPJzGIprSQBgbiCV18q2GPN/AbrX/k4spM7a2Q/WdAtNtFDWDBhNtnrK+cKNwFZ85JIvOm6ruXKGrKw+Eq5n/byg=
X-Received: by 2002:aa7:868e:0:b029:2ca:ea6a:71a1 with SMTP id
 d14-20020aa7868e0000b02902caea6a71a1mr17296934pfo.32.1621728403003; Sat, 22
 May 2021 17:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210506073610.33867-1-phil@philpotter.co.uk> <yq1pmxj526p.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1pmxj526p.fsf@ca-mkp.ca.oracle.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sun, 23 May 2021 01:06:32 +0100
Message-ID: <CAA=Fs0ndZNqz-Tdhxxi6GFqyinAoS9v0syGrJf=uR768FcuuDA@mail.gmail.com>
Subject: Re: [PATCH] scsi: sd: skip checks when media is present if
 sd_read_capacity reports zero
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 04:00:10PM -0400, Martin K. Petersen wrote:
>
> Hello Phillip!
>
> > In sd_revalidate_disk, if sdkp->media_present is set, then sdkp->capacity
> > should not be zero. Therefore, jump to end of if block and skip remaining
> > checks/calls. Fixes a KMSAN-found uninit-value bug reported by syzbot at:
> > https://syzkaller.appspot.com/bug?id=197c8a3a2de61720a9b500ad485a7aba0065c6af
>
> The reported read of an uninitialized value is in scsi_mode_sense()
> while inspecting a buffer returned from sending a MODE SENSE command to
> the device. The buffer in question is memset() before executing the MODE
> SENSE command. And we only look at the buffer contents if the MODE SENSE
> operation was successful.
>
> As far as I can tell the only way to end up reading uninitialized data
> is if the device successfully completes the command but fails to
> transfer the data buffer.
>
> But maybe I'm missing something?
>
> --
> Martin K. Petersen    Oracle Linux Engineering

Dear Martin,

Thank you for your feedback firstly, much appreciated.

I may be misunderstanding this issue, but in my mind, if this issue is
possible to
trigger with a reproducer, then uninitialised data is being read? It
occurred to me
that a capacity of zero for a media which is present would make the following
function calls/checks invalid, hence the motivation for my patch, as
skipping all
those checks with such a size prevents this bug.

Another thing I noticed was that (unless I'm reading this wrong which
is certainly
possible) the buffer is never fully memset. It is allocated to be 512
bytes in size
(as SD_BUF_SIZE) and yet sd_do_mode_sense/scsi_mode_sense is never called
with a len param of this size but in fact much lower. Perhaps you're
right though and
my patch is not required? Certainly many KMSAN bugs are probably in areas where
logic is not affected by the uninitialised access.

Regards,
Phil
