Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45CA42CC8F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhJMVPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229771AbhJMVPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634159610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qkLA5UFP68R6JirgvQAxyouzMyG5FNhHnkbPPL9o2QQ=;
        b=ekqMm97iF+VQF+YqJozhN1ZRS5WwtbjN0K6loZR08ypjl8yjwBE5avbc+nFHZQVVsxh9WW
        t9LWDCQhZ7MU/PBChgtREz7Fgunu8Ag90ud7EgZEBCRlkz5zvx22RXll21xYFFatqS5be+
        dKiwbqOQ1Jhvg0eUCTM8cnqaSJPzNgI=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-sq7_GzVvP1WPDrI859zrRg-1; Wed, 13 Oct 2021 17:13:29 -0400
X-MC-Unique: sq7_GzVvP1WPDrI859zrRg-1
Received: by mail-oi1-f200.google.com with SMTP id 17-20020aca1111000000b0027368cbf687so2354813oir.23
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qkLA5UFP68R6JirgvQAxyouzMyG5FNhHnkbPPL9o2QQ=;
        b=nYFE0qVjIwP0Rh/7jLG83vAaxRFkxsIo4YJh364Ybd3lFQ0Iy7zKGW6JDWJGwUmeHC
         7KSF9rKcVQI5tCSV74oGkMWBZUDur/6FGmWWRHWJxWuOlqrYZabh2Qv72NNZGcJ/Pgva
         sp3UMJlk55tkhA3nyhaAUOiDPvzV/Q2yOcqKR9xx5VR+sLdOrkN/H9MWXIuB2NTVW7Re
         iX4uv6Hx11fxZ0xBs9D4TeUo7q2NODzp92Tv5FPxxX5LcaBtjrwC637+2OIm3F4OyroY
         u1P8EbjB+r5YbSiLdV1IIp1xugosH8OJuh2jD+bIcknHSWVvvvuqw8rntcbki7HziUoN
         9ZZg==
X-Gm-Message-State: AOAM5316hmbTRTkfp+uofEd88ci+XyIAK8hmisUiINmOzezaJtrsx2/D
        PB8ln3i+Y/5C1dvSigMjwUk2q46dhPYruhril+fkvlANhjMW4WO3WLf0EhiVnaLF5aSxcbK378f
        UC2Oj9LzIbDki/1DfOfdHwlcT
X-Received: by 2002:a4a:ca0f:: with SMTP id w15mr1138296ooq.39.1634159608591;
        Wed, 13 Oct 2021 14:13:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy79hvNlXOyRefoedwWX4VVBZtM5zY0xCUI8/xUxS//VBNfU3NyU+qhwDEpuSugZdUkJvBb8A==
X-Received: by 2002:a4a:ca0f:: with SMTP id w15mr1138276ooq.39.1634159608388;
        Wed, 13 Oct 2021 14:13:28 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id 12sm138496otg.69.2021.10.13.14.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 14:11:58 -0700 (PDT)
Date:   Wed, 13 Oct 2021 14:11:18 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <20211013211118.apsj66c6b6abubeo@treble>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211013123645.002402102@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:22:21PM +0200, Peter Zijlstra wrote:
> +#ifdef CONFIG_X86_64
> +
> +/*
> + * CALL/JMP *%\reg
> + */
> +static int emit_indirect(int op, int reg, u8 *bytes)

X86_64 is already equivalent to STACK_VALIDATION these days, but might
as well clarify here where the retpoline_sites dependency comes from by
changing this to '#ifdef CONFIG_STACK_VALIDATION'.

-- 
Josh

