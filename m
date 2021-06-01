Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA67C396AF2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 04:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhFACUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 22:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhFACUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 22:20:18 -0400
X-Greylist: delayed 397 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 May 2021 19:18:38 PDT
Received: from hurricane.the-brannons.com (hurricane.the-brannons.com [IPv6:2602:ff06:725:1:20::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCC7C061574;
        Mon, 31 May 2021 19:18:37 -0700 (PDT)
Received: from localhost (<unknown> [2602:3f:e0f9:dc00::2])
        by hurricane.the-brannons.com (OpenSMTPD) with ESMTPSA id 9d9c450c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 31 May 2021 19:11:57 -0700 (PDT)
From:   Chris Brannon <chris@the-brannons.com>
To:     Didier Spaier <didier@slint.fr>
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        speakup@linux-speakup.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: docs: Convert the Speakup guide to rst
References: <20210531215737.8431-1-igormtorrente@gmail.com>
        <20210531220754.h4ep2dj65wl6hejf@begin>
        <393c2df8-9cb1-f428-5629-6e98c078c24f@slint.fr>
Date:   Mon, 31 May 2021 19:11:56 -0700
In-Reply-To: <393c2df8-9cb1-f428-5629-6e98c078c24f@slint.fr> (Didier Spaier's
        message of "Tue, 1 Jun 2021 00:42:22 +0200")
Message-ID: <875yyygwpf.fsf@the-brannons.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Didier Spaier <didier@slint.fr> writes:

>> Mmm, I'm unsure how the result is readable with the speakup screen
>> reader itself. I have attached the result, could people on the speakup
>> mailing list check how well it goes? If it significantly degrades
>> readability, we'll have to reject the move to rst formatting, since in
>> the end it's people who use the speakup screen reader who need to be
>> able to read this document.
>> Samuel
>
> Can we not have two versions? I don't have Sphinx installed (used to format
> https://www.kernel.org/doc/html/latest/index.html) but converted
> speakup.rst to
> html5 using rst2html5.py and indeed the output is way better looking
> and easier
> to navigate than the txt version.

RST is ok with Speakup et al, both in source form and when converted to HTML
and rendered in a console browser.

> Is it still true? PS I widely prefer the asciidoc/asciidoctor format
> than rst,
> but the choice has been done for the Linux Kernel documentation, I know...

I knew you were a man of impeccably good taste, Didier, and this
confirms it.  From a technical standpoint, asciidoc is meant as a
readable plain-text representation of docbook, so it is easily
convertable to the formats supported by docbook.  But the kernel has
settled on RST.  Speakup docs should use whatever the rest of the kernel
docs are using, and I see no compelling reason why they cannot.

-- 
Chris Brannon
Founder: Blind and Low Vision Unix Users Group (https://blvuug.org/).
Personal website: (https://the-brannons.com/)
Chat: IRC: teiresias on libera.chat and OFTC, XMPP: chris@chat.number89.net
