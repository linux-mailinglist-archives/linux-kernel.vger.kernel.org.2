Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E94319604
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 23:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhBKWsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 17:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhBKWsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:48:42 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9ECC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 14:48:02 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b145so4648900pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 14:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=WGBp0ms4trj4KJqYXx6s0gKRNvvrRpdSE+7mGZ4gKjo=;
        b=AsANI1TKW9wcXEIi4LEtOUxUNpQayajFoWP7YZ95m7XCh841Ai93sD6PPWxOs1HrCU
         KLifIGaiusRJ0RLzwKYHEWn7VejMLbo/L/UfSmjd8wD46Df0unMC3iqI/MyxpoW4tA7a
         5gPgoIkiyPiYDV1VkPTE+PliqL6iNwUwXcX8UrswcQ09T+gpIyB6rqYoLNPnfTO2EVw7
         H0xNJpzLjUU1UplPqkM3wz68SsvW4ICrfnA6OHJnQYUn2nvsmywbAN1+gGrDa3YeoSd1
         bRnNdhxaZWgAEbdWgRE/Ag2lrv76CA99xEAVfwXibiYJRkH8GzPgxqR7vvd7TAF0JkZV
         29IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=WGBp0ms4trj4KJqYXx6s0gKRNvvrRpdSE+7mGZ4gKjo=;
        b=SIhc/GsNMbhJu3IQNLwU9F0Em7Qbn68ZY/QyGXwosr4ejoMDncEeFPTjl+uacZmQHv
         VXVi5ZRUr3YAGUVjXTmHLc3TPNqeyVBLZkuKX9m7WkSDcidoRGWRZ7Z6P/6FuQW/nRPc
         X/nLZw/8W3Cr9PYyCFvtVB4zom4dHCp8Ok+0y1sf+HvGSeNUt5FLDuyHxoaVDH91oUpa
         drt+NsPe+o6rttVk6T24pRQpKHiR9iCQm91PdwLaNHehRI6OPuBk1F5Nvg+4BDYHL2Di
         Xd2a8vCyvFlH1eNJecU5KTj0YhIZUZlAgxXMHkl4C/jX955gm/jDdMG8p0yoH08pGnPP
         lrxQ==
X-Gm-Message-State: AOAM533hE1AgqCMZmiQUJTSVjLn+kMZasjKvKR48zSD7iNQC1UEYxaBM
        IrzzXcaP92rXr64cImD5unzPbg6Vzkk=
X-Google-Smtp-Source: ABdhPJwvz8NkBzT3VZIsgga9RgZijGc00zoDlZLVlsIEeO9JeUJdtdmHJB4GLs8GlIbfIgvcvJeHKg==
X-Received: by 2002:a62:18c8:0:b029:1d9:6e93:6b22 with SMTP id 191-20020a6218c80000b02901d96e936b22mr339226pfy.28.1613083682147;
        Thu, 11 Feb 2021 14:48:02 -0800 (PST)
Received: from localhost (14-201-150-91.tpgi.com.au. [14.201.150.91])
        by smtp.gmail.com with ESMTPSA id j9sm6369183pfh.52.2021.02.11.14.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 14:48:01 -0800 (PST)
Date:   Fri, 12 Feb 2021 08:47:55 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/bug: Remove specific powerpc BUG_ON()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
References: <694c7195c81d1bcc781b3c14f452886683d6c524.1613029237.git.christophe.leroy@csgroup.eu>
        <1613036567.zvyupcz926.astroid@bobo.none>
        <20210211115059.GB28121@gate.crashing.org>
In-Reply-To: <20210211115059.GB28121@gate.crashing.org>
MIME-Version: 1.0
Message-Id: <1613083544.ggx0xcefkc.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Segher Boessenkool's message of February 11, 2021 9:50 pm:
> On Thu, Feb 11, 2021 at 08:04:55PM +1000, Nicholas Piggin wrote:
>> It would be nice if we could have a __builtin_trap_if that gcc would use=
=20
>> conditional traps with, (and which never assumes following code is=20
>> unreachable even for constant true, so we can use it with WARN and put=20
>> explicit unreachable for BUG).
>=20
> It automatically does that with just __builtin_trap, see my other mail :-=
)

If that is generated without branches (or at least with no more
branches than existing asm implementation), then it could be usable=20
without trashing CFAR.

Unfortunately I don't think we will be parsing the dwarf information
to get line numbers from it any time soon, so not a drop in replacement=20
but maybe one day someone would find a solution.

Thanks,
Nick
