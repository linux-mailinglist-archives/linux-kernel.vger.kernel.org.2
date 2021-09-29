Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFAB41CDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 23:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346896AbhI2VUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 17:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhI2VUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 17:20:14 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD56C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 14:18:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w14so3074275pfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ob6Q0H2Q1UIKTHBSM2eFI4wZOKPIJ6fWx83Tj6pqkNo=;
        b=eh+1iOVD9AVJG7gkBj9ezlgvqonUNLBovN6I0rL3wpojAapIu9hSuunEhhTFjdOCJl
         I9CxSStcu1pVmuRDDYqTv0ypu+aFYyZv3vBgo71Nge5SoTv74Jfg092oyFgtBmVFeB3N
         fyPVdmUCV7k/7thT75NPlHEQBNnwhxS1N812Xa0XohxvJhvTDt0yPZ6EemtSOT397c2Y
         CklZIAy98ogMEWnWqKsXGVZpdGS+PUFXnGGkfEqwp5At3WaqoRZNGPzI1DwHBXj8+qiK
         81LDnjAtDDXeqwETttAgi5Wvnp/5eabgAPC0DgsmGB31ZCp3bsjNNdfSDCsYe2aIAb99
         6uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ob6Q0H2Q1UIKTHBSM2eFI4wZOKPIJ6fWx83Tj6pqkNo=;
        b=CTtgQTOCAnagCt4KcGcbuFgCZrimUhZeXvRf4iCpwuCzKO0sVodvoAJlDhWZtjgAX0
         +i5zGpLtISLoCjDYge/BZmdus/bRQdmWkE+mjeUxI+wsVCqFeg4HJaUFcqMP127QkoBF
         S97jaK9S0B9HWRSv3CB8AH80ojLISiZ/DYXqbFTlVxS4dL08OhYh6lk0Gi5EAuGa736/
         OM9d9WWUVY1CYLm51JpuqPumIw6Ah8YxfTQXO3+n8xwznmO0mbw5mES+d4/a+1YBpqy9
         cXC0z6ZJAyTqfkopMlydPs412qUKzSQyskxjoqjdHxJM4CSSEPG+oMHeVRTWTtpMFUf+
         DlWA==
X-Gm-Message-State: AOAM5324Aaaz4UR37qzJ0+3/EnYttJlYELeyiuQEy+KLyhA3zfCyJuZ8
        p0aTQSYl+LefF0mIShD9eOwLJKidONXiUFQTtX4=
X-Google-Smtp-Source: ABdhPJx/Pbjv2fyN8SlD3WJnnWVFClC400LRJHcc2MdtPH6sgOBW7jngCBWDQEJ+3mcpGzHiUhnCr0o/6JhCVu1hQw0=
X-Received: by 2002:a63:374c:: with SMTP id g12mr1782927pgn.35.1632950313227;
 Wed, 29 Sep 2021 14:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <YVF/Q5pA9h9S+wS9@kev-VirtualBox>
In-Reply-To: <YVF/Q5pA9h9S+wS9@kev-VirtualBox>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 29 Sep 2021 14:18:22 -0700
Message-ID: <CAADnVQ+ouHoqT4jj-BYTVC_uQkEWLnLLakUrCQzZ446J9C1vsA@mail.gmail.com>
Subject: Re: [PATCH] Trivial: docs: correct some English grammar and spelling
To:     Kev Jackson <foamdino@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 1:22 AM Kev Jackson <foamdino@gmail.com> wrote:
>
> Header DOC on include/net/xdp.h contained a few English
>  grammer and spelling errors.
>
> Signed-off-by: Kev Jackson <foamdino@gmail.com>

Pls collect the Ack and resend cc-ing bpf@vger.
Also please use [PATCH bpf-next] as the subj.
