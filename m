Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D87A30684A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhA0XvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhA0Xu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:50:59 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7FAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 15:50:19 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id j2so1232806pgl.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 15:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=XsErl/cimO7wftOceCRiamL1P72e2kHrMeV9MFjW27g=;
        b=fGLqz9UsgK9Cr9me5mJkGUUHZ/ke2usuBxuSHXBCSgMAeh8tHZ4FMurwWB5rlSQeDo
         bemL1e/oAsER36IcSonYKQfzwXrATmHWRNnVyLXNVunMnwmQ/6UkWKx24BjgWPbcs+Sz
         PRCJ5rJ8HRVTkKeKmnYynuL7P0Z9wyQg0yKdq4ezgecbXb5C18uMVENT0iSAOVQ8DT5e
         7sZTGp9nvfjpfwxGqQZbfXbzQLm68F0h7BpVi1d4byqSVDCCP9ahAQXe/AJ7YibeAlkz
         fhmRVpGnoTfaFtXnX3r7ZaMuY2o56WzZTKzZ3XZOvcNFf1MP+q4xLghbJpi5QIHQfGvS
         uzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=XsErl/cimO7wftOceCRiamL1P72e2kHrMeV9MFjW27g=;
        b=BFuesJ863OOAKUXLkdOZ3afQXQqZG+lKkYJdhQGZs8ozFm0bAmGdW6K/JmVSzZCVO7
         jAVbnqQ8VkMDh6Qd6QTzKdL5Dyp17AkBlvRus15TKjfADuv/6ZlV8MgEMNyAUTy8+HXG
         TpLey9P1nOk0YndcXupPaLzl7KScd3bXm+DFTH+LDSKqF9KtS8JLMvG0HUIG5s1OsqRi
         9i/xKxrM5Q8EUjZKgX1LZQmqHoA5YUxAFXaS68Jh8asA0OEVMkW5h/fSLC86mGKKI+fz
         eKektNHf+4d5e9kb5JbG3y0Noa0tQgyn7vqqD4Azuo5EtAPgZ/r9MrIFVNJg3JSbZQS8
         FGkQ==
X-Gm-Message-State: AOAM530uwdfSOhjnydCnjhgm0tsZJpNwiUforV2RjS3Lb7U58YCn92uO
        mjb+81LJOzq5avUqlvz1Kx+7ryrHr1Q=
X-Google-Smtp-Source: ABdhPJzPxvfNcOGRxVoxGRJhNJzeeR6LVj1ni1YjcQZl5ymQxjDeLCfX6QUO6JSQd/lT4PTM1qPt3g==
X-Received: by 2002:a63:4764:: with SMTP id w36mr13533232pgk.127.1611791419066;
        Wed, 27 Jan 2021 15:50:19 -0800 (PST)
Received: from localhost (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id g22sm3455973pfu.200.2021.01.27.15.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 15:50:18 -0800 (PST)
Date:   Thu, 28 Jan 2021 09:50:12 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: RE: [PATCH v4 11/23] powerpc/syscall: Rename syscall_64.c into
 syscall.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Laight <David.Laight@ACULAB.COM>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        Paul Mackerras <paulus@samba.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <cover.1611585031.git.christophe.leroy@csgroup.eu>
        <ff9dd4accdc897013594768833d54444e4823bf9.1611585031.git.christophe.leroy@csgroup.eu>
        <1611656343.yaxha7r2q4.astroid@bobo.none>
        <d9993f034db848d1afeffa322373b811@AcuMS.aculab.com>
In-Reply-To: <d9993f034db848d1afeffa322373b811@AcuMS.aculab.com>
MIME-Version: 1.0
Message-Id: <1611791083.sqnnh21vv0.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from David Laight's message of January 26, 2021 8:28 pm:
> From: Nicholas Piggin
>> Sent: 26 January 2021 10:21
>>=20
>> Excerpts from Christophe Leroy's message of January 26, 2021 12:48 am:
>> > syscall_64.c will be reused almost as is for PPC32.
>> >
>> > Rename it syscall.c
>>=20
>> Could you rename it to interrupt.c instead? A system call is an
>> interrupt, and the file now also has code to return from other
>> interrupts as well, and it matches the new asm/interrupt.h from
>> the interrupts series.
>=20
> Hmmm....
>=20
> That might make it harder for someone looking for the system call
> entry code to find it.

It's very grep'able.

> In some sense interrupts are the simpler case.
>=20
> Especially when comparing with other architectures which have
> special instructions for syscall entry.

powerpc does have a special instruction for syscall, and it causes a
system call interrupt.

I'm not sure about other architectures, but for powerpc its more=20
sensible to call it interrupt.c than syscall.c.

Thanks,
Nick
