Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251173309BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCHIr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhCHIrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:47:36 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B141BC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 00:47:36 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id j14-20020a17090a588eb02900cefe2daa2cso1113881pji.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 00:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=bKan0MbvNXWRj+HWXY8826SQQxFg7KQ0T970T1h/cKU=;
        b=mfgn/E41neDc4PfgZmzViMn1STcXOagr3u8Z6HPIN/QIJlv6ZGG3yxwFEjuLTLN8hY
         kjvofJ7Q8kG/W3vAxEfJbIQnMH5Ok35nQGOlXoWdeNyKD5QcWBj/ke+xk1y3TURP2TKt
         LVxwXkRz9vNLhLnPM1TRp1n/YVFMg9ACKinUaG/0PZHk99VJaBTeKrdgfW4e6FDZtXIA
         0+zCJZ0WTl8skMntt2OcUw6U38Xh5Ocyp4JGdduUVrPzQKUjqu1SgiwxTw1FZ4D/cMf/
         B0GUdijmRQKn5II/5bzO1RvSWf3jyl22d67pxgbBorMhyzScY7oseDpJlHUxRZhVuNlC
         3Z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=bKan0MbvNXWRj+HWXY8826SQQxFg7KQ0T970T1h/cKU=;
        b=gqkzhc8GLTb9yNv8TuE+b4hJtpxuxn34+G+WFFinc6Q5lY3qmBwSEOzMHT+opJA1LC
         num9WoXP8vcvOWP7QE0OmVT9ds8CFRHVr1NKyz5IwoRt9lXlxZPAOIwEgKmC6KvfdUa2
         Cfo/+sZgvonTXVG/ccg5cB4/y1hz7DLt08h+zIJDIqLfeCwIaKgZvkFK1wG02TPDmvts
         gy26xa45QKJkgmERxIDTehnBvy4+ZE/2JW6TITiAFWkrpEG8V5j1i0zOoUpdQIpWnQWf
         KKzHeolTBYt7MV2vx0v8Yo/StzdHwGicICyq6EjrV1JyeO2ZvVjzd0A6e6xTtlOfmINI
         73/A==
X-Gm-Message-State: AOAM532ycWm4UmnlgTojCN/nKaGo2I8ns7VGEfU5Ndc5e+5yEQ35M0GS
        yAaBRPYeW3Ksvv41Bu694Jc=
X-Google-Smtp-Source: ABdhPJy6Fh2uzNFRAMPVazacmcmCjtcORGUIi0dKs5WsrmwrZ7Mkz2vwL4S8o03vMyCfLzXvv2SB1A==
X-Received: by 2002:a17:90a:3b0e:: with SMTP id d14mr24269268pjc.198.1615193256337;
        Mon, 08 Mar 2021 00:47:36 -0800 (PST)
Received: from localhost (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id r13sm9446545pfh.159.2021.03.08.00.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 00:47:35 -0800 (PST)
Date:   Mon, 08 Mar 2021 18:47:30 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 05/22] powerpc/irq: Add helper to set regs->softe
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
        <5f37d1177a751fdbca79df461d283850ca3a34a2.1612796617.git.christophe.leroy@csgroup.eu>
        <1612832745.vhjk6358hf.astroid@bobo.none>
        <5987787e-ee80-ed0e-0c34-9884f6aad3c5@csgroup.eu>
        <1612856863.0x6ebz3hce.astroid@bobo.none>
        <d243672c-ea47-2d0c-bfe4-e6eed5460868@csgroup.eu>
In-Reply-To: <d243672c-ea47-2d0c-bfe4-e6eed5460868@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1615193040.e8vkjfd7b9.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of March 5, 2021 6:54 pm:
>=20
>=20
> Le 09/02/2021 =C3=A0 08:49, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Excerpts from Christophe Leroy's message of February 9, 2021 4:18 pm:
>>>
>>>
>>> Le 09/02/2021 =C3=A0 02:11, Nicholas Piggin a =C3=A9crit=C2=A0:
>>>> Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
>>>>> regs->softe doesn't exist on PPC32.
>>>>>
>>>>> Add irq_soft_mask_regs_set_state() helper to set regs->softe.
>>>>> This helper will void on PPC32.
>>>>>
>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>> ---
>>>>
>>>> You could do the same with the kuap_ functions to change some ifdefs
>>>> to IS_ENABLED.
>>>>
>>>> That's just my preference but if you prefer this way I guess that's
>>>> okay.
>>>>
>>>
>>>
>>> That's also my preference on the long term.
>>>
>>> Here it is ephemeral, I have a follow up series implementing interrupt =
exit/entry in C and getting
>>> rid of all the assembly kuap hence getting rid of those ifdefs.
>>=20
>> I thought it might have been because you hate ifdef more tha most :)
>>  =20
>>> The issue I see when using IS_ENABLED() is that you have to indent to t=
he right, then you interfere
>>> with the file history and 'git blame'
>>=20
>> Valid point if it's just going to indent back the other way in your next
>> series.
>>=20
>>> Thanks for reviewing my series and looking forward to your feedback on =
my series on the interrupt
>>> entry/exit that I will likely release later today.
>>=20
>> Cool, I'm eager to see them.
>>=20
>=20
> Hi Nick, have you been able to look at it ?
>=20
> https://patchwork.ozlabs.org/project/linuxppc-dev/cover/cover.1612864003.=
git.christophe.leroy@csgroup.eu/

Hi Christophe,

I had a look at it, it's mostly ppc32 code which I don't know well but=20
it looks like a very nice cleanup and it's good to be sharing the C
code here. All the common code changes look fine to me.

I'll take a closer look if you can rebase and repost the series I need=20
to create a tree and base 64e conversion on top of yours as they touch
the same common places.

Thanks,
Nick
