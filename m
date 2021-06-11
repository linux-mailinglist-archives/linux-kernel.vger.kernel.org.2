Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDC23A477B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhFKRJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhFKRJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:09:45 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F12C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 10:07:38 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p7so9574186lfg.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 10:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lOwkxf9QRi7C3lCfgqOaMKKdXM7YRsMkMG4gYcCEg7I=;
        b=hUJtNPjnc847EoQjZg/d561dlIomi/ORN/IB6rkSZqwqeECoGwZQRFJQb+QdwUYn9T
         gwvhv/DRfsqEqPJ1L/+W7BW/NLwxmhESeKzps5vuIMRmU1zEDrnRRjrssR42rdQ4pK6I
         xDo5ImsIUPlvP94FmFZNoRW0/65SEWbj3gJrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOwkxf9QRi7C3lCfgqOaMKKdXM7YRsMkMG4gYcCEg7I=;
        b=HjwCu/lMIzPBIKo7xNBM/oYYikNSIeuIdJDm8NVsrf4yXBsT7aqMDdYqHb03SMlv4M
         5uxrYCEWJKwgGKhl20kldfRQn9NxwD9ryiLm6HHEHupGi4RHenDgpUwmajs+xqpNlYng
         Nas+I+BWTFkq9Uu8L6JxS2ZLkXt/9efqayCAut2Wm/DepGVh0I3P9rR8eGY9RHpK0pEx
         Xe28bMKPCtD2vQBykrRkEOc+rIbi8DmfTFVMewQ0DdDq+pZ0ODX3LSwCtF9cLi/AViGg
         pOB6fGGrYXVLaUnyPjZaXhY7k82EsMYcIWwnUJgVgZ8IVQJJPYjKIYdBZkx9umQRxwIr
         xB0g==
X-Gm-Message-State: AOAM531RTnhr1Lac8PuWQPup7AXi/prBKG6xGWSUgEPU8ZN3wxj62gtY
        wKb3P9AxMjxrvrK4M0ehxPzBhbvG0oPdtvnYhjU=
X-Google-Smtp-Source: ABdhPJzC9w2BKrBv2gxm5DP+K8tmmfGcEl5sl+xGG6rq2SBdqAH9R68ssX6hu35DXZYviWu15BXXtg==
X-Received: by 2002:a19:4312:: with SMTP id q18mr3173739lfa.609.1623431256426;
        Fri, 11 Jun 2021 10:07:36 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id z8sm639400lfh.119.2021.06.11.10.07.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 10:07:36 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id m21so9521427lfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 10:07:35 -0700 (PDT)
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr3314299lfl.253.1623431255687;
 Fri, 11 Jun 2021 10:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyyyQ-0QkKquLX4q=7=pjGeRxhhP=z7rfLjEbX7mSrh5A@mail.gmail.com>
In-Reply-To: <CAPM=9tyyyQ-0QkKquLX4q=7=pjGeRxhhP=z7rfLjEbX7mSrh5A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Jun 2021 10:07:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgT1ZXOGRjBHbvw+GqY=qUv4oHv8BZ6FpSay6z_0FxkPg@mail.gmail.com>
Message-ID: <CAHk-=wgT1ZXOGRjBHbvw+GqY=qUv4oHv8BZ6FpSay6z_0FxkPg@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.13-rc6
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 8:41 PM Dave Airlie <airlied@gmail.com> wrote:
>
>   git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-06-11

I think anongit.freedesktop.org is sick. Can you ask somebody to give
it some tender loving? It's just disconnecting immediately..

             Linus
