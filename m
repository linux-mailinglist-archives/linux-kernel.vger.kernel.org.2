Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B7C4425F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 04:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhKBDRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 23:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhKBDRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 23:17:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0E9C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 20:14:44 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id m14so18008717edd.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 20:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHkSeemGPSvNiCh0s45k04F2zwQ0kuwkYVmbYsHMt8o=;
        b=EgiznZQNFI7r6O00KTXk7Ec0KBjB5MD7j7Q7Vt8ty3OZq0TTmFpp0STErNyzw6TOMv
         4FY+oJFrfNjh6hAiVr0WDZATY6EONr3+qDov4y/RR2USrRSzJWbQmy9hcdgE0NjhXtTt
         CgDTNcSNzmODBrlinMP9n3Z9uFViS/4oL5qjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHkSeemGPSvNiCh0s45k04F2zwQ0kuwkYVmbYsHMt8o=;
        b=tkm7YVrEYLrvILq8yr++QH3l3qXC3L1nYiAF9AHh3zu5X1y2Y8l/os35NfhO6CMejP
         dMb4SWbjDNu+doqVJ38vnaJwhreJfH2FPxiqazRbsoDUtKmZBUN4RRfkG/aWuB0I7+j4
         HE8MUwnkQwPJxhOq9ZvqakV04UhvSvOunvEg7ktVW0RoKP3ZakmkZveo2faPneXoUrcC
         NrYir4KJBDjznY8Bzd7cHzTZikGBij4O0/mLynAFNXdamQxF3E5r6EldGCXbCp41UwO4
         /uigA9AQ/A3Oc8OCZMcsesDkPO/i+tmjTFaKIMoOYA5MTdDuXWZMvsmrBHHYc123njpu
         WpOg==
X-Gm-Message-State: AOAM531ayV1JqtXK0SxfBstcl+8dEpoHTyFi6MAWDKixf4eyVA9nHKMZ
        P3y4t7PRj5GuK4seMPdofkMqE9cD7rdpKRlfBMo=
X-Google-Smtp-Source: ABdhPJz8VGqalF5HQPNThahWo6/MdqkHzADEaaH9xXAgFAupQuZPesHOctnfyPYwS7ZcTbJ43ZAP4A==
X-Received: by 2002:a17:907:6eaa:: with SMTP id sh42mr33455574ejc.556.1635822882527;
        Mon, 01 Nov 2021 20:14:42 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id w18sm10341661edc.4.2021.11.01.20.14.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 20:14:42 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id z20so71293427edc.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 20:14:42 -0700 (PDT)
X-Received: by 2002:a19:ad0c:: with SMTP id t12mr31485660lfc.173.1635822526470;
 Mon, 01 Nov 2021 20:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211101175544.00fc0d57@gandalf.local.home>
In-Reply-To: <20211101175544.00fc0d57@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 20:08:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgY1B0Ae+gVNP0e2bZPSBgaDJPwSVXFOx5r-dGgurJuvQ@mail.gmail.com>
Message-ID: <CAHk-=wgY1B0Ae+gVNP0e2bZPSBgaDJPwSVXFOx5r-dGgurJuvQ@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for 5.16
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Carles Pey <carles.pey@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Song Liu <songliubraving@fb.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Weizhao Ouyang <o451686892@gmail.com>,
        chongjiapeng <jiapeng.chong@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>,
        =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 2:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Also, this pull request will conflict with your tree against a fix I had
> for trace recursions. I did the conflict resolution and pushed it to my
> ftrace/conflicts branch if you want to reference it.

In the meantime, my tree had grown a few more conflicts elsewhere, but
it all looked fairly straightforward.

It might be a good idea if you were to double-check that everything
looks good, though.

                    Linus
