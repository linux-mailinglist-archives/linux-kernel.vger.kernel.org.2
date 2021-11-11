Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8989144DCDF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 22:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhKKVKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 16:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhKKVKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:10:46 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D57C061766;
        Thu, 11 Nov 2021 13:07:56 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id w1so29256652edd.10;
        Thu, 11 Nov 2021 13:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I5/QR0fHODlqbwJV7S2kEOX48nVs3lR4nWWESAR7ot8=;
        b=BACge4gwR4FjHMj+kG2cyK0l1bIwq1pBIuO96TbeV0v1aroqwuM4o8ulh/WsGrsR9o
         UgZqI4bw+rknTxhgU/qX2z/JOGeg4A1iiMba6GsseSlwJvtlpvhoLyN21YICqxgWCPXf
         5XuhgLK4aoCATpY2+Ne0fF6GzzjqgWA32BOug7lVzXwfip15ux3RNfmZ7QIuHsjZTOV0
         YoEDndBMs+3wahSmHpkgq/CL6JW+PCXjEV4aw4JLwpYCRb6THQ/im6J6FLWkaICZEsIY
         q85F9Ek5Yqbwf7fB3mXyhNlhpnMk7EkLwPv8igUyMU4UW53uEmBjQc/0JxdzpPRBLAk9
         /ZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I5/QR0fHODlqbwJV7S2kEOX48nVs3lR4nWWESAR7ot8=;
        b=qmSE6QNp6NMTiTotUZsqfxpeo/VRh/DScDmx+N3TYUBOzR8eMQWkNsUaEoZec3C0TT
         e3iYUc/wPjU++pQIRhZfSFXVoYPSNuDv5q0+8DmcIGa1Nx43BG35DqXAfpjZpC4wpplC
         rfQLfDzDwA4Na0umT2ikEgXM2dExAwv3/cCqnfKq0DIg6TsagaIWsJuvDVm/P34gbuvM
         +iGpoZzXIqhzOn1ggRPs6lz/MTSIyvGOPGBRLCfd7L8SI/SFNWEG5k9zcYfe+OIDJjKj
         uS0T5jKhU7MTW20vXp8+0ByClwKQXeJWtNlB9jlZc3cN9+/WfwrZzRz5hIbn+fjI3MB+
         sy/A==
X-Gm-Message-State: AOAM530wAYJTI4t6oIKzMzWeTyzIzsVBBhRZ1mJS5yKpJxuH36U5gfWz
        ACgbC69OtbkIoVeSxqxIaIhxCEbLVsOi2pQIIb06aX32
X-Google-Smtp-Source: ABdhPJxPQARMqHT35vc/9vUQ5/d7UgTjh+rmJjlEvmyzrZ7HxbykWPKqasxIZoRH7FEFTeB8YkjRVEspwZCrz1hcG6o=
X-Received: by 2002:a05:6402:51cc:: with SMTP id r12mr14383794edd.64.1636664875541;
 Thu, 11 Nov 2021 13:07:55 -0800 (PST)
MIME-Version: 1.0
References: <CAHifhD5V9vwJenRLcPRH5ZMeLa_JnjZKfdcFZw1CjceBtC6=Ew@mail.gmail.com>
 <CAHp75VeyQEaABFOnEUh2pdFx9ROJvRcud-BuEbKWmaEWpL9_Uw@mail.gmail.com>
 <CAHifhD7Qf7+dc7K-MjNguqmiCWUxOJZmQoCTRUZOR-RWMm_JPw@mail.gmail.com>
 <CAHp75Ve9BMNy3gP=-Dajm+Lgu+E4FCqc4phLgV1_cr2qUnTX_w@mail.gmail.com>
 <CAHifhD4n7O5eWFPOjRAmHYL52tW0K=uXXzVj7L5+enTFwFXW2A@mail.gmail.com>
 <CAArk9MP5cKJ+VhAZUseW4LnQNRvux=MZe2eSy3rQkbHKnUsGig@mail.gmail.com>
 <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
 <CAArk9MNGSxR+92n-D2pe_+r+Z0Q9FoTMPqk11sAKA=4Vckj0HQ@mail.gmail.com>
 <YYy7QZGKeEEfI1mH@lahna> <CAHifhD5bXu2nP533RXyWDnyNt=k2rRZq5Z6A6CCik_2e6XNgGA@mail.gmail.com>
 <YYzxWPIWFAV04LRU@lahna> <CAD2FfiGnmFSTPvkJaXj+cf4yDvci-j+2QkpMqNY821fUT5C=CA@mail.gmail.com>
 <CAHp75Vcp=hC1oL5FBQDDFe8EBxWB9Po4FKNS9ZGtD3q-yQPtAw@mail.gmail.com>
 <CAHifhD6p9qSm5dv1spz+oPRhRkBZeQspHNEphE49fODacm-S6g@mail.gmail.com>
 <CAHp75Vfk5WHWiQxwmqEzVEymgpvjxKWEZbaQ9+=Et7N63Ps=Ng@mail.gmail.com>
 <CAHifhD5bGZOcZFNsHYFeecikHGUts73U4k6=aUVNTKEeETW5rQ@mail.gmail.com>
 <CAHp75VeSnXfjeNeBLtrR78AmB-18kTeXpknn7-jcPLEeWCrzXQ@mail.gmail.com>
 <CAMj1kXHoRa+9gS7OEZZH2SSZQ8Tf4BUMdh-p=+OvWEb1a6ffFA@mail.gmail.com> <CAHp75VckB0RA6zoLRQ2UOcQRgMEf6sNxDGfpsNVr+92eArhD=Q@mail.gmail.com>
In-Reply-To: <CAHp75VckB0RA6zoLRQ2UOcQRgMEf6sNxDGfpsNVr+92eArhD=Q@mail.gmail.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Thu, 11 Nov 2021 21:07:42 +0000
Message-ID: <CAD2FfiH9OcKyUo6xjTfSENrEKF=4kZiGU4rT0FriK6KgKYSzyw@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2021 at 15:50, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> I was thinking about SHA256 hashes or so (as they tell about
> binaries). In any case the interface for this seems to be in the
> kernel.

I'm quite sure you don't want to put those EFI format decoders in the
kernel; there is all kinds of weird compression schemes, volumes are
recursive, and vendors like to hide weird things in the undocumented
(or reserved) areas.

Richard.
