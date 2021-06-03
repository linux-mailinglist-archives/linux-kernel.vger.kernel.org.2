Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A8A39AAE6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 21:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhFCT0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 15:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhFCT0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 15:26:44 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CC0C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 12:24:59 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d16so5631149pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 12:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=VKOvv1TfivesDpA9bfyoNG/IGgKCAjb7/e1zzaiAOEk=;
        b=YHJtOqmPmvkFRQD2wSYjf5pEKJlBfTPGaQOnmvD/5Z9Y4F5422uvqf19ecqh+AZHI8
         yAVvX4M8R1gI6PVHLKRqdskhOY3wedR4+hxBr18GaFfPA/pR52s6ev3ZvjQj8A45N1Fx
         U389vkuek419vpSY0Lgx/aC0pjQ6UHGKHXs0wAy1tUHt/hVdhxBn1Xmt3Q0vDEEbk2gt
         rSmuBEXFguqfGN2nqGbExMh2omMlRV9s8qDzIsBBpxkKAdz9Jrdi5vmtaaZtw//SVwNO
         gaQTYGHkxnc/EpICvm1ylvW4QsOvmk05/ZVNMKMo3HBcx3RqJv3RtxBueIbs2U8JMwGH
         PRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=VKOvv1TfivesDpA9bfyoNG/IGgKCAjb7/e1zzaiAOEk=;
        b=ITVhI2kYfu6vdXe585Q13LlasvL1IhmVqliKRgx3TQFc48mz9fniyFgIJDX5N9Nr8l
         0YwiYVNo9JdzW4J6pXQ4+zW8wsp7N2ETKh6cfegXWeL5o2mZcVUFbl6aXMdrbgQ6QTvD
         pUbxfnQCOctIsUKQTO50xfNz5Vq5HvliMbF8qJ2BwMGxvnP55meT34sY/+jsl3XLrovi
         h8dCRid0FIzLuaG6RGiVUZG1zqJVd+VSUQov/qw1H0aEEC5Rs0tTszKvdaRnwBhEpE3U
         nCAvXLtNfbm+sDtVZbGHDobluJMuXPu/cxae1HG0htStaVRouqIT1ODF1oXA/E0SOM76
         DjJQ==
X-Gm-Message-State: AOAM533Q4gwFiaZdYiXSMQM8V3TaQQutCOKdxzSKrGXuu4qYY5zuLt8m
        61wkRH9JxE8bMcd5P45ia+QakQaXTPlATQ==
X-Google-Smtp-Source: ABdhPJy1l1e1qBBumUKmmUFg1ps6/AplTMQguP1JhPTC2mJ0/V2yYMHkrXdmtj1HUyX2mi7TcLfapw==
X-Received: by 2002:a62:2e04:0:b029:2db:4c99:614f with SMTP id u4-20020a622e040000b02902db4c99614fmr575083pfu.47.1622748299253;
        Thu, 03 Jun 2021 12:24:59 -0700 (PDT)
Received: from smtpclient.apple ([2600:1010:b04a:17e9:b873:a3cc:f7b1:9d6d])
        by smtp.gmail.com with ESMTPSA id n23sm3300321pgv.76.2021.06.03.12.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 12:24:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem read
Date:   Thu, 3 Jun 2021 12:24:56 -0700
Message-Id: <1FD047D2-F5F3-4AC6-A4E4-DB8FB1568821@amacapital.net>
References: <CAHk-=wiNT0RhwHkLa14ts0PGQtVtDZbJniOQJ66wxzXz4Co2mw@mail.gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, Ming Lin <mlin@kernel.org>,
        Simon Ser <contact@emersion.fr>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
In-Reply-To: <CAHk-=wiNT0RhwHkLa14ts0PGQtVtDZbJniOQJ66wxzXz4Co2mw@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (18E212)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 3, 2021, at 12:14 PM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
> =EF=BB=BFOn Thu, Jun 3, 2021 at 12:07 PM Hugh Dickins <hughd@google.com> w=
rote:
>>=20
>> But the point that we've arrived at, that I'm actually now fairly
>> happy with, is do *not* permit MAP_NOSIGBUS on MAP_SHARED mappings.
>=20
> Yeah, if that's sufficient, then that original patch should just work as-i=
s.
>=20
> But there was some reason why people didn't like that patch
> originally, and I think it was literally about how it only worked on
> private mappings (the "we don't have a flag for it in the vm_flags"
> part was just a small detail.
>=20
> I guess that objection ended up changing over time.
>=20
>=20

I don=E2=80=99t understand the use case well enough to comment on whether MA=
P_PRIVATE is sufficient, but I=E2=80=99m with Hugh: if this feature is imple=
mented for MAP_SHARED, it should be fully coherent.=
