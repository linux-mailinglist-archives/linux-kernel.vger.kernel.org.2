Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256183AF16B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhFURJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhFURJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:09:39 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CFFC0611C0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:02:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h2so6422881edt.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fEkt1RTgjJoQzSaXpZ5N7EbzxOXfbeQ1+X3vmk+Uv5k=;
        b=RX0iHxjS4EwhBvgBacDGB0dBGO6saiSFQcbZCbuySz+rX9TBzFjE/kzRqvEiAi84QL
         bjvSdgaj4ZuGqylu0HB+PSn5P+BAKKkWW0YWTfsONKZ1nTYCpmABdFLRiNFG7aajD16d
         19vboB8hQkPSokTH5qywB/hbeY6Blb1PT8Mrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fEkt1RTgjJoQzSaXpZ5N7EbzxOXfbeQ1+X3vmk+Uv5k=;
        b=q+TMemmegLWw1S7UYOOqx5kTFDw2wDdkluQieEmjSIt1Fdjzm3ZfD5cA9QlC+Z4HC9
         zCFpoQjn3oB6J/CQnu4S7OrzaImz5sqivQY+iHPez99ByvMrG84GWV2craw3Eo6SqTsg
         zct5hg7K5F8NEErTSpjqWR5AE2QdOyDKmxGYbYzQUKNMa6Mxdl1qnYaCbsNMsN1UvLqW
         sR8OmmIhcqhGZadncwUyJNvsreK2x3z91NRAa9CQ2/+ZmsHs0ovyb36vk37W5pW3G884
         SrmBgPCLFZWxDUyoK/ktsQmnUHPEtJi9u+Pr6KXoZWYZiiPYkCYSy9FKeO7cXcpZjdrE
         /Big==
X-Gm-Message-State: AOAM531UT4DNZbPrNJ9EvnQA1M2SOvgbjY+9FFhNJdDAL8TKTmfOq0sI
        u6N43d4kNoSDGTAJXXz0lCPtcg==
X-Google-Smtp-Source: ABdhPJzuTySLBi0/GaCsYtsEYHojyNxIfwMjF8zLOWxnMY4egBBSgE63Bu2rWZoWTRJ2qvNiH+IS6w==
X-Received: by 2002:a05:6402:440c:: with SMTP id y12mr22975123eda.208.1624294927298;
        Mon, 21 Jun 2021 10:02:07 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id e6sm4976293ejm.35.2021.06.21.10.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 10:02:06 -0700 (PDT)
Subject: Re: [init/initramfs.c] e7cb072eb9: invoked_oom-killer:gfp_mask=0x
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20210607144419.GA23706@xsang-OptiPlex-9020>
 <d28354fd-0f72-559d-771f-fb2a80b51b05@rasmusvillemoes.dk>
 <20210611084817.GB26476@xsang-OptiPlex-9020>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f53c0e44-c0c0-8631-50c5-1c5bb549c629@rasmusvillemoes.dk>
Date:   Mon, 21 Jun 2021 19:02:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210611084817.GB26476@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2021 10.48, Oliver Sang wrote:

>>> To reproduce:
>>>
>>>         # build kernel
>>> 	cd linux
>>> 	cp config-5.12.0-11533-ge7cb072eb988 .config
>>> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
>>> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
>>> 	cd <mod-install-dir>
>>> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz

Hm, when I do this with that exact commit, config, command lines and
Ubuntu's idea of what gcc-9 is, I get a modules.cgz of 73MB,
decompressing to 215MB. But in the two dmesg captures you've sent, there
are lines

[    0.016519] RAMDISK: [mem 0x74c12000-0x7fffffff]
[    0.023424] RAMDISK: [mem 0x74c16000-0x7fffffff]

corresponding to 189MB compressed. I'm wondering why there is the huge
difference.

Artificially inflating my modules.cgz to around the same size ("cp -r
lib/modules lib/modules2; cp -r lib/modules lib/modules3;") doesn't help
reproduce, unfortunately.

Rasmus
