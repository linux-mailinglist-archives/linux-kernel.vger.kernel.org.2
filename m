Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D74037584C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhEFQR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:17:57 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:40822 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbhEFQR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:17:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620317818; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ZYIXNIJQToFO+yqUROpRHa/peGqV+Jnugb7ofs9QBf4=;
 b=xZYXyxGA5B9Pg+qLrSqqGRcEZIy0GKsSHcVB5czzV07iZ6tjC9cEkxgYvnYIOV82TmUZDS0S
 IuqDIUQiISk5z2PLRZKMqd8h1hL4OmQIoDIAO6HaG4YNPex6DUbz71NIqLxMUhOC2GtpoqHn
 0TmUPJRXpsUijG694PL0LI0pQH0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60941675febcffa80f4df5a0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 06 May 2021 16:16:53
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 662F0C433F1; Thu,  6 May 2021 16:16:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88093C433D3;
        Thu,  6 May 2021 16:16:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 May 2021 11:16:51 -0500
From:   bcain@codeaurora.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hexagon <linux-hexagon@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        sidneym@codeaurora.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [GIT PULL] hexagon changes for v5.13
In-Reply-To: <CAHk-=wgU-ERpeM0CJnN8JTVVUsBRtgpvU33sKke67V6pZj6A=g@mail.gmail.com>
References: <a81e116ba3d64aab8d379703bedcf032@codeaurora.org>
 <CAHk-=wgU-ERpeM0CJnN8JTVVUsBRtgpvU33sKke67V6pZj6A=g@mail.gmail.com>
Message-ID: <81ecc015b1bd773f583cc86490e392a0@codeaurora.org>
X-Sender: bcain@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-06 11:03, Linus Torvalds wrote:
> On Wed, May 5, 2021 at 2:10 PM <bcain@codeaurora.org> wrote:
>> 
>> Please pull the following changes for Hexagon: they contain build 
>> fixes.
> 
> The pull looks fine, but I'm wondering what key you've signed this 
> with?
> 
> I find your key 175C464E541B6D47 in the kernel.org pgpkeys archive,
> but your tag was signed with RSA key 1A54AFB8E5646C32, which I don't
> find.
> 
> And the standard keyservers are - as usual - not very helpful.

I apologize -- in my initial account setup I'd done the key creation 
without a signing feature/capability.  So in order to sign the tag I 
realized I needed a new subkey for signing.  I tried broadcasting the 
new key but perhaps I did not send it correctly.  I'll try it again 
today.

http://keyserver.ubuntu.com/pks/lookup?search=bcain&fingerprint=on&op=index

^^^ this shows one that has 3d66aae474594824c88ce0f81a54afb8e5646c32 but 
I'm not quite sure if this is a good keyserver or not.

> I'd have loved to see a key I recognize, and I was hoping to also see
> that key signed by Richard Kuo. And maybe it is, but I can't find it..
> 
> Anyway, pulled, just hoping for some clarification,
> 
>                 Linus
