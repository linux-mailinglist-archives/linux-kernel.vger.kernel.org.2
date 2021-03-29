Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0452434D7E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhC2TMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhC2TM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:12:28 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368ACC061574;
        Mon, 29 Mar 2021 12:12:28 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id x189so14864596ybg.5;
        Mon, 29 Mar 2021 12:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKmYLaEk43CYTxU5svn8oc1fILpHmvISVJqZG9ciT94=;
        b=glkaGcAkaW6c9C9lNHLJh/6XL9XUssMG00pOAbm81S5bzhukitbWs4oSCgyE0SDOKY
         aEk9SLcQkb/Fsy4UncKK8g13CpFOiK2al1OmALUUHnhLccshR2ESSxR09512PSMm9lTD
         CbImhRw/EY0QyBAdvwPtIDI1WM8T28qa405+nJ8y1TA+BYM5EFZbSJb3gSVGRqbz0sbX
         NhrwgJWtbreFCGyLCGXgft/pTRmqA26a5udUKIw6XHZcQgqS6O0x7CgW1NnwD3M8aBgQ
         8Vg7VYPPH6ujoZ3SuAto3a7Qlf5Lis4po5PtH1VQ8k8PoZ55uZdd61Cbj0aJyO1LvaC4
         NaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKmYLaEk43CYTxU5svn8oc1fILpHmvISVJqZG9ciT94=;
        b=rwTSRp0cclhP974f6ONXa8lDtjw8pG8g07AIpu0gGd6kNXnUvk4oOE+C0sdCQQuBMq
         d3w90illEceqFnbKfJOO7FqbkCILVSsmtkIafs7jXbKQNaxrEouFDm0jb4J6OJueOBr2
         WtlvjNDRkUc6QiQ5eY/5b6y5DvtkAH5dlqxcVRgKPumno0o7NcnkAeEx04WesezaMiXp
         I9ihy91Uy3gt3jJQiGscfIjFZFcXxH8YURuankGkLHu410L39Gf5zX4EI9pvWgzryLGB
         0crCkBcNzaVgVeDkfsXDPtxlboN7YnX1OltTijf3+hYPurZXSOKSwozIf5aq+omQRr+Z
         pWeQ==
X-Gm-Message-State: AOAM531BWYbR9+r773KrxGOqOTQ1cYjtN3IxxkFULEl3PbDIIXELPP1Q
        PbGyq2ZvNLaY1GX0/xc0EYiutXsnnWm5TTTQBFg=
X-Google-Smtp-Source: ABdhPJx6awGKtvZYWTCAaFfb/psgHVBPq9Uis53zOwOW3G8m1WNj3B6YanbsbiMxIj0rmuybo2xNeQ4jUH9ro6ISg9I=
X-Received: by 2002:a25:3b55:: with SMTP id i82mr42784655yba.422.1617045147596;
 Mon, 29 Mar 2021 12:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210329121054.20474-1-yashsri421@gmail.com>
In-Reply-To: <20210329121054.20474-1-yashsri421@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 29 Mar 2021 21:12:16 +0200
Message-ID: <CANiq72=-ahHeOJY66OjVF1A0WZfGyepWs4K7QvY7Tyk1Y6Uw_g@mail.gmail.com>
Subject: Re: [PATCH] lib: fix incorrect kernel-doc comment syntax in file
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 2:11 PM Aditya Srivastava <yashsri421@gmail.com> wrote:
>
> Provide a simple fix by replacing such occurrences with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.

I assumed these come from the original sources and were not adapted,
but they aren't there, at least in the current version in GitHub.

    Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
