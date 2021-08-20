Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB813F373C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 01:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbhHTXSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 19:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50674 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230303AbhHTXS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 19:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629501470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QOfsUdy3CSf2X7hLcqCS+xW43jyqXbihc3ZxGwrZDQs=;
        b=EeHyAFJzXF3kVDXXYYYApZTTSZTC6g9Ie9CBeU0pkrcrCvAleLqk6SXyI0vPdVLRNVyKH7
        gAI1me10UkMdYyINRWt+JAp56t7t0azPf+egw+DGLJjDKq/cIwbntGAGFfLGLxzXTFByoa
        IpXEF774DEbvjV5BnCVYmMCtLkrHjOQ=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-efzAwAVJMz6__BIe3hTILQ-1; Fri, 20 Aug 2021 19:17:48 -0400
X-MC-Unique: efzAwAVJMz6__BIe3hTILQ-1
Received: by mail-oo1-f70.google.com with SMTP id k18-20020a4a94920000b029026767722880so5265948ooi.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 16:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QOfsUdy3CSf2X7hLcqCS+xW43jyqXbihc3ZxGwrZDQs=;
        b=mvwjB7Y0XvfBm60ehPC7vtC1MyfBZVSl+4/V2XyX6T0byB5hbBgKOSlc4geLn7TRrn
         ks+qFQlqrfsSrTqQpUnd9jcgSCtc1ITFPGJDfA/UKD/+WWKa2WA/0+79v/N66x+zsB9y
         M8fRgrPWDOViC3rgmUnoALempaiBOUUziOxLyeI9tMMIpKVwGk5Y5iuwgkfkfampVAy+
         nmAw4/9QK5tU73kIJUx/amzjgnFG1vA1mkF/DLXS94HW2DmK1G9uQj39at5KC/GSmNhO
         ztWVeECNi62S7/3iQDL9luO0J4NPO8Wk2K3sPVe2GHGe8p2wX7QWPCz8joJQWOZd+Fvp
         8SoQ==
X-Gm-Message-State: AOAM531yt6VOlaTMOorHMWL3dh4ct6n+TDOB1Bm4og0nYt670pXX3FTc
        i6jKWaeRjMo9M++nAXOOIZbpkaeSl5MLUkxvzzJO/bncBxaj8BrO6c5E7Zuf28/ecaZYZAkaF7b
        7Rk4t+reUo3VRxUMrztdaQS/M
X-Received: by 2002:a9d:7e83:: with SMTP id m3mr13725118otp.44.1629501468150;
        Fri, 20 Aug 2021 16:17:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR5VQyh8ph5spdGdv9zKid4mCInfcyTDN5VexbwUQS2B+G0KglhUt5008ajh4sCzUfHbgbZA==
X-Received: by 2002:a9d:7e83:: with SMTP id m3mr13725106otp.44.1629501467911;
        Fri, 20 Aug 2021 16:17:47 -0700 (PDT)
Received: from treble ([68.74.140.199])
        by smtp.gmail.com with ESMTPSA id t30sm1582846oiw.42.2021.08.20.16.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 16:17:47 -0700 (PDT)
Date:   Fri, 20 Aug 2021 16:17:44 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
        elver@google.com
Subject: Re: [PATCH v2 03/24] objtool: Handle __sanitize_cov*() tail calls
Message-ID: <20210820231744.76clopxwcqeum4k7@treble>
References: <20210624094059.886075998@infradead.org>
 <20210624095147.818783799@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210624095147.818783799@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 11:41:02AM +0200, Peter Zijlstra wrote:
> +	if (insn->sec->noinstr &&
> +	    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
> +		if (reloc) {
> +			reloc->type = R_NONE;
> +			elf_write_reloc(file->elf, reloc);
> +		}
> +
> +		elf_write_insn(file->elf, insn->sec,
> +			       insn->offset, insn->len,
> +			       sibling ? arch_ret_insn(insn->len)
> +			               : arch_nop_insn(insn->len));
> +
> +		insn->type = sibling ? INSN_RETURN : INSN_NOP;
> +	}

It'd be nice to keep the comment for this case that was in
add_call_destinations().

-- 
Josh

