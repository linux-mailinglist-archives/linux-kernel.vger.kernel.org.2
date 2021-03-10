Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36267334092
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhCJOl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCJOl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:41:27 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F30AC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:41:25 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id v14so4613370pgq.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MpYPf5URi+XzdCPoi7Hk/RdtfT35iqZ3pIAtWBbl0ZM=;
        b=QcDExb6/hnzi+IPoqek/bGQ0szY+Qmndh5owKY+RX+djFLzP5dcUcZ/nax7kdNGCSg
         bJFEAAMlXi9fCq9iHBYaD0Yimz/lOhOwerbnk3s2vYCzFU93bDcOCJ8z/raJ5VqF3/W0
         /2U/uYxjDlMko4NHB5YaXibiWs9/7KiuEhK1Xj2cH6EATOu5RDSi8Jax5NrZY4QUcKqt
         IgdS0MUPfgVYLNydMouP1+Su1dzuOQqKncTM14bvNbpD2d0uhqlvteReUrehX/aOtTLA
         x5+ryjHOloG9i5oaatDdysYG/3/z9e3rGG+DKXU0mLXDjtWGUAWzKBani6tkDdp7LQtP
         6r/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MpYPf5URi+XzdCPoi7Hk/RdtfT35iqZ3pIAtWBbl0ZM=;
        b=qQa/1D0r4a+7K/0yQo4lsIZCiPt3yY0VjOQuMkZNbSYZQHoy3nhGlC4kc+b8oMBGsm
         jjsemhO9mLUQ0s10hLVbxtNaQWOS787/TrdT1JyJABMd3PUzuIJ22pviq0SN7cxD3qTi
         kICkMvfmK7w1vF+dSoRnpCk5Idsu89E3fImLPnKWshGhWhzsM2JnM6USGOrZeF3AwYCa
         2tw/qZyjsb4WGns6uMHqRLjB6s+/zD6rW+O+XdjcPB8g4YWBhpEBgMHL7FKlDboRN8RZ
         QXFJSF953oPUIS0qYSYyovn/WvPcagRYIyk9h+M71+NBUgw6mKV1O7w5V8E0HehwDKbk
         xXEA==
X-Gm-Message-State: AOAM532Yr7z5UkdVJbm99C/80sgbiagvaxn8GUQ0kGO82Awqhk6LGXyX
        013CYeMgA5R9aVpivaoLO86OEg==
X-Google-Smtp-Source: ABdhPJzZtOzSs1iQ8tl8JfRkmt3EnobTlhFe5KUsIfekTx9eENenEYIa5oIzqS/ActzM8HKyR+wRIw==
X-Received: by 2002:a63:e5d:: with SMTP id 29mr3040673pgo.450.1615387285094;
        Wed, 10 Mar 2021 06:41:25 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id a204sm5576854pfd.106.2021.03.10.06.41.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Mar 2021 06:41:24 -0800 (PST)
Date:   Wed, 10 Mar 2021 20:11:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Masahiro Yamada <masahiroy@kernel.org>, robh+dt@kernel.org
Cc:     linux-kbuild@vger.kernel.org, devicetree@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: remove unneeded -O option to dtc
Message-ID: <20210310144121.74mawocx2ydgabx2@vireshk-i7>
References: <20210310110824.782209-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310110824.782209-1-masahiroy@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-03-21, 20:08, Masahiro Yamada wrote:
> This piece of code converts the target suffix to the dtc -O option:
> 
>     *.dtb      ->  -O dtb
>     *.dt.yaml  ->  -O yaml
> 
> Commit ce88c9c79455 ("kbuild: Add support to build overlays (%.dtbo)")
> added the third case:
> 
>     *.dtbo     ->  -O dtbo
> 
> This works thanks to commit 163f0469bf2e ("dtc: Allow overlays to have
> .dtbo extension") in the upstream DTC, which has already been pulled in
> the kernel.
> 
> However, I think it is a bit odd because "dtbo" is not a format name.
> At least, it does not show up in the help message of dtc.
> 
> $ scripts/dtc/dtc --help
>   [ snip ]
>   -O, --out-format <arg>
>         Output formats are:
>                 dts - device tree source text
>                 dtb - device tree blob
>                 yaml - device tree encoded as YAML
>                 asm - assembler source
> 
> So, I am not a big fan of the second hunk of that change:
> 
>         } else if (streq(outform, "dtbo")) {
>                 dt_to_blob(outf, dti, outversion);

Looking at the very first version of the patch I sent,

https://lore.kernel.org/lkml/7aa70809eff3f32d821761d2a763e4fb72ecc8fb.1609844956.git.viresh.kumar@linaro.org/

this change was the only thing that was required to make it work.

I think the reason was that "outform != NULL" as -O option was passed
by the kernel.

> Anyway, we did not need to do this in Makefile in the first place.
> 
> guess_type_by_name() had already understood ".yaml" before commit
> 4f0e3a57d6eb ("kbuild: Add support for DT binding schema checks"),
> and now does ".dtbo" as well.
> 
> Makefile does not need to duplicate the same logic. Let's leave it
> to dtc.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/Makefile.lib | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index eee59184de64..90a4e04cd8f5 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -327,7 +327,7 @@ $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
>  
>  quiet_cmd_dtc = DTC     $@
>  cmd_dtc = $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
> -	$(DTC) -O $(patsubst .%,%,$(suffix $@)) -o $@ -b 0 \
> +	$(DTC) -o $@ -b 0 \
>  		$(addprefix -i,$(dir $<) $(DTC_INCLUDE)) $(DTC_FLAGS) \
>  		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
>  	cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)

LGTM.

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
