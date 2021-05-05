Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E783732FB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 02:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhEEAOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 20:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhEEAOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 20:14:00 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B899C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 17:13:05 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id m11so658034pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 17:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mfpzdmwVw8Fu8OiTw9MqRdmwIyqVsi2gaYUI9OYvwW4=;
        b=G+uHX1x0P+n4lyX0+pqw4LNOwzexQCbLGOM9frm33kz66Vn11x0QAJttUvxQ26k9cR
         OdWt60KwLGz+I+eiSgA360T+UNOlywi7GocCedS0+PhIf99bnfX3HJUefdd7mG3AeQXk
         n+W3smbT5Y5GQ9E16Ag3Qwmz0VX4D0NXF89oQnBG3BwiyKb8/vBw/wENfbR5BE+69+0r
         s0LLAdYzBNAyh3PwTw7J4N848ucTzd9bxtQicP9FsP8GEMzQHoC1eAkkDjwNE26xr+W1
         JDq3JBEZqUIYMArk0CkqUAxmGzl0F3bp7FF0bRlio59PnsYxLY7nZF9givRLeJI+OTFI
         53IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mfpzdmwVw8Fu8OiTw9MqRdmwIyqVsi2gaYUI9OYvwW4=;
        b=uf9nuaqdMdDGnSy7I5OEtGmEQrR3B52uZkGDduuBlkqFcgMjzX4n/4kP+XxvhVkboV
         nFkyfWFzLaz9TwWN8etfFTmDpOH1c418tjX8d3wul/rb16FFGfEl+1jrG0df+g3rREdG
         eVM6cd/ofyQXO/1AiYnZuc9Rm8uFzj8rzteDI/uXcEG1cqK3PpYJO1W+J+X8CMcPI3cr
         8UEts4GRGv+tWOEVvPU+Hg7PCOY3A+8y7eSzp04SDkPwCrLIp1Rsg6owg1jNnVU1sM+1
         z0148QFkS0OTIfwASpAwyeNJzBPoJUP9bGs/TE01EgWFjNlqg6GL1eZtmHBLcMcqzPYf
         MlMw==
X-Gm-Message-State: AOAM530jS8uA6Ex/LrhNOp8EXX7orrQhjet6na4G2YvdVttFzwShXolz
        /Ur8twG2wfweJYOXIfJ6aEaBUMqR2P8ogQ==
X-Google-Smtp-Source: ABdhPJysrdYj4CAp35wUJ0IrZJ2sRrScVz5HhokUNGM2TOcHVxQhRfFprC9ZxxrFpeaIbtaSCB3m8Q==
X-Received: by 2002:a63:ea0b:: with SMTP id c11mr25501127pgi.120.1620173584654;
        Tue, 04 May 2021 17:13:04 -0700 (PDT)
Received: from devbox.home ([50.39.96.2])
        by smtp.gmail.com with ESMTPSA id v123sm13305399pfb.80.2021.05.04.17.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 17:12:53 -0700 (PDT)
Date:   Tue, 4 May 2021 17:11:54 -0700
From:   Pawan Gupta <writetopawan@gmail.com>
To:     Ramakrishna Saripalli <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
Subject: Re: [PATCH v4 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
Message-ID: <20210505001154.rmibherzitm2yaga@devbox.home>
References: <20210430131733.192414-1-rsaripal@amd.com>
 <20210430131733.192414-2-rsaripal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20210430131733.192414-2-rsaripal@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.04.2021 08:17, Ramakrishna Saripalli wrote:
>--- a/arch/x86/kernel/cpu/amd.c
>+++ b/arch/x86/kernel/cpu/amd.c
>@@ -1170,3 +1170,26 @@ void set_dr_addr_mask(unsigned long mask, int dr)
> 		break;
> 	}
> }
>+
>+static int __init psf_cmdline(char *str)
>+{
>+	u64 tmp = 0;
>+
>+	if (!boot_cpu_has(X86_FEATURE_PSFD))
>+		return 0;
>+
>+	if (!str)
>+		return -EINVAL;
>+
>+	if (!strcmp(str, "off")) {
>+		set_cpu_cap(&boot_cpu_data, X86_FEATURE_MSR_SPEC_CTRL);
>+		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
>+		tmp |= SPEC_CTRL_PSFD;
>+		x86_spec_ctrl_base |= tmp;

I don't think there is a need to update x86_spec_ctrl_base here.
check_bugs() already reads the MSR_IA32_SPEC_CTRL and updates
x86_spec_ctrl_base. 

>+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>+	}
>+
>+	return 0;
>+}
>+
>+early_param("predict_store_fwd", psf_cmdline);
>diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>index d41b70fe4918..536136e0daa3 100644
>--- a/arch/x86/kernel/cpu/bugs.c
>+++ b/arch/x86/kernel/cpu/bugs.c
>@@ -78,6 +78,8 @@ EXPORT_SYMBOL_GPL(mds_idle_clear);
>
> void __init check_bugs(void)
> {
>+	u64 tmp = 0;
>+
> 	identify_boot_cpu();
>
> 	/*
>@@ -97,7 +99,9 @@ void __init check_bugs(void)
> 	 * init code as it is not enumerated and depends on the family.
> 	 */
> 	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
>-		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>+		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
>+
>+	x86_spec_ctrl_base |= tmp;

This change also doesn't seem to be necessary, psf_cmdline() updates the
MSR( i.e. sets PSFD).  Here read from the MSR will still update
x86_spec_ctrl_base to the correct value. Am I missing something?

Thanks,
Pawan
