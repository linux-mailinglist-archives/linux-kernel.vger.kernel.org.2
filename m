Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313B1460544
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 09:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242891AbhK1ITt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 03:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356945AbhK1IRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 03:17:48 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16D3C0613F7;
        Sun, 28 Nov 2021 00:14:14 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a18so29286497wrn.6;
        Sun, 28 Nov 2021 00:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JPdu/MwrlQhTPRIOqqddF7qUaoIy6oyGEzbM7B0SRMM=;
        b=Ek2+YONlt98jRkEQLJuGscjMRdaQP7ve0NhCBsjAtQLiIezLPifq5ALv3JMQftk3lF
         lJA2qbssuNwgL2Z8LKsVfZQO1uTIyD1LGZeT4PZueCpubW0LLV8W08cWJFJMonCIhsg+
         SMnmbpXRJmCo8EnPWDnWyNUWjNClnJUXE2fdIPEvF+IG6kwbXxa6LsbSWB459wfvmxbG
         5wZFcg+WqxTmJrYPNfy//95dL3MtNNfBOZsAv+EMoT4ZO/LfBoVQaGa90p8qf4/DY55P
         X9KhNQWcEn9RyVg1IkKvSou4CiLN4yGCRMSY0uuv2r+VMTlpSkSNYqkvhbPUmqj44NDl
         tYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JPdu/MwrlQhTPRIOqqddF7qUaoIy6oyGEzbM7B0SRMM=;
        b=K55mZTrkP9df8ocxeDJbJOq6VfBfyKPiHaGrtTg4pA9Bt3BmQfB5cUaxyBnqi5ZHuC
         EjCjx4Ct4BgGoZGqCH58X6cH4ZvKjkT6BwPDrOKzdu/Mgn5XrHYd0GURa/xvoX+b9qFR
         j58EAAuuvAOP0RYE+MJZROFsVmYSwGPQ3olwGAmRvXpIa7FD7T7WXeshsPmrqk4gVdtb
         JhWV9wpwkRllebHvFIl8wQu27uDj2UnRZFNwyCUQXzqPe/4xeh9pDJEoaKfx7VpLVH5f
         /PEZdN4yF6MdOfaaIT9SIZo5iOFXgNMNDYQ8kYvvldw6NwZF98xXEsM+XWiidwGjtYQ2
         fIlw==
X-Gm-Message-State: AOAM533893gNCw2xYRzEmUdYe3VyRJYpR8+Wg3umm/SEFfZI056Hjela
        wq8C3LksGINMPx0LiPJDjA4=
X-Google-Smtp-Source: ABdhPJw93XbQNaNAGK3Owx80LTelI1SHiOIqAPj+GZcDM5hGvKiR0GQVklYL4VCabXQJt3br41nnZA==
X-Received: by 2002:a5d:61cf:: with SMTP id q15mr25690774wrv.623.1638087253507;
        Sun, 28 Nov 2021 00:14:13 -0800 (PST)
Received: from [192.168.123.240] (static.235.156.203.116.clients.your-server.de. [116.203.156.235])
        by smtp.gmail.com with ESMTPSA id l21sm10446875wrb.38.2021.11.28.00.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 00:14:13 -0800 (PST)
Message-ID: <c7818253-44b0-777b-669a-ec950e1b2570@gmail.com>
Date:   Sun, 28 Nov 2021 16:13:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:95.0) Gecko/20100101
 Thunderbird/95.0
Subject: Re: [PATCH 2/3] mm: page table check
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, masahiroy@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        frederic@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <20211123214814.3756047-1-pasha.tatashin@soleen.com>
 <20211123214814.3756047-3-pasha.tatashin@soleen.com>
 <6d82e674-76dc-f3b0-2e53-a92eeb249eff@gmail.com>
 <CA+CK2bAX2XmMrt9RBGiUV7LG_sbpB7ov6bxMVjr5FSBVirE1CA@mail.gmail.com>
From:   Fusion Future <qydwhotmail@gmail.com>
In-Reply-To: <CA+CK2bAX2XmMrt9RBGiUV7LG_sbpB7ov6bxMVjr5FSBVirE1CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the config:

https://pastebin.com/AsLukrbE

I can't stably reproduce the bug, but it seems it's likely to happen 
when a music is playing in the background or there is a file operation.

I encountered it again on linux-next-20211126 when I was trying to 
extract a rar file, and the sound is constantly repeating when my system 
freezes, but nothing useful in journalctl.
