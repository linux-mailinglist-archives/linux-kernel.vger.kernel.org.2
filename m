Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCBC405BF9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 19:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbhIIR0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 13:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbhIIR0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 13:26:23 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0817FC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 10:25:14 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id a1so2696810ilj.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 10:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0un4/60Gj05d+kHoBDgmW4IHxdsZHIV9Vx9mcGsklAc=;
        b=UVqGn4ZTeb13nU+3U0dDTxJH3VYY8O7O86ATgWu5m16rdB/mZQH1ZFSctkjlPOjyt6
         KmwFIjdWnzpkvbDh6PpuC7VSUgE0WLZn+nssDswbfdc4EX/S9xVvkxHenr7wWJ1Pj8MG
         bFm81YSA9Emzl5r+h41yHaruJEoocol4VUCKi7SYo0BFcb1TOqQ+AAXGTKzc1wYS84CY
         m9S72tZGsMadpMoskCnOCbMqlNaAYBX2arQiqh/5GzgpZvSsCk1thOTmBsxp0X2I7dfE
         hr7Jzxw51nAc87BtYg2UAwjFxf3DPAi9TUbMDW4l/xCLilXPIJVADDSeQYfKBCMi7n/1
         9j8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0un4/60Gj05d+kHoBDgmW4IHxdsZHIV9Vx9mcGsklAc=;
        b=m/9Of8DQ2wisxukVlxBMFqaBZCkJ1+oHn+pCqDhEnVKLh/shielPb9xMqy6JG1DPPS
         gJ/EmOnNFEmZ/VFnoBhRy5IXUgUpzHqAF6HRkPS2xwnfl6YG2vb43rmQWvHFAF6wj067
         DTAKmSHAeWoeCz3sNhXr+OdtPKT8ocCbyaRuOjluIEHKALmdg9bU/KqO5Z+vohciXqQf
         azhBxlJIRkqtOa8X+S6EjcNj/wglHGNkvN/Ln5Ep9TTetw3ZPmkrttsX59oKkf/xCeGg
         57X27TpZ7tPWWVFSVPsjUxhspBdZ9BqMg7KvDPjLXtucId+jXMvo4u4F59DnBeunqEj1
         feyQ==
X-Gm-Message-State: AOAM533ZbgBqadrHP7D4285WG2rNOpLWYTUsCYvEBedohxNV3xqJ9v5q
        aA/3ad+NNdnzKlzpTSpNoV0M9w==
X-Google-Smtp-Source: ABdhPJxLzZHByioJFNX19U8HFOCWCb0ZNfky7m6fN0DmywQhM+PAgQMHesk0jQcYBLuzh2z9eMd+UA==
X-Received: by 2002:a92:d3c1:: with SMTP id c1mr3243899ilh.194.1631208313483;
        Thu, 09 Sep 2021 10:25:13 -0700 (PDT)
Received: from [192.168.183.254] ([172.58.142.211])
        by smtp.gmail.com with ESMTPSA id y11sm1154258iol.49.2021.09.09.10.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 10:25:12 -0700 (PDT)
Subject: Re: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>, j-core@j-core.org
References: <20210627220544.8757-1-rdunlap@infradead.org>
 <2bae95d0-0932-847c-c105-a333e9956dff@infradead.org>
 <f63694aa-85b3-0238-5228-eb35a52bf360@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <22a4cacd-0b75-b52c-2ae5-d8f0c5dd2f7e@landley.net>
Date:   Thu, 9 Sep 2021 12:44:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f63694aa-85b3-0238-5228-eb35a52bf360@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/21 3:25 AM, John Paul Adrian Glaubitz wrote:
> Hi Randy!
> 
> On 9/8/21 22:19, Randy Dunlap wrote:
>> What is the status of arch/sh/ in general and
>> of these patches in particular?
> 
> I've also been trying to reach out to Yoshinori and Rich. I know that Yoshinori is
> currently busy with other work but he can be reached over Twitter [1]. I don't
> know about Rich though.

https://twitter.com/richfelker

(That said I believe he's on a road trip with his family this week?)

> There are quite a number of patches on the mailing list that need reviewing and
> I fear if that doesn't happen in the foreseeable future, the SH port is being
> kicked out which would be a pity given that we're still maintaining the port in
> Debian and given that there is new hardware available with the J-Core board [2].

Rich tends to miss things that go by on the list, or silently assume things will
go in through somebody else's tree. That said he responds to email and if all
else fails I have his cell phone number, so poke _me_ about it. :)

What I _don't_ have is the technical expertise to say more than "yup it compiled
and ran on qemu and/or my turtle board". (I have two other pieces of sh4
hardware and an original sh2 board, but they're in austin and I'm in chicago at
the moment, and none of them has a particularly friendly bootloader for feeding
new kernel images into.)

If you just want "it worked", I can sign off on that. If you want "is it a good
idea", that's a higher bar.

Rob
