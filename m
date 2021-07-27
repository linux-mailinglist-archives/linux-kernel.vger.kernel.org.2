Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0133D7DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 20:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhG0ScX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 14:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229593AbhG0ScV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 14:32:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5642460F9D;
        Tue, 27 Jul 2021 18:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627410740;
        bh=SbKJxgORSL3OHTajOsbI4rDNzTp7WUtwzo59AKVBWnY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YL3cgO4C5fn730SSD5MqaDcnknogE1r8OKuo3F/qbP39alo7tXYrsYwE+nHn+09qj
         +wybqn9Vt16lq+MvzvQMaK7StUb+9Fx+TBl96hdGTmd86QKafOt2aaJbHZzYcwtWS4
         qMIlm00118caZUQcuW26pxm1zNDjErKhX5lt4JWj56vaUPNhlkLZSKlJNjKeK8dt42
         o5qIXvzt0AsbUrRCDqYo1r2jSokrHdIgL+hw9PQTQplWokX5mUnKh0HyvxAjs9t+40
         msk2wLXPYHgZMyzDHwXfS+8BkhayLw9zvCfLstZ3fD2dRcW0t1tbyFAVLHGFGrrw0J
         n/tIHpIAM20bw==
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bill Wendling <morbo@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <0fcf5740-2e0f-4da7-be58-77822df54f81@kernel.org>
Date:   Tue, 27 Jul 2021 11:32:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdm62a7mrLZb_eciUO-HZj7m3cjgfvtQ=EqRy9Nh0rZOPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/2021 10:39 AM, 'Nick Desaulniers' via Clang Built Linux wrote:
> Isn't -Wunused-but-set-variable enabled only for W=1 builds?

Maybe Bill's tree does not have commit 885480b08469 ("Makefile: Move 
-Wno-unused-but-set-variable out of GCC only block"), which disables the 
warning for clang just like GCC for regular builds?

Cheers,
Nathan
