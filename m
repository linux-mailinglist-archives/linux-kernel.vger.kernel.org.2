Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0DD3AA99F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 05:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFQDgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 23:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhFQDgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 23:36:08 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2259C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 20:34:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q15so3762324pgg.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 20:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Np87+P91qpLWwoFgyfj/tVvnbhFOu2PiFh8/7E4oNNU=;
        b=SWZmufYBXINix7/MHI629etAmmtBCT21x/eT4irvwjM8HUG0nFjwyMcXibhj4ODnG4
         3MkPm/nYtVj1kXUdjUS9UZ02EU+htVQUFF8zowNuTWzjVShPVCWWBnWSdp8g48fIJ+Nm
         eMrm6zLpJYTtfJkFcaMVTSur10oBYr/K8xXJ5Kysa4o0PaqEJumDh/7+3rBGVgHY1o9Y
         8ybsNypepRxESJOycWNi+AluTbvQgjb/UuQfS05zkJJU19CGmsozLRReDKk7GzoLRQUb
         sYtqsFCJMVyFmUnGDevw3Pjvwv0wk1KWnmbhPTvTicMKdQNPsO9lsDwECOo4oRokM9Bz
         fu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Np87+P91qpLWwoFgyfj/tVvnbhFOu2PiFh8/7E4oNNU=;
        b=DigXkx6hZ6UBiXTMU87zVcVIOHBxKZA9sbNzU3qGbp0upYjGQZQxXdInubAv780e3R
         jN2+x0wj57kHRe4qDvgg5JzBim8dQdRMgy5UeKHNgI0barDPOUvClgo5NG1pLhnxMdJz
         IBaODaXfze9UTQZhAzdMpPmMMx4dUOpU0c2SO80pn51AYhDVRTYp8125j1SSc9kAb+O+
         N9YPLjwFib8/c9Z0AIVoHkMAVYQD+oeTctCkrcKG2kWrOkuq1IdbNa0Z+41ZxgF99LoV
         kr9Ui8kh/bnc2rSk225I/E2YTC4o3nKDfYiMy0Ay7OsDuU6csvo+pQJe2z5BQMcH++/c
         AzwA==
X-Gm-Message-State: AOAM5327EUZ0wSlH72E1PuMtbPS/BWq+Gc2Ly4roezH3HRn6cZ5b63N3
        nSg5E1sly+4Kxbndx59nkUjT2CBCblU=
X-Google-Smtp-Source: ABdhPJwaKbkscV5Os4TdY4LLC+vm6rH5DiyJ0bLZ8Qywlo8VE6hK0awThMofSNj3Ak+GdCXhUiNxmw==
X-Received: by 2002:a63:6841:: with SMTP id d62mr2905034pgc.7.1623900841294;
        Wed, 16 Jun 2021 20:34:01 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id q4sm3609641pfh.18.2021.06.16.20.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 20:34:00 -0700 (PDT)
Date:   Thu, 17 Jun 2021 13:33:55 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 2/4] powerpc/interrupt: Refactor
 prep_irq_for_user_exit()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <809d316bf5f1a81acdd69e220c13e716dac24f53.1622818556.git.christophe.leroy@csgroup.eu>
        <3fbef68e1cffc0ebbbad1893e4fb9426b0915039.1622818556.git.christophe.leroy@csgroup.eu>
        <1623378421.ayihg84s3a.astroid@bobo.none>
        <4f21c7c2-d04b-dcb6-09ad-562a2c3cf88f@csgroup.eu>
In-Reply-To: <4f21c7c2-d04b-dcb6-09ad-562a2c3cf88f@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1623900771.37yjadhzel.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of June 15, 2021 6:37 pm:
>=20
>=20
> Le 11/06/2021 =C3=A0 04:30, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Excerpts from Christophe Leroy's message of June 5, 2021 12:56 am:
>>> prep_irq_for_user_exit() is a superset of
>>> prep_irq_for_kernel_enabled_exit().
>>>
>>> Refactor it.
>>=20
>> I like the refactoring, but now prep_irq_for_user_exit() is calling
>> prep_irq_for_kernel_enabled_exit(), which seems like the wrong naming.
>>=20
>> You could re-name prep_irq_for_kernel_enabled_exit() to
>> prep_irq_for_enabled_exit() maybe? Or it could be
>> __prep_irq_for_enabled_exit() then prep_irq_for_kernel_enabled_exit()
>> and prep_irq_for_user_exit() would both call it.
>=20
> I renamed it prep_irq_for_enabled_exit().
>=20
> And I realised that after patch 4, prep_irq_for_enabled_exit() has become=
 a trivial function used=20
> only once.
>=20
> So I swapped patches 1/2 with patches 3/4 and added a 5th one to squash p=
rep_irq_for_enabled_exit()=20
> into its caller.
>=20
> You didn't have any comment on patch 4 (that is now patch 2) ?

I think it's okay, just trying to hunt down some apparent big-endian bug=20
with my series. I can't see any problems with yours though, thanks for
rebasing them, I'll take a better look when I can.

Thanks,
Nick
