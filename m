Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0503D7E4A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 21:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhG0TKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 15:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230136AbhG0TKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 15:10:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31A9760F9D;
        Tue, 27 Jul 2021 19:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627413011;
        bh=pbJoQXdSHk4Q/Ty1FB8ff96IEn4YhOF44MyV2EZMumQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZzN8+XtWSLhJODEygVCWzfkxTdaB4rt4VigjaMU4/0CeejHhpn8DWBi4ROZMOOvGR
         fkBhPeIAGj4aMOE/qmIcx/TgPhbrcBixYGAZVOzvpefAdZo77Bv/Smzp7hTKoVw67D
         5UyG79bBnvtb3nd5xPtCZGeD/igiMca7bPzXLcr/qpPXB5CipYbyv6+FklcxUiX5NI
         LfZ0yL5v0BbEg7JGOBPmvKHGjOC1A4JELDwtrzEzAcU7AbwSsUquv0YbnoOiU5zKwz
         8Tpgobk5OV888DTx/69hZUK37xyPFGM5d5cUCbM3UpwbO8rOdAMtkXoSXiMUVqDnWb
         VZEzc5eAtpZfA==
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org
References: <20210714091747.2814370-1-morbo@google.com>
 <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com>
 <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
 <YP+ZOx8BETgufxBS@kroah.com>
 <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com>
 <YP+ql3QFYnefR/Cf@kroah.com>
 <CAKwvOdm62a7mrLZb_eciUO-HZj7m3cjgfvtQ=EqRy9Nh0rZOPg@mail.gmail.com>
 <0fcf5740-2e0f-4da7-be58-77822df54f81@kernel.org>
 <CAKwvOdmMpLcYEKSyTavUmK-CxuR6H55ogwLQzRA1q12RuUYNNg@mail.gmail.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <aaf432cc-bb42-bfee-dfe6-ec0c4c9d87d5@kernel.org>
Date:   Tue, 27 Jul 2021 12:10:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmMpLcYEKSyTavUmK-CxuR6H55ogwLQzRA1q12RuUYNNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/2021 12:04 PM, 'Nick Desaulniers' via Clang Built Linux wrote:
> On Tue, Jul 27, 2021 at 11:32 AM Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> On 7/27/2021 10:39 AM, 'Nick Desaulniers' via Clang Built Linux wrote:
>>> Isn't -Wunused-but-set-variable enabled only for W=1 builds?
>>
>> Maybe Bill's tree does not have commit 885480b08469 ("Makefile: Move
>> -Wno-unused-but-set-variable out of GCC only block"), which disables the
>> warning for clang just like GCC for regular builds?
> 
> Looks like 885480b08469, which landed in v5.13-rc1, so that's a
> possibility.  Should that be sent to stable@ so that we don't observe
> these warnings for non-W=1 builds of stable branches with newer
> versions of clang?

It is already in all supported stable versions.

Cheers,
Nathan
