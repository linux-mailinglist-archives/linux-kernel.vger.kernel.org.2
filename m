Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269B440A17B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 01:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346128AbhIMXUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 19:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349896AbhIMXTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 19:19:42 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E71C0613E4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 16:05:40 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id h1so20093501ljl.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 16:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WKl+vSgoVtwUpDwTiYFeDbvOkP5sbvNaiiVprss03Dw=;
        b=A1SYNoXPXp9aR+QbDKLZgTKR12NmkzDsOFeCyOq0tPMxICI8eICyWtmYqdV3M1oPuP
         9MBd9pl8eNdfQkXn+0HNWq9vz63p8ZK8e3uwgCGxvf635skYTr0/yvFcHK4U/9Wsbopw
         8ecObmvzNF+VlYoo92Jv4arrMr190jRmGZWA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WKl+vSgoVtwUpDwTiYFeDbvOkP5sbvNaiiVprss03Dw=;
        b=FkpUNvWJziQLe0eEGsZDhRHta+V0kRXkJ+nEqZW5Wl5XBpVcts440YQoBD+BCSae7B
         khqy/ohOvvRL0wF35enMjBRQ+uUZGV99PAfmpHPkjkyjLsPiXbfaEXx1FzKo6wsXgKAN
         ytxjxWUMqoeylmcuk6Sc+oIPFiHTUr3M/2b3/G3gbnPMGJNMiNXR/R1NsKvR1XcRcefp
         Mq3E20QK0lNMEOoKBIo/5t2AQVbx4IQC/IV4b5Pi5FNj8Cze2DxKYcCyrygEd2p5YGK0
         zYhDcyHdZPCjt423juWkfkGB+dlH52SSKeDCMqlgEuUEWy95b2KL59eIxWOhHlJ4yWAe
         bTXw==
X-Gm-Message-State: AOAM532nuscfPl4SmZwPmu9rRH6WdegrKI//QqzjH5yNYHQArR7txd9Z
        31Hki9XbfLty/uApwwDKri/lBfTYlT98jOQVEnA=
X-Google-Smtp-Source: ABdhPJy5ra4najmj8jPJSvcnWx6YDsfX63Lq1387WVPSLTBOQk/gJ1AMMql3WGiMWLEwefIe6J/nFg==
X-Received: by 2002:a2e:900c:: with SMTP id h12mr12914576ljg.263.1631574338418;
        Mon, 13 Sep 2021 16:05:38 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id u16sm1196592ljj.0.2021.09.13.16.05.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 16:05:38 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id y28so195024lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 16:05:38 -0700 (PDT)
X-Received: by 2002:a05:6512:3984:: with SMTP id j4mr963725lfu.280.1631574034860;
 Mon, 13 Sep 2021 16:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210913131113.390368911@linuxfoundation.org> <20210913131114.028340332@linuxfoundation.org>
 <CA+G9fYtdPnwf+fi4Oyxng65pWjW9ujZ7dd2Z-EEEHyJimNHN6g@mail.gmail.com>
 <YT+RKemKfg6GFq0S@kroah.com> <CAKwvOdmOAKTkgFK4Oke1SFGR_NxNqXe-buj1uyDgwZ4JdnP2Vg@mail.gmail.com>
 <CAKwvOdmCS5Q7AzUL5nziYVU7RrtRjoE9JjOXfVBWagO1Bzbsew@mail.gmail.com>
 <CA+icZUVuRaMs=bx775gDF88_xzy8LFkBA5xaK21hFDeYvgo12A@mail.gmail.com>
 <CAKwvOdmN3nQe8aL=jUwi0nGXzYQGic=NA2o40Q=yeHeafSsS3g@mail.gmail.com>
 <CAHk-=whwREzjT7=OSi5=qqOkQsvMkCOYVhyKQ5t8Rdq4bBEzuw@mail.gmail.com>
 <CAKwvOdkf3B41RRe8FDkw1H-0hBt1_PhZtZxBZ5pj0pyh7vDLmA@mail.gmail.com>
 <CAHk-=wjP2ijctPt2Hw3DagSZ-KgdRsO6zWTTKQNnSk0MajtJgA@mail.gmail.com>
 <CAKwvOd=ZG8sf1ZOkuidX_49VGkQE+BJDa19_vR4gh2FNQ2F_9Q@mail.gmail.com>
 <CAKwvOdkz4e3HdNKFvOdDDWVijB7AKaeP14_vAEbxWXD1AviVhA@mail.gmail.com> <CAKwvOdmtX8Y8eWESYj4W-H-KF7cZx6w1NbSjoSPt5x5U9ezQUQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmtX8Y8eWESYj4W-H-KF7cZx6w1NbSjoSPt5x5U9ezQUQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Sep 2021 16:00:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjhJgk7hD-ftUy-8+9cenhMDHqaNKXOyeNVoMxZRD-_A@mail.gmail.com>
Message-ID: <CAHk-=whjhJgk7hD-ftUy-8+9cenhMDHqaNKXOyeNVoMxZRD-_A@mail.gmail.com>
Subject: Re: [PATCH 5.14 018/334] nbd: add the check to prevent overflow in __nbd_ioctl()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Baokun Li <libaokun1@huawei.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        lkft-triage@lists.linaro.org, llvm@lists.linux.dev,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 2:15 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Sorry wrong diff:

Well, this second diff was seriously whitespace-damaged and hard to
read, but while it seems to be the same number of lines, it sure looks
a lot more readable in this format.

Except I think that

                default: dividend / divisor);

should really have parentheses around both of those macro arguments.

That's a preexisting problem, but it should be fixed while at it.

I'm also not sure why that (again, preexisting) BUILD_BUG_ON_MSG()
only checks the size of the dividend, not the divisor. Very strange.
But probably not worth worrying about.

               Linus
