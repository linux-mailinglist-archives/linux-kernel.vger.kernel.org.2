Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F232A368F19
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241612AbhDWIvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhDWIvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:51:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BC2C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 01:50:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u21so72804284ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 01:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tk7QHMucgsTnP0BXUwq8EqX9ImGb+FValpCAjS0aaHY=;
        b=TrRs9wDMC3sE+YeTzfwstdDIdnYxLzJypVz6votvKwnmHwZjkNnzzV7PxSwFzTx10J
         Yzxk3Tgh+i0FQZD8rqo38FD3nphBXyZSWmGhNDSua95H90+JYJjIcStbB+qRZomAN8Xl
         yDCf8yuS8SV4wQQLaC1zurSut+sx+7XznLlxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tk7QHMucgsTnP0BXUwq8EqX9ImGb+FValpCAjS0aaHY=;
        b=aZX02T7SSNr1ZQGJWdPLyKxTn1x+KOSMlkCciMd+Q1KzV5INgDgJQBiwXCQ5ADlJrs
         HQqkKxO++NyeQ1fqoN4yDOJLTHC/Z82XdMGT3YHn28f8IAbls+h9dcossI7QXy41nWsi
         aG6FQVQZtzdJi8GPy3HuKuQHea21Mp+ELr5iG8yqauxPbE52/K+Gsn7UDyaww6mZWI8x
         x41VvbFRtpTemgpIqCYTmRjFL+RLpLS1oPfUjj3qhjHgcouM80wPKLXUGnYHVu4FRFFw
         12XyiNSUfc2Pp7xMhVghjbSy6LUe8UdBAjBjP4HTfQtjFYw5STQWkJ/aNj6G2K6yLV5v
         +oyQ==
X-Gm-Message-State: AOAM530U3XTHnPPTJWcjeLCY/oboAk6iH2Goz+tkGYA8HkGkC71isOaJ
        cQ22K2jDH26oMiyFa3eMWYg8eUvo7qbXwJmi
X-Google-Smtp-Source: ABdhPJw/0MjHZo0l9xHPBagyn0uPeCBBg51eztDfN9HXapkYWD9WJVsTpiOoNZ0Kj6B5p6Cgj2/TOg==
X-Received: by 2002:a17:906:4d10:: with SMTP id r16mr2943761eju.169.1619167823718;
        Fri, 23 Apr 2021 01:50:23 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id h9sm3458298ejf.10.2021.04.23.01.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 01:50:23 -0700 (PDT)
Subject: Re: [PATCH bpf-next 0/2] Implement BPF formatted output helpers with
 bstr_printf
To:     Florent Revest <revest@chromium.org>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org
References: <20210423011517.4069221-1-revest@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8f89faf1-d7e6-ebe0-fb7d-c5b8243d140a@rasmusvillemoes.dk>
Date:   Fri, 23 Apr 2021 10:50:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210423011517.4069221-1-revest@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2021 03.15, Florent Revest wrote:
> Our formatted output helpers are currently implemented with
> snprintf-like functions which take arguments as va_list but the types
> stored in a va_list need to be known at compilation time which causes
> problems when dealing with arguments from the BPF world that are always
> u64 but considered differently depending on the format specifiers they
> are associated with at runtime.
> 
> This series replaces snprintf usages with bstr_printf calls. This lets
> us construct a binary representation of arguments in bpf_printf_prepare
> at runtime that matches an ABI that is neither arch nor compiler
> specific.
> 
> This solves a bug reported by Rasmus Villemoes that would mangle
> arguments on 32 bit machines.

That's not entirely accurate. The arguments are also mangled on x86-64,
it's just that in a few cases that goes unnoticed. That's why I
suggested you try and take your test case (which I assume had been
passing with flying colours on x86-64) and rearrange the specifiers,
arguments and expected output string so that the (morally) 32 bit
arguments end up beyond those-that-end-up-in-the-reg_save_area.

IOWs, it is the 32 bit arguments that are mangled (because they get
passed as-if they were actually 64 bits), and that applies on all
architectures; nothing to do with sizeof(long).

Rasmus
