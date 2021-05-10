Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D213B378126
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhEJKWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhEJKWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:22:07 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FEFC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:21:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u13so18070104edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gRUkuXLvOd629w4Wa3qbU1BWVXD7weS5ofld23M/oV8=;
        b=GNb4LYCp3rtxfKdKb0K6j/ySzrtNwKjW1EHUdfz4kWJOE/umuFGfZLd752/SD3PDP7
         UDPVey96cU/hMHDtiUPQjqyQjnlfssVNeZQipN+cH2fIfWOlDrOMyrqlMJCe0+8yNUjt
         gNKzLNj2AMicDbuvFfBkEaMpHBrqABLIpDj20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gRUkuXLvOd629w4Wa3qbU1BWVXD7weS5ofld23M/oV8=;
        b=KvdW6iKFeDmXfbEFQb1s7QtmzC/8rJk3s+J1fLmUMmIw0IP2FQMLc6Hb0NHg7S1DsP
         VjSOQjzwgHL0cjCWeYm6OOWJmq5KUdUwhMh1/tEqSFQjMkpAfF0f3BnaqXnmtAyKzJNK
         /eaLvKRJUnwiTkj5io2qabvFu9zYA9qYXrbv36uU4svaJlnG+XMN2qm3db8olpiGbN/k
         YgreNE8BcXcpvv/tjleJjjrP1eicG0Go8mdMBbAvStbxb/0fGWvzTpeT0KiVpOupL4wC
         pmf8/cWox4I4iB/zBGhGCLu+oSkv7N9ixAF20cKjFVZFevkMDq5MxKQuAxyiJVWMI6AD
         dMcA==
X-Gm-Message-State: AOAM5308NM05NkmWJnoxuAcQVQr5zqWUBlpzjk0FjTm07HmSnO9Ja4qu
        WSTe5+5o2RjU18yqf+spTHCNWI2UTHg4FKlI
X-Google-Smtp-Source: ABdhPJxeFyFb+ZTVNxW2gxjFPEe2ruMF4COjrzjEdL03Vb9LcgJmU9AacKf6Mphif45FXxU83024BA==
X-Received: by 2002:aa7:d702:: with SMTP id t2mr28111661edq.367.1620642061055;
        Mon, 10 May 2021 03:21:01 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id c8sm10927965edy.63.2021.05.10.03.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 03:21:00 -0700 (PDT)
Subject: Re: [PATCH] docs: admin-guide: update description for kernel.modprobe
 sysctl
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210420125324.1246826-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <50761eeb-6592-ba5c-e86b-ba3efe3233ff@rasmusvillemoes.dk>
Date:   Mon, 10 May 2021 12:20:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210420125324.1246826-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2021 14.53, Rasmus Villemoes wrote:
> When I added CONFIG_MODPROBE_PATH, I neglected to update
> Documentation/. It's still true that this defaults to /sbin/modprobe,
> but now via a level of indirection. So document that the kernel might
> have been built with something other than /sbin/modprobe as the
> initial value.
> 

Andrew, can I get you to pick this up? It's a follow-up to what is now
known as 17652f4240f7.

Rasmus
