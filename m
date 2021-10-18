Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE18B431274
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhJRIuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:50:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230006AbhJRIuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:50:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE5A360F02;
        Mon, 18 Oct 2021 08:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634546908;
        bh=2dm5Ijkya2CLkLIjx7kqKKuqwSeDj7YfNf+Ugr1sE1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p7cH8MGOxXrNNxRHyjfVe+rapoMxiG3DPUJ4YzFKPAIw4ycAhKbERTmMmbr9XuE92
         eg5URdlYKJx1cvZ2ZWdjXia2KjHny/bLmI9pfeDRA1BQLG5ZXBghp8Bx1jvqGoszN9
         iCJZtZ+YkPcw2c1S+ize4sIzjtFqlpyYOrT8M4R8=
Date:   Mon, 18 Oct 2021 10:48:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     FMDF <fmdefrancesco@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: Any tracing mechanism can track the executed instructions of a
 user process in the kernel?
Message-ID: <YW002dG2NebAMNlf@kroah.com>
References: <CAD-N9QWd6Orm8d9AMk7mybByAKZod=GJ-HSNPOfhFDStSPwSUA@mail.gmail.com>
 <CAPj211vRdmJZBQvM-DE+saiY=LwoQdOu0hV-YFcny6worQ46rg@mail.gmail.com>
 <CAD-N9QW0NEi6Jzh-bu0Bb=RFB6405G28t_jtctk_t8Kw+HUpVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD-N9QW0NEi6Jzh-bu0Bb=RFB6405G28t_jtctk_t8Kw+HUpVQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 04:41:14PM +0800, Dongliang Mu wrote:
> On Mon, Oct 18, 2021 at 4:07 PM FMDF <fmdefrancesco@gmail.com> wrote:
> >
> > On Mon, 18 Oct 2021, 04:46 Dongliang Mu, <mudongliangabcd@gmail.com> wrote:
> >>
> >> Hi all,
> >>
> >> I am writing to kindly ask one question: is there any tracing
> >> mechanism in Linux kernel that can trace all the executed instructions
> >> of a user process? If this user process is run on different
> >> processors, traces of this process on different processors should be
> >> also recorded.
> >
> >
> > You've not explained in detail what is the purpose of the tracing that you want to do. Missing this information I can only provide you a list of links to various tools and methods. Take a look by yourself and try to figure out what is better suited for your needs...
> 
> I want to log all the executed instructions of a user process (e.g.,
> poc.c in syzkaller) in the kernel mode and then would like to leverage
> backward analysis to capture the root cause of kernel panic/crash.
> 
> Therefore, I need the instruction-level tracing mechanisms or tools.

Then use a userspace debugger like gdb, that is what they are designed
for.

good luck!

greg k-h
