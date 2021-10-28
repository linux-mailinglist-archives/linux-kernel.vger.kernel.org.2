Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D7F43DA09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 05:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhJ1EBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 00:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33353 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229488AbhJ1EBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 00:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635393514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Ek5ATL1TPnzxx9rmMjyQPzlEbSmEt+54jM7SEgv68c=;
        b=LKU2Mrv4/fPomY8Sdovj9JGbEz3weyXIjA5k70s57ciYenLnv31+gfRRTQHJcm2RL7Y0m2
        2Oy9mGedQbeZvIBVOq/2nyAXnJzTMkZBIf0tbXKaB+ARxE+TakI5jwxaNExJOK5JXDq9/o
        kxeSsFOKcv8Ytp7EtZrlCuGHsRNjRRI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-6CuRMfWAMBWmNtBn9MwZSg-1; Wed, 27 Oct 2021 23:58:32 -0400
X-MC-Unique: 6CuRMfWAMBWmNtBn9MwZSg-1
Received: by mail-qk1-f200.google.com with SMTP id u24-20020ae9c018000000b00462caee0884so820652qkk.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 20:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Ek5ATL1TPnzxx9rmMjyQPzlEbSmEt+54jM7SEgv68c=;
        b=FQh1IWt1vIQRbwJ/oqhCPloyA5f7+V5HMzDBXdIy/gzH4dTW+i1Cs8DNGvsO0PZnqx
         nBnzYOif+8O2tt95GWSFwUgCVTP+5sjBlv2Zhgv872wjujEhJ0my5f7kRXketwDStYuo
         VbTG5nx8FNvoWlPGEoXCVj7zouhNam3aTnQFNnbnPPAkLrIJo5wsCGM5AxI7r28y/EIY
         RzjztTWb02lnMR/KBRndJf/qgwgTedP2tfyru/o71azMIBQWG5GuYzVTV8EXF3fCj/7O
         Hm3mKxzjQFUgDtT3Kee+K7DjhcJuHU+FB19wZZApUMQMvNvkws6IjlL0/CrgibiyvNgd
         9ePQ==
X-Gm-Message-State: AOAM531YCYK8mxDFocbdb3Q4BgWWhUPfTneb+pkfGWHAzpBT1UduxowP
        OUqThoBha5gjycTVIxhw9lYSToFwBTkR8SfIsvWCWuQ5qSt8W04j3AyZfUKp6y2xioQEoyYa8zV
        yQGBAxgXZvsUHm9mYMrQ+fizs
X-Received: by 2002:a05:620a:2912:: with SMTP id m18mr1523796qkp.365.1635393512290;
        Wed, 27 Oct 2021 20:58:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCsW2WiKwN5RiRTVcwiWVuqcuhHx8/ryX6WcnFXnPhiWySF450O6HBu1Clr2PQoi84x5HuWQ==
X-Received: by 2002:a05:620a:2912:: with SMTP id m18mr1523784qkp.365.1635393512036;
        Wed, 27 Oct 2021 20:58:32 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id o2sm1280794qtw.17.2021.10.27.20.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 20:58:31 -0700 (PDT)
Date:   Wed, 27 Oct 2021 20:58:28 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com, bpf@vger.kernel.org
Subject: Re: [PATCH v3 01/16] objtool: Classify symbols
Message-ID: <20211028035828.q4opdtbarrbklczp@treble>
References: <20211026120132.613201817@infradead.org>
 <20211026120309.658539311@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211026120309.658539311@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 02:01:33PM +0200, Peter Zijlstra wrote:
> @@ -55,7 +55,10 @@ struct symbol {
>  	unsigned int len;
>  	struct symbol *pfunc, *cfunc, *alias;
>  	bool uaccess_safe;
> -	bool static_call_tramp;
> +	u8 static_call_tramp : 1;
> +	u8 retpoline_thunk   : 1;
> +	u8 fentry            : 1;
> +	u8 kcov              : 1;
>  	struct list_head pv_target;

Might as well convert uaccess_safe to a bitfield?

-- 
Josh

