Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E277D3D3251
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 05:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhGWDH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 23:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbhGWDHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 23:07:24 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCC5C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 20:47:59 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id y18so391474vsc.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 20:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ov3sTIdDgkhinUkLdbYA6eaZmI5paJMcon2JwN7yw+A=;
        b=cTqH7tH3pMk/WR/OEYVl3fGSR9Z/1xl8SYqYxSgunubwJKp31znNoY95TijGcwzmZy
         6bPmKnq+BCCM/zDfe8moixzui4Yyb7cjP4gOBXAG/rm7Ucy7FXCpOXwcneQf8sRsB/GH
         fpN6tqbnidEkcpQtfd+ecTCENIHqObKAoe5nlfqPUR6coLLs+Jzj5PtP1mV+hGn+bM/B
         tKlguWVhg+MG/vHMDMslnuKATorQZe89sUF0JpIY/iueQ9rbD7+xzD1CajYK1wJbQ/M7
         lQ7ws5mAZH/KVSIhJW9S6NkiY9ClvIf7/Qfsn/v6nZ3dy4pPQisnKX6AyjK8CtSwFQzf
         SYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ov3sTIdDgkhinUkLdbYA6eaZmI5paJMcon2JwN7yw+A=;
        b=pmHGJKT2wpjeDQ7kQuOMZ95eBzFIXeGKgIges1vL1tUmDKrDN8mT4Mr6vfUwJPC4kn
         N49b9yJTd+U1lE+XYVVTYFSLlGcVHGfsmcPFKSaQS72uw5zbmiYGKdCWlhgE84ZEUqqg
         4UV0F4Tw4Y7hWtxlkfMOXSjnyjLO0LsxkT9w0DucnFB+4FiCs3SDJjs4mu9XR6HOnOWL
         gWvX7ZMH9+oG2hwZY6TBceYrPMBZx3y2Rb0s7aXF0HKPdomN3MSXGfovlirsvbWnJ6fI
         or+VqQtdc/FIyD620DzLNRZy6et95yJucHdUjiZD98IqoF+CEKXJdB16cIvcD25iSrtM
         QFCQ==
X-Gm-Message-State: AOAM531AXwt8Ow6ARiYpqw0qmWry1eL0JW4CgNVw8HW87bKJU1Nop4p8
        3XGXtOqUav9UgQ6P5dP3kcp+K0PLpCwP6VTzZ7sIZA==
X-Google-Smtp-Source: ABdhPJxil7w/dnxpj6cyp8RC/mEq1xSXXqriheWzbE0Hd/5357y/A4K0r+Yk8Nv9FLRliSWo+b12mq1bKXz0jIGDBoI=
X-Received: by 2002:a67:fe01:: with SMTP id l1mr2937274vsr.50.1627012078016;
 Thu, 22 Jul 2021 20:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcxDJ7YsnYtyzSmgfBj-rmALkjigKx2ODB=SCYCzY8FJYg4iA@mail.gmail.com>
 <20210722151930.GA1453521@agluck-desk2.amr.corp.intel.com>
 <CAPcxDJ6bB7GEhTq9fkHuT4chRTUk_s-crci=nh+COCwAzMP8Yw@mail.gmail.com> <20210723001436.GA1460637@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20210723001436.GA1460637@agluck-desk2.amr.corp.intel.com>
From:   Jue Wang <juew@google.com>
Date:   Thu, 22 Jul 2021 20:47:46 -0700
Message-ID: <CAPcxDJ4Liv1_zASzRxdGKu7MmjRQ9inXPfhPMQdEZrEjL0U=zw@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/mce: Avoid infinite loop for copy from user recovery
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        x86 <x86@kernel.org>, "Song, Youquan" <youquan.song@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 5:14 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> I'm not aware of, nor expecting to find, places where the kernel
> tries to access user address A and hits poison, and then tries to
> access user address B (without returrning to user between access
> A and access B).
This seems a reasonablely easy scenario.

A user space app allocates a buffer of xyz KB/MB/GB.

Unfortunately the dimms are bad and multiple cache lines have
uncorrectable errors in them on different pages.

Then the user space app tries to write the content of the buffer into some
file via write(2) from the entire buffer in one go.

We have some test cases like this repros reliably with infinite MCE loop.

I believe the key here is that in the real world this will happen,
in particular the bit flips tend to be clustered physically -
same dimm row, dimm column, or same rank, same device etc.
>
> -Tony
