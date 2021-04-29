Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C6936E9D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 13:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhD2LzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 07:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhD2LzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 07:55:06 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DCDC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 04:54:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id n25so6097272edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 04:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CMvMuvuTciwDVZ/KzrxH2STYwNF49iaFIcUSnZPNLNM=;
        b=B1lx1G+D97mH3O/bJGl1kifKvvXiQkqY5I5rt08F+TibDHUgyENDGydn612v0aZts3
         OIt0KszPHCnDQNGJtD+O2s1fo2uZNjh/MylNBSQQEljeFWHeUlKImoA2zN9E9HFiqOVJ
         /avO3sxfTShFdww/uuUT5nObnM5ChOMzqY69M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CMvMuvuTciwDVZ/KzrxH2STYwNF49iaFIcUSnZPNLNM=;
        b=g+VkWYApnsgtPIzwCBIHRPY2oMiNV3mee+oJsSDmcNJ4CWKEv8zVgMEm7VPj4BAuIY
         /ilcxhyMU3/R0nk3DiDg/JOkGEWIsq1ZIfy6fmBtC6zENSgofdcIRESjN3V/EcTBG3nV
         9spaPHHmkGPfDa2uA/+sZDhmr6Skoq4Z07ux8WMacwUi2gmvBGL4o+lbt2sJUmMhKtyr
         YJ4uB7NO971DNv+CqMamoIZYukDdAybYKboiOK8PJM0LwFzbuocIwaw7N+PXrc6LeeQu
         s9AhEuBI8UfhX2+jCW9XE3oUYvBDgqYH6U5uSc4quPQzPX1Qg9gyXTqbKyN9596n7ACx
         OUUQ==
X-Gm-Message-State: AOAM533ZYDlluR0n66mbW5FoZGvTRYr+whSDU/kX3+669yqP8t5DQZsV
        KV4H8TZD4iq0Hmg8QHlFqWm7qA==
X-Google-Smtp-Source: ABdhPJyM9DYB+I3qcNbhmorquqVoVO3QWr2FOME2k2Bh2iPq4F1ObVAnvS7bQBpH9KJailsurRzV3A==
X-Received: by 2002:aa7:c454:: with SMTP id n20mr18114477edr.138.1619697258625;
        Thu, 29 Apr 2021 04:54:18 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id w19sm2117948edd.52.2021.04.29.04.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 04:54:18 -0700 (PDT)
Subject: Re: RFC: collection of common distro configs?
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>
References: <a7fac800-02ae-62d4-00d4-770facff4a7c@rasmusvillemoes.dk>
 <YIqW5a2DTsw7uc9O@kroah.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <69c626ba-4c50-9414-6ed4-51eaf04457df@rasmusvillemoes.dk>
Date:   Thu, 29 Apr 2021 13:54:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YIqW5a2DTsw7uc9O@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2021 13.22, Greg Kroah-Hartman wrote:
> On Thu, Apr 29, 2021 at 12:26:54PM +0200, Rasmus Villemoes wrote:
>> Hi there,
>>
>> Does anybody know of a place where one can find a collection of .configs
>> from various distros? I think it might be useful to be able to grep
>> around to see what features are actually enabled by which distros.
>>
>> Based on the domain name, I hoped linuxconfig.org would be such a place,
>> if so I cannot find it.
>>
>> If no such collection exists, do others agree it might be useful? If so,
>> I'll be happy to throw up a repo somewhere and start collecting them.
> 
> It will change on a monthly basis, is this really all that useful?  Who
> will keep it up to date?
> 
> What are you trying to determine?

Concretely, I wanted to know if any distro has CONFIG_UEVENT_HELPER_PATH
set to something other than the empty string (if they have
CONFIG_UEVENT_HELPER at all). There are some in-tree _defconfigs with
that, but that doesn't say a whole lot, nobody knows if anybody use
those defconfigs.

But it's something I've wanted to use on other occasions before, and I
see from Arnd's reply that I'm not alone.

It's not about which distros enable some random rtc driver - it's for
the more generic, high-level config options it would be useful. Stack
protector and other hardening things. Is tracing enabled? How about
dynamic_debug, anybody (not) using that? Or legacy config options, can
we remove CONFIG_USELIB and be done with it?

For the same reason, I wouldn't need a new copy of /boot/config-`uname
-r` every time a distro updates to the next -stable tag, the configs are
very likely to be the same for all practical purposes.

As for maintaining it: I'm not going to actively hunt down .configs from
various distros - if that was easy, I wouldn't have asked here in the
first place. I was hoping for crowd-sourcing it; create a github repo
with a README laying out the directory structure and hope kernel devs
would send me the .config they have on their machine in the form of a PR
(or just an email with the info I'd need). It's very likely I'm naive.
But at least I'm not alone in wishing such a thing existed.

Rasmus
