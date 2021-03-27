Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BAA34B427
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 04:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhC0Dv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 23:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhC0Dvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 23:51:48 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4481C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 20:51:48 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 32so5902816pgm.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 20:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=rNJlO4/q80kk+PEPtW5ue8B+S2Qcu1i/6aKbO8a3aoI=;
        b=CH6fUfiTDrd45jiVSE2pqtY1dPgorrmxOKFozpl+9xYe99WdFCj38RZVXhRJXw0wa9
         WfEZomwuJjBXkJAazOeA8RfJWP9Mkj33tHhit5HCLlbJD4HDeDOVzqNmzfquxNqX7ebt
         NxXeZH6v0dF2iGDr4Ta9k84mxqSwCtuVuAmqz5VcgzT5RBZCI0MimPBdrCVRYwI/BLEB
         XUBz7KbVHXo2+I8SYbN3jOal9ZC5ccIVFhH10VLjnHvZZ+R6ZYfmgRBwQqSu7yiZpZAj
         CmtZFmCHwT25IvNZ4jI0cXPKEGNTRfVM597At0Vhuc+j1PxS2ugjfpun1ShJiOxuUEwz
         +Dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rNJlO4/q80kk+PEPtW5ue8B+S2Qcu1i/6aKbO8a3aoI=;
        b=g/QKLuyZ6ocw2icZBqpkRgYysC1qFMy+lTdptR4ecs1iSWu9lZxb/rCyOQHwNZEk1+
         YCtAlpe90QrUPxGQJNVKOUpf73PAlYnM38R6LPqg53hf5n7L/KhyBYbCs+cC6kQOmQyV
         veJOD4dmk0keLROjuXFCVZVoje/i+Ce3wvnxr/BD1ybfHIj10i7mSf8T06yc4LVLeWYP
         xNmU3oJOmmOQ5ZZwEdd+IYwy7wLHN/9MIEp4A7htmN4i8OzX7DjI0gxWxe3IS18NL+eB
         P06oakA3hx7EJ6qRF5CLm+yNuVTvTwo/oyDD8+zXu8WHXKujPYdSIcVwA/iK9YtviQLV
         TVkA==
X-Gm-Message-State: AOAM5330WioPNhXft9lgv4d/1Um3/EylMKEq2R1TbRlasOe3WgeoXxGu
        kiAah1imXxDJNlcRcYBXrG45bTgzNoJyNw==
X-Google-Smtp-Source: ABdhPJzm/Y3qnTMikdaVkilW5KzFcgHCYwmu/Me/waHh8TjK+gBriDLdT7fhASd/fHwv5+FReEabEw==
X-Received: by 2002:a63:4d0:: with SMTP id 199mr15356957pge.304.1616817108311;
        Fri, 26 Mar 2021 20:51:48 -0700 (PDT)
Received: from ?IPv6:2601:648:c100:2aa0:a0f4:2914:dbfc:d1e3? ([2601:648:c100:2aa0:a0f4:2914:dbfc:d1e3])
        by smtp.gmail.com with ESMTPSA id 143sm10628276pfx.144.2021.03.26.20.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 20:51:47 -0700 (PDT)
Subject: Re: arch/x86/kvm/hyperv.c failing to compile: frame size of 1048
 bytes is larger than 1024 bytes
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <5932e10b-b890-c48a-3ab6-abe93ef97721@gmail.com>
 <922ee155-7b28-5098-ac64-d4d1430684cf@infradead.org>
From:   Logan Devine <bbhclinux@gmail.com>
Message-ID: <411654af-6e36-d5b3-e38b-f7f5681d6711@gmail.com>
Date:   Fri, 26 Mar 2021 20:51:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <922ee155-7b28-5098-ac64-d4d1430684cf@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you!
