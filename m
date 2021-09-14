Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FA640A1DF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 02:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbhINAZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 20:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbhINAZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 20:25:47 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A28CC061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 17:24:30 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id o11so12896328ljp.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 17:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ilht7yuGeza7KxnmHTP+E2966EzjBhfJp58VMsQTPTY=;
        b=OyWldn4cRJVLyXq6LgbpKqWBqxTaQjehON/ag/GIf4HbIUXBoHl9V8OzGKT2Ylw04i
         uUG63w1xUjKTcrlLMVBNRKtBukGdfVoxMaymciw4pdsgxR1SflagLJb66lTfifVfnZuV
         nGyWGAvhm/vMudecgclcQqVLBtG8dwi+c08xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ilht7yuGeza7KxnmHTP+E2966EzjBhfJp58VMsQTPTY=;
        b=hdbNicYHzpMga064peFNV6iAXa6fpkLAbAdXw2a1QBRIby9jH/jTEzFKbMh9teKuLk
         ZoV6Ma/MZd31bcc7JpMsAQWCS4AQuIfoUAHaqnYNcCeUukxfCIivg0qHbPXimRe1kjsd
         tdYC2VsJxt1B76E96hqXXcdMlSQ2IGB/LFZtrnxtqnwhmm0C0hkVm6wK6QQ14FBSbd/D
         rgnv6kCgWJr8VTe1jphFtjAtCIsAAcj/39EG8sGKTHDiPEuLuFWYZnnHsg+FGuqdhFIy
         SKwnDQy/6mz8EOTIUHqeR7XzghxbQv5TXhh5tDGMar0vYIVRVu7qen2/tC5omhH9SBdh
         bAxA==
X-Gm-Message-State: AOAM530GU5gbXdDDE/mcD7VNA76okyYTBirKBu0bKEwFrGKIYSAI5tms
        Qm3csc9+SjDJSELlQKAIJ6EIeM79zKOWtyDjQgc=
X-Google-Smtp-Source: ABdhPJxdMw4n2hGmYoVYVOnBMK0LwDziqkoczMeRO/jyefITtndu7QUfxi+J6HZagWDQ7EegR2LBOQ==
X-Received: by 2002:a2e:a4d1:: with SMTP id p17mr12585761ljm.82.1631579068306;
        Mon, 13 Sep 2021 17:24:28 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id f9sm397212lfp.273.2021.09.13.17.24.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 17:24:27 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id x27so24769057lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 17:24:27 -0700 (PDT)
X-Received: by 2002:a05:6512:94e:: with SMTP id u14mr5107509lft.173.1631579067472;
 Mon, 13 Sep 2021 17:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210914100853.3f502bc9@canb.auug.org.au> <CAHk-=whOv-LZKxBqQr8yzmhi7sN4zoFG7t8ALNx+2XFhXjGTpA@mail.gmail.com>
In-Reply-To: <CAHk-=whOv-LZKxBqQr8yzmhi7sN4zoFG7t8ALNx+2XFhXjGTpA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Sep 2021 17:24:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGuEkYmQcJx8WfZ7MFhbKGJDcA6NUZWtrnM6Y6xFqATw@mail.gmail.com>
Message-ID: <CAHk-=whGuEkYmQcJx8WfZ7MFhbKGJDcA6NUZWtrnM6Y6xFqATw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the origin tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 5:19 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> What version of gcc is this? Are you maybe on gcc-4.9 and we just
> didn't check that properly?

Hmm. That version check works for me (tested by just arbitrarily
making min-tool-version return version 15 for gcc ;)

So you got far enough that I don't believe you have gcc-4.

I have no idea why it then complains about removal of the GCC4 macros.

Can somebody hit me with the clue-bat?

            Linus
