Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D395436BA27
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 21:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbhDZTkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 15:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbhDZTkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:40:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0AAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:39:19 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r128so63051086lff.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TLJVtvvBoq/yqMsEsQp2CVsNqoS4kEVzTchedKnBltY=;
        b=NxuUruDr2lHnywJ3Z+r1UAHxMhgCb3UXfYiRrhPJNqo/FGK2U0yh4/vlZZ85hcv7nA
         3HvU6GlJWZRop3dtZzBjGWObyYxvKgpbeCBjOIoUeouS04fHBeKbz6C8bj89JWN2R32/
         AsOVH7NQyCezbLTnpC+iiKrKnd9al2JuP18Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TLJVtvvBoq/yqMsEsQp2CVsNqoS4kEVzTchedKnBltY=;
        b=CHAXcLG8qbt/m36RnICkvmwcrPrNdX0SFlP5yZRb3AbJB+aYppOQFzbUelZOM7tyPq
         itJ5MhNVPydJw6AgTQaW5YLzydo/BzrbwATyUE5HQK/Tm3a1NQgUxjKiyK4tYhSxcGdU
         88WBYCEYLQsXvZkTzm0Y6kktygUyqiaDBksCr8KEfKyYmF5GhDNg/sXHLDiEALSKdZFf
         2hxQSBXR74P7BGXOKLAe5ARwbUoWudMiiSORpb/Zpbi6WRy7ChoIu+wYVCb1OR9b7ng5
         GXmQ8UjgLe9hY1bRJJexanLYc9dkZ68Bg/fzbMUpAnCEqo60kiScbsBw00otiT/FfAqv
         7rkg==
X-Gm-Message-State: AOAM5306isPBRI5B23CnsO+678l0JMZXJAr79d4EBxp/PiJeVnqfNyIL
        iT2Us4v84zAPxqkGktwxREmMrxmqZ0pJF+yH
X-Google-Smtp-Source: ABdhPJyhJfww/0bNim93oXroK8sgsY5A4bz3cbBWQTWKOT1/3oZ6pR9Y6dQjOybmLZI0JqKOyKNJ1A==
X-Received: by 2002:a05:6512:2027:: with SMTP id s7mr13373252lfs.587.1619465958248;
        Mon, 26 Apr 2021 12:39:18 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id u16sm102328lja.48.2021.04.26.12.39.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 12:39:17 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id b38so24356228ljf.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:39:17 -0700 (PDT)
X-Received: by 2002:a2e:1406:: with SMTP id u6mr13608357ljd.61.1619465957464;
 Mon, 26 Apr 2021 12:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2RjRSjTcmwVf3VHy2CUB2HBj5AaJTx=1NSYuA_Qy4E-w@mail.gmail.com>
In-Reply-To: <CAK8P3a2RjRSjTcmwVf3VHy2CUB2HBj5AaJTx=1NSYuA_Qy4E-w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Apr 2021 12:39:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDQ23kEkVVhjwcVPkQCDUVmJJdhO_HtjaRRCv_mtZgag@mail.gmail.com>
Message-ID: <CAHk-=wgDQ23kEkVVhjwcVPkQCDUVmJJdhO_HtjaRRCv_mtZgag@mail.gmail.com>
Subject: Re: [GIT PULL 0/6] ARM SoC branches for 5.13
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 8:53 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> Here are six branches for the SoC tree [...]

Ok, all merged. Please do check my conflict resolutions - not because
I think there is anything wrong there, but simply because the arm side
doesn't get the same build coverage testing when I merge.

All but the two first had some fairly trivial conflicts with the other
trees I've been merging today.

              Linus
