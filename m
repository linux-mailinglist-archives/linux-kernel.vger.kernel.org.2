Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF54455CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 14:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhKRNsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 08:48:04 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36328
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229976AbhKRNsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 08:48:03 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 87C5E409FC
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637243101;
        bh=SkABN7FSLVoCTXNwtMsVpF/6O00jmyQ1cjla8kqAH/Q=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=A6ab9N+voGfFgu2BnBMXc0ljb2ybP2N3oT8DtCAVJ4Q2JT+TccapvwjQ9As75Uf9K
         DtZc+WDe577X2znT3rDUcyUbkv24x3349VCThrGlhEwqlN5Boyb2T2udRMjd79zu2i
         o/etNws8P3VQw7SEjnlHWfYoiTw+hIVu3FIfa7xg/tcQ2swWpdr+e0GV0VKouEP4HG
         WQThmc2DR34gqw17pV5zxQGtcx462qS+Qis6p9oIiqiBrBqqSam4eatXW8gE70BUB3
         RoJpC6YjoHfr3I4xK0Y46YhfbqUhFWOuS2hzl2giMXKOxuRyyjnW3IvQO6Q3ekahAi
         FKDS5HKY/xO4w==
Received: by mail-lf1-f69.google.com with SMTP id u20-20020a056512129400b0040373ffc60bso4051657lfs.15
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 05:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SkABN7FSLVoCTXNwtMsVpF/6O00jmyQ1cjla8kqAH/Q=;
        b=wvlMFefBSD+02FeU6kooFs6dkpAztCT+zwFoEe/2cw4/LdnSY0QNRGjaICeYdOTJ81
         GwgL1MY6tyitWJZIVFU2A2zLrRxOARtHdOfJEywnxQUzzK2AQ6TjfzzK3GJkDL/6zLFX
         yN4zRBDXcSOQZlNOMuu/JU9KcZj8nYQSof2K6jYQRkOHnY//A27SVdJ7eEBNojp76+rV
         DGCH+aIX2xyxn1HdendUqKb7Q7HYNtpgBUzC757+9YRObYVwR9IbACfx3+yIPho0a3i8
         bCZXrFzd/jgSQ68ZArHqDXc1SUwpL0p9A4R561c3AuKIiAqKJqj/AHFgnyKwf6oWXqSL
         QiQQ==
X-Gm-Message-State: AOAM533FQ9SyW4QfGhb+RCoSpoTTERaE4zYQXu+o3d1fKSK0sNq2dISc
        deprB1e764B2nz2XT0mEBvKD2KgvcY7nmgh35gjm8kR+Tqlu48h6IYjl+St+GvTwIJ0srWnnli+
        nDoYVKfDMN88pGu2sDYAgwc1+sL1N3i6dFgtiRhks+w==
X-Received: by 2002:a2e:5852:: with SMTP id x18mr16682697ljd.184.1637243101047;
        Thu, 18 Nov 2021 05:45:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxp+b3XRdQRVsPuseT9rrdDR4Py0VnFvJx/IzhVQvRG8lUQZ8e6YNXcADek8vpy+yLeVubtg==
X-Received: by 2002:a2e:5852:: with SMTP id x18mr16682670ljd.184.1637243100797;
        Thu, 18 Nov 2021 05:45:00 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id e3sm316851lfc.259.2021.11.18.05.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 05:45:00 -0800 (PST)
Message-ID: <d368dd0e-b883-26a1-7f2f-47f21c5f9763@canonical.com>
Date:   Thu, 18 Nov 2021 14:44:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 1/6] riscv: dts: sifive unmatched: Name gpio lines
Content-Language: en-US
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
References: <bb7e8e36425a2c243cfbf03a23af525499268822.1637107062.git.plr.vincent@gmail.com>
 <1444ff08-24a6-afbe-1512-9ea24ad5b32d@canonical.com>
 <20211118003418.2edd1913@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211118003418.2edd1913@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2021 01:34, Vincent Pelletier wrote:
> On Wed, 17 Nov 2021 10:28:59 +0100, Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
>> On 17/11/2021 00:57, Vincent Pelletier wrote:
>>> Follow the pin descriptions given in the version 3 of the board schematics.
>>>
>>> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
>>>
>>> --
>>> Changes since v1:
>>> - Remove trailing "." on subject line.
>>> ---  
>>
>> This is not a correct changelog placement - you have to use '---' just
>> like git uses it. Just test it yourself and you will see the problem.
> 
> Indeed, thanks for catching this.
> 
> Is there a recommended way for managing these not-for-commit-message
> chunks automatically ?
> I obviously compose them by hand so far, and put them in my local git
> working copy commit messages, but I would be happier if I did not have
> to make (bad) decisions on such mechanical detail.

There is an idea of git notes (wasn't really efficient) or git branch
description for cover letter (--cover-from-description, didn't try yet).

> 
> On a related topic, is there a way to automate "git send-email"
> recipient list using get_maintainer.pl (plus some more magic lines,
> for example to exclude bouncing addresses) ?

There are few different options, so depends what do you want, e.g.:
git send-email --cc-cmd "scripts/get_maintainer.pl --no-git --no-roles
--no-rolestats" --to linux-kernel@vger.kernel.org 0*

However above does not take care about cover-letter.

> 
> While process/submitting-patches.rst describes what the result should
> look like, it feels to me that it (or another related file) could be
> more directive on what commands/workflows help to get such result, for
> casual contributors like myself. Have I missed such documentation ?

Not sure. Anyway just look at the lists at lore.kernel.org how other
people are doing it.


Best regards,
Krzysztof
