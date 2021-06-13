Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD033A59A8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 18:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhFMQn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 12:43:58 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:40638 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhFMQnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 12:43:55 -0400
Received: by mail-ed1-f43.google.com with SMTP id t3so43324183edc.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRPRNwiv+Qa7LFNhBGliyXNB+ILCSmwq5eW3TGTSNt4=;
        b=Ir8CB+iHpFkcvuC0iayj4871f+XLzvhX6J/Kt97Mt3KEOnhKF2FuoPmCgCXiyFHVZb
         a3vZ1bFlfJqYsgReA//8fKfvmfAw9UQ9L3/FROogtXl5Y+0Yg5/PdSLnMyCqRq9wloMj
         c8xEpAkHe1qMxWqPIzfxymaDwcEWycewdrirLQW5fQ1KX1FzjvOTpfvXdrZ1MU1hqc0c
         rMXOCxvDfsS2Hl/dVNhr7LxGEB6v70IW3ddxeuBeK6C1UCVhQEqVklTR+kXXr/isMR3L
         m8GVKj/SMqD9dU+fdcwhkuCbMXWfF9S5kS3y5eJj6PZqeVG10KUByzLXnFKoSlvftplU
         Q81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRPRNwiv+Qa7LFNhBGliyXNB+ILCSmwq5eW3TGTSNt4=;
        b=aMYahrn+XZSrVI/JUPmnKD5DrqCBhqrrPHw0agsw3o/+Je5QuzJ6g2LDe5f2Evmp4V
         pNixTgEwfuC8YAz0ijZhHF4bCzUSG0MNT5/XfKanpARr3fhbWRkZvy9GPVK4VoKRL04n
         6wMyAZgpvOostQCS42p2fuUKM1ZfMDQ3j3Iu85M/GtrrrbEiNuLOrfZccDJTLC6aGhR8
         gcnTDvmJbLVdS9pjtfy27JSB1LSWwpnndaocDHaTiDkdNgkKF8CeZ1MI10CnC41QsFvP
         /1mqJs+tY07dtHtAkAmkchSXyK8bRq8bhmJFa3K8FS+uJD7c5nfY+4bWmupIBUPoRjKI
         B0ug==
X-Gm-Message-State: AOAM530ZvsoJR6FmpUwzC43znMSO3soR/kwqFy69BIVhNvsMjYJjKPxf
        U5yQgDRlQjv+SzBw12zmAYQ1Z0S8YthVmUzkjnQ=
X-Google-Smtp-Source: ABdhPJxrUobJ0ZeGHRd9i3Birfg+SOyHtdoiO8WUhzM4VEBRpOW85ihfvEdSnxiIhRdS435p3BLfS1Ka3cwS4fldJ4k=
X-Received: by 2002:aa7:c7cd:: with SMTP id o13mr13362281eds.269.1623602438426;
 Sun, 13 Jun 2021 09:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210613122858.1433252-1-fbihjmeric@gmail.com> <YMX7SRSPgvMA/Pw1@kroah.com>
In-Reply-To: <YMX7SRSPgvMA/Pw1@kroah.com>
From:   Jhih Ming Huang <fbihjmeric@gmail.com>
Date:   Mon, 14 Jun 2021 00:40:27 +0800
Message-ID: <CAKgboZ8QUQpiinL0xCxUmcp6nEVU20jXkDXbrK_QisUMiLEo1A@mail.gmail.com>
Subject: Re: [PATCH v2] rtw_security: fix cast to restricted __le32
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        maqianga@uniontech.com, marcocesati@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 8:34 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jun 13, 2021 at 08:28:58PM +0800, Jhih-Ming Huang wrote:
> > This patch fixes the sparse warning of fix cast to restricted __le32.
> >
> > Last month, there was a change for replacing private CRC-32 routines with
> > in-kernel ones.
> > In that patch, we replaced getcrc32 with crc32_le in calling le32_to_cpu.
> > le32_to_cpu accepts __le32 type as arg, but crc32_le returns unsigned int.
> > That how it introduced the sparse warning.
>
> As crc32_le returns a u32 which is in native-endian format, how can you
> cast it to le32?  Why do you cast it to le32?  Isn't that going to be
> incorrect for big endian systems?
>
> thanks,
>
> greg k-h

Thanks for the fast reply.
Yes, you are right. I did not notice that le32_to_cpu already handles
both of the cases.

So it seems the warning from sparse is false positives, am I right?

thanks

--jmhuang
