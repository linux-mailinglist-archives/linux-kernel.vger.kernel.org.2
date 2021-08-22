Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169403F3CF3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 03:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhHVBR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 21:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231167AbhHVBRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 21:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629595035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u4xeDb0xiSkHYvpeYqNRRiH9/pK7u1VGqkKmKiQtiX8=;
        b=N6hn4OM1vNMmXFCuD7DhjzFFWpsnpxJWJW73IFID2c8nFFYJ4o//DJM77WgYynMbs2/S0Q
        oPCGiYS7B6KIAbj1DnLOfuvjmEipOG5UfXmVzZt5/xSTK1YAvCHPcKOudGxFw7THWtu7x6
        RjgNUhM5bJtQDscxZvoGV075myvXGJ0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-I6-8psYJMGysJaUpNKaqyA-1; Sat, 21 Aug 2021 21:17:13 -0400
X-MC-Unique: I6-8psYJMGysJaUpNKaqyA-1
Received: by mail-qk1-f198.google.com with SMTP id h135-20020a379e8d000000b003f64b0f4865so3610510qke.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 18:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u4xeDb0xiSkHYvpeYqNRRiH9/pK7u1VGqkKmKiQtiX8=;
        b=RALXXnA8SOwEPveB6CcK7GqzOCGIwT2DOYzMmHEos4cZ8lBJfjQbvp7UCdKyNRh2ce
         DNAQhmKCCOOf778DKc02UZKJd1zaSs0XCvwMAbWhL9D9iPY5mjkX7wcetesJj0VVabk/
         PM1Yy3lugGsd32GEGSiBGDbZQpkq30a7g41V3mdYlT9R+hKObSFFJbnSRFQPMdkZSimX
         r/M5dD/nXbLsVoeEZxsGCaAMCcJqb/3ntqau6livKfoQspt455EDE6PwQtAWyeW33ETA
         WoxuwHcgU/SO4WDMBaOKt4M1K/R22v1N/FvEXQEHQNjfSusCuDzTIi1zTaNErU5WMDe8
         gKtA==
X-Gm-Message-State: AOAM530PQ+BV9jhA0LXy9tzKxWcXx5VWogwAoGbGxyOXQFFMTBgxcXRR
        oRNZC+DoOC3FzzVxtAJdbh/ZIBg4ob0X3mI4lucEoY+thKx+gbnxwxmLzorX4W5iA/UgRzGRrRE
        Tsk6+ZjHMzhOl+IpSSezhwlhd
X-Received: by 2002:aed:2029:: with SMTP id 38mr24147587qta.71.1629595033212;
        Sat, 21 Aug 2021 18:17:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxjdMzlEtB04A9H2gWJ3xaTLyZ4fVo0vEX7mXpihQ9WTD/TfwhY8KT897Z8Jn+QTR4LepA7Q==
X-Received: by 2002:aed:2029:: with SMTP id 38mr24147578qta.71.1629595033023;
        Sat, 21 Aug 2021 18:17:13 -0700 (PDT)
Received: from [192.168.1.9] (pool-68-163-101-245.bstnma.fios.verizon.net. [68.163.101.245])
        by smtp.gmail.com with ESMTPSA id f1sm536386qtb.66.2021.08.21.18.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 18:17:12 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] objtool: remove redundant len value from struct
 section
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Andy Lavr <andy.lavr@gmail.com>
References: <20210820194453.395548-1-joe.lawrence@redhat.com>
 <20210820194453.395548-3-joe.lawrence@redhat.com>
Message-ID: <7ca86dcb-65f8-006b-0628-a79fb4defe40@redhat.com>
Date:   Sat, 21 Aug 2021 21:17:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210820194453.395548-3-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/21 3:44 PM, Joe Lawrence wrote:
> [ ... snip ... ]
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> [ ... snip ... ]
> @@ -307,8 +307,9 @@ static int decode_instructions(struct objtool_file *file)
>  			insn->offset = offset;
>  
>  			ret = arch_decode_instruction(file->elf, sec, offset,
> -						      sec->len - offset,
> -						      &insn->len, &insn->type,
> +						      sec->sh.sh_size - offset,
> +						      &insn->sec->sh.sh_size,
> +						      &insn->type,
>  						      &insn->immediate,
>  						      &insn->stack_ops);
>  			if (ret)

Nack!  Not sure what I was thinking here.  It was Friday afternoon, so I
probably wans't.

Changing insn->len to insn->sec->sh.sh_size is obviously bogus.  I'll
correct this part of the patch, do better testing and post v3 on Monday.

Thanks to Andy for reporting.
-- 
Joe

