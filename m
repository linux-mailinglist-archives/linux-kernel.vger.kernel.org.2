Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3BA41502B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 20:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbhIVSxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 14:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23501 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229732AbhIVSxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632336703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IuYQbTDXUzoYKskDvC5YNv/UqQcx/FSLsqP8ByecJHg=;
        b=hDuVVNQie83EW9vmxLbft7YKnmEXpLbusHTrQdcEtFHc/VLNvbur8Sw032ht2Dr3htDL9C
        IHVuP6s4I6+kFMYlmFt+TYxqe7j3YssdGK9AcWPQUGa53mKO8AdP2VAd+wtPdHhTwTfbIs
        5UwYsQ5glOmUTiKI/BdX87cudEPEEBg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-CAykba1SNICC0cNCrrVoow-1; Wed, 22 Sep 2021 14:51:42 -0400
X-MC-Unique: CAykba1SNICC0cNCrrVoow-1
Received: by mail-qk1-f199.google.com with SMTP id bi14-20020a05620a318e00b00432f0915dd6so12372189qkb.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 11:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IuYQbTDXUzoYKskDvC5YNv/UqQcx/FSLsqP8ByecJHg=;
        b=kbK18jFLvhQ9mKB7I6FW1j3whM27O0g9ChT7yMACJvF0GqDczYmCrhm8ECHDi9nh8N
         SQeAA2tLau24XVWkbuCBoJrTNSiXRebGKZ061xBIdF0SUkeQ01a1YJ0X1DfxFPe8Atxv
         pjWd/JHUrIa1qEyv9ymh1ydKQC5e8GeqcgOA1rVCIPPMGAnV3fMIBGxOXJ6SuYMji3+a
         DjU9+GZ0QoZKEQW9MJnfHE9IOgK67G15NzSsklK0sUu0E9ngw0OFo3fTkfzL2wwBboiy
         oyjAoZgD7rkvOwdsaIFVbprGUrkNh0ONkVMLR1PJyK2JTPW7idjfm/Bmvlp4vHbKaS3u
         Jc8g==
X-Gm-Message-State: AOAM533HTKKL3N57GIvYeW3HZ2yXN4C+lEUtmnGgP6DDMYeV2dzXOLbe
        oNEPHoht+7N6czlc/o/gxHGUwOOhpowxdAl5TTuIUWTv573ZP8Wqerf+26xQQe8P092SM91x2pn
        JTcWaBrXkhBlucegjgIaPLtQe
X-Received: by 2002:a37:9d82:: with SMTP id g124mr819496qke.237.1632336701648;
        Wed, 22 Sep 2021 11:51:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw59/JWKD3GNdZH8LP3SV/xf1grrpAWNCMgx5+10bLfKRg0+cBO04sge8t+ikOnStmA04MQ+g==
X-Received: by 2002:a37:9d82:: with SMTP id g124mr819467qke.237.1632336701349;
        Wed, 22 Sep 2021 11:51:41 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id d17sm2004733qte.0.2021.09.22.11.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 11:51:40 -0700 (PDT)
Date:   Wed, 22 Sep 2021 11:51:37 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH] x86, vmlinux.lds: Add debug option to force all data
 sections aligned
Message-ID: <20210922185137.ivdp4yoalv4qdbe2@treble>
References: <1627456900-42743-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1627456900-42743-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 03:21:40PM +0800, Feng Tang wrote:
> 0day has reported many strange performance changes (regression or
> improvement), in which there was no obvious relation between the culprit
> commit and the benchmark at the first look, and it causes people to doubt
> the test itself is wrong.
> 
> Upon further check, many of these cases are caused by the change to the
> alignment of kernel text or data, as whole text/data of kernel are linked
> together, change in one domain can affect alignments of other domains.
> 
> To help to quickly identify if the strange performance change is caused
> by _data_ alignment. add a debug option to force the data sections from
> all .o files aligned on THREAD_SIZE, so that change in one domain won't
> affect other modules' data alignment.
> 
> We have used this option to check some strange kernel changes [1][2][3],
> and those performance changes were gone after enabling it, which proved
> they are data alignment related.
> 
> Similarly, there is another kernel debug option to check text alignment
> related performance changes: CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B,  
> which forces all function's start address to be 64 bytes alinged.
> 
> This option depends on CONFIG_DYNAMIC_DEBUG==n, as '__dyndbg' subsection
> of .data has a hard requirement of ALIGN(8), shown in the 'vmlinux.lds':
> 
> "
> . = ALIGN(8); __start___dyndbg = .; KEEP(*(__dyndbg)) __stop___dyndbg = .;
> "
> 
> It contains all pointers to 'struct _ddebug', and dynamic_debug_init()
> will "pointer++" to loop accessing these pointers, which will be broken
> with this option enabled.
> 
> [1]. https://lore.kernel.org/lkml/20200205123216.GO12867@shao2-debian/
> [2]. https://lore.kernel.org/lkml/20200305062138.GI5972@shao2-debian/
> [3]. https://lore.kernel.org/lkml/20201112140625.GA21612@xsang-OptiPlex-9020/
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  arch/x86/Kconfig.debug        | 13 +++++++++++++
>  arch/x86/kernel/vmlinux.lds.S |  7 ++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)

Hi Feng,

Thanks for the interesting LPC presentation about alignment-related
performance issues (which mentioned this patch).
 
  https://linuxplumbersconf.org/event/11/contributions/895/

I wonder if we can look at enabling some kind of data section alignment
unconditionally instead of just making it a debug option.  Have you done
any performance and binary size comparisons?

On a similar vein I think we should re-explore permanently enabling
cacheline-sized function alignment i.e. making something like
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B the default.  Ingo did some
research on that a while back:

   https://lkml.kernel.org/r/20150519213820.GA31688@gmail.com

At the time, the main reported drawback of -falign-functions=64 was that
even small functions got aligned.  But now I think that can be mitigated
with some new options like -flimit-function-alignment and/or
-falign-functions=64,X (for some carefully-chosen value of X).

-- 
Josh

