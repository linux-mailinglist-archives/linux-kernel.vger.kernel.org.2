Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518FE44D2BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 08:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhKKHyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 02:54:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229706AbhKKHyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 02:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636617108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j0cBMqZ5/FRmtHivqu4thgkkpo6zFWw/Co/9X0tXpIw=;
        b=BlNlypVZeQRkVOjvcy3z5KrHIHAT0gVDZzJA1OcSna4oC5tZUv73AlleVGCO/7PzKJl9Mb
        DmYeGMucA/TMreaz6eucei0ptWuU8QXDjI/DS6UVkLisA0aS8eoVpTJyo2gntdRjoRMXMA
        CVgWbATpZ/oBEGD9VU35VT+rmlOASNc=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-_OnCee9-NwGZ4qpvrj4m2Q-1; Thu, 11 Nov 2021 02:51:47 -0500
X-MC-Unique: _OnCee9-NwGZ4qpvrj4m2Q-1
Received: by mail-ot1-f70.google.com with SMTP id v13-20020a9d69cd000000b00563c36fd48cso2868264oto.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 23:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j0cBMqZ5/FRmtHivqu4thgkkpo6zFWw/Co/9X0tXpIw=;
        b=mKOddrDQXBphvdL/U0wsCdLPKzO/LG9wwzmvx9ssE5v0jBLzFj55Y/mTNtcLpZuCFg
         q8RH7/z/uzrQJl/fC0QYKE8HwY1kjfyr+lfOCr952WfdrbfQAXJLftfcHKOt2b6pJASK
         jR/gowtN2rXNehSlU2dTdRD68Gpot2bhRKNJ34ctLYqSkFl6FTBiPq7YkKCp7eqpHqq9
         Qegpiz5pR+pR1CKyx84mctoHRqZv5i0PtZAj+oLPVM3WieZV1uEO8jIyFTZSDxNIHjcB
         rLJjz+T74ZUPJ6QjXmyp8I0BQ6Qj8N+/VtOvzxy4HQgpIAH9zvSjy9qIpoJPVz/AwIQC
         W57g==
X-Gm-Message-State: AOAM531MIhgegL0XDWwB0/SG6dwHhTDvlO7FjpUdeMs3QjvC+pI2HAay
        wl9oQm1cLsirxfxoa3V9JvH0025DInpraDp7wCvp3k+YGaC4QgN2r2Tg+ccPFQLO6gKCssFR/wq
        9ZRn37aAdrO2UBKpv6dWUcJxi
X-Received: by 2002:aca:4283:: with SMTP id p125mr17796307oia.81.1636617107042;
        Wed, 10 Nov 2021 23:51:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzvU/7xML3Z3YThghMCQlVLSkqZXe3Ud3UCLZzlVsAwFG0lMuaYgoTgtqgcvG18q6/gu0YqA==
X-Received: by 2002:aca:4283:: with SMTP id p125mr17796293oia.81.1636617106809;
        Wed, 10 Nov 2021 23:51:46 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id p14sm424833oov.0.2021.11.10.23.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 23:51:46 -0800 (PST)
Date:   Wed, 10 Nov 2021 23:51:43 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [PATCH v2 20/23] x86,usercopy: Remove .fixup usage
Message-ID: <20211111075143.td3fickblsvl3hau@treble>
References: <20211110100102.250793167@infradead.org>
 <20211110101326.081701085@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211110101326.081701085@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 11:01:22AM +0100, Peter Zijlstra wrote:
> +static bool ex_handler_ucopy_leng(const struct exception_table_entry *fixup,
> +				   struct pt_regs *regs, int trapnr, int reg, int imm)
> +{
> +	regs->cx = imm * regs->cx + *pt_regs_nr(regs, reg);
> +	return ex_handler_uaccess(fixup, regs, trapnr);
> +}
> +
>  int ex_get_fixup_type(unsigned long ip)
>  {
>  	const struct exception_table_entry *e = search_exception_tables(ip);
> @@ -217,6 +224,8 @@ int fixup_exception(struct pt_regs *regs
>  		return ex_handler_imm_reg(e, regs, reg, imm);
>  	case EX_TYPE_FAULT_SGX:
>  		return ex_handler_sgx(e, regs, trapnr);
> +	case EX_TYPE_UCOPY_LEN:
> +		return ex_handler_ucopy_leng(e, regs, trapnr, reg, imm);

"leng"?

-- 
Josh

