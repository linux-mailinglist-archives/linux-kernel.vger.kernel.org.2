Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B5A42CC1E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhJMUzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:55:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229897AbhJMUzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634158384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N3Ys0GKSzSbqDhdpxCV91fHChV1yr5umjrGeyF6XK/E=;
        b=Fnfhwgzp0qPuK8wZKN0GKsh1kZWiLCCjZ0o76l6kYRgAL5khCSbVaLsrztdb4KXHclyj8/
        Gsr8CMfTq3utxTvGLeX1ztZyqHzCRU6C3xulO2w9aMGmOtsPCqqpDihKFITHKmu8M3TEzo
        2ya7pw8j/7QEMySbDCeabViZO+U1U38=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-jwoc5FqvOCqCyP9KVSIweg-1; Wed, 13 Oct 2021 16:53:03 -0400
X-MC-Unique: jwoc5FqvOCqCyP9KVSIweg-1
Received: by mail-qv1-f69.google.com with SMTP id t12-20020a05621421ac00b00382ea49a7cbso3829709qvc.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 13:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N3Ys0GKSzSbqDhdpxCV91fHChV1yr5umjrGeyF6XK/E=;
        b=aL6hr9PAQ304rQ4913dxg1HvEWkRVZim+6SYNtxIoGN4PIJYJ6ISZ/cmSYbM3yH1uO
         7gn/BY05G9XVLzRtQQDvGBELEEz+A2RuHmrJ5TuyHHAgzS7iibdASxOGA1xU9F7nxpo6
         F8eiZDBhTWJqLEtzg0ZpveGB4Ii97rmawAd72IeRfEf6YmaNTJQRR1m18syop571hYJA
         qp2dh+DAnT6ekMtueFWlRhoCEpaY7G4KJXuNdZ7A2AiQVsgfP0unfLXVeSgKpqi08YUV
         Fe3EvuRykpOiarn5DMiQwYSwJLokMTEVR8G84YXclrkoKNITqR/scj8EBBXiYyFwRESb
         3how==
X-Gm-Message-State: AOAM530/46S0I9btYUFHYof7+oDc6uevaLWPgJSKZnMYJJ25XVjR+gfk
        H8S8pQHhNQBPxl9kUIRe2qk0PgUWU7485XNDaMoglTzjT4/FHQQUn15Yo62SPoeOhns1d83cAoc
        ymkoGv+n5iAf9vUeGPvHk5oB3
X-Received: by 2002:a05:622a:1343:: with SMTP id w3mr1918846qtk.203.1634158382741;
        Wed, 13 Oct 2021 13:53:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKOVyFEEy+K+cN6AS/kNLt0G8AYlja8L6t11WipMXDhmobIe6FumGFVQGEZeh9tiF6qPU4xw==
X-Received: by 2002:a05:622a:1343:: with SMTP id w3mr1918823qtk.203.1634158382511;
        Wed, 13 Oct 2021 13:53:02 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id s185sm349026qke.93.2021.10.13.13.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 13:53:02 -0700 (PDT)
Date:   Wed, 13 Oct 2021 13:52:59 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <20211013205259.44cvvaxiexiff5w5@treble>
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
>  	/*
> +	 * Rewrite the retpolines, must be done before alternatives since
> +	 * those can rewrite the retpoline thunks.
> +	 */

Why exactly is that a problem?  This code doesn't read the thunks.

BTW, CALL_NOSPEC results in a retpoline site in .altinstr_replacement:

Relocation section [40] '.rela.retpoline_sites' for section [39] '.retpoline_sites' at offset 0x8d28 contains 1 entry:
  Offset              Type            Value               Addend Name
  000000000000000000  X86_64_PC32     000000000000000000     +10 .altinstr_replacement

Which I assume we don't want.

-- 
Josh

