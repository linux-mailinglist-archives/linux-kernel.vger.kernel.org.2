Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB31F357658
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhDGUxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:53:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:44825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231239AbhDGUxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617828779;
        bh=cby4+7+PyImwBvHAF/3lP1NyMJ5/pRmNjBb55SurJy8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jdPOF9hqiM9ZwkMWZ0WLp/ie5hsjiKEXY2YVMqIZ8r8P2IxhJdhIbXHg2sFB51gyx
         cO76xJlW9ZflMQpX9t6x811SdtjzklwTwuE0Izu2ohdTUEBh6R4QV5LiiePz12dfvJ
         UKDCIxREGbV3rhWMJ6ux6BUtCwFoHMSL7FLg6HG8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.167.102]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw7V-1luXEG0YL5-00j1HY; Wed, 07
 Apr 2021 22:52:59 +0200
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.12-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Gao Xiang <hsiangkao@redhat.com>,
        Wan Jiabing <wanjiabing@vivo.com>
References: <YG12tezhGsQ5R/lG@ls3530>
 <CAHk-=wjmtbLVB4RYfmjSbYXTxiOsEsXzkkpShRN4NZpe2cAVTQ@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
Message-ID: <05b0acff-922b-291d-457d-e86bc86a7f72@gmx.de>
Date:   Wed, 7 Apr 2021 22:52:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjmtbLVB4RYfmjSbYXTxiOsEsXzkkpShRN4NZpe2cAVTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qOg1tCModRqB37ShUiEMTu+mEo/YAP2vnqje6q5apH0Gv49Frye
 HyKxJHFKsKUIZBtFuBBx0/8nD+AMa+FVZ988bJhuveVK3LUpQJGfjCcgiKfsHktcnWkFTl3
 ySSzPVE02vmvHdqHDwlvj2bKgPBThpt4kY8zFz1T5n/yF8m5R+VIv+E/pUxnol2miorh0qj
 eo3HNN6KLr61K2M8SteXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lAGtXh/LF2o=:NZYaYA/vQXwvaF52LKUtns
 cWB5mBKkTRZr89fJ+3FReFTmLt8kBExdcjYxdHOH1XVN90crkSrsKmgBFXPzppMSwqlIqR8l2
 ebCJeZnT4ZFdsY5EfZXLF0eUkPr+sUHEXjyyi85/eG7KWNORqjisQ1Yk4sXjRERqsHSw4ggiQ
 fRk6581xTPEdPwIAsVMSe3vcy+mRqsi8JxdNq3b+Cj7iyowq8EEEx9MbfLRxJb94kZcgxihQq
 zRchS9UkEy3ofStZurFHyQUN3Lt48H0tV1tEPKxL/v61wDanwX1ekmMk2R5YIWiGIEnl1IHjq
 XiuLummQHZXXQ9MzxkYf5rQcaacGovxMHJnLN2dtKczOJrvb+27y6IFKBT7R+Rk1a1+dxYq97
 a2AFinbktL0b3d+2zq7IccDHXxEUbF+1T1wqtrf6PGZI9hNkN+vQ+Mi89lx7DOQXsWTw+8hLM
 vkV5wh7J86TYsDWJlcYxlR54F1+CyWWaM0n8eVSVoWw3Psy4v4AtIqTFufru3b96yLfzLUwe3
 j9UbhR5KXZ5D7RFzhQAXFD5x9WPbv5uRH9HLyVZ2CKH8BIWtcCd48lZPx4MXSQcP17t08YOHC
 3lcXpza5xxEsTgZjE5IprG4AzpZwDfyyTnRBzEIdAqH5BYix1VjAvbv9NeSBM8i6I/Q469WXh
 +QWPmJWa7bA9Z0P8p0vyZDA4ZMnP9LXnkvFqmoZ4qf3AoXeeDX50QvLMJZnccMsDFbrpE9aKv
 XRbqzFkbBVZQhy8wA5poTLAew8jrjhlGXHzQOwV9fTsypEcUyn1HTZFbDbIIf0l38VdaZJlro
 hAjjjzB1za1OaVvwXywROMecc4rt8QONB+BYcy0jiU6s6yTsqHUtiHanigpkN68vcWnOgupM8
 e6pviDLeJX0iIIC4Dc3un/e7V0THz7c0sr/v292kLgMQUWVpNi0ZMo6kHVKASK5JAvOdjYeCC
 Ti9NHTEswzh7QeUjKjb8xNSwJtx36TwtGQaLXRNz5UvudeGPwlrayzwzF7KYpG8hTD2jPPyrm
 0rqR+HZU2MxDMa9x7HSw1y6BXFAjLo+CIZznnLjjoe/RqGrFcENq25DuN8MYD6Qi/bW1lXr+n
 zrbui7dQrLkkeRjZoay2jnCElyu5dc1yexttJa+vk5MGrZf60og74iCiNvAIv461TbcwGj7cW
 Aqp11z20sOz91bL/ZPb/21g0e0l4Yi2dMa4nu54R6AsaNSXw972kvlt9YFZH2cZWn04s0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/21 6:26 PM, Linus Torvalds wrote:
> On Wed, Apr 7, 2021 at 2:09 AM Helge Deller <deller@gmx.de> wrote:
>>
>>    http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.g=
it parisc-5.12-3
>
> Not technically related to this pull (which I just did), but doing the
> pull did remind me that you're one of the people who don't use signed
> tags for pull requests.

Ok.

> I don't require that for kernel.org accounts, and it's not really a
> problem, but I do encourage it.  So I thought I'd just mention it in
> case it would be something you'd be willing to do..

Thanks for the reminder and sure, I'll sign my next tags as well.

Helge
