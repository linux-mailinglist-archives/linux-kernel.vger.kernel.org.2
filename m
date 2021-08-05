Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046953E1D15
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbhHET7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhHET7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:59:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80789C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:58:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t9so13370025lfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vEevYj21zoSQmliOP+GMeNBU1++4inbujPB40FoMVRE=;
        b=Y6sdNXACERnZgRtJfiblGNVRlF8k/of8efB8rL4qUsGwzT1eoMcbK46RBdFjsO7Xwc
         Hfv/7BQ3ZeTPsSVcChRDC7JvZFHwWjCfnij0+Vub/bgZ4OW10c3WBY1qWPx0ud0v648Z
         m00O68w2gE0PjbLMN9g03sAVgXn0Fct0sky1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vEevYj21zoSQmliOP+GMeNBU1++4inbujPB40FoMVRE=;
        b=Rp0uPb6dOIL/JvYI8jL9oP38jAjRfZNkC7ZUmP5DSSeMDq19g9bl1n3LD+DMu4sjLl
         oAKq5D39iYmizEpTUljCp1vdBKaeYgQGh1WvwYwKCKNXjgxrH3tszO3AYoYj4BpoEyJs
         ot7m6A2G/ruxfhu6ikGc7fsZygmM9dRzTFLuamV4OE4lt8lTJI/4Cr57ik8IyM3O7V1i
         +ZaAFueE+7QWj+3tRuK96L+yqmasTzQOT08as5dlzPJcjPocbdndvSvzdiBqQiX+nNDO
         a+0kkwa0cW0Xpw9odDZKOiHvPmKxOxmklprreXQ1SiHSHwS42gi5zuymhvZ93S3R6zbQ
         Sijg==
X-Gm-Message-State: AOAM532OYdFNprmp2NGfYGXkwC/iN+VZBDB688aaTYLqfbONKQgc8+O9
        dgYv2M6c4i0Tbacw77aKSVWbCi7G79po9GWvYhs=
X-Google-Smtp-Source: ABdhPJw2EiQrZypZ17p57nwBDnF4tbqA6NWLQ24JfkFpq7lSCncAxvyE3abom8myOFgBoIDBT8IGVA==
X-Received: by 2002:a05:6512:3e2a:: with SMTP id i42mr4962497lfv.427.1628193532349;
        Thu, 05 Aug 2021 12:58:52 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id f23sm539181ljn.45.2021.08.05.12.58.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 12:58:51 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id c24so10069945lfi.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:58:51 -0700 (PDT)
X-Received: by 2002:ac2:569a:: with SMTP id 26mr4868925lfr.41.1628193530897;
 Thu, 05 Aug 2021 12:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210805154335.1070064-1-kuba@kernel.org> <CAHk-=wi8ufjAUS=+gPxpDPx_tupvfPppLX03RxjWeJ1JtuDZYg@mail.gmail.com>
 <afa0b41f-bcb9-455e-4ea8-476ed880fbd2@infradead.org> <20210805123829.1f3a276f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210805123829.1f3a276f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Aug 2021 12:58:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtH6RFPUdOudOydvqnMJdORNAPb_uTHCPny115LZ2dSw@mail.gmail.com>
Message-ID: <CAHk-=wjtH6RFPUdOudOydvqnMJdORNAPb_uTHCPny115LZ2dSw@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 5.14-rc5
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 12:38 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Oops, I thought it was pan-European term, guess not.

Seems to be fairly widespread, but never heard it in Finnish or
Swedish (but google claims the concept is at least known in Denmark,
Norway and Iceland)

              Linus
