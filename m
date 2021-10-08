Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0104264F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 08:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhJHG5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 02:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32479 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229490AbhJHG5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 02:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633676158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m3QDfmSLAjmoHrGCTu41W/RpCv2mw53WP+nmw7odVgg=;
        b=XGOB1kfRsnZySwenOS1UDJ/G+GDMPeUEbtJT+q9nUugTCdIeH6hcdbaG9dYeUENhRoM99y
        YoWgClmIXRx+WIni822ZUYTusUPra3nc6xCXmVUFIRFTIh/rHiRgdY7tp/5k8ZgPQLcuk6
        vi3bgGg407V8stnl05dI4hmPjY0rbW4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-1nbTtLrOMRedkKCPR2kmfw-1; Fri, 08 Oct 2021 02:55:54 -0400
X-MC-Unique: 1nbTtLrOMRedkKCPR2kmfw-1
Received: by mail-qt1-f197.google.com with SMTP id l22-20020ac87b36000000b002a6c575f419so6942351qtu.23
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 23:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m3QDfmSLAjmoHrGCTu41W/RpCv2mw53WP+nmw7odVgg=;
        b=qIaFt3O0eJRmHjpiWqL4JxEpyr1tYeibRaYhtawSdDWYNupQlLgLT7a+YbVpigYjUk
         5sqlxvHjwQWh48xaOAg7f2lOSah4tI5lk4rE0uTjYlXTpYzdIIfgJogKLDuKzVU7vs1Z
         RAPNsEFWkA59J2K1cOxAxsGyMX0DJL8ghSYRSnFHalPlfAmSie9Ich1NCzbdwbRiEYPb
         Q1RPVMKidAaGTFOel12Nwre+xnd2K7TX/Jaa4phVEcLjdM5UOhB7Ut65XP8tBxUKE/2v
         jINya2SvXbQ5E5z84euAU9MchvXiq+NxTiS8uM8LEtrT/A+ae7bKao8zc975A2ebZUoG
         o7qw==
X-Gm-Message-State: AOAM531kyFUfVPiueVu/qtUaprW+vrmbnId9cT/KFmCBIdE3P0EfcCim
        j2SG07z+iDwoY66zEauxQWPWZKtOK6iuFYsRhx52BzWtfNohyk618FdtCHkjYOsaSROXFf02ALZ
        bw/+9/tw8QFxvUX8xkum8jAmB
X-Received: by 2002:a37:8044:: with SMTP id b65mr1492608qkd.150.1633676154069;
        Thu, 07 Oct 2021 23:55:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4d3+GPoOrwFMddlP7LAGq88cvtfnX4m1g2hLJcn6R7ko+kNWh40tny1P4cH8Kw1XraPv/mQ==
X-Received: by 2002:a37:8044:: with SMTP id b65mr1492602qkd.150.1633676153834;
        Thu, 07 Oct 2021 23:55:53 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id bj31sm1602009qkb.43.2021.10.07.23.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 23:55:53 -0700 (PDT)
Date:   Thu, 7 Oct 2021 23:55:50 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 1/2] objtool: Optimize re-writing jump_label
Message-ID: <20211008065550.zge5zkbfrki5osv2@treble>
References: <20211007212211.366874577@infradead.org>
 <20211007212626.950220936@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211007212626.950220936@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 11:22:12PM +0200, Peter Zijlstra wrote:
> There's no point to re-write the jump_label NOP when it's already a NOP.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/check.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1397,7 +1397,7 @@ static int handle_jump_alt(struct objtoo
>  		return -1;
>  	}
>  
> -	if (special_alt->key_addend & 2) {
> +	if ((special_alt->key_addend & 2) && orig_insn->type != INSN_NOP) {
>  		struct reloc *reloc = insn_reloc(file, orig_insn);
>  
>  		if (reloc) {

While you're at it, a comment would be very helpful for that whole
clause.

-- 
Josh

