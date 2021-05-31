Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4C43969CB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 00:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhEaWu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 18:50:27 -0400
Received: from darkstar.slint.fr ([172.105.89.79]:51924 "EHLO
        darkstar.slint.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhEaWuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 18:50:25 -0400
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 May 2021 18:50:25 EDT
Received: from ici.slint.fr (men75-h08-176-172-247-100.dsl.sta.abo.bbox.fr [176.172.247.100])
        by darkstar.slint.fr (Postfix) with ESMTPSA id BF9A9A3744;
        Mon, 31 May 2021 23:42:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=slint.fr; s=default;
        t=1622497329; bh=TcYnZ6DHOSMey6JxZZJmyzwQJVc0F0o0a72UGBPvwZ0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=QlDEPWTz8nwXojKnX/mDgcRG/bHmbeDHrruLlVpmHqQvL3rRfDm8t7k8A+O4k+DtE
         kkkTYjOc5XmoDVR4LMOm19DBJj85OG+pNTIM6WUCxFZ3aQfWhHpcNcgMRRvkGioPUq
         rR6BXp8vEqabv/VUe6qaK1qUaigYDuBztf7YHODCUZH43SF+tSbBd+5LV4N44f0apc
         p/4XnL/tUFh3QMG3/a04XA6PmTPw/0jHhkPC/D2pFrQpGUTtXjiOS31ZPQ+jifVPA6
         EM9PxyTgFIPiq+pkAtCgIwClDe1C62lBkBnRQcnyurzhLvV8LK8H+F/8DNrlvJVrlu
         Q4RjvLAgyAbfg==
Subject: Re: docs: Convert the Speakup guide to rst
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        speakup@linux-speakup.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210531215737.8431-1-igormtorrente@gmail.com>
 <20210531220754.h4ep2dj65wl6hejf@begin>
From:   Didier Spaier <didier@slint.fr>
Message-ID: <393c2df8-9cb1-f428-5629-6e98c078c24f@slint.fr>
Date:   Tue, 1 Jun 2021 00:42:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210531220754.h4ep2dj65wl6hejf@begin>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 01/06/2021 00:07, Samuel Thibault wrote:
> Mmm, I'm unsure how the result is readable with the speakup screen
> reader itself. I have attached the result, could people on the speakup
> mailing list check how well it goes? If it significantly degrades
> readability, we'll have to reject the move to rst formatting, since in
> the end it's people who use the speakup screen reader who need to be
> able to read this document.
> 
> Samuel

Can we not have two versions? I don't have Sphinx installed (used to format
https://www.kernel.org/doc/html/latest/index.html) but converted 
speakup.rst to
html5 using rst2html5.py and indeed the output is way better looking and 
easier
to navigate than the txt version.

And anyway can we just provide a link to the web page that will be built
from the rst file? I think it should be accessible in graphical web 
browsers as
in console ones (I tried using links, lynx and w3m).

As an aside the document still states:
Speakup does NOT support usb connections!

Is it still true? PS I widely prefer the asciidoc/asciidoctor format 
than rst,
but the choice has been done for the Linux Kernel documentation, I know...

Didier
